From: Jakub Bogusz <qboosh@pld.org.pl>
Subject: tdfxfb patch - fixes and enhancements
Date: Mon, 9 Dec 2002 22:35:48 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021209213548.GC8048@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tsOsTdHNUZQcU9Ye"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pg6.warszawa.cvx.ppp.tpnet.pl ([213.76.102.6] helo=satan.blackhosts)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18LWOD-0006KU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Dec 2002 14:28:53 -0800
Received: from satan.blackhosts (localhost [127.0.0.1])
	by satan.blackhosts (8.12.6/8.12.6) with ESMTP id gB9MYXmM021081
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Dec 2002 23:34:58 +0100
Received: (from qboosh@localhost)
	by satan.blackhosts (8.12.6/8.12.6/Submit) id gB9LZmDZ019880
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 9 Dec 2002 22:35:48 +0100
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

(note that I'm not subscriber, so please Cc answers to me)

Is this list proper place for tdfxfb-related things, or should I post to
some other address (linux-kernel?)?
I don't see tdfxfb in MAINTAINERS file.

1. hardware cursor (seems to be Voodoo4, maybe Voodoo5 too, specific).
On my Voodoo4 4500 I got some (mostly white) junk in bottom 48 (of 64)
lines of hardware cursor. After setting hardware cursor base 1 page
lower (alternatively speaking, rounding it to even page boundary),
cursor is displayed correctly.

2. 16/24/32bpp modes should be defined as TRUECOLOR, not DIRECTCOLOR.
It's because Voodoo (or at least tdfxfb driver) doesn't support colour
mapping in high- and true-colour modes.
This seems to be already fixed in Linux 2.5 tree.
It caused displaying Tux logo in wrong colours on 16/24/32bpp tdfxfb.

3. (partial) double-scan modes support.
Double-scan modes were silently not supported (flag was set only in
internal data structure, but not in chipset); with my patch, it's
possible to set such mode (but without hardware cursor - because it's
handled in normal Y coordinate, not doubled).

4. interlaced modes support.
As far as I could find - Voodoo Banshee doesn't support interlace, but
Voodoo3 (at least some models) and higher do.
With patch, it works on my Voodoo4 4500 (refresh rate seems to be fixed
at 50Hz (for TV Out, which I don't have?), but it's still useful for
displaying some high resolution picture for a while).

Attached patch was made againt Linux 2.4.20, and requires some changes
for 2.5 tree (BTW, it seems that hardware cursor support is gone in
tdfxfb for 2.5?).


-- 
Jakub Bogusz    http://www.cs.net.pl/~qboosh/
PLD Linux       http://www.pld.org.pl/

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-fixes.patch"

This patch contains:
* fix for hardware cursor
  (Voodoo4 4500 specific problem??? bottom 48 lines contained random data
   if cursor start address was not aligned down to even page boundary...)
* fix for logo colours
  (I'm not sure about hardware, but at least this driver doesn't support colour
   lookup tables in 16/24/32bpp, so visual must be TRUECOLOR, not DIRECTCOLOR)
* interlace support (works on Voodoo4 (50 Hz only?), problably Voodoo[35] too)
* partial doublescan support (hardware cursor still doesn't work correctly,
  but such modes doesn't just turn monitor out-of-sync)

        -- Jakub Bogusz <qboosh@pld.org.pl>
	
--- linux-2.4.20/drivers/video/tdfxfb.c.orig	Mon Feb 25 20:38:07 2002
+++ linux-2.4.20/drivers/video/tdfxfb.c	Mon Dec  2 23:19:54 2002
@@ -208,6 +208,7 @@
 #define VGAINIT1_MASK			0x1fffff
 #define VIDCFG_VIDPROC_ENABLE		BIT(0)
 #define VIDCFG_CURS_X11			BIT(1)
+#define VIDCFG_INTERLACE		BIT(3)
 #define VIDCFG_HALF_MODE		BIT(4)
 #define VIDCFG_DESK_ENABLE		BIT(7)
 #define VIDCFG_CLUT_BYPASS		BIT(10)
@@ -238,6 +239,7 @@
 #define TDFXF_VSYNC_ACT_LOW	0x08
 #define TDFXF_LINE_DOUBLE	0x10
 #define TDFXF_VIDEO_ENABLE	0x20
+#define TDFXF_INTERLACE		0x40
 
 #define TDFXF_HSYNC_MASK	0x03
 #define TDFXF_VSYNC_MASK	0x0c
@@ -1321,10 +1323,17 @@
   hbs = hd;
   hbe = ht;
 
-  vd  = par->vdispend - 1;
-  vs  = par->vsyncsta - 1;
-  ve  = par->vsyncend - 1;
-  vt  = par->vtotal   - 2;
+  if (par->video & TDFXF_LINE_DOUBLE) {
+    vd = (par->vdispend << 1) - 1;
+    vs = (par->vsyncsta << 1) - 1;
+    ve = (par->vsyncend << 1) - 1;
+    vt = (par->vtotal   << 1) - 2;
+  } else {
+    vd = par->vdispend - 1;
+    vs = par->vsyncsta - 1;
+    ve = par->vsyncend - 1;
+    vt = par->vtotal   - 2;
+  }
   vbs = vd;
   vbe = vt;
   
@@ -1429,9 +1438,6 @@
     VGAINIT0_EXTSHIFTOUT;
   reg.vgainit1 = tdfx_inl(VGAINIT1) & 0x1fffff;
 
-  fb_info.cursor.enable=reg.vidcfg | VIDCFG_HWCURSOR_ENABLE;
-  fb_info.cursor.disable=reg.vidcfg;
-   
   reg.stride    = par->width*cpp;
   reg.cursloc   = 0;
    
@@ -1450,9 +1456,20 @@
   reg.gfxpll = do_calc_pll(..., &fout);
 #endif
 
-  reg.screensize = par->width | (par->height << 12);
-  reg.vidcfg &= ~VIDCFG_HALF_MODE;
+  if (par->video & TDFXF_LINE_DOUBLE) {
+    reg.screensize = par->width | (par->height << 13);
+    reg.vidcfg |= VIDCFG_HALF_MODE;
+    reg.crt[0x09] |= 0x80;
+  } else {
+    reg.screensize = par->width | (par->height << 12);
+    reg.vidcfg &= ~VIDCFG_HALF_MODE;
+  }
+  if (par->video & TDFXF_INTERLACE)
+    reg.vidcfg |= VIDCFG_INTERLACE;
 
+  fb_info.cursor.enable=reg.vidcfg | VIDCFG_HWCURSOR_ENABLE;
+  fb_info.cursor.disable=reg.vidcfg;
+   
   reg.miscinit0 = tdfx_inl(MISCINIT0);
 
 #if defined(__BIG_ENDIAN)
@@ -1496,11 +1513,6 @@
     return -EINVAL;
   }
 
-  if((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
-    DPRINTK("interlace not supported\n");
-    return -EINVAL;
-  }
-
   if(var->xoffset) {
     DPRINTK("xoffset not supported\n");
     return -EINVAL;
@@ -1516,9 +1528,10 @@
     return -EINVAL;
   }
 
-  /* fixme: does Voodoo3 support interlace? Banshee doesn't */
-  if((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
-    DPRINTK("interlace not supported\n");
+  /* Banshee doesn't support interlace, but Voodoo4 and probably Voodoo3 do. */
+  if(((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
+     && (i->dev == PCI_DEVICE_ID_3DFX_BANSHEE)) {
+    DPRINTK("interlace not supported on Banshee\n");
     return -EINVAL;
   }
 
@@ -1578,6 +1591,8 @@
       par->video |= TDFXF_VSYNC_ACT_LOW;
     if((var->vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE)
       par->video |= TDFXF_LINE_DOUBLE;
+    else if((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
+      par->video |= TDFXF_INTERLACE;
     if(var->activate == FB_ACTIVATE_NOW)
       par->video |= TDFXF_VIDEO_ENABLE;
   }
@@ -1639,6 +1654,8 @@
     v.sync |= FB_SYNC_VERT_HIGH_ACT;
   if(par->video & TDFXF_LINE_DOUBLE)
     v.vmode = FB_VMODE_DOUBLE;
+  else if(par->video & TDFXF_INTERLACE)
+    v.vmode = FB_VMODE_INTERLACED;
   *var = v;
   return 0;
 }
@@ -1672,7 +1689,7 @@
   fix->line_length = par->lpitch;
   fix->visual      = (par->bpp == 8) 
                      ? FB_VISUAL_PSEUDOCOLOR
-                     : FB_VISUAL_DIRECTCOLOR;
+                     : FB_VISUAL_TRUECOLOR;
 
   fix->xpanstep    = 0; 
   fix->ypanstep    = nopan ? 0 : 1;
@@ -2386,7 +2403,9 @@
 static void tdfxfb_hwcursor_init(void)
 {
    unsigned int start;
-   start = (fb_info.bufbase_size-1024) & PAGE_MASK;
+   start = (fb_info.bufbase_size-1024) & (PAGE_MASK << 1);
+   	/* even page boundary - on Voodoo4 4500 bottom 48 lines
+	 * contained trash when just page boundary was used... */
    fb_info.bufbase_size=start; 
    fb_info.cursor.cursorimage=fb_info.bufbase_size;
    printk("tdfxfb: reserving 1024 bytes for the hwcursor at %p\n",

--tsOsTdHNUZQcU9Ye--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
