From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: [PATCH, 2.4] Add logo drawing support for 8-bit mono
Date: Sun, 27 Apr 2003 01:35:57 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030426233557.GF31642@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 199ZDe-00073F-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 26 Apr 2003 16:36:34 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hello Geert,

this patch adds logo drawing support for mono visuals with 8 bits
per pixel. The DECstation's PMAG-AA is such a card.

2.4 only, the 2.5 logo code is very different.


Thiemo


diff -BurpNX /bigdisk/src/dontdiff linux-orig/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux-orig/drivers/video/fbcon.c	Sat Jan 11 22:55:05 2003
+++ linux/drivers/video/fbcon.c	Sat Apr 12 15:44:11 2003
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


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
