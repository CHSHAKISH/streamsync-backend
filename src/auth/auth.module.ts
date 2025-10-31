// src/auth/auth.module.ts
import { Module } from '@nestjs/common';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { PrismaModule } from 'src/prisma/prisma.module'; // <-- IMPORT THIS

@Module({
  imports: [PrismaModule], // <-- ADD PRISMAMODULE
  controllers: [AuthController],
  providers: [AuthService],
})
export class AuthModule {}