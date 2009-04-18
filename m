From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] cvt: Exchange v_front_porch and
	v_back_porch
Date: Fri, 17 Apr 2009 18:24:28 -0700
Message-ID: <1240017868-16677-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tkisky@boundarydevices.com>) id 1LuzIU-0006UE-Tr
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Apr 2009 01:24:46 +0000
Received: from mpls-qmqp-04.inet.qwest.net ([63.231.195.115])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LuzIL-0008Vm-1C for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 18 Apr 2009 01:24:38 +0000
In-Reply-To: <>
References: <>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@gmail.com, Troy Kisky <troy.kisky@boundarydevices.com>

Make fbcvt agree with the cvt program output.
cvt always assigns 3 to the front porch.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

Not tested, there could be another bug that
cancels this out.
---
 drivers/video/fbcvt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbcvt.c b/drivers/video/fbcvt.c
index 0847c5e..2230103 100644
--- a/drivers/video/fbcvt.c
+++ b/drivers/video/fbcvt.c
@@ -368,8 +368,8 @@ int fb_find_mode_cvt(struct fb_videomode *mode, int margins, int rb)
 	cvt.h_back_porch = cvt.hblank/2 + cvt.h_margin;
 	cvt.h_front_porch = cvt.hblank - cvt.hsync - cvt.h_back_porch +
 		2 * cvt.h_margin;
-	cvt.v_back_porch = 3 + cvt.v_margin;
-	cvt.v_front_porch = cvt.vtotal - cvt.yres/cvt.interlace -
+	cvt.v_front_porch = 3 + cvt.v_margin;
+	cvt.v_back_porch = cvt.vtotal - cvt.yres/cvt.interlace -
 	    cvt.v_back_porch - cvt.vsync;
 	fb_cvt_print_name(&cvt);
 	fb_cvt_convert_to_mode(&cvt, mode);
-- 
1.5.4.3


------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
