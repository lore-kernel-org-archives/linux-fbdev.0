From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 0/7] RFC: Cell SPE logos
Date: Tue, 13 Feb 2007 20:51:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702132049030.898@pentafluge.infradead.org>
References: <Pine.LNX.4.62.0701311325480.14996@pademelon.sonytel.be>
	<Pine.LNX.4.62.0702121452480.4624@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HH4dW-0007ze-8A for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Feb 2007 12:52:26 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HH4dN-0006KL-2N
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Feb 2007 12:52:26 -0800
In-Reply-To: <Pine.LNX.4.62.0702121452480.4624@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>


Andrew please apply. 

Acked-By: James Simmons <jsimmons@infradead.org>

On Mon, 12 Feb 2007, Geert Uytterhoeven wrote:

> On Wed, 31 Jan 2007, Geert Uytterhoeven wrote:
> > I would like to hear your opinions about the patchset below (updated version
> > compared to yesterday, lkml added to the CC list).
> > 
> > The Cell Broadband Engine contains a 64-bit PowerPC core with 2 hardware
> > threads (called PPEs) and 8 Synergistic Processing Engines (called SPEs).
> > When booting Linux, 2 penguins logos are shown on the graphical console by
> > the standard frame buffer console logo code.
> > 
> > To emphasize the existence of the SPEs (which can be used under Linux), we
> > added a second row of (smaller) helper penguin logos, one for each SPE.
> > I attached a PNG version of the helper penguin logo for reference.
> > 
> > Summaries:
> > [PATCH 1/7] fbdev: Avoid vertical overflow when making space for the logo
> > [PATCH 2/7] fbdev: fb_do_show_logo() updates
> > [PATCH 3/7] fbdev: extract fb_show_logo_line()
> > [PATCH 4/7] fbdev: move logo externs to header file
> > [PATCH 5/7] fbdev: Add fb_append_extra_logo()
> > [PATCH 6/7] fbdev: SPE helper penguin logo
> > [PATCH 7/7] Cell: Draw SPE helper penguin logos
> 
> The helper penguins overlap with the main penguins when using console rotation
> (fbcon=rotate:x, with x != 0). Here's a fix:
> 
> ---
> 
> Correct the image offsets when rotating the logo. Before image->dx and
> image->dy were always zero, so nobody ever noticed.
> 
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  drivers/video/fbmem.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
> 
> --- ps3-linux-2.6.20.orig/drivers/video/fbmem.c
> +++ ps3-linux-2.6.20/drivers/video/fbmem.c
> @@ -355,22 +355,26 @@ static void fb_rotate_logo(struct fb_inf
>  	if (rotate == FB_ROTATE_UD) {
>  		fb_rotate_logo_ud(image->data, dst, image->width,
>  				  image->height);
> -		image->dx = info->var.xres - image->width;
> -		image->dy = info->var.yres - image->height;
> +		image->dx = info->var.xres - image->width - image->dx;
> +		image->dy = info->var.yres - image->height - image->dy;
>  	} else if (rotate == FB_ROTATE_CW) {
>  		fb_rotate_logo_cw(image->data, dst, image->width,
>  				  image->height);
>  		tmp = image->width;
>  		image->width = image->height;
>  		image->height = tmp;
> -		image->dx = info->var.xres - image->width;
> +		tmp = image->dy;
> +		image->dy = image->dx;
> +		image->dx = info->var.xres - image->width - tmp;
>  	} else if (rotate == FB_ROTATE_CCW) {
>  		fb_rotate_logo_ccw(image->data, dst, image->width,
>  				   image->height);
>  		tmp = image->width;
>  		image->width = image->height;
>  		image->height = tmp;
> -		image->dy = info->var.yres - image->height;
> +		tmp = image->dx;
> +		image->dx = image->dy;
> +		image->dy = info->var.yres - image->height - tmp;
>  	}
>  
>  	image->data = dst;
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
> Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
> Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
