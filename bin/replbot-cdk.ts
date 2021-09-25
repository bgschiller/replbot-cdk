import * as cdk from '@aws-cdk/core';
import { ReplbotCdkStack } from '../lib/replbot-cdk-stack';

const app = new cdk.App();

new ReplbotCdkStack(app, 'devetry-replbot', {
  botToken: process.env.REPLBOT_TOKEN!
});

