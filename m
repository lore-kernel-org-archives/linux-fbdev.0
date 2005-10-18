From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 13/17] s3c2410fb: initialise device_driver .owner
Date: Tue, 18 Oct 2005 17:21:20 +0800
Message-ID: <4354BE90.3080804@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyJD-0000eL-8m
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:43 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyJB-0000dG-V3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:43:43 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395707nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:43:41 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Ben Dooks <ben-linux@fluff.org>

From: Ben Dooks <ben-linux@fluff.org>

Initialise the .owner field, so that if the
driver is built as a module, the system has
a link to the owner

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 s3c2410fb.c |    1 +
 1 files changed, 1 insertion(+)


diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -883,6 +883,7 @@ static int s3c2410fb_resume(struct devic
 
 static struct device_driver s3c2410fb_driver = {
 	.name		= "s3c2410-lcd",
+	.owner		= THIS_MODULE,
 	.bus		= &platform_bus_type,
 	.probe		= s3c2410fb_probe,
 	.suspend	= s3c2410fb_suspend,




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
