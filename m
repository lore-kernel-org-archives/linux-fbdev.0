From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 4/8] pxa: sanitize the usage of #ifdef
	.. processing pxafb parameters
Date: Wed, 27 Feb 2008 10:36:00 +0800
Message-ID: <f17812d70802261836j7cb106a4m8eb721af05f9086@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUC9J-0003PK-KP for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:36:01 -0800
Received: from el-out-1112.google.com ([209.85.162.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUC9J-0003xk-3v
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:36:01 -0800
Received: by el-out-1112.google.com with SMTP id y26so2497055ele.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Feb 2008 18:36:00 -0800 (PST)
Content-Disposition: inline
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
To: linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

From 1557a30cfaa0e941c258a6c74f7c2568f61511cd Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Tue, 26 Feb 2008 18:04:44 +0800
Subject: [PATCH] pxa: sanitize the usage of #ifdef .. processing pxafb
parameters

So to get a better coding style and centralize the pxafb parameters
handling code.

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c |   57 ++++++++++++++++++++++++-------------------------
 1 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 4b513f4..245550d 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -70,11 +70,6 @@ static int pxafb_activate_var(struct fb_var_screeninfo *var,
 				struct pxafb_info *);
 static void set_ctrlr_state(struct pxafb_info *fbi, u_int state);

-#ifdef CONFIG_FB_PXA_PARAMETERS
-#define PXAFB_OPTIONS_SIZE 256
-static char g_options[PXAFB_OPTIONS_SIZE] __devinitdata = "";
-#endif
-
 static inline void pxafb_schedule_work(struct pxafb_info *fbi, u_int state)
 {
 	unsigned long flags;
@@ -1315,6 +1310,32 @@ static int __init pxafb_parse_options(struct
device *dev, char *options)
 	}
 	return 0;
 }
+
+static char g_options[256] __devinitdata = "";
+
+#ifndef CONFIG_MODULES
+static int __devinit pxafb_setup_options(void)
+{
+	char *options = NULL;
+
+	if (fb_get_options("pxafb", &options))
+		return -ENODEV;
+
+	if (options)
+		strlcpy(g_options, options, sizeof(g_options));
+
+	return 0;
+}
+#else
+#define pxafb_setup_options()		(0)
+
+module_param_string(options, g_options, sizeof(g_options), 0);
+MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
+#endif
+
+#else
+#define pxafb_parse_options(...)	(0)
+#define pxafb_setup_options()		(0)
 #endif

 static int __init pxafb_probe(struct platform_device *dev)
@@ -1331,11 +1352,9 @@ static int __init pxafb_probe(struct
platform_device *dev)
 	if (!inf)
 		goto failed;

-#ifdef CONFIG_FB_PXA_PARAMETERS
 	ret = pxafb_parse_options(&dev->dev, g_options);
 	if (ret < 0)
 		goto failed;
-#endif

 #ifdef DEBUG_VAR
 	/* Check for various illegal bit-combinations. Currently only
@@ -1448,31 +1467,11 @@ static struct platform_driver pxafb_driver = {
 	},
 };

-#ifndef MODULE
-static int __devinit pxafb_setup(char *options)
-{
-# ifdef CONFIG_FB_PXA_PARAMETERS
-	if (options)
-		strlcpy(g_options, options, sizeof(g_options));
-# endif
-	return 0;
-}
-#else
-# ifdef CONFIG_FB_PXA_PARAMETERS
-module_param_string(options, g_options, sizeof(g_options), 0);
-MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
-# endif
-#endif
-
 static int __devinit pxafb_init(void)
 {
-#ifndef MODULE
-	char *option = NULL;
+	if (pxafb_setup_options())
+		return -EINVAL;

-	if (fb_get_options("pxafb", &option))
-		return -ENODEV;
-	pxafb_setup(option);
-#endif
 	return platform_driver_register(&pxafb_driver);
 }

-- 
1.5.3.8



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
