From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: [PATCH] - video/imsttfb.c warning fix.
Date: Tue, 13 Apr 2004 16:47:31 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040413164731.70e30fc6.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDTsG-0003gc-6C
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Apr 2004 12:47:12 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDTsF-0002Mg-H3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Apr 2004 12:47:11 -0700
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
To: jsimmons@infradead.org
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sf.net


Hi,

 I'm getting the fallowing warnings:

drivers/video/imsttfb.c:1089: warning: `imsttfb_load_cursor_image' defined but not used
drivers/video/imsttfb.c:1159: warning: `imstt_set_cursor' defined but not used

 They are caused by dead code, this patch remove then:

diff -X dontdiff -Nparu a/drivers/video/imsttfb.c a~/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	2003-10-20 08:11:34.000000000 -0200
+++ a~/drivers/video/imsttfb.c	2004-04-13 16:02:51.000000000 -0300
@@ -1084,177 +1084,6 @@ imsttfb_copyarea(struct fb_info *info, c
 	while(read_reg_le32(par->dc_regs, SSTATUS) & 0x40);
 }
 
-static int
-imsttfb_load_cursor_image(struct imstt_par *par, int width, int height, __u8 fgc)
-{
-	u_int x, y;
-
-	if (width > 32 || height > 32)
-		return -EINVAL;
-
-	if (par->ramdac == IBM) {
-		par->cmap_regs[PIDXHI] = 1;	eieio();
-		for (x = 0; x < 0x100; x++) {
-			par->cmap_regs[PIDXLO] = x;		eieio();
-			par->cmap_regs[PIDXDATA] = 0x00;	eieio();
-		}
-		par->cmap_regs[PIDXHI] = 1;	eieio();
-		for (y = 0; y < height; y++)
-			for (x = 0; x < width >> 2; x++) {
-				par->cmap_regs[PIDXLO] = x + y * 8;	eieio();
-				par->cmap_regs[PIDXDATA] = 0xff;	eieio();
-			}
-		par->cmap_regs[PIDXHI] = 0;		eieio();
-		par->cmap_regs[PIDXLO] = CURS1R;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-		par->cmap_regs[PIDXLO] = CURS1G;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-		par->cmap_regs[PIDXLO] = CURS1B;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-		par->cmap_regs[PIDXLO] = CURS2R;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-		par->cmap_regs[PIDXLO] = CURS2G;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-		par->cmap_regs[PIDXLO] = CURS2B;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-		par->cmap_regs[PIDXLO] = CURS3R;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-		par->cmap_regs[PIDXLO] = CURS3G;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-		par->cmap_regs[PIDXLO] = CURS3B;	eieio();
-		par->cmap_regs[PIDXDATA] = fgc;		eieio();
-	} else {
-		par->cmap_regs[TVPADDRW] = TVPIRICC;	eieio();
-		par->cmap_regs[TVPIDATA] &= 0x03;	eieio();
-		par->cmap_regs[TVPADDRW] = 0;		eieio();
-		for (x = 0; x < 0x200; x++) {
-			par->cmap_regs[TVPCRDAT] = 0x00;	eieio();
-		}
-		for (x = 0; x < 0x200; x++) {
-			par->cmap_regs[TVPCRDAT] = 0xff;	eieio();
-		}
-		par->cmap_regs[TVPADDRW] = TVPIRICC;	eieio();
-		par->cmap_regs[TVPIDATA] &= 0x03;	eieio();
-		for (y = 0; y < height; y++)
-			for (x = 0; x < width >> 3; x++) {
-				par->cmap_regs[TVPADDRW] = x + y * 8;	eieio();
-				par->cmap_regs[TVPCRDAT] = 0xff;		eieio();
-			}
-		par->cmap_regs[TVPADDRW] = TVPIRICC;	eieio();
-		par->cmap_regs[TVPIDATA] |= 0x08;	eieio();
-		for (y = 0; y < height; y++)
-			for (x = 0; x < width >> 3; x++) {
-				par->cmap_regs[TVPADDRW] = x + y * 8;	eieio();
-				par->cmap_regs[TVPCRDAT] = 0xff;		eieio();
-			}
-		par->cmap_regs[TVPCADRW] = 0x00;	eieio();
-		for (x = 0; x < 12; x++)
-			par->cmap_regs[TVPCDATA] = fgc;	eieio();
-	}
-	return 1;
-}
-
-static void
-imstt_set_cursor(struct imstt_par *par, struct fb_image *d, int on)
-{
-	if (par->ramdac == IBM) {
-		par->cmap_regs[PIDXHI] = 0;	eieio();
-		if (!on) {
-			par->cmap_regs[PIDXLO] = CURSCTL;	eieio();
-			par->cmap_regs[PIDXDATA] = 0x00;	eieio();
-		} else {
-			par->cmap_regs[PIDXLO] = CURSXHI;	eieio();
-			par->cmap_regs[PIDXDATA] = d->dx >> 8;	eieio();
-			par->cmap_regs[PIDXLO] = CURSXLO;	eieio();
-			par->cmap_regs[PIDXDATA] = d->dx & 0xff;eieio();
-			par->cmap_regs[PIDXLO] = CURSYHI;	eieio();
-			par->cmap_regs[PIDXDATA] = d->dy >> 8;	eieio();
-			par->cmap_regs[PIDXLO] = CURSYLO;	eieio();
-			par->cmap_regs[PIDXDATA] = d->dy & 0xff;eieio();
-			par->cmap_regs[PIDXLO] = CURSCTL;	eieio();
-			par->cmap_regs[PIDXDATA] = 0x02;	eieio();
-		}
-	} else {
-		if (!on) {
-			par->cmap_regs[TVPADDRW] = TVPIRICC;	eieio();
-			par->cmap_regs[TVPIDATA] = 0x00;	eieio();
-		} else {
-			__u16 x = d->dx + 0x40, y = d->dy + 0x40;
-
-			par->cmap_regs[TVPCXPOH] = x >> 8;	eieio();
-			par->cmap_regs[TVPCXPOL] = x & 0xff;	eieio();
-			par->cmap_regs[TVPCYPOH] = y >> 8;	eieio();
-			par->cmap_regs[TVPCYPOL] = y & 0xff;	eieio();
-			par->cmap_regs[TVPADDRW] = TVPIRICC;	eieio();
-			par->cmap_regs[TVPIDATA] = 0x02;	eieio();
-		}
-	}
-}
-
-#if 0
-static int 
-imsttfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
-{
-	struct imstt_par *par = (struct imstt_par *) info->par;
-        u32 flags = cursor->set, fg, bg, xx, yy;
-
-	if (cursor->dest == NULL && cursor->rop == ROP_XOR)
-		return 1;
-	
-	imstt_set_cursor(info, cursor, 0);
-
-	if (flags & FB_CUR_SETPOS) {
-		xx = cursor->image.dx - info->var.xoffset;
-		yy = cursor->image.dy - info->var.yoffset;
-	}
-
-	if (flags & FB_CUR_SETSIZE) {
-        }
-
-        if (flags & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP)) {
-                int fg_idx = cursor->image.fg_color;
-                int width = (cursor->image.width+7)/8;
-                u8 *dat = (u8 *) cursor->image.data;
-                u8 *dst = (u8 *) cursor->dest;
-                u8 *msk = (u8 *) cursor->mask;
-
-                switch (cursor->rop) {
-                case ROP_XOR:
-                        for (i = 0; i < cursor->image.height; i++) {
-                                for (j = 0; j < width; j++) {
-                                        d_idx = i * MAX_CURS/8  + j;
-                                        data[d_idx] =  byte_rev[dat[s_idx] ^
-                                                                dst[s_idx]];
-                                        mask[d_idx] = byte_rev[msk[s_idx]];
-                                        s_idx++;
-                                }
-                        }
-                        break;
-                case ROP_COPY:
-                default:
-                        for (i = 0; i < cursor->image.height; i++) {
-                                for (j = 0; j < width; j++) {
-                                        d_idx = i * MAX_CURS/8 + j;
-                                        data[d_idx] = byte_rev[dat[s_idx]];
-                                        mask[d_idx] = byte_rev[msk[s_idx]];
-                                        s_idx++;
-                                }
-			}
-			break;
-		}
-
-		fg = ((info->cmap.red[fg_idx] & 0xf8) << 7) |
-                     ((info->cmap.green[fg_idx] & 0xf8) << 2) |
-                     ((info->cmap.blue[fg_idx] & 0xf8) >> 3) | 1 << 15;
-
-		imsttfb_load_cursor_image(par, xx, yy, fgc);
-	}
-	if (cursor->enable)
-		imstt_set_cursor(info, cursor, 1);
-	return 0;
-}
-#endif
-
 #define FBIMSTT_SETREG		0x545401
 #define FBIMSTT_GETREG		0x545402
 #define FBIMSTT_SETCMAPREG	0x545403

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
