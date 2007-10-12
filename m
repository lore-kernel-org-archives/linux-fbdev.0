From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 06/13] ps3fb: Make
	ps3fb_wait_for_vsync() and ps3fb_flip_ctl() static
Date: Fri, 12 Oct 2007 16:50:58 +0200
Message-ID: <20071012145130.182399000@pademelon.sonytel.be>
References: <20071012145052.640177000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1937156330=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgLsN-0003Dm-4R for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 07:52:31 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgLsK-0000md-Lj
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

--===============1937156330==
Content-Disposition: inline;
	filename=ps3-stable/ps3fb-ps3fb_wait_for_vsync-ps3fb_flip_ctl-static.diff

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

ps3fb: Make ps3fb_wait_for_vsync() and ps3fb_flip_ctl() static, as they're no
(longer) used outside ps3fb.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 drivers/video/ps3fb.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -652,7 +652,7 @@ static int ps3fb_get_vblank(struct fb_vb
 	return 0;
 }
 
-int ps3fb_wait_for_vsync(u32 crtc)
+static int ps3fb_wait_for_vsync(u32 crtc)
 {
 	int ret;
 	u64 count;
@@ -667,9 +667,7 @@ int ps3fb_wait_for_vsync(u32 crtc)
 	return 0;
 }
 
-EXPORT_SYMBOL_GPL(ps3fb_wait_for_vsync);
-
-void ps3fb_flip_ctl(int on, void *data)
+static void ps3fb_flip_ctl(int on, void *data)
 {
 	struct ps3fb_priv *priv = data;
 	if (on)

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



--===============1937156330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1937156330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1937156330==--
