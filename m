From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Fix softcursor issues
Date: Mon, 9 Feb 2004 18:04:46 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402091804390.24535-100000@phoenix.infradead.org>
References: <1076309769.986.4.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqFm5-0000Vi-JG
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 10:04:49 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AqFm4-0006Ai-R6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 10:04:49 -0800
In-Reply-To: <1076309769.986.4.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Thanks. Applied.


On Mon, 9 Feb 2004, Benjamin Herrenschmidt wrote:

> Hi James !
> 
> I'm having troubles with softcursor in the new tree. It can tap
> outside of the ioremap'ed region of the framebuffer because it
> doesn't properly crop the saved area at the bottom of the screen.
> 
> Here's a quick fix that works for me with offb (offb ioremap's just
> the exact size of the framebuffer and so would trigger it).
> 
> I also added calls to fb_sync since we are touching the framebuffer,
> we must make sure pending accel operations are properly completed.
> 
> Ben.
> 
> diff -urN fbdev-2.5/drivers/video/softcursor.c linuxppc-2.5-benh/drivers/video/softcursor.c
> --- fbdev-2.5/drivers/video/softcursor.c	2004-01-28 16:50:07.000000000 +1100
> +++ linuxppc-2.5-benh/drivers/video/softcursor.c	2004-02-09 17:51:13.338387792 +1100
> @@ -29,9 +29,10 @@
>  {
>  	unsigned int scan_align = info->sprite.scan_align - 1;
>  	u8 *addr = info->sprite.addr, *dst;
> -	unsigned int size, i, j;
> +	unsigned int size, i, j, ysize;
>  	unsigned long *save;
> -	
> +	int needsync = 1;
> +
>  	if (cursor->image.height > 32 || cursor->image.width > 32)
>  		return -ENXIO;
>  
> @@ -63,14 +64,20 @@
>  		fb_load_cursor_image(info);
>  		
>  	if (!cursor->enable || (info->cursor.enable && (cursor->set & FB_CUR_SETPOS))) {
> +		if (needsync && info->fbops->fb_sync) {
> +			info->fbops->fb_sync(info);
> +			needsync = 0;
> +		}
>  		// Draw saved area
>  		i = (info->cursor.image.width * info->var.bits_per_pixel + 7) >> 3;
>  		size = (i + scan_align) & ~scan_align;
>  		i = (info->cursor.image.dx * info->var.bits_per_pixel >> 3);
>  		dst = info->screen_base + info->cursor.image.dy * info->fix.line_length + i;
> -		
> +		ysize = 32;
> +		if ((info->cursor.image.dy + ysize) > info->var.yres_virtual)
> +			ysize = info->var.yres_virtual - info->cursor.image.dy;
>  		save = (unsigned long *) (addr + info->sprite.size/2);
> -		for (i = 0; i < 32; i++) {
> +		for (i = 0; i < ysize; i++) {
>  			unsigned long *dst0 = (unsigned long *) dst;
>  			for (j = 0; j < size; j++) {
>  				FB_WRITEL(FB_READL(save++), dst0++);
> @@ -80,14 +87,21 @@
>  	}
>  	
>  	if (!info->cursor.enable || (cursor->set & FB_CUR_SETPOS)) {
> +		if (needsync && info->fbops->fb_sync) {
> +			info->fbops->fb_sync(info);
> +			needsync = 0;
> +		}
>  		// Save the area under the cursor
>  		i = (info->cursor.image.width * info->var.bits_per_pixel + 7) >> 3;
>  		size = (i + scan_align) & ~scan_align;
>  		i = (info->cursor.image.dx * info->var.bits_per_pixel >> 3);
>  		dst = info->screen_base + info->cursor.image.dy * info->fix.line_length + i;
>  		
> +		ysize = 32;
> +		if ((info->cursor.image.dy + ysize) > info->var.yres_virtual)
> +			ysize = info->var.yres_virtual - info->cursor.image.dy;
>  		save = (unsigned long *) (addr + info->sprite.size/2);
> -		for (i = 0; i < 32; i++) {
> +		for (i = 0; i < ysize; i++) {
>  			unsigned long *dst0 = (unsigned long *) dst;
>  			for (j = 0; j < size; j++) {
>  				FB_WRITEL(FB_READL(dst0++), save++);
> @@ -96,10 +110,8 @@
>  		}
>  	}
>  
> -	if (cursor->enable) {
> -		//info->cursor.image.data = addr;
> +	if (cursor->enable)
>  		info->fbops->fb_imageblit(info, &info->cursor.image);
> -	}
>  	return 0;
>  }
>  
> 
> 
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
