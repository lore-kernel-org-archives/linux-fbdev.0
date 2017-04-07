From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 07 Apr 2017 10:56:29 +0000
Subject: Re: [PATCH v4 03/14] pinctrl-ingenic: add a pinctrl driver for the Ingenic jz47xx SoCs
Message-Id: <20170407105629.n6a2cxt3pof66gu2@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170125185207.23902-2-paul@crapouillou.net>
 <20170402204244.14216-1-paul@crapouillou.net>
 <20170402204244.14216-4-paul@crapouillou.net>
 <CACRpkdbeudhXDE8KEgB_kZSAUUwS4Sd3=+GyR0YZ2-PQnEa9zw@mail.gmail.com>
In-Reply-To: <CACRpkdbeudhXDE8KEgB_kZSAUUwS4Sd3=+GyR0YZ2-PQnEa9zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Thierry Reding <thierry.reding@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Maarten ter Huurne <maarten@treewalker.org>, Lars-Peter Clausen <lars@metafoo.de>, Paul Burton <paul.burton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux MIPS <linux-mips@linux-mips.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, 07 Apr 2017, Linus Walleij wrote:

> On Sun, Apr 2, 2017 at 10:42 PM, Paul Cercueil <paul@crapouillou.net> wro=
te:
>=20
> > This driver handles pin configuration and pin muxing for the
> > JZ4740 and JZ4780 SoCs from Ingenic.
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> (...)
> > +       select MFD_CORE
> (...)
> > +#include <linux/mfd/core.h>
>=20
> That's unorthodox. Still quite pretty!
> I would nee Lee Jones to say something about this, as it is
> essentially hijacking MFD into the pinctrl subsystem.
>=20
> > +static struct mfd_cell ingenic_pinctrl_mfd_cells[] =3D {
> > +       {
> > +               .id =3D 0,
> > +               .name =3D "GPIOA",
> > +               .of_compatible =3D "ingenic,gpio-bank-a",
> > +       },
> > +       {
> > +               .id =3D 1,
> > +               .name =3D "GPIOB",
> > +               .of_compatible =3D "ingenic,gpio-bank-b",
> > +       },
> > +       {
> > +               .id =3D 2,
> > +               .name =3D "GPIOC",
> > +               .of_compatible =3D "ingenic,gpio-bank-c",
> > +       },
> > +       {
> > +               .id =3D 3,
> > +               .name =3D "GPIOD",
> > +               .of_compatible =3D "ingenic,gpio-bank-d",
> > +       },
> > +       {
> > +               .id =3D 4,
> > +               .name =3D "GPIOE",
> > +               .of_compatible =3D "ingenic,gpio-bank-e",
> > +       },
> > +       {
> > +               .id =3D 5,
> > +               .name =3D "GPIOF",
> > +               .of_compatible =3D "ingenic,gpio-bank-f",
> > +       },
> > +};
> (...)
> > +       err =3D devm_mfd_add_devices(dev, 0, ingenic_pinctrl_mfd_cells,
> > +                       ARRAY_SIZE(ingenic_pinctrl_mfd_cells), NULL, 0,=
 NULL);
> > +       if (err) {
> > +               dev_err(dev, "Failed to add MFD devices\n");
> > +               return err;
> > +       }
>=20
> I guess the alternative would be to reimplement the MFD structure.
>=20
> Did you check the approach to use "simple-mfd" and just let the subnodes
> spawn as devices that way? I guess you did and this adds something
> necessary.

I'd like to hear what the OP has to say about why this is necessary.
However, as a first glimpse, I'm dead against exporting MFD
functionality to outside of the subsystem.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
