From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 12/15] viafb: introduce wrapper for
 2D engine registers
Date: Sat, 23 May 2009 08:28:31 +0200
Message-ID: <20090523082831.413686f6.krzysztof.h1@poczta.fm>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-11-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-12-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M7kci-0002FB-Lu
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:22:24 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7kcY-0002hJ-FB for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 06:22:24 +0000
In-Reply-To: <1242851333-325-12-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Harald Welte <HaraldWelte@viatech.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 21 May 2009 04:28:50 +0800
Harald Welte <HaraldWelte@viatech.com> wrote:

> From: Harald Welte <laforge@gnumonks.org>
> 
> This is required as preparation for supporting the new M1 engine of the
> VX800/VX855 which has registers at permutated addresses.
> 
> Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
> ---

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

>  drivers/video/via/accel.c    |   13 +++++++++----
>  drivers/video/via/accel.h    |    1 +
>  drivers/video/via/viafbdev.c |   38 +++++++++++++++++---------------------
>  3 files changed, 27 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
> index 4a1183f..c3af95f 100644
> --- a/drivers/video/via/accel.c
> +++ b/drivers/video/via/accel.c
> @@ -20,6 +20,11 @@
>   */
>  #include "global.h"
>  
> +void viafb_2d_writel(u_int32_t val, u_int32_t reg)
> +{
> +	writel(val, viaparinfo->io_virt + reg);
> +}
> +
>  void viafb_init_accel(void)
>  {
>  	viaparinfo->fbmem_free -= CURSOR_SIZE;
> @@ -213,18 +218,18 @@ void viafb_set_2d_mode(struct fb_info *info)
>  		dwGEMode |= VIA_GEM_8bpp;
>  		break;
>  	}
> -	writel(dwGEMode, viaparinfo->io_virt + VIA_REG_GEMODE);
> +	viafb_2d_writel(dwGEMode, VIA_REG_GEMODE);
>  
>  	/* Set source and destination base */
>  	base = ((void *)info->screen_base - viafb_FB_MM);
> -	writel(base >> 3, viaparinfo->io_virt + VIA_REG_SRCBASE);
> -	writel(base >> 3, viaparinfo->io_virt + VIA_REG_DSTBASE);
> +	viafb_2d_writel(base >> 3, VIA_REG_SRCBASE);
> +	viafb_2d_writel(base >> 3, VIA_REG_DSTBASE);
>  
>  	/* Set source and destination pitch (128bit aligned) */
>  	pitch = (viaparinfo->hres * viaparinfo->bpp >> 3) >> 3;
>  	pitch_reg = pitch | (pitch << 16);
>  	pitch_reg |= VIA_PITCH_ENABLE;
> -	writel(pitch_reg, viaparinfo->io_virt + VIA_REG_PITCH);
> +	viafb_2d_writel(pitch_reg, VIA_REG_PITCH);
>  }
>  
>  void viafb_hw_cursor_init(void)
> diff --git a/drivers/video/via/accel.h b/drivers/video/via/accel.h
> index bef3134..5081ac2 100644
> --- a/drivers/video/via/accel.h
> +++ b/drivers/video/via/accel.h
> @@ -159,6 +159,7 @@
>  
>  #define MAXLOOP                 0xFFFFFF
>  
> +void viafb_2d_writel(u_int32_t val, u_int32_t reg);
>  void viafb_init_accel(void);
>  void viafb_init_2d_engine(void);
>  void viafb_set_2d_mode(struct fb_info *info);
> diff --git a/drivers/video/via/viafbdev.c b/drivers/video/via/viafbdev.c
> index af8acfe..859827b 100644
> --- a/drivers/video/via/viafbdev.c
> +++ b/drivers/video/via/viafbdev.c
> @@ -899,16 +899,14 @@ static void viafb_fillrect(struct fb_info *info,
>  	viafb_set_2d_mode(info);
>  
>  	/* BitBlt Destination Address */
> -	writel(((rect->dy << 16) | rect->dx),
> -		viaparinfo->io_virt + VIA_REG_DSTPOS);
> +	viafb_2d_writel(((rect->dy << 16) | rect->dx), VIA_REG_DSTPOS);
>  	/* Dimension: width & height */
> -	writel((((rect->height - 1) << 16) | (rect->width - 1)),
> -		viaparinfo->io_virt + VIA_REG_DIMENSION);
> +	viafb_2d_writel((((rect->height - 1) << 16) | (rect->width - 1)),
> +			VIA_REG_DIMENSION);
>  	/* Forground color or Destination color */
> -	writel(col, viaparinfo->io_virt + VIA_REG_FGCOLOR);
> +	viafb_2d_writel(col, VIA_REG_FGCOLOR);
>  	/* GE Command */
> -	writel((0x01 | 0x2000 | (rop << 24)),
> -		viaparinfo->io_virt + VIA_REG_GECMD);
> +	viafb_2d_writel((0x01 | 0x2000 | (rop << 24)), VIA_REG_GECMD);
>  
>  }
>  
> @@ -943,15 +941,14 @@ static void viafb_copyarea(struct fb_info *info,
>  	viafb_set_2d_mode(info);
>  
>  	/* BitBlt Source Address */
> -	writel(((sy << 16) | sx), viaparinfo->io_virt + VIA_REG_SRCPOS);
> +	viafb_2d_writel(((sy << 16) | sx), VIA_REG_SRCPOS);
>  	/* BitBlt Destination Address */
> -	writel(((dy << 16) | dx), viaparinfo->io_virt + VIA_REG_DSTPOS);
> +	viafb_2d_writel(((dy << 16) | dx), VIA_REG_DSTPOS);
>  	/* Dimension: width & height */
> -	writel((((area->height - 1) << 16) | (area->width - 1)),
> -		   viaparinfo->io_virt + VIA_REG_DIMENSION);
> +	viafb_2d_writel((((area->height - 1) << 16) | (area->width - 1)),
> +			VIA_REG_DIMENSION);
>  	/* GE Command */
> -	writel((0x01 | direction | (0xCC << 24)),
> -		viaparinfo->io_virt + VIA_REG_GECMD);
> +	viafb_2d_writel((0x01 | direction | (0xCC << 24)), VIA_REG_GECMD);
>  
>  }
>  
> @@ -987,19 +984,18 @@ static void viafb_imageblit(struct fb_info *info,
>  	viafb_set_2d_mode(info);
>  
>  	/* BitBlt Source Address */
> -	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCPOS);
> +	viafb_2d_writel(0x0, VIA_REG_SRCPOS);
>  	/* BitBlt Destination Address */
> -	writel(((image->dy << 16) | image->dx),
> -		viaparinfo->io_virt + VIA_REG_DSTPOS);
> +	viafb_2d_writel(((image->dy << 16) | image->dx), VIA_REG_DSTPOS);
>  	/* Dimension: width & height */
> -	writel((((image->height - 1) << 16) | (image->width - 1)),
> -		   viaparinfo->io_virt + VIA_REG_DIMENSION);
> +	viafb_2d_writel((((image->height - 1) << 16) | (image->width - 1)),
> +			VIA_REG_DIMENSION);
>  	/* fb color */
> -	writel(fg_col, viaparinfo->io_virt + VIA_REG_FGCOLOR);
> +	viafb_2d_writel(fg_col, VIA_REG_FGCOLOR);
>  	/* bg color */
> -	writel(bg_col, viaparinfo->io_virt + VIA_REG_BGCOLOR);
> +	viafb_2d_writel(bg_col, VIA_REG_BGCOLOR);
>  	/* GE Command */
> -	writel(0xCC020142, viaparinfo->io_virt + VIA_REG_GECMD);
> +	viafb_2d_writel(0xCC020142, VIA_REG_GECMD);
>  
>  	for (i = 0; i < size / 4; i++) {
>  		writel(*udata, viaparinfo->io_virt + VIA_MMIO_BLTBASE);
> -- 
> 1.6.2.4
> 
> 
> ------------------------------------------------------------------------------
> Crystal Reports - New Free Runtime and 30 Day Trial
> Check out the new simplified licensing option that enables 
> unlimited royalty-free distribution of the report engine 
> for externally facing server and web deployment. 
> http://p.sf.net/sfu/businessobjects
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 

----------------------------------------------------------------------
Chcesz miec nawigacje GPS ?
Zamow lub przedluz umowe na neostrade, a nawigacja bedzie Twoja.
Kliknij na link po szczegoly! http://link.interia.pl/f219a



------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
