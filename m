From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] Tile Blitting
Date: 23 Feb 2003 19:07:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045998239.1188.4.camel@localhost.localdomain>
References: <1045975269.1676.18.camel@localhost.localdomain> 
	<1045986190.1189.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18mtyi-00036J-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 23 Feb 2003 03:07:28 -0800
In-Reply-To: <1045986190.1189.2.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-02-23 at 15:43, Antonino Daplas wrote:
> On Sun, 2003-02-23 at 12:42, Antonino Daplas wrote:
> 
> > Here's an updated Tile Blitting patch.  The feature is selectable via
> > kernel configuration (under Advanced Low Level Driver Features). 
> > Currently, it detects the presence of info->tileops but bit setting
> > info->caps should be better.
> 
> Stupid me :-(, the patch does not work properly.  Try this one instead.
> 

The optimization logic is flawed :-(  Please apply this patch also.

Tony

diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon_accelops.c linux-2.5.61/drivers/video/console/fbcon_accelops.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon_accelops.c	2003-02-23 18:47:53.000000000 +0800
+++ linux-2.5.61/drivers/video/console/fbcon_accelops.c	2003-02-23 18:52:23.000000000 +0800
@@ -113,13 +113,16 @@
 					src++;
 				}
 				dst[idx] &= mask;
-				dst[idx] |= *src++ >> shift_low;
+				dst[idx] |= *src >> shift_low;
+ 				if (shift_high < mod)
+					dst[idx+1] = *src << shift_high;
+				src++;
 				dst += pitch;
 			}
 			shift_low += mod;
+			dst0 += (shift_low >= 8) ? width : width - 1;
 			shift_low &= 7;
 			shift_high = 8 - shift_low;
-			dst0 += (shift_low) ? width - 1 : width;
 		}
 		
 		info->fbops->fb_imageblit(info, image);



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
