From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: Blank LCD by turning off backlight voltage
Date: Thu, 17 Jun 2004 12:53:41 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617095341.GC28687@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yVhtmJPUSI46BTXb"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BataY-0001hi-Kp
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 02:53:42 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BataY-00060M-6A
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 02:53:42 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 59B834047E
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 12:53:41 +0300 (EEST)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch makes the blanking code turn the backlight voltage on/off.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-lcd_blank.patch"

diff -urN linux-orig/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux-orig/drivers/video/aty/atyfb_base.c	2004-06-17 11:41:21.265972568 +0300
+++ linux/drivers/video/aty/atyfb_base.c	2004-06-17 11:40:45.733374344 +0300
@@ -2464,7 +2464,14 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if ((_machine == _MACH_Pmac) && blank)
 		set_backlight_enable(0);
-#endif /* CONFIG_PMAC_BACKLIGHT */
+#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
+	if (par->lcd_table && blank &&
+	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
+		u32 pm = aty_ld_lcd(POWER_MANAGEMENT, par);
+		pm &= ~PWR_BLON;
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+	}
+#endif
 
 	gen_cntl = aty_ld_8(CRTC_GEN_CNTL, par);
 	if (blank > 0)
@@ -2488,7 +2495,15 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if ((_machine == _MACH_Pmac) && !blank)
 		set_backlight_enable(1);
-#endif /* CONFIG_PMAC_BACKLIGHT */
+#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
+	if (par->lcd_table && !blank &&
+	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
+		u32 pm = aty_ld_lcd(POWER_MANAGEMENT, par);
+		pm |= PWR_BLON;
+		aty_st_lcd(POWER_MANAGEMENT, pm, par);
+	}
+#endif
+
 	return 0;
 }
 

--yVhtmJPUSI46BTXb--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
