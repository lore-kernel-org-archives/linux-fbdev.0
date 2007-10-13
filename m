From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 10/15] ps3fb: Default to 480p on
	DVI-D/HDMI if video=safe
Date: Sat, 13 Oct 2007 08:29:57 +0800
Message-ID: <47101185.4080902@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgVO8-0007hT-J3 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 18:01:58 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUya-0002xt-64
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:32 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:35:32 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Default to the 480p video mode on DVI-D and HDMI displays if
`video=safe' is passed on the kernel command line.

This is intended to be used by `kboot'-style boot loaders (i.e. first-stage
kernels) for the PS3, to provide a failsafe video mode.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/ps3/ps3av.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 0829641..397f4ce 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -23,6 +23,7 @@ #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/ioctl.h>
+#include <linux/fb.h>
 
 #include <asm/firmware.h>
 #include <asm/ps3av.h>
@@ -33,6 +34,8 @@ #include "vuart.h"
 #define BUFSIZE          4096	/* vuart buf size */
 #define PS3AV_BUF_SIZE   512	/* max packet size */
 
+static int safe_mode;
+
 static int timeout = 5000;	/* in msec ( 5 sec ) */
 module_param(timeout, int, 0644);
 
@@ -639,6 +642,9 @@ static int ps3av_hdmi_get_id(struct ps3a
 {
 	int id;
 
+	if (safe_mode)
+		return PS3AV_DEFAULT_HDMI_MODE_ID_REG_60;
+
 	/* check native resolution */
 	id = ps3av_resbit2id(info->res_50.native, info->res_60.native,
 			     info->res_vesa.native);
@@ -1021,7 +1027,14 @@ static int ps3av_probe(struct ps3_system
 		       res);
 
 	ps3av_get_hw_conf(ps3av);
+
+#ifdef CONFIG_FB
+	if (fb_mode_option && !strcmp(fb_mode_option, "safe"))
+		safe_mode = 1;
+#endif /* CONFIG_FB */
 	id = ps3av_auto_videomode(&ps3av->av_hw_conf);
+	safe_mode = 0;
+
 	mutex_lock(&ps3av->mutex);
 	ps3av->ps3av_mode = id;
 	mutex_unlock(&ps3av->mutex);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
