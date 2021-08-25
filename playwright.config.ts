import { PlaywrightTestConfig } from '@playwright/test';

const projects = [];
for (const channel of ["chrome", undefined]) {
  for (const headless of [true, false]) {
    projects.push({
      name: `Channel: ${channel}, Headless: ${headless}`,
      use: {
        headless,
        channel,
      }
    })
  }
}

const config: PlaywrightTestConfig = {
  projects
};

export default config;
