From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 14 Mar 2017 10:05:47 +0000
Subject: Re: [PATCH v6 2/2] backlight arcxcnn devicetree bindings for ArcticSand
Message-Id: <20170314100547.zqj5vkbk2dyqlcld@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1488306035-16461-1-git-send-email-olimpiu@arcticsand.com>
 <73fb917e-d71c-b094-7d33-8ccddd0ea1cf@linaro.org>
In-Reply-To: <73fb917e-d71c-b094-7d33-8ccddd0ea1cf-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Daniel Thompson <daniel.thompson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Olimpiu Dejeu <olimpiu-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bdodge-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, medasaro-eV7fy4qpoLhpLGFMi4vTTA@public.gmane.org

On Fri, 10 Mar 2017, Daniel Thompson wrote:

> On 28/02/17 19:20, Olimpiu Dejeu wrote:
> > backlight: Add devicetree bindings for the Arctic Sand backlight driver
> > This patch provides devicetree bindings for the Arctic Sand
> >     driver submitted in the previous patch
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Olimpiu Dejeu <olimpiu@arcticsand.com>
>=20
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
>=20
> But...
>=20
> This binding documentation patch should precede the code in the patch ser=
ies
> (amoung other things this avoids transient checkpatch errors).

Right.  Also, when you send patch-sets, please sent them 'threaded'.

Please resubmit with Daniel's Ack.

> > ---
> > v5 =3D> v6:
> > - Version updated to match other patch in set. No other changes.
> > v4 =3D> v5:
> > - Added spaces for increased readability per Lee Jones
> > v3 =3D> v4:
> > - Added spaces for increased readability per Lee Jones
> > v2 =3D> v3:
> > - Version updated to match other patch in set. No other changes.
> > v1 =3D> v2:
> > - Version updated to match other patch in set. No other changes.
> >=20
> >  .../bindings/leds/backlight/arcxcnn_bl.txt         | 33 ++++++++++++++=
++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/ar=
cxcnn_bl.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/arcxcnn_b=
l.txt b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> > new file mode 100644
> > index 0000000..ecb7731
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/arcxcnn_bl.txt
> > @@ -0,0 +1,33 @@
> > +Binding for ArcticSand arc2c0608 LED driver
> > +
> > +Required properties:
> > +- compatible:		should be "arc,arc2c0608"
> > +- reg:			slave address
> > +
> > +Optional properties:
> > +- default-brightness:	brightness value on boot, value from: 0-4095
> > +- label:		The name of the backlight device
> > +			See Documentation/devicetree/bindings/leds/common.txt
> > +- led-sources:		List of enabled channels from 0 to 5.
> > +			See Documentation/devicetree/bindings/leds/common.txt
> > +
> > +- arc,led-config-0:	setting for register ILED_CONFIG_0
> > +- arc,led-config-1:	setting for register ILED_CONFIG_1
> > +- arc,dim-freq:		PWM mode frequence setting (bits [3:0] used)
> > +- arc,comp-config:	setting for register CONFIG_COMP
> > +- arc,filter-config:	setting for register FILTER_CONFIG
> > +- arc,trim-config:	setting for register IMAXTUNE
> > +
> > +Note: Optional properties not specified will default to values in IC E=
PROM
> > +
> > +Example:
> > +
> > +arc2c0608@30 {
> > +	compatible =3D "arc,arc2c0608";
> > +	reg =3D <0x30>;
> > +	default-brightness =3D <500>;
> > +	label =3D "lcd-backlight";
> > +	linux,default-trigger =3D "backlight";
> > +	led-sources =3D <0 1 2 5>;
> > +};
> > +
> >=20
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
