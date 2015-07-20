From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 20 Jul 2015 09:10:04 +0000
Subject: Re: [RFC PATCH 08/15] backlight: pwm_bl: remove useless call to pwm_set_period
Message-Id: <20150720091003.GN29614@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nb8zVy0QMK3AA1xu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-9-git-send-email-boris.brezillon@free-electrons.com>
 <20150720081559.GI29614@ulmo> <20150720102143.05949ca2@bbrezillon>
 <20150720083648.GK29614@ulmo> <20150720105003.29b5813a@bbrezillon>
In-Reply-To: <20150720105003.29b5813a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 10:50:03AM +0200, Boris Brezillon wrote:
> On Mon, 20 Jul 2015 10:36:50 +0200
> Thierry Reding <thierry.reding@gmail.com> wrote:
>=20
> > On Mon, Jul 20, 2015 at 10:21:43AM +0200, Boris Brezillon wrote:
> > > On Mon, 20 Jul 2015 10:16:00 +0200
> > > Thierry Reding <thierry.reding@gmail.com> wrote:
> > >=20
> > > > On Wed, Jul 01, 2015 at 10:21:54AM +0200, Boris Brezillon wrote:
> > > > > The PWM period will be set when calling pwm_config. Remove this u=
seless
> > > > > call to pwm_set_period, which might mess up with the initial PWM =
state
> > > > > once we have added proper support for PWM init state retrieval.
> > > > >=20
> > > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.co=
m>
> > > > > ---
> > > > >  drivers/video/backlight/pwm_bl.c | 4 +---
> > > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/bac=
klight/pwm_bl.c
> > > > > index ae498c1..fe5597c 100644
> > > > > --- a/drivers/video/backlight/pwm_bl.c
> > > > > +++ b/drivers/video/backlight/pwm_bl.c
> > > > > @@ -295,10 +295,8 @@ static int pwm_backlight_probe(struct platfo=
rm_device *pdev)
> > > > >  	 * via the PWM lookup table.
> > > > >  	 */
> > > > >  	pb->period =3D pwm_get_default_period(pb->pwm);
> > > > > -	if (!pb->period && (data->pwm_period_ns > 0)) {
> > > > > +	if (!pb->period && (data->pwm_period_ns > 0))
> > > > >  		pb->period =3D data->pwm_period_ns;
> > > > > -		pwm_set_period(pb->pwm, data->pwm_period_ns);
> > > > > -	}
> > > > > =20
> > > > >  	pb->lth_brightness =3D data->lth_brightness * (pb->period / pb-=
>scale);
> > > >=20
> > > > As far as I remember this line is there in order to pass in a perio=
d if
> > > > the backlight driver is initialized from board setup files. In such=
 a
> > > > case there won't be an period associated with the PWM channel in the
> > > > first place.
> > > >=20
> > > > I think even with the introduction of a default period, we'd be mis=
sing
> > > > out on the board setup case because there is no standard place wher=
e it
> > > > is being set, so it must come from the platform data.
> > >=20
> > > AFAICT, we don't need to explicitly set the period when probing the
> > > backlight device, because it will be set next time we call
> > > pwm_config(), and since we're passing pb->period when calling
> > > pwm_config() everything should be fine.
> >=20
> > Calling pwm_set_period() is still good for consistency. Consider for
> > example what happens if after the driver were to call pwm_get_period().
> > It would return some more or less random value (likely 0 or whatever it
> > had been set to by an earlier user).
>=20
> Yes, that's true in general, but in this specific driver
> pwm_get_period() is never called, and the driver only relies on the
> pb->period value.

Perhaps that's something that should change. If the PWM core has all
this infrastructure there should be no need for the backlight driver to
keep it's own copy of that variable.

> > Technically I think the most proper equivalent here would be to set the
> > default state's period to data->pwm_period_ns, but I don't think that's
> > proper to do. Perhaps since this is only relevant to boards where the
> > backlight device is created from board setup code we don't have to care
> > so much about messing up the initial state because either the board
> > setup code has been carefully written to match what the bootloader set
> > up, or because they don't match at all, in which case we don't have to
> > worry anyway.
>=20
> IMHO, if we had to support default period values for non DT boards, the
> proper way would be to pass something in the PWM platform data and let
> the PWM driver (or PWM core) initialize the default PWM state.
> This way the PWM user could rely on the pwm_get_default_period() helper
> to extract the default period value.

Yes, that's what PWM lookup tables are meant to address. I tried to
convert existing users a number of times, but never got any replies and
since it's board code I couldn't merge this through the PWM tree...

Thierry

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVrLrrAAoJEN0jrNd/PrOh08gQALrBJoxriwoZWZuTHFuVxlXj
+qacwxnzF7AAuQ33hTrSUoW5nvNOH2Tk2sdvD3dyG2f0RoxSTh48BN3AcwOT/05Z
2+YTTQx+hNl3JGwAfaJ5jMWlhu+spJ3YzRUvFxCT3lRxiRctHlu+Gv69tykqmQUS
onIO1vId37QlOKXdu2GrDwQUDhaGbsOYAj9kA+1SI4svYEnOKIzeUOz+kOxWC4DI
Q0K2O4ztcJFKkOBxhY92QIjwgyO0E5aN/tRr4g4H/0lOATHXXukAQ2iKKmAvoCvU
jvrbArFhS7zlGLAM0eshD/JJC+ticio8MGxo+G5OK+aRyEHeRads9ZDKpJdQIQLI
sHRZwJQeMKXX+eXSr9aozDPFwcYjURToyuAWGH8HwsnwBGiN9ReUKjlQ5ty7Q2R2
5xzV95vPKpAm2g+Y3kABZEKNGL0E+QEdLrQOs3w/tV7XsZT+YfC3iD5ZI6dpctew
QwaQctm9QKzYDU7PQPPUSMF9viEmQENVp/oLAyxXcnO7Mhvoh+IsThOM6xd4GPkf
4ok+DiTUzYt2p8KM/GGy1WSuoCi5PCj2oJ/iHdGjhRlXRrxdDhIE+chBtxdUu64m
Gr6fMb1mkw/gyQ9d4g1FYO97SHX1SOPhtczpGro1gib6U7Xc0lnRIAVf9urr9mVT
ciC3JfK9IB1EEWiTRCR6
=xdx6
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--
