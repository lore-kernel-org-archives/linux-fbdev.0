From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: [PATCH, 2.4] Fix inverse logo for FB_VISUAL_MONO01
Date: Sun, 27 Apr 2003 01:27:30 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030426232730.GE31642@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 199Z5P-0005AH-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 26 Apr 2003 16:28:03 -0700
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

this fixes the logo inversion logic for FB_VISUAL_MONO01. It also fixes
the declaration of a variable in the middle of a function, which isn't
allowed in traditional C.

2.4 only, as the 2.5 logo code has changed.


Thiemo


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
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
