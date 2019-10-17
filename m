From: Adam Ford <aford173@gmail.com>
Date: Thu, 17 Oct 2019 13:09:36 +0000
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Message-Id: <CAHCN7xJz9vOQneMSZQ6GSqLCROWOHNgdx6NF=Ut5J2S+_aLKzw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
 <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
 <CAHCN7xKogdqoLmbbTatPdtLzqz+MKh-jgrHkkCh+YA-bwwOkDA@mail.gmail.com>
 <CAHCN7xJFDrsqzR2H2mNYhKB8iF7xYWb9kM+HdzukjDix461gsg@mail.gmail.com>
 <20191017130519.GC3768303@ulmo>
In-Reply-To: <20191017130519.GC3768303@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Sascha Hauer <kernel@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>

On Thu, Oct 17, 2019 at 8:05 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Thu, Oct 17, 2019 at 07:40:47AM -0500, Adam Ford wrote:
> > On Thu, Oct 17, 2019 at 7:34 AM Adam Ford <aford173@gmail.com> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 7:19 AM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > >
> > > > On Thu, Oct 17, 2019 at 12:47:27PM +0100, Daniel Thompson wrote:
> > > > > On Thu, Oct 17, 2019 at 10:10:59AM +0200, Uwe Kleine-König wrote:
> > > > > > A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
> > > > > > pwm_get_state() return the last implemented state")) changed the
> > > > > > semantic of pwm_get_state() and disclosed an (as it seems) common
> > > > > > problem in lowlevel PWM drivers. By not relying on the period and duty
> > > > > > cycle being retrievable from a disabled PWM this type of problem is
> > > > > > worked around.
> > > > > >
> > > > > > Apart from this issue only calling the pwm_get_state/pwm_apply_state
> > > > > > combo once is also more effective.
> > > > >
> > > > > I'm only interested in the second paragraph here.
> > > > >
> > > > > There seems to be a reasonable consensus that the i.MX27 and cros-ec
> > > > > PWM drivers should be fixed for the benefit of other PWM clients.
> > > > > So we make this change because it makes the pwm-bl better... not to
> > > > > work around bugs ;-).
> > > >
> > > > That's fine, still I think it's fair to explain the motivation of
> > > > creating this patch.
> > > >
> > > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > > > > index 746eebc411df..ddebd62b3978 100644
> > > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > > @@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
> > > > > >
> > > > > >  static void pwm_backlight_power_off(struct pwm_bl_data *pb)
> > > > > >  {
> > > > > > -   struct pwm_state state;
> > > > > > -
> > > > > > -   pwm_get_state(pb->pwm, &state);
> > > > > > -   if (!pb->enabled)
> > > > > > -           return;
> > > > > > -
> > > > >
> > > > > Why remove the pb->enabled check? I thought that was there to ensure we
> > > > > don't mess up the regular reference counts.
> > > >
> > > > I havn't looked yet, but I guess I have to respin. Expect a v2 later
> > > > today.
> > >
> > > I would agree that a high-level fix is better than a series of low
> > > level driver fixes.  For what its worth, your V1 patch worked fine on
> > > my i.MX6Q.  I can test the V2 patch when its ready.
> >
> > I may have spoken too soon.  The patch fixes the display in that it
> > comes on when it previously did not, but changes to brightness do not
> > appear to do anything anymore.  I don't have an oscilloscope where I
> > am now, so I cannot verify whether or not the PWM duty cycle changes.
> >
> > To my eye, the following do not appear to change the brightness of the screen:
> >      echo 7 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/brightness
> >      echo 2 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/brightness
> >      echo 5 > /sys/devices/soc0/backlight-lvds/backlight/backlight-lvds/brightness
>
> Hi Adam,
>
> can you try the i.MX PWM patch that I posted earlier instead? I really
> think we need to fix this in the PWM drivers because they are broken.
> pwm-backlight is not. -rc3 is really not a time to work around breakage
> in consumers.

I did try your patch, but it did not appear to make any difference on my i.MX6Q.

>
> If my patch doesn't help, can you try reverting the offending patch? If
> we can't come up with a good fix for the drivers, reverting is the next
> best option.

I am able to get an image after reverting the offending patch.  I did
not try playing with brightness levels after reverting.


>
> Thierry
