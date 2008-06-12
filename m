From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.26-rc3 01/10] pxafb: fix ifdef for
	command line option handling
Date: Thu, 12 Jun 2008 12:59:12 -0400
Message-ID: <1213289961-1562-2-git-send-email-jayakumar.lkml@gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6r26-0003dn-VP for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 10:56:23 -0700
Received: from wf-out-1314.google.com ([209.85.200.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6r25-0008E0-PM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 10:56:22 -0700
Received: by wf-out-1314.google.com with SMTP id 27so3712034wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 10:56:21 -0700 (PDT)
In-Reply-To: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ymiao3@marvell.com
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

This bug was found and fixed by Lothar Wassmann.

Previously, the use of ifndef CONFIG_MODULES made it such that pxafb command
line option parsing was dependent on whether the kernel was built with module
support. The ifndef should be MODULE so that parsing is dependent only on
whether the driver is built-in or not.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/video/pxafb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 274bc93..dd013f3 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1586,7 +1586,7 @@ static int __init pxafb_parse_options(struct device *dev, char *options)
 
 static char g_options[256] __devinitdata = "";
 
-#ifndef CONFIG_MODULES
+#ifndef MODULE
 static int __devinit pxafb_setup_options(void)
 {
 	char *options = NULL;
-- 
1.5.3.6


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
