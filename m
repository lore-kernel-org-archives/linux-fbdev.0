From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH]: More optimization for
	accel_putcs()
Date: 23 Feb 2003 19:07:47 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045998151.1188.2.camel@localhost.localdomain>
References: <1045884656.1188.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18mtye-000367-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Feb 2003 03:07:24 -0800
In-Reply-To: <1045884656.1188.7.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2003-02-22 at 11:32, Antonino Daplas wrote:
> Geert, James,
> 
> Here's a patch for linux-2.5.61 + James' fbdev.diff so accel_putcs()
> will do only 1 fb_imageblit() at the end when fontwidth is not divisible
> by 8.  Tested on 4x6 and 12x22 fonts.  There should be a significant
> performance increase even with the generic functions, however, the
> greatest gain can be seen on drivers with accelerated fb_imageblit(). 
> Here are some numbers:
> 

The optimization logic is flawed :-(  Please apply this patch also.

Tony

diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.c linux-2.5.61/drivers/video/console/fbcon.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.c	2003-02-23 18:54:32.000000000 +0800
+++ linux-2.5.61/drivers/video/console/fbcon.c	2003-02-23 18:58:05.000000000 +0800
@@ -400,7 +400,7 @@
 			image.width = vc->vc_font.width * cnt;
 			pitch = (image.width + 7)/8;
 			while (k--) {
-				src = p->fontdata + (scr_readw(s++)&charmask)*
+				src = p->fontdata + (scr_readw(s++)&charmask)* 
 					cellsize;
 				dst = dst0;
 				mask = (u8) (0xfff << shift_high);
@@ -412,15 +412,18 @@
 						src++;
 					}
 					dst[idx] &= mask;
-					dst[idx] |= *src++ >> shift_low;
+					dst[idx] |= *src >> shift_low;
+					if (shift_high < mod)
+						dst[idx+1] = *src << shift_high;
+					src++;
 					dst += pitch;
 				}
 				shift_low += mod;
+				dst0 += (shift_low >= 8) ? width : width - 1;
 				shift_low &= 7;
 				shift_high = 8 - shift_low;
-				dst0 += (shift_low) ? width - 1 : width;
 			}
-
+			
 			info->fbops->fb_imageblit(info, &image);
 			image.dx += cnt * vc->vc_font.width;
 			count -= cnt;



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
