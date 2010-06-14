From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Date: Mon, 14 Jun 2010 11:31:16 +0000
Subject: S3C FB pixclock calculation
Message-Id: <4C161304.70903@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

one thing that has bothered me for some time is the fb pixclock value: this
seems rather arbitrary and undocumented (couldn't find it in the datasheets).

Though I did find an "algorithm", which I've used in the SmartQ machs for the
calculation of this value (I can't remember where I found it, I think it was in
the original SmartQ kernels).

So I made this small patch which does the calculation in the s3c fb driver
itself when the pixclock pdata hasn't been set (see below).

I've checked this against the SMDK6410 value (and ANW6410 and HMT, which are
identical) and it seems to match so I *think* this is correct, but as it's
undocumented I'm not sure.

Is anyone able to tell me whether I'm correct? (if so, I'll clean up this patch
and send it for inclusion)

--
Maurus Cuelenaere

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 9682ecc..17d882f 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -235,6 +235,22 @@ static int s3c_fb_calc_pixclk(struct s3c_fb *sfb, unsigned int pixclk)
 	return result;
 }

+static void s3c_fb_missing_pixclock(struct fb_videomode *mode)
+{
+	u64 pixclk = 1000000000000ULL;
+	u32 div;
+
+	div  = mode->left_margin + mode->hsync_len + mode->right_margin +
+	       mode->xres;
+	div *= mode->upper_margin + mode->vsync_len + mode->lower_margin +
+	       mode->yres;
+	div *= mode->refresh ? : 80;
+
+	do_div(pixclk, div);
+
+	mode->pixclock = pixclk;
+}
+
 /**
  * s3c_fb_align_word() - align pixel count to word boundary
  * @bpp: The number of bits per pixel
@@ -925,6 +941,9 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		if (!pd->win[win])
 			continue;

+		if (!pd->win[win]->win_mode.pixclock)
+			s3c_fb_missing_pixclock(&pd->win[win]->win_mode);
+
 		ret = s3c_fb_probe_win(sfb, win, &sfb->windows[win]);
 		if (ret < 0) {
 			dev_err(dev, "failed to create window %d\n", win);


