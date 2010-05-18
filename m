From: Ben Dooks <ben-linux@fluff.org>
Date: Tue, 18 May 2010 10:54:02 +0000
Subject: [PATCH 2/5] s3c-fb: only init window colour key controls for windows with blending
Message-Id: <1274180045-14645-3-git-send-email-ben-linux@fluff.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
In-Reply-To: <1274180045-14645-1-git-send-email-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The driver clears all windows, but also sets the windows' colour key
controls at the same time. However, the last window does not have these
registers as it is always blended into the previous window.

Move the colour key initialisation into the probe, and run it for only
nr_win-1 windows.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/video/s3c-fb.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 9682ecc..2403ed3 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -844,9 +844,6 @@ static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
 	void __iomem *regs = sfb->regs;
 
 	writel(0, regs + WINCON(win));
-	writel(0xffffff, regs + WxKEYCONy(win, 0));
-	writel(0xffffff, regs + WxKEYCONy(win, 1));
-
 	writel(0, regs + VIDOSD_A(win));
 	writel(0, regs + VIDOSD_B(win));
 	writel(0, regs + VIDOSD_C(win));
@@ -919,6 +916,12 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	for (win = 0; win < S3C_FB_MAX_WIN; win++)
 		s3c_fb_clear_win(sfb, win);
 
+	/* initialise colour key controls */
+	for (win = 0; win < (S3C_FB_MAX_WIN - 1); win++) {
+		writel(0xffffff, sfb->regs + WxKEYCONy(win, 0));
+		writel(0xffffff, sfb->regs + WxKEYCONy(win, 1));
+	}
+
 	/* we have the register setup, start allocating framebuffers */
 
 	for (win = 0; win < S3C_FB_MAX_WIN; win++) {
@@ -1019,6 +1022,11 @@ static int s3c_fb_resume(struct platform_device *pdev)
 	for (win_no = 0; win_no < S3C_FB_MAX_WIN; win_no++)
 		s3c_fb_clear_win(sfb, win_no);
 
+	for (win_no = 0; win_no < S3C_FB_MAX_WIN - 1; win_no++) {
+		writel(0xffffff, sfb->regs + WxKEYCONy(win_no, 1));
+		writel(0xffffff, sfb->regs + WxKEYCONy(win_no, 1));
+	}
+
 	/* restore framebuffers */
 	for (win_no = 0; win_no < S3C_FB_MAX_WIN; win_no++) {
 		win = sfb->windows[win_no];
-- 
1.6.3.3

