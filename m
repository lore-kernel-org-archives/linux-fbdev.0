From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 13 Mar 2012 09:34:32 +0000
Subject: [PATCH v3 2/3] video: s3c-fb: remove 'default_win' element from platform data
Message-Id: <002e01cd00fc$7efad9e0$7cf08da0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-3-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1331585999-8604-3-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Thomas Abraham <thomas.abraham@linaro.org>

The decision to enable or disable the data output to the lcd panel from
the controller need not be based on the value of 'default_win' element
in the platform data. Instead, the data output to the panel is enabled
if any of the windows are active, else data output is disabled.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
v3: fix some minor coding styles

 arch/arm/plat-samsung/include/plat/fb.h |    3 ---
 drivers/video/s3c-fb.c                  |   24 +++++-------------------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index 39d6bd7..b885322 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -43,7 +43,6 @@ struct s3c_fb_pd_win {
  * @setup_gpio: Setup the external GPIO pins to the right state to transfer
  *		the data from the display system to the connected display
  *		device.
- * @default_win: default window layer number to be used for UI layer.
  * @vidcon0: The base vidcon0 values to control the panel data format.
  * @vidcon1: The base vidcon1 values to control the panel data output.
  * @vtiming: Video timing when connected to a RGB type panel.
@@ -62,8 +61,6 @@ struct s3c_fb_platdata {
 	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
 	struct fb_videomode     *vtiming;
 
-	u32			 default_win;
-
 	u32			 vidcon0;
 	u32			 vidcon1;
 };
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index c94f40d..dd816fb 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -531,7 +531,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 	/* disable the window whilst we update it */
 	writel(0, regs + WINCON(win_no));
 
-	if (win_no = sfb->pdata->default_win)
+	if (!sfb->output_on)
 		s3c_fb_enable(sfb, 1);
 
 	/* write the buffer address */
@@ -799,6 +799,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 	struct s3c_fb *sfb = win->parent;
 	unsigned int index = win->index;
 	u32 wincon;
+	u32 output_on = sfb->output_on;
 
 	dev_dbg(sfb->dev, "blank mode %d\n", blank_mode);
 
@@ -844,27 +845,12 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 	 * it is highly likely that we also do not need to output
 	 * anything.
 	 */
-
-	/* We could do something like the following code, but the current
-	 * system of using framebuffer events means that we cannot make
-	 * the distinction between just window 0 being inactive and all
-	 * the windows being down.
-	 *
-	 * s3c_fb_enable(sfb, sfb->enabled ? 1 : 0);
-	*/
-
-	/* we're stuck with this until we can do something about overriding
-	 * the power control using the blanking event for a single fb.
-	 */
-	if (index = sfb->pdata->default_win) {
-		shadow_protect_win(win, 1);
-		s3c_fb_enable(sfb, blank_mode != FB_BLANK_POWERDOWN ? 1 : 0);
-		shadow_protect_win(win, 0);
-	}
+	s3c_fb_enable(sfb, sfb->enabled ? 1 : 0);
+	shadow_protect_win(win, 0);
 
 	pm_runtime_put_sync(sfb->dev);
 
-	return 0;
+	return output_on = sfb->output_on;
 }
 
 /**
-- 
1.7.1


