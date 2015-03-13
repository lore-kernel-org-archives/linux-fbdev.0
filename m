From: Thomas =?UTF-8?B?TmllZGVycHLDvG0=?= <niederp@physik.uni-kl.de>
Date: Fri, 13 Mar 2015 19:21:37 +0000
Subject: Re: [PATCH 7/8] fbdev: ssd1307fb: Add sysfs handles to expose contrast and dim setting to userspace.
Message-Id: <20150313202137.5957a23f@maestro.intranet>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
	<1423261694-5939-8-git-send-email-niederp@physik.uni-kl.de>
	<20150207114329.GQ2079@lukather>
	<20150207174244.25987977@maestro.intranet>
	<20150209085239.GX2079@lukather>
	<54FECC2F.8080804@ti.com>
In-Reply-To: <54FECC2F.8080804@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org

Am Tue, 10 Mar 2015 12:49:19 +0200
schrieb Tomi Valkeinen <tomi.valkeinen@ti.com>:

> On 09/02/15 10:52, Maxime Ripard wrote:
> > On Sat, Feb 07, 2015 at 05:42:44PM +0100, Thomas Niederpr=C3=BCm wrote:
> >>>> +static struct device_attribute device_attrs[] =3D {
> >>>> +	__ATTR(contrast, S_IRUGO|S_IWUSR, show_contrast,
> >>>> store_contrast),
> >>>> +	__ATTR(dim, S_IRUGO|S_IWUSR, show_dim, store_dim),
> >>>> +
> >>>> +};
> >>>> +
> >>>
> >>> I would have thought this was something accessible through the
> >>> framebuffer ioctl.
> >>>
> >>> Apparently it's not, at least for the contrast, so maybe it
> >>> should be added there, instead of doing it for a single driver?
> >>
> >> I think the contrast setting for an OLED display is much like the
> >> backlight setting for LCD panel. Since there is also no ioctl to
> >> set the backlight of an LCD I wonder if the contrast of an OLED
> >> should have one.
> >=20
> > It's too much of framebuffer interface debate for me here. Tomi?
>=20
> We have backlight and contrast already in backlight-class and
> lcd-class (drivers/video/backlight/backlight.c and
> drivers/video/backlight/lcd.c). Are those something that could be
> used here instead of custom sysfs files?

I just gave the backlight-class a try and it works like a charm. I
will include it in v4 and drop the sysfs handles instead. Thanks for the
hint!

Thomas

