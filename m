From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Framebuffer fixes.
Date: 28 Mar 2003 04:43:39 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048797768.1035.9.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0303261951090.21188-100000@phoenix.infradead.org> 
	<1048734021.982.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yeVr-0007m8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 13:02:15 -0800
In-Reply-To: <1048734021.982.4.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-27 at 11:01, Antonino Daplas wrote:

> 5. logo fixes 
> 	- forgotten case statement for FB_VISUAL_PSEUDOCOLOR. 
>  
>        - image->depth should be representative of the data depth
> (currently, either 8 or 1).  If image->depth == 1, color expansion can
> now be used to draw the logo, thus there's no need to differentiate
> between mono logo drawing and monochrome expansion.
> 
> 
> The patch is against 2.5.66 + fbdev.diff.gz. 
> 

Grr.  The patch has a few problems...

Tony

diff -Naur linux-2.5.66-orig/drivers/video/console/fbcon.c linux-2.5.66/drivers/video/console/fbcon.c
--- linux-2.5.66-orig/drivers/video/console/fbcon.c	2003-03-27 20:36:06.000000000 +0000
+++ linux-2.5.66/drivers/video/console/fbcon.c	2003-03-27 20:40:53.000000000 +0000
@@ -209,7 +209,7 @@
 		cursor.set = FB_CUR_SETFLASH;
 
 		if (!cursor_drawn)
-			cursor.set = FB_CUR_SETCUR;
+			cursor.set |= FB_CUR_SETCUR;
 		accel_cursor(vc, info, &cursor, real_y(p, vc->vc_y));
 		cursor_drawn ^= 1;
 		vbl_cursor_cnt = cursor_blink_rate;
@@ -597,6 +597,8 @@
 	/* Allocate private data */
 	info->fbcon_priv = kmalloc(sizeof(struct fbcon_private), GFP_KERNEL);
 	if (info->fbcon_priv == NULL) {
+		if (softback_buf)
+			kfree(softback_buf);
 		kfree(vc);
 		return NULL;
 	}
diff -Naur linux-2.5.66-orig/drivers/video/fbmem.c linux-2.5.66/drivers/video/fbmem.c
--- linux-2.5.66-orig/drivers/video/fbmem.c	2003-03-27 20:36:06.000000000 +0000
+++ linux-2.5.66/drivers/video/fbmem.c	2003-03-27 20:37:52.000000000 +0000
@@ -728,17 +728,14 @@
 	 * Monochrome expansion and logo drawing functions are the same if
 	 * fb_logo.needs_logo == 1.
 	 */
-	switch (info->fix.visual) {
-	case FB_VISUAL_MONO10:
+	if (fb_logo.needs_logo == 1) {
 		image.fg_color = (u32) (~(~0UL << fb_logo.depth));
 		image.bg_color = 0;
 		image.depth = 1;
-		break;
-	case FB_VISUAL_MONO01:
-		image.bg_color = (u32) (~(~0UL << fb_logo.depth));
-		image.fg_color = 0;
-		image.depth = 1;
-		break;
+		if (info->fix.visual == FB_VISUAL_MONO01) {
+			image.bg_color = image.fg_color;
+			image.fg_color = 0;
+		}
 	}
 
 	for (x = 0; x < num_online_cpus() * (fb_logo.logo->width + 8) &&



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
