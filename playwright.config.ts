import { PlaywrightTestConfig } from '@playwright/test';

const projects = [];
for (const args of [["--use-gl=swiftshader"], undefined]) {
  for (const headless of [true, false]) {
    projects.push({
      name: `Chrome-Stable - Headless: ${headless}, Args: ${args}`,
      use: {
        headless,
        channel: "chrome",
        launchOptions: {
          args,
        },
      }
    })
  }
}

const config: PlaywrightTestConfig = {
  projects,
};

export default config;
