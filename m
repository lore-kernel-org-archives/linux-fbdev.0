From: Matthias Kaehlcke <mka@chromium.org>
Date: Thu, 25 Jul 2019 17:17:26 +0000
Subject: Re: [PATCH v3 0/4] backlight: Expose brightness curve type through sysfs
Message-Id: <20190725171726.GD250418@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190722235926.GA250418@google.com> <20190725111541.GA23883@dell>
In-Reply-To: <20190725111541.GA23883@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Enric Balletbo i Serra <enric.balletbo@collabora.com>

On Thu, Jul 25, 2019 at 12:15:41PM +0100, Lee Jones wrote:
> On Mon, 22 Jul 2019, Matthias Kaehlcke wrote:
> 
> > On Tue, Jul 09, 2019 at 12:00:03PM -0700, Matthias Kaehlcke wrote:
> > > Backlight brightness curves can have different shapes. The two main
> > > types are linear and non-linear curves. The human eye doesn't
> > > perceive linearly increasing/decreasing brightness as linear (see
> > > also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
> > > linearly to human eye"), hence many backlights use non-linear (often
> > > logarithmic) brightness curves. The type of curve is currently opaque
> > > to userspace, so userspace often relies on more or less reliable
> > > heuristics (like the number of brightness levels) to decide whether
> > > to treat a backlight device as linear or non-linear.
> > > 
> > > Export the type of the brightness curve via a new sysfs attribute.
> > > 
> > > Matthias Kaehlcke (4):
> > >   MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
> > >   backlight: Expose brightness curve type through sysfs
> > >   backlight: pwm_bl: Set scale type for CIE 1931 curves
> > >   backlight: pwm_bl: Set scale type for brightness curves specified in
> > >     the DT
> > > 
> > >  .../ABI/testing/sysfs-class-backlight         | 26 ++++++++++++++
> > >  MAINTAINERS                                   |  2 ++
> > >  drivers/video/backlight/backlight.c           | 19 ++++++++++
> > >  drivers/video/backlight/pwm_bl.c              | 35 ++++++++++++++++++-
> > >  include/linux/backlight.h                     |  8 +++++
> > >  5 files changed, 89 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight
> > 
> > ping, any comments on v3?
> 
> Looks like PATCH 2/4 still needs seeing to.

The patch currently doesn't have any comments.

Do you see any specific things that need improvement? If so, could you
comment on the patch?

Thanks

Matthias
