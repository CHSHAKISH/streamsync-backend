// src/auth/auth.service.ts
import {
  Injectable,
  ConflictException,
  UnauthorizedException, // <-- IMPORT
} from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto'; // <-- IMPORT
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt'; // <-- IMPORT

@Injectable()
export class AuthService {
  // Inject both Prisma and Jwt services
  constructor(
    private prisma: PrismaService,
    private jwtService: JwtService, // <-- INJECT
  ) {}

  // --- REGISTRATION FUNCTION (from before) ---
  async register(registerDto: RegisterDto) {
    const { email, password } = registerDto;

    const existingUser = await this.prisma.user.findUnique({
      where: { email },
    });

    if (existingUser) {
      throw new ConflictException('User with this email already exists');
    }

    const salt = await bcrypt.genSalt();
    const hashedPassword = await bcrypt.hash(password, salt);

    const user = await this.prisma.user.create({
      data: {
        email: email,
        password_hash: hashedPassword,
      },
    });

    const { password_hash, ...result } = user;
    return result;
  }

  // --- NEW LOGIN FUNCTION ---
  async login(loginDto: LoginDto) {
    const { email, password } = loginDto;

    // 1. Find the user by email
    const user = await this.prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // 2. Compare the passwords
    const isPasswordMatch = await bcrypt.compare(
      password,
      user.password_hash,
    );

    if (!isPasswordMatch) {
      throw new UnauthorizedException('Invalid credentials');
    }

    // 3. Generate a JWT
    const payload = { sub: user.id, email: user.email };
    const accessToken = await this.jwtService.signAsync(payload);

    // 4. Return the token
    return {
      access_token: accessToken,
    };
  }
}