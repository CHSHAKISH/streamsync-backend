// backend/src/main.ts
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common'; 

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // --- MAKE SURE THESE TWO LINES EXIST ---
  app.enableCors(); // Allows your app to call the backend
  app.setGlobalPrefix('api'); // This is the prefix
  // ------------------------------------

  app.useGlobalPipes(new ValidationPipe()); 

  await app.listen(3000);
}
bootstrap();