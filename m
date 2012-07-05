From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Thu, 05 Jul 2012 07:57:14 +0000
Subject: Re: [PATCH] pwm-backlight: add regulator and GPIO support
Message-Id: <20120705075714.GA26428@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120704104840.GJ24458@pengutronix.de>
 <4FF43692.2040805@nvidia.com>
 <20120704130056.GC30009@pengutronix.de>
 <4FF45DDF.9000306@nvidia.com>
 <20120704152451.GA7333@sirena.org.uk>
 <4FF4FDC0.8020405@nvidia.com>
 <20120705062011.GI30009@pengutronix.de>
 <4FF53368.6090805@nvidia.com>
 <20120705064742.GL30009@pengutronix.de>
 <4FF5459F.5090201@nvidia.com>
In-Reply-To: <4FF5459F.5090201-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2012 at 04:43:27PM +0900, Alex Courbot wrote:
> On 07/05/2012 03:47 PM, Sascha Hauer wrote:
> >>I thought about just checking if devm_get_regulator returned -ENODEV
> >>and happily continue if that was the case, assuming no regulator was
> >>declared.
> >
> >And that's the problem. The get_regulator won't return -ENODEV. It will
> >return -EPROBE_DEFER which tells you nothing about whether a regulator
> >will ever be available or not.
> >
> >Having a flag in platform data would be fine with me, but I know other
> >people think differently.
> >
> >BTW in devicetree this flag implicitely exists with the power-supply
> >property.
>=20
> One could actually question whether the whole regulator/gpio thing
> should be supported at all with platform data. The platform
> interface can use the function hooks in order to implement whatever
> behavior it wants when the light needs to be powered on and off. The
> reason for introducing optional regulator/gpio parameters is because
> the DT cannot use these. Since I have no plan to remove these
> function hooks, making the regulator/gpio option available in
> platform data might be redundant. Any thought about this?

I agree. Non-DT platforms have always used the callbacks to execute this
kind of code. As you've said before there are situations where it isn't
just about setting a GPIO or enabling a regulator but it also requires a
specific timing. Representing this in the platform data would become
tedious.

So I think for the DT case you can parse the power-on and power-off
sequences directly and execute code based on it, while in non-DT cases
the init and exit callbacks should be used instead. I think it even
makes sense to reuse the platform data's init and exit functions in the
DT case and implement the parser/interpreter within those.

> >Right now the regulator core will just return -EPROBE_DEFER in both
> >cases. This could easily be changed in the regulator core.
>=20
> Could this be because the regulator core cannot make the difference
> between a not-yet-available regulator and a missing one?

I case where the regulator comes from a DT it should assume that it will
become available at some point, so -EPROBE_DEFER is correct. However if
the DT doesn't even contain the power-supply property, then EPROBE_DEFER
will never work because there's no regulator to become available.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJP9UjaAAoJEN0jrNd/PrOhU6MP/jPqvDMa0WgF59KAn5wg9FAU
hZTJ8x08OOD1cWiZNdJ2Muqf4Ttq7LbNa+kR1A+JYOLOzTYDIwBDHwLtcko1k1Mt
FT2uTP9QfibhK4o5sr7DLiy5sScQxdamv4a6f4Krf2SkiSLR4KbEgx+cU9X8Amp3
EGiFGDC+a0ITSS+mc0RT2VZENqH6sV2NUuEq4Pwoh7WkgdtEuVxnNLNUuACpHrNd
o1Vaag00eHKbUJd482hsSqyDiG88vBfSRceesy1s4Eo1K9S5L8t6evNDiBQFRT7e
Tg5fBovOk79Acz2VaYdsc4FULh6Whpo7SDxlnkX9aImHS4o8bILZSTWMKBt7FABi
k/ryv7yOayCdOiVsNjet2r4kLyJuZ7YAgzfHyZCCUyLxDK7CxUnARzXRhtvjFO79
Wl7c/mV6fLBP9GuA5vwgei9CTdeYH6tHmuG0sa85o04PkV6opqjhsq1tGqn3BAvW
BhPsig7b/KjDuxXveXw9ph4vVEiSiU1CVO3oIgcKZIKq4l4hNcQnewMorsw3kcjL
HLt65aveqM3qf3BwKUJXmXeVEqHUaRyEkxRS2ulYg/9TvHS/6UVU72GRZWg3kc5r
n2T6DMB2JAcE+VUL2e4RgsBMvQegFaF3NJ0MiDOdzfY3BM0PrHr7FmXWJCD1aKCk
4AiGiSwgBDUL5UxGHoP9
=YaPi
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
