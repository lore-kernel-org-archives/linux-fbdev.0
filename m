From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: latest patch for atyfb, even more patches
Date: Sat, 16 Oct 2004 23:47:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410162347.59630.alex.kern@gmx.de>
References: <200410120024.50968.alex.kern@gmx.de> <200410122042.53878.adaplas@hotpop.com> <200410152125.55255.alex.kern@gmx.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PcZcBKYloDM+pEf"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIwPQ-0007i9-EU
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 14:48:16 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CIwPP-0003tB-Gl
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 14:48:16 -0700
In-Reply-To: <200410152125.55255.alex.kern@gmx.de>
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
Cc: adaplas@pol.net, Arnaud FONTAINE <arnaud.fontaine@free.fr>, =?utf-8?q?Dani=C3=ABl_Mantione?= <daniel@deadlock.et.tudelft.nl>, Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Nicolas Souchu <nsouch@free.fr>, Ville =?utf-8?q?Syrj=C3=A4l=C3=A4?= <syrjala@sci.fi>

--Boundary-00=_PcZcBKYloDM+pEf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag, 15. Oktober 2004 21:25 schrieb Alexander Kern:
> Am Dienstag, 12. Oktober 2004 14:42 schrieb Antonino A. Daplas:
> > BTW, can you send me a changelog?
> >
> > Tony
>
> Alphabetical sort, please if I forgot something, add you comment.
>
> Alex Kern
> [PATCH] port Daniel Mantione 2.4 driver to 2.6
> [PATCH] add more pci_id number
> [PATCH] add accelerated imgblit
> [PATCH] revert SDRAM_MAGIC_PLL to old behaviour
> [PATCH] do a "from BIOS" initialisation only by __i386__
>
> Arnaud FONTAINE
> [PATCH atyfb] correction for 3D Rage Mobility L
>
> Geert Uytterhoeven
> [PATCH atyfb] Atari Atyfb fixes
> [PATCH atyfb] Atyfb on Mach64 GX or Atari
> [PATCH 468] m68k sparse floating point
>
> James Simmons
> [PATCH add] port to framebuffer_alloc api
>
> Nicolas Souchu
> [PATCH] I do not found a copy, but it was incorporated too
>
> Ville Syrj=E4l=E4
> [PATCH] fix pan with doublescan
> [PATCH] another double scan fix
> [PATCH] disable linear aperture register access
> [PATCH] Memory type correction
> [PATCH] atyfb (2.6): Fix mmio_start
> [PATCH] atyfb (2.6): Fix mem_refresh_rate for Mobility
> [PATCH] atyfb (2.6): Add RGB565 support
> [PATCH] atyfb: Blank LCD by turning off backlight voltage
> [PATCH] atyfb: Rage LT LCD register access
> [PATCH] atyfb: vblank irq support
> [PATCH] atyfb: MTRR support
>
Hi,  here is more patches to go

Our cursor API is a bit understandable, 80 % of drivers given up, and using=
=20
soft_cursor (see a comment in ffb.c#61).

Three drivers made an error and use cursor->enable insted of
info->cursor.enable.

[PATCH atyfb] fix hw cursor breakage

[PATCH g364fb] fix hw cursor breakage

[PATCH imsttfb] fix hw cursor breakage

And tdfxfb is in my mind, broken as a hell.
cut from tdfxfb_cursor function

#ifdef TDFX_HARDWARE_CURSOR
static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
{
=2E.....
	if (info->cursor.enable) {    < Hey it's right
=2E.....
	/* Turn the cursor on */
	cursor->enable =3D 1;
	info->cursor =3D *cursor;    < Outch!
}
#endif

Regards Alex

--Boundary-00=_PcZcBKYloDM+pEf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cursor-atyfb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cursor-atyfb.patch"

--- linux-2.6.8/drivers/video/aty/mach64_cursor.c	2004-10-15 22:25:16.000000000 +0200
+++ linux-2.6.head/drivers/video/aty/mach64_cursor.c	2004-10-16 22:57:34.434688080 +0200
@@ -198,7 +198,7 @@ int atyfb_cursor(struct fb_info *info, s
 	    }
 	}	
 	
-	if (cursor->enable) {
+	if (info->cursor.enable) {
 		wait_for_fifo(1, par);
 		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
 			    | HWCURSOR_ENABLE, par);

--Boundary-00=_PcZcBKYloDM+pEf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cursor-g364fb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cursor-g364fb.patch"

--- linux-2.6.8/drivers/video/g364fb.c	2004-10-15 22:19:15.000000000 +0200
+++ linux-2.6.head/drivers/video/g364fb.c	2004-10-16 23:11:33.687102320 +0200
@@ -128,7 +128,7 @@ static struct fb_ops g364fb_ops = {
 int g364fb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	
-	switch (cursor->enable) {
+	switch (info->cursor.enable) {
 	case CM_ERASE:
 		*(unsigned int *) CTLA_REG |= CURS_TOGGLE;
 		break;

--Boundary-00=_PcZcBKYloDM+pEf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="cursor-imsttfb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cursor-imsttfb.patch"

--- linux-2.6.8/drivers/video/imsttfb.c	2004-10-15 22:21:24.000000000 +0200
+++ linux-2.6.head/drivers/video/imsttfb.c	2004-10-16 23:12:28.787725752 +0200
@@ -1249,7 +1249,7 @@ imsttfb_cursor(struct fb_info *info, str
 
 		imsttfb_load_cursor_image(par, xx, yy, fgc);
 	}
-	if (cursor->enable)
+	if (info->cursor.enable)
 		imstt_set_cursor(info, cursor, 1);
 	return 0;
 }

--Boundary-00=_PcZcBKYloDM+pEf--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
