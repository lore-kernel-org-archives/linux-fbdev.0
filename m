From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 15 Dec 2017 20:30:26 +0000
Subject: Re: [PATCH V1 1/4] qcom: spmi-wled: Add support for qcom wled driver
Message-Id: <20171215203026.GA19442@amd>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-2-git-send-email-kgunda@codeaurora.org>
In-Reply-To: <1510834717-21765-2-git-send-email-kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <jacek.anaszewski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-11-16 17:48:34, Kiran Gunda wrote:
> WLED driver provides the interface to the display driver to
> adjust the brightness of the display backlight.
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  .../bindings/leds/backlight/qcom-spmi-wled.txt     |  90 ++++
>  drivers/video/backlight/Kconfig                    |   9 +
>  drivers/video/backlight/Makefile                   |   1 +
>  drivers/video/backlight/qcom-spmi-wled.c           | 504 +++++++++++++++=
++++++
>  4 files changed, 604 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom=
-spmi-wled.txt
>  create mode 100644 drivers/video/backlight/qcom-spmi-wled.c
>=20
> diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-w=
led.txt b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.t=
xt
> new file mode 100644
> index 0000000..f1ea25b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
> @@ -0,0 +1,90 @@
> +Binding for Qualcomm WLED driver
> +
> +WLED (White Light Emitting Diode) driver is used for controlling display
> +backlight that is part of PMIC on Qualcomm Technologies reference platfo=
rms.
> +The PMIC is connected to the host processor via SPMI bus.
> +
> +- compatible
> +	Usage:      required
> +	Value type: <string>
> +	Definition: should be "qcom,pm8998-spmi-wled".
> +
> +- reg
> +	Usage:      required
> +	Value type: <prop-encoded-array>
> +	Definition:  Base address and size of the WLED modules.
> +
> +- reg-names
> +	Usage:      required
> +	Value type: <string>
> +	Definition:  Names associated with base addresses. should be
> +		     "qcom-wled-ctrl-base", "qcom-wled-sink-base".
> +
> +- label
> +	Usage:      required
> +	Value type: <string>
> +	Definition: The name of the backlight device.
> +
> +- default-brightness
> +	Usage:      optional
> +	Value type: <u32>
> +	Definition: brightness value on boot, value from: 0-4095
> +		    default: 2048
> +
> +- qcom,fs-current-limit

I'd add "-uA" suffix here.

> +	Usage:      optional
> +	Value type: <u32>
> +	Definition: per-string full scale current limit in uA. value from
> +		    0 to 30000 with 5000 uA resolution. default: 25000 uA
> +
> +- qcom,current-boost-limit

And -mA suffix here. Similar for other units.

Thanks,
								Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlo0MOIACgkQMOfwapXb+vJhwACfR1k70Lve5If7KoLwAZfAlQ2V
6z4AoI/uaT+pl3chUKAcZqRd9ytgPGt1
=wLJn
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
