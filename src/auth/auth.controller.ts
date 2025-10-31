// src/auth/auth.controller.ts
import { Controller, Post, Body, ValidationPipe } from '@nestjs/common';
import { AuthService } from './auth.service';
import { RegisterDto } from './dto/register.dto'; // <-- TYPO WAS HERE

@Controller('auth')
export class AuthController {
  // This "injects" the AuthService
  constructor(private authService: AuthService) {}

  @Post('register') // This creates the POST /auth/register endpoint
  register(@Body(new ValidationPipe()) registerDto: RegisterDto) {
    return this.authService.register(registerDto);
  }
}