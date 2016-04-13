From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 13 Apr 2016 08:26:13 +0000
Subject: Re: [PATCH v5 03/46] backlight: lm3630a_bl: stop messing with the pwm->period field
Message-Id: <20160413082613.GM8094@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110809.GI18882@ulmo.ba.sec>
 <20160412141613.GI8094@x1>
 <20160412142608.GB25006@ulmo.ba.sec>
 <20160413082511.GL8094@x1>
In-Reply-To: <20160413082511.GL8094@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kamil Debski <k.debski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Joachim Eastwood <manabian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Wed, 13 Apr 2016, Lee Jones wrote:

> On Tue, 12 Apr 2016, Thierry Reding wrote:
>=20
> > On Tue, Apr 12, 2016 at 03:16:13PM +0100, Lee Jones wrote:
> > > On Tue, 12 Apr 2016, Thierry Reding wrote:
> > >=20
> > > > On Wed, Mar 30, 2016 at 10:03:26PM +0200, Boris Brezillon wrote:
> > > > > pwm->period field is not supposed to be changed by PWM users. The=
 only
> > > > > ones authorized to change it are the PWM core and PWM drivers.
> > > > >=20
> > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.co=
m>
> > > > > ---
> > > > >  drivers/video/backlight/lm3630a_bl.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >=20
> > > > Applied, thanks.
> > >=20
> > > Applied?
> >=20
> > You didn't specifically Ack this one, but I presumed that since the
> > change is essentially the same as for pwm-backlight, and this is another
> > prerequisite for the remainder of the series it should go in through the
> > PWM tree as well.
>=20
> If you're taking Backlight patches through a !Backlight tree, you're
> going to have to send out a pull-request.  There are no conflicts
> currently, so I won't use it right away, but I need it in my arsenal
> if they do occur.

... also, don't forget to change the subject line to make the
rest of the patches in Backlight.  The subject description needs to
start with an uppercase char.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
