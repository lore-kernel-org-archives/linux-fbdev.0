From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 09 Mar 2015 09:40:40 +0000
Subject: Re: [PATCH v11 3/6] devicetree: Add new SKY81452 mfd binding
Message-Id: <20150309094040.GN3427@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425019346-4559-1-git-send-email-jack.yoo@skyworksinc.com>
 <1425019346-4559-4-git-send-email-jack.yoo@skyworksinc.com>
In-Reply-To: <1425019346-4559-4-git-send-email-jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: gyungoh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, trivial-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, florian.vaussard-p8DiymsW2f8@public.gmane.org, andrew-g2DYL2Zd6BY@public.gmane.org, antonynpavlov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hytszk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, jack.yoo-tjhQNA90jdKqndwCJWfcng@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org

Applied, thanks.

On Fri, 27 Feb 2015, gyungoh@gmail.com wrote:

> From: Gyungoh Yoo <jack.yoo@skyworksinc.com>
>=20
> Signed-off-by: Gyungoh Yoo <jack.yoo@skyworksinc.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changes v11:
> Renamed 'skyworks,en-channels' property to led-sources.
> Removed unused property 'skyworks,ovp-level'.
>=20
> Changes v10:
> Nothing
>=20
> Changes v9:
> Nothing
>=20
> Changes v8:
> Made up the example for backlight DT
>=20
> Changes v7:
> Nothing
>=20
> Changes v6:
> Nothing
>=20
> Changes v5:
> Changed DT for regulator : 'lout' node should be defined under 'regulator'
> Removed compatible string from sky81452-regulator driver
>=20
> Changes v4:
> Nothing
>=20
> Changes v3:
> Nothing
>=20
> Changes v2:
> Added reg attribute for I2C slave address
>=20
>  Documentation/devicetree/bindings/mfd/sky81452.txt | 35 ++++++++++++++++=
++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sky81452.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/sky81452.txt b/Documen=
tation/devicetree/bindings/mfd/sky81452.txt
> new file mode 100644
> index 0000000..3518179
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sky81452.txt
> @@ -0,0 +1,35 @@
> +SKY81452 bindings
> +
> +Required properties:
> +- compatible	: Must be "skyworks,sky81452"
> +- reg		: I2C slave address
> +
> +Required child nodes:
> +- backlight	: container node for backlight following the binding
> +		in video/backlight/sky81452-backlight.txt
> +- regulator	: container node for regulators following the binding
> +		in regulator/sky81452-regulator.txt
> +
> +Example:
> +
> +	sky81452@2c {
> +		compatible =3D "skyworks,sky81452";
> +		reg =3D <0x2c>;
> +
> +		backlight {
> +			compatible =3D "skyworks,sky81452-backlight";
> +			name =3D "pwm-backlight";
> +			led-sources =3D <0 1 2 3 6>;
> +			skyworks,ignore-pwm;
> +			skyworks,phase-shift;
> +			skyworks,current-limit =3D <2300>;
> +		};
> +
> +		regulator {
> +			lout {
> +				regulator-name =3D "sky81452-lout";
> +				regulator-min-microvolt =3D <4500000>;
> +				regulator-max-microvolt =3D <8000000>;
> +			};
> +		};
> +	};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
