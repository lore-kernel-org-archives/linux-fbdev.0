From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: [PATCH, 2.5] Avoid distorting mono attributes
Date: Sun, 27 Apr 2003 00:58:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030426225817.GC31642@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 199Yd8-00075n-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 26 Apr 2003 15:58:50 -0700
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

this patch protects mono attributes from being overwritten by
the color handling.


Thiemo


--- linux-2.5.68/drivers/char/vt.c~	Sun Apr 27 00:15:49 2003
+++ linux-2.5.68/drivers/char/vt.c	Sun Apr 27 00:40:02 2003
@@ -1052,7 +1052,8 @@ static void default_attr(int currcons)
 	underline = 0;
 	reverse = 0;
 	blink = 0;
-	color = def_color;
+	if (can_do_color)
+		color = def_color;
 }
 
 /* console_sem is held */
@@ -1125,7 +1126,8 @@ static void csi_m(int currcons)
 				  * with white underscore (Linux - use
 				  * default foreground).
 				  */
-				color = (def_color & 0x0f) | background;
+			        if (can_do_color)
+					color = (def_color & 0x0f) | background;
 				underline = 1;
 				break;
 			case 39: /* ANSI X3.64-1979 (SCO-ish?)
@@ -1133,19 +1135,23 @@ static void csi_m(int currcons)
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
+			        if (can_do_color)
+					color = (def_color & 0xf0) | foreground;
 				break;
 			default:
-				if (par[i] >= 30 && par[i] <= 37)
-					color = color_table[par[i]-30]
-						| background;
-				else if (par[i] >= 40 && par[i] <= 47)
-					color = (color_table[par[i]-40]<<4)
-						| foreground;
+			        if (can_do_color) {
+					if (par[i] >= 30 && par[i] <= 37)
+						color = color_table[par[i]-30]
+							| background;
+					else if (par[i] >= 40 && par[i] <= 47)
+						color = (color_table[par[i]-40]<<4)
+							| foreground;
+				}
 				break;
 		}
 	update_attr(currcons);
@@ -1280,9 +1286,11 @@ static void setterm_command(int currcons
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


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
