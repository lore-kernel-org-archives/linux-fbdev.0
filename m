From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 29 Oct 2019 12:16:26 +0000
Subject: Re: [PATCH v4 1/2] dt-bindings: backlight: lm3630a: add enable_gpios
Message-Id: <20191029131626.2a18d27e@kemnade.info>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_/DGHuyPjjOiEtDx6AE.MMu8p"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190912213257.24147-1-andreas@kemnade.info>
        <20190912213257.24147-2-andreas@kemnade.info>
        <CAL_Jsq+zDYifFntHMqmqU4qmsj7_nafN+W7a0Vh+HdwGvVj5TA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+zDYifFntHMqmqU4qmsj7_nafN+W7a0Vh+HdwGvVj5TA@mail.gmail.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

--Sig_/DGHuyPjjOiEtDx6AE.MMu8p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 28 Oct 2019 18:25:56 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> On Thu, Sep 12, 2019 at 4:33 PM Andreas Kemnade <andreas@kemnade.info> wr=
ote:
> >
> > add enable-gpios to describe HWEN pin
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > Acked-by: Daniel Thompson <daniel.thompson@linaro.org> =20
>=20
> This breaking linux-next now...
>=20
oops, sorry.=20

> > ---
> > changes in v2: added example
> > changes in v3: added Acked-by
> > changes in v4: moved enable-gpios to the right position
> >   in the example
> >  .../bindings/leds/backlight/lm3630a-backlight.yaml           | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/lm3630a-b=
acklight.yaml b/Documentation/devicetree/bindings/leds/backlight/lm3630a-ba=
cklight.yaml
> > index dc129d9a329e..c8470628fe02 100644
> > --- a/Documentation/devicetree/bindings/leds/backlight/lm3630a-backligh=
t.yaml
> > +++ b/Documentation/devicetree/bindings/leds/backlight/lm3630a-backligh=
t.yaml
> > @@ -29,6 +29,10 @@ properties:
> >    '#size-cells':
> >      const: 0
> >
> > +  enable-gpios:
> > +    description: GPIO to use to enable/disable the backlight (HWEN pin=
).
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -96,6 +100,7 @@ examples:
> >          led-controller@38 {
> >                  compatible =3D "ti,lm3630a";
> >                  reg =3D <0x38>;
> > +                enable-gpios =3D <&gpio2 5 GPIO_ACTIVE_HIGH>; =20
>=20
> Error: Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight=
.example.dts:24.46-47
> syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [Documentation/devicetree/bindings/leds/backlight/lm3630a-ba=
cklight.example.dt.yaml]
> Error 1
> scripts/Makefile.lib:314: recipe for target
> 'Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.examp=
le.dt.yaml'
> failed
>=20
> You need the include for the define.

gpio/gpio.h is missing.
Yes, was not aware of that these things will be compiled and the automatic
check did not work on my system at all. So I decided not to fix that for ju=
st
this simple thing which was a not so good idea.
Will send a fixup.

Regards,
Andreas

--Sig_/DGHuyPjjOiEtDx6AE.MMu8p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl24LZoACgkQl4jFM1s/
ye/XiA/8DVVyxxx109wsfNmna3iGryDIzfVOZVxZKmh2SUGenfnGGggrA2vM9QJx
GRYg0Wi7kkXEW2EmYrgI0AddYBxTsuEI82ANE4BO6umA+1nCSedjttxZ2OptyZCH
sZqcV+nKvtROpTwSWOdG4cYH+3vpL7Is9meLNlyFbiDUjznJ67K0tgXuOCE6Iq69
xvw1xhnaomCXazrimAlht1JNDQc6Rgma7FT9AUSM9ngEW7tbfxSVhuYUCKaMlN17
M6DhV9PePIf1SZVelYIeOT8pkBHxpcb+Pza61FpQYrXF2iRwsmfMtzNx8LOiCobp
5qnkyz2YIRZ5CIz7gc5EkZim+pIPCAJekZz3HEWsS3ypkhw3pLabRBOekX2r57iO
NwqStsPFM71+xZnElqULvQ5o331G3aCbJEFkCsG9sZp98qNN0yI0UYABVl+MIeqT
euvtkNHzvntSBsqYUm7MjWW8uUiFxuS0eL+AIiXBOofvJ6nsvuQHyEDvHsMNec1R
dokvq/TxLbKe81rZY1OBGT/UGzMKKGuwkH0BetpuJ0eOYZJ+nHCXA20JWr5fCoPS
06G2W/MLRyTTuL7tGJ8Xa6RcKvj9pCxO+upE3eRGp02ZxyGefs68gHprOS8UiclL
TMCcxD8d3k9LmR2e089kZwoA+9JhgUK33pCZBQwVVIBGuSxl1nY=
=c3AX
-----END PGP SIGNATURE-----

--Sig_/DGHuyPjjOiEtDx6AE.MMu8p--
