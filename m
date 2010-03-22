From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Mon, 22 Mar 2010 11:01:16 +0000
Subject: Re: [PATCH v2 3/6] hid: add backlight support to PicoLCD device
Message-Id: <20100322120116.12979762@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100320170014.440959a8@neptune.home>
	<20100320170619.4ae99546@neptune.home>
	<alpine.LNX.2.00.1003220957390.18642@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1003220957390.18642@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Richard Purdie <rpurdie@rpsys.net>

On Mon, 22 March 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> On Sat, 20 Mar 2010, Bruno Prémont wrote:
> 
> > Add backlight support to PicoLCD device.
> > 
> > Backlight support depends on backlight class and is only being
> > compiled if backlight class has been selected.
> > 
> > Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> > ---
> >  drivers/hid/Kconfig       |    2 +-
> >  drivers/hid/hid-picolcd.c |  134 ++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 134 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index a474bcd..5ec3cb7 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -243,8 +243,8 @@ config HID_PICOLCD
> >  	  - Keypad
> >  	  - Switching between Firmware and Flash mode
> >  	  - Framebuffer for monochrome 256x64 display
> > +	  - Backlight control    (needs CONFIG_BACKLIGHT_CLASS_DEVICE)
> 
> Wouldn't it be better to have Kconfig rules actually resolve the 
> dependency?
> 
> I don't see any issue with HID_PICOLCD directly selecting 
> BACKLIGHT_CLASS_DEVICE. Or you can do a separate sub-option for that, if 
> you really want to avoid the direct dependency of the whole driver.

I could select both BACKLIGHT_CLASS_DEVICE and LCD_CLASS_DEVICE (as
well as their common parent -- same applies to FB) though for the
LEDS_CLASS I would definitely rather go the path of a sub-option, by
default the GPO pins operated with the LEDs are not connected to
anything.

Thanks for the review,
Bruno
