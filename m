From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH RESEND] video: s3c_fb.c: fix build with
	CONFIG_HOTPLUG=n
Date: Sun, 20 Sep 2009 17:29:22 +0200
Message-ID: <1253460562-691-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jacmet@gmail.com>) id 1MpOM9-0001xB-Nt
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Sep 2009 15:29:41 +0000
Received: from mail-ew0-f225.google.com ([209.85.219.225])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MpOM2-0000eH-5F for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Sep 2009 15:29:41 +0000
Received: by ewy25 with SMTP id 25so2345483ewy.33
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 20 Sep 2009 08:29:27 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org, ben-linux@fluff.org, linux-fbdev-devel@lists.sourceforge.net
Cc: Peter Korsgaard <jacmet@sunsite.dk>

Fixes `s3c_fb_remove' referenced in section `.data' of
drivers/built-in.o: defined in discarded section `.devexit.text' of
drivers/built-in.o

With CONFIG_HOTPLUG=n, functions marked with __devexit gets removed,
so make sure we use __devexit_p when referencing pointers to them.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
Acked-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Seems like this never made it to mainline, even though Ben acked it back
in June. Andrew, please push to Linus.

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 5a72083..adf9632 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1036,7 +1036,7 @@ static int s3c_fb_resume(struct platform_device *pdev)
 
 static struct platform_driver s3c_fb_driver = {
 	.probe		= s3c_fb_probe,
-	.remove		= s3c_fb_remove,
+	.remove		= __devexit_p(s3c_fb_remove),
 	.suspend	= s3c_fb_suspend,
 	.resume		= s3c_fb_resume,
 	.driver		= {
-- 
1.6.3.3


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
