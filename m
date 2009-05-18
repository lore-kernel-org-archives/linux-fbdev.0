From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] [drivers] [fb] S3C-fb: PM fix
Date: Mon, 18 May 2009 08:05:46 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC0226526883@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Andrew Morton <akpm@linux-foundation.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Restore correctly FrameBuffer registers state in resume function.

Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

--- 

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 5e9c630..d3a568e 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -947,7 +947,8 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 	int win;
 
 	for (win = 0; win <= S3C_FB_MAX_WIN; win++)
-		s3c_fb_release_win(sfb, sfb->windows[win]);
+		if (sfb->windows[win])
+			s3c_fb_release_win(sfb, sfb->windows[win]);
 
 	iounmap(sfb->regs);
 
@@ -985,11 +986,20 @@ static int s3c_fb_suspend(struct platform_device *pdev, pm_message_t state)
 static int s3c_fb_resume(struct platform_device *pdev)
 {
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
+	struct s3c_fb_platdata *pd = sfb->pdata;
 	struct s3c_fb_win *win;
 	int win_no;
 
 	clk_enable(sfb->bus_clk);
 
+	/* setup registers */
+	writel(pd->vidcon1, sfb->regs + VIDCON1);
+
+	/* zero all windows before we do anything */
+	for (win_no = 0; win_no < S3C_FB_MAX_WIN; win_no++)
+		s3c_fb_clear_win(sfb, win_no);
+
+	/* restore framebuffers */
 	for (win_no = 0; win_no < S3C_FB_MAX_WIN; win_no++) {
 		win = sfb->windows[win_no];
 		if (!win)


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
