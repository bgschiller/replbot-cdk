import * as cdk from '@aws-cdk/core';
import { ReplbotCdkStack } from '../lib/replbot-cdk-stack';

if (!process.env.REPLBOT_TOKEN) {
  console.error('No environment variable found for REPLBOT_TOKEN');
  process.exit(1);
}

const app = new cdk.App();

new ReplbotCdkStack(app, 'devetry-replbot', {
  botToken: process.env.REPLBOT_TOKEN!
});

