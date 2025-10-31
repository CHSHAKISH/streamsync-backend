// src/auth/auth.service.ts
import { Injectable, ConflictException } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { RegisterDto } from './dto/register.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  // This "injects" the PrismaService so we can use it
  constructor(private prisma: PrismaService) {}

  async register(registerDto: RegisterDto) {
    const { email, password } = registerDto;

    // 1. Check if user already exists
    const existingUser = await this.prisma.user.findUnique({
      where: { email },
    });

    if (existingUser) {
      throw new ConflictException('User with this email already exists');
    }

    // 2. Hash the password
    const salt = await bcrypt.genSalt();
    const hashedPassword = await bcrypt.hash(password, salt);

    // 3. Save the new user to the database
    const user = await this.prisma.user.create({
      data: {
        email: email,
        password_hash: hashedPassword,
      },
    });

    // 4. Return the new user (without the password)
    const { password_hash, ...result } = user;
    return result;
  }
}