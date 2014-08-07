From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 07 Aug 2014 09:30:47 +0000
Subject: Re: [RFC] pwm-backlight: Allow backlight to remain disabled on boot
Message-Id: <009e01cfb222$4555d940$d0018bc0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1406806970-12561-1-git-send-email-thierry.reding@gmail.com>
 <20140731115429.GA12627@ulmo>
In-Reply-To: <20140731115429.GA12627@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday, July 31, 2014 8:55 PM, Thierry Reding wrote:
> On Thu, Jul 31, 2014 at 01:42:50PM +0200, Thierry Reding wrote:
> [...]
> > @@ -317,6 +319,12 @@ static int pwm_backlight_probe(struct platform_device *pdev)
> >  	}
> >
> >  	bl->props.brightness = data->dft_brightness;
> > +
> > +	if (data->boot_off)
> > +		bl->props.power = FB_BLANK_POWERDOWN;
> > +	else
> > +		bl->props.power = FB_BLANK_UNBLANK;
> > +
> >  	backlight_update_status(bl);
> 
> Looking at this again, perhaps a more sensible thing to do would be to
> not call backlight_update_status() in the first place. For example if
> the board defines that backlight should be kept off at boot, but the
> bootloader had already enabled it, then this would effectively turn off
> the backlight again.

(+cc Ajay Kumar)

Personally, I prefer not to call backlight_update_status(), when the
backlight was already turned on by bootloader. Also, it would be better
for subsystems such as DRM to handle the power of panel.

> 
> I think it's safe to assume that if the bootloader sets up the backlight
> then it would also set up the display. Therefore not touching the
> backlight state at all at probe time seems like the safest default.
> 
> Of course that doesn't help people who use some dumb framebuffer driver
> and therefore nothing explicitly enables the backlight. So it would
> still be changing behaviour for people for whom the bootloader doesn't
> set up the backlight at all and who therefore rely on the kernel to turn
> it on.
> 
> We could perhaps alleviate that pain a little by making this dependent
> on whether or not the board is booted using DT on the assumption that
> anything that uses DT would be "modern" enough to provide a means to
> automatically enable the backlight at the right moment.

I also agree with the way to use DT.

Best regards,
Jingoo Han

> 
> Thierry

