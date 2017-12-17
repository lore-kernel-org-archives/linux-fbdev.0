From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Sun, 17 Dec 2017 20:57:20 +0000
Subject: Re: [PATCH v2 2/3] backlight: tdo24m: add the reset line gpio
Message-Id: <20171217205720.7ujsneqdbsjkenej@oak.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171013194250.9001-1-robert.jarzmik@free.fr>
 <20171013194250.9001-2-robert.jarzmik@free.fr>
 <20171215115309.ez7odo7sh5zz7vge@oak.lan>
 <87shcaewah.fsf@belgarion.home>
In-Reply-To: <87shcaewah.fsf@belgarion.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Dec 16, 2017 at 12:39:50PM +0100, Robert Jarzmik wrote:
> Daniel Thompson <daniel.thompson@linaro.org> writes:
> > On Fri, Oct 13, 2017 at 09:42:48PM +0200, Robert Jarzmik wrote:
> >> The Toppoly panels have a global reset line. Add an optional gpio
> >> control for this line, for platforms which have the ability to drive it.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >>  drivers/video/backlight/tdo24m.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >> 
> >> diff --git a/drivers/video/backlight/tdo24m.c b/drivers/video/backlight/tdo24m.c
> >> index e4bd63e9db6b..e4b2dfabf192 100644
> >> --- a/drivers/video/backlight/tdo24m.c
> >> +++ b/drivers/video/backlight/tdo24m.c
> >> @@ -10,6 +10,7 @@
> >>   */
> >>  
> >>  #include <linux/module.h>
> >> +#include <linux/gpio/consumer.h>
> >>  #include <linux/kernel.h>
> >>  #include <linux/init.h>
> >>  #include <linux/device.h>
> >> @@ -32,6 +33,7 @@ struct tdo24m {
> >>  	struct spi_message	msg;
> >>  	struct spi_transfer	xfer;
> >>  	uint8_t			*buf;
> >> +	struct gpio_desc	*xres;
> >
> > Why do we need a write-only variable?
> It's written to by devm_gpiod_get() below.

Yes, but it not *read* anywhere because we rely on devm to release the GPIO.
Why do we need a write-only variable?


> >> +	lcd->xres = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
> >
> > devm_gpiod_get_optional() would be better, if only for its commenting
> > value.
> Yes, you're perfectly right.
> 
> > Also, this adds a new optional property, doesn't the devicetree binding 
> > docs need to be update to match this?
> Ah yes, that too. I'll add it for v3.

Thanks!


Daniel.
