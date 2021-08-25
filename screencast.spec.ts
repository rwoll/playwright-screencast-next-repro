import { test, expect } from '@playwright/test';

test('should produce screencast frame', async ({ context, page }) => {
  const cdp = await context.newCDPSession(page);
  const screencastFrame = new Promise(res => {
    cdp.once("Page.screencastFrame", res);
  });
  await cdp.send("Page.startScreencast");
  await page.goto('https://playwright.dev/');
  expect(await page.screenshot()).toMatchSnapshot("playwright.png");
  await screencastFrame;
});
