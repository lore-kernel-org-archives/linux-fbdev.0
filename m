From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 13/13] ps3fb: Default to 480p on
	DVI-D/HDMI if video=safe
Date: Fri, 12 Oct 2007 16:51:05 +0200
Message-ID: <20071012145130.961757000@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============0919478364=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgLsN-0003Dr-DX for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 07:52:31 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgLsK-0002qY-Rs
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 07:52:31 -0700
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
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org

--===============0919478364==
Content-Disposition: inline; filename=ps3-stable/ps3fb-safe-mode.diff

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Default to the 480p video mode on DVI-D and HDMI displays if
`video=safe' is passed on the kernel command line.

This is intended to be used by `kboot'-style boot loaders (i.e. first-stage
kernels) for the PS3, to provide a failsafe video mode.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/ps3/ps3av.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/ioctl.h>
+#include <linux/fb.h>
 
 #include <asm/firmware.h>
 #include <asm/ps3av.h>
@@ -33,6 +34,8 @@
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

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village ������ Da Vincilaan 7-D1 ������ B-1935 Zaventem ������ Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 ������ B-1840 Londerzeel ������ Belgium	
VAT BE 0413.825.160 ������ RPR Brussels	
Fortis Bank Zaventem ������ Swift GEBABEBB08A ������ IBAN BE39001382358619



--===============0919478364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============0919478364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0919478364==--
