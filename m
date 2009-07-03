From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] [drivers] [fb] S3C-fb: fix off-by-one
	bug in loop indexes
Date: Fri, 03 Jul 2009 08:56:38 +0200
Message-ID: <E4D3F24EA6C9E54F817833EAE0D912AC076E71C036@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <m.szyprowski@samsung.com>) id 1MMciw-0001HX-4D
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Jul 2009 06:58:18 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMcip-0004NB-M0 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Jul 2009 06:58:18 +0000
Received: from eu_spt2 (mailout1.w1.samsung.com [210.118.77.11])
	by mailout1.w1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KM700C9L20OMI@mailout1.w1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Jul 2009 07:58:00 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
	by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul
	14 2004)) with ESMTPA id <0KM700LEM20OZT@spt2.w1.samsung.com> for
	linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Jul 2009 07:58:01 +0100 (BST)
Content-language: en-US
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>

From: Pawel Osciak <p.osciak@samsung.com>

Fixed off-by-one bug in loop indexes - some elements beyond windows' array were
accessed, which might result in memory access violations when removing/suspending
the device.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


--- 

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 094bfeb..92f2a59 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -970,7 +970,7 @@ static int __devexit s3c_fb_remove(struct platform_device *pdev)
 	struct s3c_fb *sfb = platform_get_drvdata(pdev);
 	int win;
 
-	for (win = 0; win <= S3C_FB_MAX_WIN; win++)
+	for (win = 0; win < S3C_FB_MAX_WIN; win++)
 		if (sfb->windows[win])
 			s3c_fb_release_win(sfb, sfb->windows[win]);
 
@@ -994,7 +994,7 @@ static int s3c_fb_suspend(struct platform_device *pdev, pm_message_t state)
 	struct s3c_fb_win *win;
 	int win_no;
 
-	for (win_no = S3C_FB_MAX_WIN; win_no >= 0; win_no--) {
+	for (win_no = S3C_FB_MAX_WIN - 1; win_no >= 0; win_no--) {
 		win = sfb->windows[win_no];
 		if (!win)
 			continue;


------------------------------------------------------------------------------
