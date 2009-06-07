From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH] video: s3c_fb.c: fix build with
	CONFIG_HOTPLUG=n
Date: Sun,  7 Jun 2009 15:05:39 +0200
Message-ID: <1244379939-23641-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jacmet@gmail.com>) id 1MDI4R-0007pX-0w
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 07 Jun 2009 13:05:55 +0000
Received: from mail-fx0-f225.google.com ([209.85.220.225])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MDI4P-0002gA-1E for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 07 Jun 2009 13:05:53 +0000
Received: by fxm25 with SMTP id 25so2414530fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 07 Jun 2009 06:05:40 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ben-linux@fluff.org, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Peter Korsgaard <jacmet@sunsite.dk>, wookey@wookware.org

Fixes `s3c_fb_remove' referenced in section `.data' of
drivers/built-in.o: defined in discarded section `.devexit.text' of
drivers/built-in.o

With CONFIG_HOTPLUG=n functions marked with __devexit gets removed, so
make sure we use __devexit_p when referencing pointers to them.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index d3a568e..db71de1 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1018,7 +1018,7 @@ static int s3c_fb_resume(struct platform_device *pdev)
 
 static struct platform_driver s3c_fb_driver = {
 	.probe		= s3c_fb_probe,
-	.remove		= s3c_fb_remove,
+	.remove		= __devexit_p(s3c_fb_remove),
 	.suspend	= s3c_fb_suspend,
 	.resume		= s3c_fb_resume,
 	.driver		= {
-- 
1.6.2


------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
