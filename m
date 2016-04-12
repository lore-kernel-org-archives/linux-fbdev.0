From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Tue, 12 Apr 2016 14:13:01 +0000
Subject: Re: [PATCH v5 15/46] pwm: introduce the pwm_state concept
Message-Id: <20160412161301.30b0dc4f@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-16-git-send-email-boris.brezillon@free-electrons.com>
 <20160412114904.GM18882@ulmo.ba.sec>
 <20160412141718.5fe4cf24@bbrezillon>
 <20160412122141.GP18882@ulmo.ba.sec>
 <20160412144508.2ee181fe@bbrezillon>
 <20160412131118.GQ18882@ulmo.ba.sec>
 <20160412152644.45ff517a@bbrezillon>
 <20160412140546.GS18882@ulmo.ba.sec>
In-Reply-To: <20160412140546.GS18882@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org, Jean-Christophe

On Tue, 12 Apr 2016 16:05:46 +0200
Thierry Reding <thierry.reding@gmail.com> wrote:

> On Tue, Apr 12, 2016 at 03:26:44PM +0200, Boris Brezillon wrote:
> > On Tue, 12 Apr 2016 15:11:18 +0200
> > Thierry Reding <thierry.reding@gmail.com> wrote:
> > 
> > > On Tue, Apr 12, 2016 at 02:45:08PM +0200, Boris Brezillon wrote:
> > > > On Tue, 12 Apr 2016 14:21:41 +0200
> > > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > 
> > > > > On Tue, Apr 12, 2016 at 02:17:18PM +0200, Boris Brezillon wrote:
> > > > > > On Tue, 12 Apr 2016 13:49:04 +0200
> > > > > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > > > > > 
> > > > > > > On Wed, Mar 30, 2016 at 10:03:38PM +0200, Boris Brezillon wrote:
> > > > > > > > The PWM state, represented by its period, duty_cycle and polarity,
> > > > > > > > is currently directly stored in the PWM device.
> > > > > > > > Declare a pwm_state structure embedding those field so that we can later
> > > > > > > > use this struct to atomically update all the PWM parameters at once.
> > > > > > > > 
> > > > > > > > All pwm_get_xxx() helpers are now implemented as wrappers around
> > > > > > > > pwm_get_state().
> > > > > > > > 
> > > > > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > > > > > ---
> > > > > > > >  drivers/pwm/core.c  |  8 ++++----
> > > > > > > >  include/linux/pwm.h | 54 +++++++++++++++++++++++++++++++++++++++++------------
> > > > > > > >  2 files changed, 46 insertions(+), 16 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > > > > > > index 6433059..f3f91e7 100644
> > > > > > > > --- a/drivers/pwm/core.c
> > > > > > > > +++ b/drivers/pwm/core.c
> > > > > > > > @@ -268,7 +268,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
> > > > > > > >  		pwm->chip = chip;
> > > > > > > >  		pwm->pwm = chip->base + i;
> > > > > > > >  		pwm->hwpwm = i;
> > > > > > > > -		pwm->polarity = polarity;
> > > > > > > > +		pwm->state.polarity = polarity;
> > > > > > > 
> > > > > > > Would this not more correctly be assigned to pwm->args.polarity? After
> > > > > > > all this is setting up the "initial" state, much like DT or the lookup
> > > > > > > tables would for duty cycle and period.
> > > > > > 
> > > > > > Yes, I wasn't sure about the pwm_add_with_polarity() meaning. To me,
> > > > > > all the reference info should be extracted from DT, PWM lookup table or
> > > > > > driver specific ->request() implementation, but I can definitely
> > > > > > initialize the args.polarity here too.
> > > > > > 
> > > > > > Should I keep the pwm->state.polarity assignment (to set the initial
> > > > > > polarity when the driver does not support hardware readout)?
> > > > > 
> > > > > Wouldn't this work automatically as part of the pwm_apply_args() helper
> > > > > if we extended it with this setting?
> > > > 
> > > > Well, as you explained in you answer to patch 5, pwm_apply_args()
> > > > should be called on a per-request basis (each time a PWM device is
> > > > requested), while the initial polarity setting should only be applied
> > > > when registering the PWM chip (and its devices). After that, the
> > > > framework takes care of keeping the PWM state in sync with the hardware
> > > > state.
> > > > 
> > > > Let's take a real (though a bit unusual) example. Say you have a single
> > > > PWM device referenced by two different users. Only one user can be
> > > > enabled at a time, but each of them has its own reference config
> > > > (different polarity, different period).
> > > > 
> > > > User1 calls pwm_get() and applies its own polarity and period. Then
> > > > user1 is unregistered and release the PWM device, leaving the polarity
> > > > and period untouched.
> > > > 
> > > > User2 is registered and request the same PWM device, but user2 is
> > > > smarter and tries to extract the current PWM state before adapting the
> > > > config according to pwm_args. If you just reset pwm->state.polarity
> > > > each time pwm_apply_args() is called (and you suggested to call it as
> > > > part of the request procedure), then this means the PWM state is no
> > > > longer in sync with the hardware state.
> > > 
> > > In that case neither will be the period or duty cycle. Essentially this
> > > gets us back to square one where we need to decide how to handle current
> > > state vs. initial arguments.
> > 
> > That's not true. Now we clearly differentiate the reference config
> > (content of pwm_args which is only a subset of what you'll find in
> > pwm_state) and the PWM state (represented by pwm_state).
> > 
> > We should be safe as long as we keep those 2 elements as 2 orthogonal
> > concepts:
> > - pwm_args is supposed to give some hint to the PWM user to help him
> >   configure it's PWM appropriately
> > - pwm_state is here to reflect the real PWM state, and apply new
> >   configs
> > 
> > > 
> > > But I don't think this is really going to be an issue because this is
> > > all moot until we've moved over to the atomic API, at which point this
> > > is all going to go away anyway.
> > 
> > As stated in my answer to patch 5, I think I misunderstood your
> > suggestion. pwm_apply_args() is supposed to adjust the PWM config to
> > match the period and polarity specified in pwm_args, right?
> > 
> > If that's the case, my question is, should we really call this function
> > each time a new user requests a PWM instead of letting those users call
> > the function on-demand (not all users want to adapt the current PWM
> > config to the pwm_args, some may just want to apply a completely new
> > config).
> 
> I think we're still talking past each other. I didn't mean for this to
> be a proper part of the API. Like you said the struct pwm_args doesn't
> contain enough data to construct a complete state and apply it.
> 
> What I was suggesting is to factor out the individual calls to the
> various pwm_set_*() functions into a single call. So we wouldn't be
> changing semantics, just refactoring to make it easier to get rid of
> again in one of the subsequent patches.
> 
> That is, pwm_apply_args() would go away again within this very series,
> at the same point that you're currently removing the pwm_set_*() calls.

Okay, eventually got it :).

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
