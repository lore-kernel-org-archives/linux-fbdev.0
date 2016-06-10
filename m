From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Date: Fri, 10 Jun 2016 10:34:53 +0000
Subject: Re: [PATCHv2] backlight: pwm_bl: disable PWM when 'duty_cycle' is zero
Message-Id: <20160610123453.3a8ee14e@ipc1.ka-ro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465294429-8570-1-git-send-email-LW@KARO-electronics.de>
	<20160609135125.GA2385@dell>
	<20160610072346.51b0a5d5@ipc1.ka-ro>
	<20160610074449.GB1537@dell>
In-Reply-To: <20160610074449.GB1537@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jingoohan1@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org

Hi,

On Fri, 10 Jun 2016 08:44:49 +0100 Lee Jones wrote:
> On Fri, 10 Jun 2016, Lothar Waßmann wrote:
> 
> > Hi,
> > 
> > On Thu, 9 Jun 2016 14:51:25 +0100 Lee Jones wrote:
> > > On Tue, 07 Jun 2016, Lothar Waßmann wrote:
> > > 
> > > > 'brightness' is usually an index into a table of duty_cycle values,
> > > > where the value at index 0 may well be non-zero
> > > > (tegra30-apalis-eval.dts and tegra30-colibri-eval-v3.dts are real-life
> > > > examples).
> > > > Thus brightness = 0 does not necessarily mean that the PWM output
> > > > will be inactive.
> > > > Check for 'duty_cycle = 0' rather than 'brightness = 0' to decide
> > > > whether to disable the PWM.
> > > > 
> > > > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> > > > ---
> > > > Changes wrt. v1:
> > > >   - update binding docs to reflect the change
> > > > 
> > > >  .../devicetree/bindings/leds/backlight/pwm-backlight.txt         | 9 ++++++---
> > > >  drivers/video/backlight/pwm_bl.c                                 | 4 ++--
> > > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > > > index 764db86..95fa8a9 100644
> > > > --- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > > > +++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
> > > > @@ -4,10 +4,13 @@ Required properties:
> > > >    - compatible: "pwm-backlight"
> > > >    - pwms: OF device-tree PWM specification (see PWM binding[0])
> > > >    - brightness-levels: Array of distinct brightness levels. Typically these
> > > > -      are in the range from 0 to 255, but any range starting at 0 will do.
> > > > +      are in the range from 0 to 255, but any range will do.
> > > >        The actual brightness level (PWM duty cycle) will be interpolated
> > > > -      from these values. 0 means a 0% duty cycle (darkest/off), while the
> > > > -      last value in the array represents a 100% duty cycle (brightest).
> > > > +      from these values. 0 means a 0% duty cycle, while the highest value in
> > > > +      the array represents a 100% duty cycle.
> > > > +      The range may be in reverse order (starting with the maximum duty cycle
> > > > +      value) to create a PWM signal with the 100% duty cycle representing
> > > > +      minimum and 0% duty cycle maximum brigthness.
> > > >    - default-brightness-level: the default brightness level (index into the
> > > >        array defined by the "brightness-levels" property)
> > > >    - power-supply: regulator for supply voltage
> > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > index b2b366b..80b2b52 100644
> > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > @@ -103,8 +103,8 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
> > > >  	if (pb->notify)
> > > >  		brightness = pb->notify(pb->dev, brightness);
> > > >  
> > > > -	if (brightness > 0) {
> > > > -		duty_cycle = compute_duty_cycle(pb, brightness);
> > > > +	duty_cycle = compute_duty_cycle(pb, brightness);
> > > > +	if (duty_cycle > 0) {
> > > 
> > > How does this work in the aforementioned:
> > > 
> > >   "The range may be in reverse order"
> > > 
> > > ... case?  Surely when duty_cycle is when the screen should be at it's
> > > brightest?  Wouldn't it confuse the user if they turn their brightness
> > > *up* and the screen goes *off*?
> > > 
> > Assuming that the PWM output is inactive (LOW) when the duty_cycle is
> > set to zero, there will be no difference between operating the PWM at
> > duty_cycle 0 or disabling it.
> > 
> > Currently, the screen will go bright when it should be off in this
> > case.
> 
> It sounds like we need something that lets the framework know if
> duty_cycle = MAX is the brightest or if duty_cycle = 0 is.  Either way
> someone is going to get screwed by this logic.
> 
The backlight framework does not (and does not need to) know anything
about PWM duty cycles. Its 'brightness' values are consistently 0 =
dark, max = brightest in either case.


Lothar Waßmann
