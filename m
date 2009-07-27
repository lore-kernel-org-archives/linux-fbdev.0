From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4] davinci: fb: Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Mon, 27 Jul 2009 18:23:02 +0530
Message-ID: <178.172151982103$1248699331@news.gmane.org>
References: <1248238020-8266-1-git-send-email-sudhakar.raj@ti.com>
	<20090724142336.2b9b4082.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090724142336.2b9b4082.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Content-Type: text/plain; charset="us-ascii"
To: 'Andrew Morton' <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org

Hi,

On Sat, Jul 25, 2009 at 02:53:36, Andrew Morton wrote:
> On Wed, 22 Jul 2009 00:47:00 -0400
> Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org> wrote:
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
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> > Signed-off-by: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> > Acked-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
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
