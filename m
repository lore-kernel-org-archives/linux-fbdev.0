From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] - video/tridentfb.c warning fix.
Date: Wed, 14 Apr 2004 19:06:00 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404141905520.13481-100000@phoenix.infradead.org>
References: <20040413164729.2eba2e6e.lcapitulino@prefeitura.sp.gov.br>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDolw-0001XU-Af
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:06:04 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BDolv-0004Qw-GE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 11:06:03 -0700
In-Reply-To: <20040413164729.2eba2e6e.lcapitulino@prefeitura.sp.gov.br>
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
To: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sf.net


ANyone want to test this?


On Tue, 13 Apr 2004, Luiz Fernando N. Capitulino wrote:

> 
>  Hi,
> 
>  I'm getting the fallowing warnings:
> 
> drivers/video/tridentfb.c:455: warning: `tridentfb_fillrect' defined but not used
> drivers/video/tridentfb.c:473: warning: `tridentfb_copyarea' defined but not used
> 
> They are caused by dead code, this patch remove then:
> 
> diff -X dontdiff -Nparu a/drivers/video/tridentfb.c a~/drivers/video/tridentfb.c
> --- a/drivers/video/tridentfb.c	2004-02-05 08:42:40.000000000 -0200
> +++ a~/drivers/video/tridentfb.c	2004-04-13 16:19:55.000000000 -0300
> @@ -448,34 +448,6 @@ static struct accel_switch accel_image =
>  };
>  
>  /*
> - * Accel functions called by the upper layers
> - */
> -
> -static void tridentfb_fillrect(struct fb_info * info, const struct fb_fillrect *fr)
> -{
> -	int bpp = info->var.bits_per_pixel;
> -	int col;
> -	
> -	switch (bpp) {
> -		default:
> -		case 8: col = fr->color;
> -			break;
> -		case 16: col = ((u16 *)(info->pseudo_palette))[fr->color];
> -			 break;
> -		case 32: col = ((u32 *)(info->pseudo_palette))[fr->color];
> -			 break;
> -	}		 
> -			
> -	acc->fill_rect(fr->dx, fr->dy, fr->width, fr->height, col, fr->rop);
> -	acc->wait_engine();
> -}
> -static void tridentfb_copyarea(struct fb_info *info, const struct fb_copyarea *ca)
> -{
> -	acc->copy_rect(ca->sx,ca->sy,ca->dx,ca->dy,ca->width,ca->height);
> -	acc->wait_engine();
> -}
> -
> -/*
>   * Hardware access functions
>   */
>  
> @@ -1265,8 +1237,6 @@ static struct fb_ops tridentfb_ops = {
>  	.fb_blank = tridentfb_blank,
>  	.fb_check_var = tridentfb_check_var,
>  	.fb_set_par = tridentfb_set_par,
> -//	.fb_fillrect = tridentfb_fillrect,
> -//	.fb_copyarea= tridentfb_copyarea,
>  	.fb_fillrect = cfb_fillrect,
>  	.fb_copyarea= cfb_copyarea,
>  	.fb_imageblit = cfb_imageblit,
> 
> 
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
