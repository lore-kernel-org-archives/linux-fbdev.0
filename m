From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: [macro@ds2.pg.gda.pl: Re: PMAG-A support?]
Date: Tue, 12 Aug 2003 08:53:18 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030812065318.GE23104@rembrandt.csv.ica.uni-stuttgart.de>
References: <20030811163833.GA765@excalibur.cologne.de> <20030812063707.GC23104@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19mT2c-00033W-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 11 Aug 2003 23:53:59 -0700
Content-Disposition: inline
In-Reply-To: <20030812063707.GC23104@rembrandt.csv.ica.uni-stuttgart.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Karsten Merker <karsten@excalibur.cologne.de>, Martin Schulze <joey@infodrom.org>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-fbdev-devel@lists.sourceforge.net

Thiemo Seufer wrote:
[snip]
> Anyway, the AA driver is appended as a diff against current linux-mips
> CVS. I hope it doesn't deviate too much from whatever fbdev uses.
> 
> The bootlogo stuff needs one more patch, I'll follow up on this one.

As appended here.


Thiemo


diff -urpNX /bigdisk/src/dontdiff linux-orig/drivers/char/console.c linux/drivers/char/console.c
--- linux-orig/drivers/char/console.c	Sat Jan 11 18:53:12 2003
+++ linux/drivers/char/console.c	Sat Apr 12 15:44:11 2003
@@ -1046,7 +1046,8 @@ static void default_attr(int currcons)
 	underline = 0;
 	reverse = 0;
 	blink = 0;
-	color = def_color;
+	if (can_do_color)
+		color = def_color;
 }
 
 /* console_sem is held */
@@ -1119,7 +1120,8 @@ static void csi_m(int currcons)
 				  * with white underscore (Linux - use
 				  * default foreground).
 				  */
-				color = (def_color & 0x0f) | background;
+			        if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 1;
 				break;
 			case 39: /* ANSI X3.64-1979 (SCO-ish?)
@@ -1127,11 +1129,13 @@ static void csi_m(int currcons)
 				  * Reset colour to default? It did this
 				  * before...
 				  */
-				color = (def_color & 0x0f) | background;
+			        if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 0;
 				break;
 			case 49:
-				color = (def_color & 0xf0) | foreground;
+			  	if (can_do_color)
+					color = (def_color & 0xf0) | foreground;
 				break;
 			default:
 				if (par[i] >= 30 && par[i] <= 37)
@@ -1274,9 +1278,11 @@ static void setterm_command(int currcons
 			}
 			break;
 		case 8:	/* store colors as defaults */
-			def_color = attr;
-			if (hi_font_mask == 0x100)
-				def_color >>= 1;
+			if (can_do_color) {
+				def_color = attr;
+				if (hi_font_mask == 0x100)
+					def_color >>= 1;
+			}
 			default_attr(currcons);
 			update_attr(currcons);
 			break;
diff -urpNX /bigdisk/src/dontdiff linux-orig/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux-orig/drivers/video/fbcon.c	Wed Apr  9 13:39:41 2003
+++ linux/drivers/video/fbcon.c	Sat Apr 12 15:44:11 2003
@@ -711,7 +711,7 @@ static void fbcon_setup(int con, int ini
     if ((p->var.yres % fontheight(p)) &&
 	(p->var.yres_virtual % fontheight(p) < p->var.yres % fontheight(p)))
 	p->vrows--;
-    conp->vc_can_do_color = p->var.bits_per_pixel != 1;
+    conp->vc_can_do_color = (p->var.bits_per_pixel != 1 && !p->var.grayscale);
     conp->vc_complement_mask = conp->vc_can_do_color ? 0x7700 : 0x0800;
     if (charcnt == 256) {
     	conp->vc_hi_font_mask = 0;
@@ -1576,7 +1576,8 @@ static int fbcon_blank(struct vc_data *c
 
     if (!p->can_soft_blank) {
 	if (blank) {
-	    if (p->visual == FB_VISUAL_MONO01) {
+	    if (p->visual == FB_VISUAL_MONO10
+		|| p->visual == FB_VISUAL_MONO01) {
 		if (p->screen_base)
 		    fb_memset255(p->screen_base,
 				 p->var.xres_virtual*p->var.yres_virtual*
@@ -2328,7 +2329,9 @@ static int __init fbcon_show_logo( void 
 	}
 #endif
 #if defined(CONFIG_FBCON_CFB8) || defined(CONFIG_FB_SBUS)
-	if (depth == 8 && p->type == FB_TYPE_PACKED_PIXELS) {
+	if (depth == 8 && p->type == FB_TYPE_PACKED_PIXELS
+	    && p->visual != FB_VISUAL_MONO10
+	    && p->visual != FB_VISUAL_MONO01) {
 	    /* depth 8 or more, packed, with color registers */
 		
 	    src = logo;
@@ -2339,6 +2342,37 @@ static int __init fbcon_show_logo( void 
 	    }
 	    done = 1;
 	}
+	if (depth == 8 && p->type == FB_TYPE_PACKED_PIXELS
+	    && (p->visual == FB_VISUAL_MONO10
+		|| p->visual == FB_VISUAL_MONO01)) {
+	    /* depth 8, but only monochrome */
+		
+	    unsigned char inverse = 0xff;
+
+	    /* monochrome */
+	    if (p->inverse)
+		inverse = ~inverse;
+	    if (p->visual == FB_VISUAL_MONO01)
+		inverse = ~inverse;
+
+	    for( y1 = 0; y1 < LOGO_H; y1++ ) {
+		src = linux_logo_bw + y1*LOGO_LINE;
+		dst = fb + y1*line + x;
+		for( x1 = 0; x1 < LOGO_LINE; x1++ ) {
+		    u8 bits = *src++ ^ inverse;
+
+		    fb_writeb ((bits >> 7) & 0x01, dst++);
+		    fb_writeb ((bits >> 6) & 0x01, dst++);
+		    fb_writeb ((bits >> 5) & 0x01, dst++);
+		    fb_writeb ((bits >> 4) & 0x01, dst++);
+		    fb_writeb ((bits >> 3) & 0x01, dst++);
+		    fb_writeb ((bits >> 2) & 0x01, dst++);
+		    fb_writeb ((bits >> 1) & 0x01, dst++);
+		    fb_writeb ((bits >> 0) & 0x01, dst++);
+		}
+	    }
+	    done = 1;
+	}
 #endif
 #if defined(CONFIG_FBCON_AFB) || defined(CONFIG_FBCON_ILBM) || \
     defined(CONFIG_FBCON_IPLAN2P2) || defined(CONFIG_FBCON_IPLAN2P4) || \
@@ -2400,11 +2434,15 @@ static int __init fbcon_show_logo( void 
 			   p->type == FB_TYPE_PLANES ||
 			   p->type == FB_TYPE_INTERLEAVED_PLANES)) {
 
+	    int is_hga = !strncmp(p->fb_info->modename, "HGA", 3);
+	    unsigned char inverse = 0xff;
+
 	    /* monochrome */
-	    unsigned char inverse = p->inverse || p->visual == FB_VISUAL_MONO01
-		? 0x00 : 0xff;
+	    if (p->inverse)
+		inverse = ~inverse;
+	    if (p->visual == FB_VISUAL_MONO01)
+		inverse = ~inverse;
 
-	    int is_hga = !strncmp(p->fb_info->modename, "HGA", 3);
 	    /* can't use simply memcpy because need to apply inverse */
 	    for( y1 = 0; y1 < LOGO_H; y1++ ) {
 		src = logo + y1*LOGO_LINE;


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
