From: "Sudhakar Rajashekhara" <sudhakar.raj@ti.com>
Subject: Re: [PATCH v3] davinci: fb: Frame Buffer driver
	for TI DA8xx/OMAP-L1xx
Date: Thu, 16 Jul 2009 11:51:24 +0530
Message-ID: <32850.5352874801$1247725537@news.gmane.org>
References: <1247644654-10952-1-git-send-email-sudhakar.raj@ti.com>
	<20090715140012.93397475.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sudhakar.raj@ti.com>) id 1MRKNI-0008Rf-Ci
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Jul 2009 06:23:24 +0000
Received: from devils.ext.ti.com ([198.47.26.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MRKND-00057q-5b
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 16 Jul 2009 06:23:24 +0000
In-Reply-To: <20090715140012.93397475.akpm@linux-foundation.org>
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

Thanks for your comments...

On Thu, Jul 16, 2009 at 02:30:12, Andrew Morton wrote:
> On Wed, 15 Jul 2009 03:57:34 -0400
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



------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
