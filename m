From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 19 Aug 2019 12:29:15 +0000
Subject: Re: [PATCH v3 2/4] backlight: Expose brightness curve type through sysfs
Message-Id: <20190819122915.icjszuvnwyjpa75n@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190709190007.91260-1-mka@chromium.org>
 <20190709190007.91260-3-mka@chromium.org>
 <20190816165148.7keg45fmlndr22fl@pengutronix.de>
 <20190816175157.GT250418@google.com>
 <20190816194754.ldzjqy2yjonfvaat@pengutronix.de>
 <20190816211051.GV250418@google.com>
 <20190819054628.asw3cxp46w3rpml7@pengutronix.de>
 <20190819095037.h3gig3quyhnzshm7@holly.lan>
 <20190819102127.wqudnbngottjakf5@pengutronix.de>
 <20190819111613.2kkn25tmjgyjhbip@holly.lan>
In-Reply-To: <20190819111613.2kkn25tmjgyjhbip@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Pavel Machek <pavel@ucw.cz>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, kernel@pengutronix.de

On Mon, Aug 19, 2019 at 12:16:13PM +0100, Daniel Thompson wrote:
> On Mon, Aug 19, 2019 at 12:21:27PM +0200, Uwe Kleine-K=F6nig wrote:
> > > > > In an ideal world the backlight interface would be consistent as =
you
> > > > > suggest, however there are plenty of existing devices which use t=
he
> > > > > 'other' scaling (regardless of which is chosen as the 'correct'
> > > > > one). Userspace still has to deal with these. And changing previo=
usly
> > > > > 'logarithmic' drivers to linear (or viceversa) may 'break' usersp=
ace,
> > > > > when it keeps using its 'old' scaling, which now isn't correct an=
ymore.
> > > >=20
> > > > It might be subjective, or maybe I'm just too optimistic, but I thi=
nk if
> > > > there was no policy before about the meaning of
> > > >=20
> > > > 	echo 17 > brightness
> > > >=20
> > > > other than "brighter than lower values and darker than higher ones"
> > > > introducing (say) the scale is intended to represent a linear brigh=
tness
> > > > curve is ok.
> > > >=20
> > > > Unless userspace jumps through hoops and tries to identify the actu=
al
> > > > device it is running on it is wrong on some machines anyhow and we'=
re
> > > > only shifting the set of affected machines with a tighter policy (u=
ntil
> > > > that userspace application is fixed).
> > >=20
> > > I believe that there are two common approaches by userspace at presen=
t:
> > >=20
> > > 1. Assume the scale is perceptual and we can directly map a slider
> > >    to the backlight value. This is common simply because most ACPI
> > >    backlights are perceptual and therefore when tested in a laptop
> > >    it works OK.
> > >=20
> > > 2. Assume that is max brightness is small (e.g. ACPI) then the
> > >    scale is perceptual and if the max brightness is large (e.g.
> > >    a PWM) then the scale is linear and apply a correction
> > >    function between the slider and the control.
> > >=20
> > > That historic baggage makes is diffcult to "just define a standardized
> > > scale"... especially given that if we selected a standardized scale we
> > > would probably want a perceptual scale with lots of steps (e.g. break
> > > the heuristic).
> >=20
> > With "perceptual" you mean that logarithmic stuff, right?
>=20
> Human perception is fairly complex so it depends how strict you want to
> get. At the end of the day what it means is you can map a slider UI
> component directly to the backlight range and it will feel right. Thus
> a userspace that maps directly to a slider *is* assuming the scale
> is perceptual.

I have problems to declare something as "the right thing to do" that
depends on feeling of users. I much prefer to make a technical device
authoritative here (in this case a device that measures emitted light).

Other than that I don't have enough experience with backlights to judge
the decisions that have to be done and so will stop my participation in
this thread now.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
