From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] atyfb: Rage LT LCD register access.
Date: Thu, 17 Jun 2004 12:51:34 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617095134.GB28687@sci.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aVD9QWMuhilNxW9f"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BatYY-0001bq-Fh
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 02:51:38 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BatYX-0000vE-41
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 02:51:37 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id A2CA03FB88
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 12:51:34 +0300 (EEST)
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


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patch is an attempt to make the LCD code work for Rage LT chips.

I don't actually own a Rage LT (only LT Pro) so the code is completely=20
untested in that regards...

I also got rid of the two different power management functions. I changed=
=20
the timeouts so that the bigger of the previosuly used values is now used=
=20
in every step. Also untested...

The mach64_ct.c changes actually affect all chips since before it was=20
trying to write to the LCD registers using aty_{ld,st}_le32(). This=20
almost gets rid of the visual garble I see when atyfb takes over my LT=20
Pro but not quite. Apparently the LCD would need to be turned off even=20
earlier to fix this.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="atyfb-2.6-lt_lcd_regs.patch"

diff -urN linux-orig/drivers/video/aty/atyfb.h linux/drivers/video/aty/atyfb.h
--- linux-orig/drivers/video/aty/atyfb.h	2004-06-17 09:23:25.000000000 +0300
+++ linux/drivers/video/aty/atyfb.h	2004-06-17 10:44:00.133104280 +0300
@@ -192,7 +192,7 @@
 #define M64F_G3_PB_1_1		0x00008000
 #define M64F_G3_PB_1024x768	0x00010000
 #define M64F_EXTRA_BRIGHT	0x00020000
-#define M64F_LT_SLEEP		0x00040000
+#define M64F_LT_LCD_REGS	0x00040000
 #define M64F_XL_DLL		0x00080000
 #define M64F_MFB_FORCE_4	0x00100000
 #define M64F_HW_TRIPLE		0x00200000
@@ -252,6 +252,11 @@
 #endif
 }
 
+#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
+extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
+extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
+#endif
+
     /*
      *  DAC operations
      */
diff -urN linux-orig/drivers/video/aty/atyfb_base.c linux/drivers/video/aty/atyfb_base.c
--- linux-orig/drivers/video/aty/atyfb_base.c	2004-06-17 09:23:25.000000000 +0300
+++ linux/drivers/video/aty/atyfb_base.c	2004-06-17 11:14:01.101315496 +0300
@@ -106,26 +106,46 @@
 #define FAIL_MAX(msg, x, _max_) do { if(x > _max_) { printk(KERN_CRIT msg " %x(%x)\n", x, _max_); return -EINVAL; } } while (0)
 
 #if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD)
-static void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
+static const u32 lt_lcd_regs[] = {
+	CONFIG_PANEL_LG,
+	LCD_GEN_CNTL_LG,
+	DSTN_CONTROL_LG,
+	HFB_PITCH_ADDR_LG,
+	HORZ_STRETCHING_LG,
+	VERT_STRETCHING_LG,
+	0, /* EXT_VERT_STRETCH */
+	LT_GIO_LG,
+	POWER_MANAGEMENT_LG
+};
+
+void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
 {
-	unsigned long temp;
+	if (M64_HAS(LT_LCD_REGS)) {
+		aty_st_le32(lt_lcd_regs[index], val, par);
+	} else {
+		unsigned long temp;
 
-	/* write addr byte */
-	temp = aty_ld_le32(LCD_INDEX, par);
-	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
-	/* write the register value */
-	aty_st_le32(LCD_DATA, val, par);
+		/* write addr byte */
+		temp = aty_ld_le32(LCD_INDEX, par);
+		aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
+		/* write the register value */
+		aty_st_le32(LCD_DATA, val, par);
+	}
 }
 
-static u32 aty_ld_lcd(int index, const struct atyfb_par *par)
+u32 aty_ld_lcd(int index, const struct atyfb_par *par)
 {
-	unsigned long temp;
+	if (M64_HAS(LT_LCD_REGS)) {
+		return aty_ld_le32(lt_lcd_regs[index], par);
+	} else {
+		unsigned long temp;
 
-	/* write addr byte */
-	temp = aty_ld_le32(LCD_INDEX, par);
-	aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
-	/* read the register value */
-	return aty_ld_le32(LCD_DATA, par);
+		/* write addr byte */
+		temp = aty_ld_le32(LCD_INDEX, par);
+		aty_st_le32(LCD_INDEX, (temp & ~LCD_INDEX_MASK) | index, par);
+		/* read the register value */
+		return aty_ld_le32(LCD_DATA, par);
+	}
 }
 #endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
 
@@ -573,7 +593,8 @@
 		/* get stretching */
 		crtc->horz_stretching = aty_ld_lcd(HORZ_STRETCHING, par);
 		crtc->vert_stretching = aty_ld_lcd(VERT_STRETCHING, par);
-		crtc->ext_vert_stretch = aty_ld_lcd(EXT_VERT_STRETCH, par);
+		if (!M64_HAS(LT_LCD_REGS))
+			crtc->ext_vert_stretch = aty_ld_lcd(EXT_VERT_STRETCH, par);
 	}
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
 }
@@ -647,7 +668,8 @@
 		printk(KERN_INFO "LCD_GEN_CNTL: %x\n", temp);
 		printk(KERN_INFO "HORZ_STRETCHING: %x\n", crtc->horz_stretching);
 		printk(KERN_INFO "VERT_STRETCHING: %x\n", crtc->vert_stretching);
-		printk(KERN_INFO "EXT_VERT_STRETCH: %x\n", crtc->ext_vert_stretch);
+		if (!M64_HAS(LT_LCD_REGS))
+			printk(KERN_INFO "EXT_VERT_STRETCH: %x\n", crtc->ext_vert_stretch);
 #endif
 		/* Restore CRTC selection & shadow state */
 		/*aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);*/
@@ -655,7 +677,8 @@
 		/* Enable/disable stretching */
 		aty_st_lcd(HORZ_STRETCHING, crtc->horz_stretching, par);
 		aty_st_lcd(VERT_STRETCHING, crtc->vert_stretching, par);
-		aty_st_lcd(EXT_VERT_STRETCH, crtc->ext_vert_stretch, par);
+		if (!M64_HAS(LT_LCD_REGS))
+			aty_st_lcd(EXT_VERT_STRETCH, crtc->ext_vert_stretch, par);
 		/*
 		outr(LCD_INDEX, pATIHW->lcd_index);
 		*/
@@ -741,7 +764,10 @@
 
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table != 0) {
-		u32 lcd_index = aty_ld_le32(LCD_INDEX, par);
+		u32 lcd_index;
+		if (!M64_HAS(LT_LCD_REGS))
+			lcd_index = aty_ld_le32(LCD_INDEX, par);
+
 		lcd_on_off = aty_ld_lcd(LCD_GEN_CNTL, par);
 
 		if((lcd_on_off & LCD_ON) &&
@@ -759,7 +785,8 @@
 				FAIL("Video mode exceeds size of lcd panel.\nConnect this computer to a conventional monitor if you really need this mode.");
 			}
 		}
-		aty_st_le32(LCD_INDEX, lcd_index, par);
+		if (!M64_HAS(LT_LCD_REGS))
+			aty_st_le32(LCD_INDEX, lcd_index, par);
 	}
 
 	if ((par->lcd_table != 0) && (lcd_on_off & LCD_ON)) {
@@ -911,8 +938,9 @@
 */
 		/* MOBILITY M1 tested, FIXME: LT */
 		crtc->horz_stretching = aty_ld_lcd(HORZ_STRETCHING, par);
-		crtc->ext_vert_stretch = aty_ld_lcd(EXT_VERT_STRETCH, par) &
-			~(AUTO_VERT_RATIO | VERT_STRETCH_MODE | VERT_STRETCH_RATIO3);
+		if (!M64_HAS(LT_LCD_REGS))
+			crtc->ext_vert_stretch = aty_ld_lcd(EXT_VERT_STRETCH, par) &
+				~(AUTO_VERT_RATIO | VERT_STRETCH_MODE | VERT_STRETCH_RATIO3);
 
 		crtc->horz_stretching &=
 			~(HORZ_STRETCH_RATIO | HORZ_STRETCH_LOOP | AUTO_HORZ_RATIO |
@@ -983,7 +1011,8 @@
 			crtc->vert_stretching = (VERT_STRETCH_USE0 | VERT_STRETCH_EN |
 				(((VDisplay * (VERT_STRETCH_RATIO0 + 1)) / par->lcd_height) & VERT_STRETCH_RATIO0));
 
-			if (xres <= (M64_HAS(MOBIL_BUS)?1024:800))
+			if (!M64_HAS(LT_LCD_REGS) &&
+			    xres <= (M64_HAS(MOBIL_BUS)?1024:800))
 				crtc->ext_vert_stretch |= VERT_STRETCH_MODE;
 		} else {
 			/*
@@ -1346,9 +1375,18 @@
 		/* LCD registers */
 		base = 0x00;
 		printk("LCD register values:");
-		for (i = 0; i < 64; i++) {
-			if(i%4 == 0) printk("\n0x%02X: ", base + i);
-			printk(" %08X", aty_ld_lcd(i, par));
+		if (M64_HAS(LT_LCD_REGS)) {
+			for (i = 0; i <= POWER_MANAGEMENT; i++) {
+				if (i == EXT_VERT_STRETCH)
+					continue;
+				printk("\n0x%04X: ", lt_lcd_regs[i]);
+				printk(" %08X", aty_ld_lcd(i, par));
+			}
+		} else {
+			for (i = 0; i < 64; i++) {
+				if(i%4 == 0) printk("\n0x%02X: ", base + i);
+				printk(" %08X", aty_ld_lcd(i, par));
+			}
 		}
 		printk("\n\n");
 	}
@@ -1743,69 +1781,10 @@
 #if defined(CONFIG_PM) && defined(CONFIG_PCI)
 
 /* Power management routines. Those are used for PowerBook sleep.
- *
- * It appears that Rage LT and Rage LT Pro have different power
- * management registers. There's is some confusion about which
- * chipID is a Rage LT or LT pro :(
  */
-static int aty_power_mgmt_LT(int sleep, struct atyfb_par *par)
-{
-	unsigned int pm;
-	int timeout;
-
-	pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
-	pm = (pm & ~PWR_MGT_MODE_MASK) | PWR_MGT_MODE_REG;
-	aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
-	pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
-
-	timeout = 200000;
-	if (sleep) {
-		/* Sleep */
-		pm &= ~PWR_MGT_ON;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
-		pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
-		udelay(10);
-		pm &= ~(PWR_BLON | AUTO_PWR_UP);
-		pm |= SUSPEND_NOW;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
-		pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
-		udelay(10);
-		pm |= PWR_MGT_ON;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
-		do {
-			pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
-			udelay(10);
-			if ((--timeout) == 0)
-				break;
-		} while ((pm & PWR_MGT_STATUS_MASK) != PWR_MGT_STATUS_SUSPEND);
-	} else {
-		/* Wakeup */
-		pm &= ~PWR_MGT_ON;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
-		pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
-		udelay(10);
-		pm |= (PWR_BLON | AUTO_PWR_UP);
-		pm &= ~SUSPEND_NOW;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
-		pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
-		udelay(10);
-		pm |= PWR_MGT_ON;
-		aty_st_le32(POWER_MANAGEMENT_LG, pm, par);
-		do {
-			pm = aty_ld_le32(POWER_MANAGEMENT_LG, par);
-			udelay(10);
-			if ((--timeout) == 0)
-				break;
-		} while ((pm & PWR_MGT_STATUS_MASK) != 0);
-	}
-	mdelay(500);
-
-	return timeout ? -1 : 0;
-}
-
-static int aty_power_mgmt_LTPro(int sleep, struct atyfb_par *par)
+static int aty_power_mgmt(int sleep, struct atyfb_par *par)
 {
-	unsigned int pm;
+	u32 pm;
 	int timeout;
 
 	pm = aty_ld_lcd(POWER_MANAGEMENT, par);
@@ -1813,7 +1792,7 @@
 	aty_st_lcd(POWER_MANAGEMENT, pm, par);
 	pm = aty_ld_lcd(POWER_MANAGEMENT, par);
 
-	timeout = 200;
+	timeout = 2000;
 	if (sleep) {
 		/* Sleep */
 		pm &= ~PWR_MGT_ON;
@@ -1853,16 +1832,11 @@
 				break;
 		} while ((pm & PWR_MGT_STATUS_MASK) != 0);
 	}
+	mdelay(500);
 
 	return timeout ? -1 : 0;
 }
 
-static int aty_power_mgmt(int sleep, struct atyfb_par *par)
-{
-	return M64_HAS(LT_SLEEP) ? aty_power_mgmt_LT(sleep, par)
-	    : aty_power_mgmt_LTPro(sleep, par);
-}
-
 static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
diff -urN linux-orig/drivers/video/aty/mach64_ct.c linux/drivers/video/aty/mach64_ct.c
--- linux-orig/drivers/video/aty/mach64_ct.c	2004-06-17 09:23:25.000000000 +0300
+++ linux/drivers/video/aty/mach64_ct.c	2004-06-17 09:48:49.000000000 +0300
@@ -281,8 +281,8 @@
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table != 0) {
 		/* turn off LCD */
-		lcd_gen_cntrl = aty_ld_le32(LCD_GEN_CNTL, par);
-		aty_st_le32(LCD_GEN_CNTL, lcd_gen_cntrl & ~LCD_ON, par);
+		lcd_gen_cntrl = aty_ld_lcd(LCD_GEN_CNTL, par);
+		aty_st_lcd(LCD_GEN_CNTL, lcd_gen_cntrl & ~LCD_ON, par);
 	}
 #endif
 	aty_st_8(CLOCK_CNTL, par->clk_wr_offset | CLOCK_STROBE, par);
@@ -351,7 +351,7 @@
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table != 0) {
 		/* restore LCD */
-		aty_st_le32(LCD_GEN_CNTL, lcd_gen_cntrl, par);
+		aty_st_lcd(LCD_GEN_CNTL, lcd_gen_cntrl, par);
 	}
 #endif
 }
diff -urN linux-orig/include/video/mach64.h linux/include/video/mach64.h
--- linux-orig/include/video/mach64.h	2004-06-17 09:23:25.000000000 +0300
+++ linux/include/video/mach64.h	2004-06-17 11:03:21.338574216 +0300
@@ -68,6 +68,8 @@
 
 #define I2C_CNTL_0		0x003C	/* Dword offset 0_0F */
 
+#define DSTN_CONTROL_LG		0x003C	/* Dword offset 0_0F (LG) */
+
 /* Overscan */
 #define OVR_CLR			0x0040	/* Dword offset 0_10 */
 #define OVR2_CLR		0x0040	/* Dword offset 0_10 */
@@ -101,7 +103,7 @@
 #define CUR_HORZ_VERT_OFF	0x0070	/* Dword offset 0_1C */
 #define CUR2_HORZ_VERT_OFF	0x0070	/* Dword offset 0_1C */
 
-#define CONFIG_PANEL_LG		0x0074	/* Dword offset 0_1D */
+#define CONFIG_PANEL_LG		0x0074	/* Dword offset 0_1D (LG) */
 
 /* General I/O Control */
 #define GP_IO			0x0078	/* Dword offset 0_1E */
@@ -153,6 +155,8 @@
 #define LCD_INDEX		0x00A4	/* Dword offset 0_29 */
 #define LCD_DATA		0x00A8	/* Dword offset 0_2A */
 
+#define HFB_PITCH_ADDR_LG	0x00A8	/* Dword offset 0_2A (LG) */
+
 /* Memory Control */
 #define EXT_MEM_CNTL		0x00AC	/* Dword offset 0_2B */
 #define MEM_CNTL		0x00B0	/* Dword offset 0_2C */
@@ -161,6 +165,8 @@
 
 #define I2C_CNTL_1		0x00BC	/* Dword offset 0_2F */
 
+#define LT_GIO_LG		0x00BC	/* Dword offset 0_2F (LG) */
+
 /* DAC Control */
 #define DAC_REGS		0x00C0	/* Dword offset 0_30 */
 #define DAC_W_INDEX		0x00C0	/* Dword offset 0_30 */
@@ -171,14 +177,16 @@
 
 #define EXT_DAC_REGS		0x00C8	/* Dword offset 0_32 */
 
+#define HORZ_STRETCHING_LG	0x00C8	/* Dword offset 0_32 (LG) */
+#define VERT_STRETCHING_LG	0x00CC	/* Dword offset 0_33 (LG) */
+
 /* Test and Debug */
 #define GEN_TEST_CNTL		0x00D0	/* Dword offset 0_34 */
 
 /* Custom Macros */
 #define CUSTOM_MACRO_CNTL	0x00D4	/* Dword offset 0_35 */
 
-#define LCD_GEN_CNTL_LG		0x00D4	/* Dword offset 0_35 */
-
+#define LCD_GEN_CNTL_LG		0x00D4	/* Dword offset 0_35 (LG) */
 #define POWER_MANAGEMENT_LG	0x00D8	/* Dword offset 0_36 (LG) */
 
 /* Configuration */

--aVD9QWMuhilNxW9f--


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
