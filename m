From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 09 Jul 2010 08:49:50 +0000
Subject: [PATCH 02/19] s3c-fb: add default window feature.
Message-Id: <1278665407-18002-3-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: InKi Dae <inki.dae@samsung.com>

s5pv210 has five window layers (window0 ~ 4), among them,
window0 ~ 2 could be used for local path with fimc(capture device)
and fimd writeback feature so this patch makes default window layer
for UI to be set at machine code.

Signed-off-by: InKi Dae <inki.dae@samsung.com>
Reviewed-by: KyungMin Park <kyungmin.park.samsung.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
---
 arch/arm/plat-samsung/include/plat/fb.h |    3 +++
 drivers/video/s3c-fb.c                  |    6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index 27d3b49..cb3ca3a 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -42,6 +42,7 @@ struct s3c_fb_pd_win {
  * @setup_gpio: Setup the external GPIO pins to the right state to transfer
  *		the data from the display system to the connected display
  *		device.
+ * @default_win: default window layer number to be used for UI layer.
  * @vidcon0: The base vidcon0 values to control the panel data format.
  * @vidcon1: The base vidcon1 values to control the panel data output.
  * @win: The setup data for each hardware window, or NULL for unused.
@@ -58,6 +59,8 @@ struct s3c_fb_platdata {
 
 	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
 
+	u32			 default_win;
+
 	u32			 vidcon0;
 	u32			 vidcon1;
 };
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 9682ecc..c4639c4 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -300,9 +300,9 @@ static int s3c_fb_set_par(struct fb_info *info)
 	/* disable the window whilst we update it */
 	writel(0, regs + WINCON(win_no));
 
-	/* use window 0 as the basis for the lcd output timings */
+	/* use platform specified window as the basis for the lcd timings */
 
-	if (win_no = 0) {
+	if (win_no = sfb->pdata->default_win) {
 		clkdiv = s3c_fb_calc_pixclk(sfb, var->pixclock);
 
 		data = sfb->pdata->vidcon0;
@@ -636,7 +636,7 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 	/* we're stuck with this until we can do something about overriding
 	 * the power control using the blanking event for a single fb.
 	 */
-	if (index = 0)
+	if (index = sfb->pdata->default_win)
 		s3c_fb_enable(sfb, blank_mode != FB_BLANK_POWERDOWN ? 1 : 0);
 
 	return 0;
-- 
1.7.1.569.g6f426

