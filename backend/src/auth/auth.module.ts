// src/auth/auth.module.ts
import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { PrismaModule } from 'src/prisma/prisma.module';
import { JwtModule } from '@nestjs/jwt'; // <-- IMPORT

@Module({
  imports: [
    PrismaModule,
    JwtModule.register({ // <-- CONFIGURE JWT
      global: true, // Makes JwtService available everywhere
      secret: process.env.JWT_SECRET, // Reads from your .env file
      signOptions: { expiresIn: '1d' }, // Token expires in 1 day
    }),
  ],
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}