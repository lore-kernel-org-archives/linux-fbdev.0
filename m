From: Tomasz Figa <t.figa@samsung.com>
Date: Fri, 17 May 2013 12:29:35 +0000
Subject: Re: [PATCH 1/2] video: exynos_dp: Add parsing of gpios pins to exynos-dp driver
Message-Id: <6459883.FZan3akiXR@amdc1227>
List-Id: <linux-fbdev.vger.kernel.org>
References: <26364319.123371368669839202.JavaMail.weblogic@epml12>
In-Reply-To: <26364319.123371368669839202.JavaMail.weblogic@epml12>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: jg1.han@samsung.com
Cc: Vikas Sajjan <vikas.sajjan@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, =?utf-8?B?6rmA6rWt7KeE?= <kgene.kim@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "patches@linaro.org" <patches@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "rpurdie@rpsys.net" <rpurdie@rpsys.net>, "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Jingoo,

On Thursday 16 of May 2013 02:03:59 한진구 wrote:
> Tuesday, May 14, 2013 11:17 PM, Vikas Sajjan wrote:
> 
> > 
> > Hi Vikas,
> > 
> > On Tuesday 14 of May 2013 18:25:51 Vikas Sajjan wrote:
> > 
> > >  Adds GPIO parsing functionality for "LCD backlight" and "LCD enable"
> > >  GPIO pins of exynos dp controller.
> > >
> > >
> > >
> > > Signed-off-by: Vikas Sajjan <vikas.sajjan@linaro.org>
> > > ---
> > > 
> > >  drivers/video/exynos/exynos_dp_core.c |   45
> > > 
> > > +++++++++++++++++++++++++++++++++ 1 file changed, 45 insertions(+)
> > >
> > >
> > 
> > 
> > I don't think that Exynos DP driver is right place for such code.
> > Backlight
 and LCD drivers are responsible for backlight and LCD power
> > control using backlight and LCD subsystems.
> > 
> > IMHO the correct solution would be to either extend existing
> > backlight/lcd
> > drivers found in drivers/video/backlight to support direct GPIO control
> > and
 parse GPIO pins from device tree or create new gpio_bl and gpio_lcd
> > drivers.
> 
> Hi Vikas Sajian,
> 
> I agree with Tomasz Figa's opinion.
> Backlight/LCD framework should be used.
> eDP panel backlight on SMDK5210 board can be controlled by PWM;
> thus, pwm-backlight driver should be used.
> Also, eDP panel reset pin should be controlled by using
> platform-lcd driver.
> 
> 
> > 
> > CCing Richard, Florian and linux-fbdev.
> 
> 
> Also, I have been doing backlight reviews instead of Richard,
> please do CC'ing me.

OK. I used get_maintainers script, but it seems like the result was a bit off 
in this case. Will remember for future.

Best regards,
-- 
Tomasz Figa
Linux Kernel Developer
Samsung R&D Institute Poland
Samsung Electronics

