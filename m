From: Matthias Kaehlcke <mka@chromium.org>
Date: Thu, 13 Jun 2019 15:43:57 +0000
Subject: Re: [PATCH] backlight: pwm_bl: Fix heuristic to determine number of brightness levels
Message-Id: <20190613154357.GN137143@google.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190612180003.161966-1-mka@chromium.org>
 <fd554750-7ec6-73e1-be3a-5bac0749fa0b@collabora.com>
In-Reply-To: <fd554750-7ec6-73e1-be3a-5bac0749fa0b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Brian Norris <briannorris@chromium.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>

On Thu, Jun 13, 2019 at 11:14:55AM +0200, Enric Balletbo i Serra wrote:
> Hi Matthias,
> 
> On 12/6/19 20:00, Matthias Kaehlcke wrote:
> > With commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of
> > LED linearly to human eye") the number of set bits (aka hweight())
> > in the PWM period is used in the heuristic to determine the number
> > of brightness levels, when the brightness table isn't specified in
> > the DT. The number of set bits doesn't provide a reliable clue about
> > the length of the period, instead change the heuristic to:
> > 
> >  nlevels = period / fls(period)
> > 
> > Also limit the maximum number of brightness levels to 4096 to avoid
> > excessively large tables.
> > 
> > With this the number of levels increases monotonically with the PWM
> > period, until the maximum of 4096 levels is reached:
> > 
> > period (ns)    # levels
> > 
> > 100    	       16
> > 500	       62
> > 1000	       111
> > 5000	       416
> > 10000	       769
> > 50000	       3333
> > 100000	       4096
> > 
> > Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Tested on Samsung Chromebook Plus (16-bit pwm)
> 
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks!
