From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH 1/5]: logo fix
Date: 17 Feb 2003 19:33:53 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045479988.1275.2.camel@localhost.localdomain>
References: <1045375680.1823.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kjWy-0000ns-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Feb 2003 03:33:53 -0800
In-Reply-To: <1045375680.1823.71.camel@localhost.localdomain>
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

On Sun, 2003-02-16 at 14:08, Antonino Daplas wrote:

> 3. Fixed all drivers affected by the (image.depth == 0) is color
> expansion.
> 

Sigh, missed fbcon_putc().

Tony

diff -Naur linux-2.5.61-fbdev/drivers/video/console/fbcon.c linux-2.5.61/drivers/video/console/fbcon.c
--- linux-2.5.61-fbdev/drivers/video/console/fbcon.c	2003-02-17 10:48:33.000000000 +0000
+++ linux-2.5.61/drivers/video/console/fbcon.c	2003-02-17 10:49:13.000000000 +0000
@@ -1157,7 +1157,7 @@
 	image.dy = real_y(p, ypos) * vc->vc_font.height;
 	image.width = vc->vc_font.width;
 	image.height = vc->vc_font.height;
-	image.depth = 1;
+	image.depth = 0;
 	image.data = p->fontdata + (c & charmask) * vc->vc_font.height * width;
 
 	info->fbops->fb_imageblit(info, &image);



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
