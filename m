From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Thu, 02 Aug 2012 08:21:57 +0000
Subject: Re: [RFC][PATCH v3 1/3] runtime interpreted power sequences
Message-Id: <20120802082157.GA14866@avionic-0098.adnet.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1343390750-3642-1-git-send-email-acourbot@nvidia.com>
 <1343390750-3642-2-git-send-email-acourbot@nvidia.com>
 <50170EA0.1010408@wwwdotorg.org>
 <501A338D.7080105@nvidia.com>
In-Reply-To: <501A338D.7080105-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 02, 2012 at 05:00:13PM +0900, Alex Courbot wrote:
> On 07/31/2012 07:45 AM, Stephen Warren wrote:
> >Oh I see. That's a little confusing. Why not just reference the relevant
> >resources directly in each step; something more like:
> >
> >		gpio@1 {
> >			action =3D "enable-gpio";
> >			gpio =3D <&gpio 1 0>;
> >		};
> >
> >I guess that might make parsing/building a little harder, since you'd
> >have to detect when you'd already done gpio_request() on a given GPIO
> >and not repeat it or something like that, but to me this makes the DT a
> >lot easier to comprehend.
>=20
> I tried to move towards having the phandles directly in the
> sequences themselves - that reminded me why I did not do that in the
> first place. Let's say we have a sequence like this (reg property
> omitted on purpose):
>=20
> 	power-on-sequence {
> 		step@0 {
> 			regulator =3D <&backlight_reg>;
> 			enable;
> 		};
> 		step@1 {
> 			delay =3D <10000>;
> 		};
> 		step@2 {
> 			pwm =3D <&pwm 2 5000000>;
> 			enable;
> 		};
> 		step@3 {
> 			gpio =3D <&gpio 28 0>;
> 			enable;
> 		};
> 	};
>=20
> The problem is, how do we turn these phandles into the resource of
> interest. The type of the resource can be infered by the name of the
> property. The hard part is resolving the resource from the phandle -
> it seems like the API just does not allow to do this. GPIO has
> of_get_named_gpio, but AFAIK there are no equivalent for regulator
> consumer and PWM: the only way to use the DT with them is through
> get_regulator and get_pwm which work at the device level.
>=20
> Or is there a way that I overlooked?

No, you are right. Perhaps we should add exported functions that do the
equivalent of of_pwm_request() or the regulator_dev_lookup() and
of_get_regulator() pair.

Thierry

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQGjilAAoJEN0jrNd/PrOhWQIP/ia8nbamFqB7B7+uXDeV7vqy
GRrn/b9KIIWdIIij79MoJKaoljC2Cwf+i5gviN5IrbN/wvLlZtPXLbO6du3u+YF6
4+b48S8oEysitxKCw3/9t1GGRZVbcLuC2ulHr+GOAsH42J5tD/X8NsSOPBMiL6Zm
jqNP56WcuDAyAG1maCu3cBX66rp8K3ErfOb6QveFmzAWZKGajvQY+/bkdp+bQRPX
gAe7SOqVp1n9u4Tj8gqJC6UQyp+hDulDEZ4yQx/fyRJbxuy1i0gu+33FWhFSVolQ
+aHDIhSZdClv9AnCp2HM8FrXh4BWTh2h31wu+P3h+IV2D0OzQ45SJ/uptMPkwhoT
CjeGIsDxfOI7yriCUxZ65zHnhdlPRJP9FSF+5qknRthgxP4LCidEcdMidPU5lLQa
ditQPl8iiuMq3gDr/GTkOQpiSThAP6GOqhdRVWz8wJgnxKibKMMNvV8mgz+kfMSW
N+N38Lj/njak7rIqkdrDilxrtpqFJq3kqOY97O0wVGdelpx8lT8Qu7NoOIsanDdh
IL1UO5pXgCX1QzS/M++hNnx6riRjIUood1cYyzyd8J/qOY9Sl9MT+9gOMcwfRevh
oaR18VD5uPrSxtYufrvO/tXFB90hucHfosEnDuKP3uB45tUhddgRsUi1iKIjr7MO
yEb1u6FLcbdCIbqD49rQ
=HfNb
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
