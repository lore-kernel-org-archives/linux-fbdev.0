From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: FrameMasterII fbdev updates.
Date: Tue, 24 Feb 2004 09:31:08 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402240930080.3187@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402232214520.11599-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvY6J-000580-D8
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 00:39:35 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AvXmG-00049O-Ny
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 Feb 2004 00:18:52 -0800
In-Reply-To: <Pine.LNX.4.44.0402232214520.11599-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 23 Feb 2004, James Simmons wrote:
> > On Wed, 18 Feb 2004, James Simmons wrote:
> > >   Can you test this patch. It is a port of the driver to use sysfs.
>
> Merged your patch with mine. Here is the latest patch. Please test. The
> patch is against linus tree. Thank you.
>
>
> --- fbdev-2.6/drivers/video/fm2fb.c	2004-02-22 20:18:18.000000000 -0800
> +++ linus-2.6/drivers/video/fm2fb.c	2004-02-18 20:59:07.000000000 -0800

Woops, wrong direction :-)

You missed these two:
  - Fix indentation
  - Kill space at end of line

--- linux/drivers/video/fm2fb.c.orig	2004-02-24 09:28:59.000000000 +0100
+++ linux/drivers/video/fm2fb.c	2004-02-23 20:48:50.000000000 +0100
@@ -211,7 +211,7 @@
      */

 static int __devinit fm2fb_probe(struct zorro_dev *z,
-				const struct zorro_device_id *id);
+				 const struct zorro_device_id *id);

 static struct zorro_device_id fm2fb_devices[] __devinitdata = {
 	{ ZORRO_PROD_BSC_FRAMEMASTER_II },
@@ -226,7 +226,7 @@
 };

 static int __devinit fm2fb_probe(struct zorro_dev *z,
-				const struct zorro_device_id *id)
+				 const struct zorro_device_id *id)
 {
 	struct fb_info *info;
 	unsigned long *ptr;
@@ -238,7 +238,7 @@
 	if (!zorro_request_device(z,"fm2fb"))
 		return -ENXIO;

-	info = framebuffer_alloc(256 * sizeof(u32), &z->dev);
+	info = framebuffer_alloc(256 * sizeof(u32), &z->dev);
 	if (!info) {
 		zorro_release_device(z);
 		return -ENOMEM;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
