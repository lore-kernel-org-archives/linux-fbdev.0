From: "Sudhakar Rajashekhara" <sudhakar.raj@ti.com>
Subject: Re: [PATCH v4] davinci: fb: Frame Buffer driver
	for TI DA8xx/OMAP-L1xx
Date: Mon, 27 Jul 2009 18:23:02 +0530
Message-ID: <47745.9173104309$1248699419@news.gmane.org>
References: <1248238020-8266-1-git-send-email-sudhakar.raj@ti.com>
	<20090724142336.2b9b4082.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sudhakar.raj@ti.com>) id 1MVPjc-00064X-UL
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Jul 2009 12:55:20 +0000
Received: from comal.ext.ti.com ([198.47.26.152])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MVPjY-00026Z-Ni
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Jul 2009 12:55:20 +0000
In-Reply-To: <20090724142336.2b9b4082.akpm@linux-foundation.org>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-fbdev-devel@lists.sourceforge.net, schen@mvista.com, linux-kernel@vger.kernel.org, pkiryukhin@ru.mvista.com

Hi,

On Sat, Jul 25, 2009 at 02:53:36, Andrew Morton wrote:
> On Wed, 22 Jul 2009 00:47:00 -0400
> Sudhakar Rajashekhara <sudhakar.raj@ti.com> wrote:
> 
> > Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx
> > architecture. LCDC specifications can be found at
> > http://www.ti.com/litv/pdf/sprufm0a.
> > 
> > LCDC on DA8xx consists of two independent controllers, the
> > Raster Controller and the LCD Interface Display Driver (LIDD)
> > controller. LIDD further supports character and graphic displays.
> > 
> > This patch adds support for the graphic display (Sharp LQ035Q3DG01)
> > found on the DA830 based EVM. The EVM details can be found at:
> > http://support.spectrumdigital.com/boards/dskda830/revc/.
> > 
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> > Signed-off-by: Steve Chen <schen@mvista.com>
> > Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > ---
> >  This patch applies to Linus's Kernel tree.
> > 
> >  Since the previous version, return values in ioctl()
> >  function have been modified.
> 
> That wasn't the only change in version 4:
> 

I missed documenting all the modifications. I'll take care of it.

> --- a/drivers/video/da8xx-fb.c~davinci-fb-frame-buffer-driver-for-ti-da8xx-omap-l1xx-v4
> +++ a/drivers/video/da8xx-fb.c
> @@ -201,14 +201,13 @@ static int lcd_disable_raster(struct da8
>  		ret = wait_event_interruptible_timeout(par->da8xx_wq,
>  						!lcdc_read(LCD_STAT_REG) &
>  						LCD_END_OF_FRAME0, WSI_TIMEOUT);
> +		if (ret < 0)
> +			return ret;
> +		if (ret == 0)
> +			ret = -ETIMEDOUT;
>  	}
>  
> -	if (ret < 0)
> -		return ret;
> -	if (ret == 0)
> -		return -ETIMEDOUT;
> -
> -	return 0;
> +	return ret;
>  }
>  
>  static void lcd_blit(int load_mode, struct da8xx_fb_par *par)
> @@ -634,11 +633,11 @@ static int fb_ioctl(struct fb_info *info
>  	case FBIPUT_BRIGHTNESS:
>  	case FBIGET_COLOR:
>  	case FBIPUT_COLOR:
> -		return -EINVAL;
> +		return -ENOTTY;
>  	case FBIPUT_HSYNC:
>  		if (copy_from_user(&sync_arg, (char *)arg,
>  				sizeof(struct lcd_sync_arg)))
> -			return -EINVAL;
> +			return -EFAULT;
>  		lcd_cfg_horizontal_sync(sync_arg.back_porch,
>  					sync_arg.pulse_width,
>  					sync_arg.front_porch);
> @@ -646,7 +645,7 @@ static int fb_ioctl(struct fb_info *info
>  	case FBIPUT_VSYNC:
>  		if (copy_from_user(&sync_arg, (char *)arg,
>  				sizeof(struct lcd_sync_arg)))
> -			return -EINVAL;
> +			return -EFAULT;
>  		lcd_cfg_vertical_sync(sync_arg.back_porch,
>  					sync_arg.pulse_width,
>  					sync_arg.front_porch);
> _
> 
> 
> Was that intentional?
> 

Yes. As per your review comment last time I have changed the
return value in case of error from "copy_from_user" to -EFAULT.
Changing the return value of non-implemented ioctls to -ENOTTY
seems more appropriate as per the man page of ioctl.

> 
> The change to lcd_disable_raster() is a bit odd:
> 
> static int lcd_disable_raster(struct da8xx_fb_par *par)
> {
> 	int ret = 0;
> 	u32 reg;
> 
> 	reg = lcdc_read(LCD_RASTER_CTRL_REG);
> 	if (reg & LCD_RASTER_ENABLE) {
> 		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> 		ret = wait_event_interruptible_timeout(par->da8xx_wq,
> 						!lcdc_read(LCD_STAT_REG) &
> 						LCD_END_OF_FRAME0, WSI_TIMEOUT);
> 		if (ret < 0)
> 			return ret;
> 		if (ret == 0)
> 			ret = -ETIMEDOUT;
> 	}
> 
> 	return ret;
> }
> 
> 
> We can do this, yes?
> 

Right. I'll submit an updated version of this patch with all
these changes.

> --- a/drivers/video/da8xx-fb.c~davinci-fb-frame-buffer-driver-for-ti-da8xx-omap-l1xx-v4-cleanup
> +++ a/drivers/video/da8xx-fb.c
> @@ -201,8 +201,6 @@ static int lcd_disable_raster(struct da8
>  		ret = wait_event_interruptible_timeout(par->da8xx_wq,
>  						!lcdc_read(LCD_STAT_REG) &
>  						LCD_END_OF_FRAME0, WSI_TIMEOUT);
> -		if (ret < 0)
> -			return ret;
>  		if (ret == 0)
>  			ret = -ETIMEDOUT;
>  	}
> _
> 

Thanks,
Sudhakar



------------------------------------------------------------------------------
