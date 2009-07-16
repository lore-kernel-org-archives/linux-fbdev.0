From: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3] davinci: fb: Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Thu, 16 Jul 2009 11:51:24 +0530
Message-ID: <3802.42269388891$1247725397@news.gmane.org>
References: <1247644654-10952-1-git-send-email-sudhakar.raj@ti.com>
	<20090715140012.93397475.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090715140012.93397475.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Content-Type: text/plain; charset="us-ascii"
To: 'Andrew Morton' <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org

Thanks for your comments...

On Thu, Jul 16, 2009 at 02:30:12, Andrew Morton wrote:
> On Wed, 15 Jul 2009 03:57:34 -0400
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
> >
> > ...
> >
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -2038,6 +2038,17 @@ config FB_SH7760
> >  	  and 8, 15 or 16 bpp color; 90 degrees clockwise display rotation for
> >  	  panels <= 320 pixel horizontal resolution.
> >  
> > +config FB_DA8XX
> > +        tristate "DA8xx/OMAP-L1xx Framebuffer support"
> > +        depends on FB && ARCH_DAVINCI_DA8XX
> > +	select FB_CFB_FILLRECT
> > +	select FB_CFB_COPYAREA
> > +	select FB_CFB_IMAGEBLIT
> > +	---help---
> > +          This is the frame buffer device driver for the TI LCD controller
> > +	  found on DA8xx/OMAP-L1xx SoCs.
> > +          If unsure, say N.
> 
> Leading whitespace is all mucked up there - I fixed it.
> 

Thanks. I'll take care of it in future.

> >  config FB_VIRTUAL
> >  	tristate "Virtual Frame Buffer support (ONLY FOR TESTING!)"
> >  	depends on FB
> >
> > ...
> >
> > +/* Disable the Raster Engine of the LCD Controller */
> > +static int lcd_disable_raster(struct da8xx_fb_par *par)
> > +{
> > +	int ret = 0;
> > +	u32 reg;
> > +
> > +	reg = lcdc_read(LCD_RASTER_CTRL_REG);
> > +	if (reg & LCD_RASTER_ENABLE) {
> > +		lcdc_write(reg & ~LCD_RASTER_ENABLE, LCD_RASTER_CTRL_REG);
> > +		ret = wait_event_interruptible_timeout(par->da8xx_wq,
> > +						!lcdc_read(LCD_STAT_REG) &
> > +						LCD_END_OF_FRAME0, WSI_TIMEOUT);
> > +	}
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret == 0)
> > +		return -ETIMEDOUT;
> > +
> > +	return 0;
> > +}
> 
> This looks wrongish.  If LCD_RASTER_ENABLE is not set, it will return
> -ETIMEDOUT without ever having waited for anything.
> 

I'll correct this.

> >
> > ...
> >
> > +static int fb_ioctl(struct fb_info *info, unsigned int cmd,
> > +			  unsigned long arg)
> > +{
> > +	struct lcd_sync_arg sync_arg;
> > +
> > +	switch (cmd) {
> > +	case FBIOGET_CONTRAST:
> > +	case FBIOPUT_CONTRAST:
> > +	case FBIGET_BRIGHTNESS:
> > +	case FBIPUT_BRIGHTNESS:
> > +	case FBIGET_COLOR:
> > +	case FBIPUT_COLOR:
> > +		return -EINVAL;

As per the man page of ioctl, I think the above should be -ENOTTY.
I'll change it to -ENOTTY.

> > +	case FBIPUT_HSYNC:
> > +		if (copy_from_user(&sync_arg, (char *)arg,
> > +				sizeof(struct lcd_sync_arg)))
> > +			return -EINVAL;
> 
> -EFAULT?
> 

Agree, I'll change it.

> > +		lcd_cfg_horizontal_sync(sync_arg.back_porch,
> > +					sync_arg.pulse_width,
> > +					sync_arg.front_porch);
> > +		break;
> > +	case FBIPUT_VSYNC:
> > +		if (copy_from_user(&sync_arg, (char *)arg,
> > +				sizeof(struct lcd_sync_arg)))
> > +			return -EINVAL;
> 
> -EFAULT?
> 

I'll change it here as well.

> > +		lcd_cfg_vertical_sync(sync_arg.back_porch,
> > +					sync_arg.pulse_width,
> > +					sync_arg.front_porch);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> 
> -ENOTTY?  (Maybe not - I forget)
> 

I think -EINVAL is the proper return value here. I'll retain it.

I'll submit an updated version of this patch with these changes.

Regards, Sudhakar
