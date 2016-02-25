From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 25 Feb 2016 16:45:37 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56CF2FB1.106@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ovrXfS9h7F7fiKKpcS0eM3iV64QNUpPi7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
In-Reply-To: <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--ovrXfS9h7F7fiKKpcS0eM3iV64QNUpPi7
Content-Type: multipart/mixed; boundary="3nQNAV0fRGgfTbC7S8uQoXiB6J7j1451n"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Joachim Eastwood <manabian@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>
Message-ID: <56CF2FB1.106@ti.com>
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
In-Reply-To: <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>

--3nQNAV0fRGgfTbC7S8uQoXiB6J7j1451n
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 25/02/16 16:04, Linus Walleij wrote:
> On Tue, Feb 23, 2016 at 2:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>=20
>> Maybe Versatile is different. If CLCD is only used on that board, or a=

>> small family of boards, from one vendor, I guess it is maintainable to=

>> have board specific driver parts for CLCD. But if CLCD can be used by
>> many vendors in many different boards, I'd steer clear of board specif=
ic
>> driver code.
>=20
> OK I think at this point we would say that CLCD is a legacy driver.

Ok.

My biggest fear with this is the maintenance nightmare that comes if an
IP or panel is used in multiple SoCs and future designs. We have the
same display subsystem and panel drivers used from OMAP2 forward, and
it's been a constant struggle, so I've come to appreciate the effort to
split things up as much as possible, so that when the time comes when
the HW guys have decided to change a piece here or there, it's easier to
cope with.

Anyway, if it's likely that we're not seeing new CLCD boards, I think
it's fine if we don't go to any great lengths to clean things up there.
Let's just get it working.

> HOWEVER: the ARM Versatile is the *only* platform I have
> seen of these that have plug'n'play for the display.

Ok. And presumably no new boards will use that plug'n'play display, so
we can just consider it specific to versatile.

> *All* the others
> will be very happy with *ONE* display defined as panel in the
> device tree, and off they go. Usually VGA. And that will look

You keep mentioning VGA. So is there are VGA output? Or do you just mean
MIPI DPI panels, which happen to take the same video timings as VGA?

> I add support for doing this for the Integrator and RealView in
> the patch set, by grabbing a handle to the system controller
> where they have a few "misc registers". However if you look at
> it:
>=20
> static void integrator_clcd_enable(struct clcd_fb *fb)
> {
>         struct fb_var_screeninfo *var =3D &fb->fb.var;
>         u32 val;
>=20
>         dev_info(&fb->dev->dev, "enable Integrator CLCD connectors\n");=

>=20
>         val =3D INTEGRATOR_CLCD_LCD_STATIC1 | INTEGRATOR_CLCD_LCD_STATI=
C2 |
>                 INTEGRATOR_CLCD_LCD0_EN | INTEGRATOR_CLCD_LCD1_EN;
>         if (var->bits_per_pixel <=3D 8 ||
>             (var->bits_per_pixel =3D=3D 16 && var->green.length =3D=3D =
5))
>                 /* Pseudocolor, RGB555, BGR555 */
>                 val |=3D INTEGRATOR_CLCD_LCDMUX_VGA555;
>         else if (fb->fb.var.bits_per_pixel <=3D 16)
>                 /* truecolor RGB565 */
>                 val |=3D INTEGRATOR_CLCD_LCDMUX_VGA565;
>         else
>                 val =3D 0; /* no idea for this, don't trust the docs */=

>=20
>         regmap_update_bits(versatile_syscon_map,
>                            INTEGRATOR_HDR_CTRL_OFFSET,
>                            0,
>                            INTEGRATOR_CLCD_MASK);
> }
>=20
> This is stuff that is so closely tied in to the fbdev driver that even
> if it is SoC-specific (and reside in arch/arm/mach-integrator etc
> today) it would be hard to argument that it should not be part
> of the fbdev driver: what it does is connect the lines out of the
> CLCD block to the physical VGA encode chip in different ways
> depending on how the pixels were set up.

Hmm so is there an external VGA encoder on the board?

 Tomi


--3nQNAV0fRGgfTbC7S8uQoXiB6J7j1451n--

--ovrXfS9h7F7fiKKpcS0eM3iV64QNUpPi7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWzy+xAAoJEPo9qoy8lh71/LIQAIq8O8l9b3FNHTc7aVwGETAZ
ZWug3EcvbcufRuanTLJXrkTeC8oWV2OxrFni1EjOph4O/tlWLhbfntntka2KOKK0
5gU4cpLT4qPsV+VWdMdHUKHL+PxCc0l89Dy+NA8MebekYUL6cA5OKAUT18hk3xLK
eWRqFCqcRTe0Tju4McX8JOlW1gT+mUTKVDe+tzUB948/W3o/gxnV4b/3ftOWmlxf
EC6HvJ8MNF2TkxJBfbGVsvsZ4j+yICEmWAWFl/4yfCFd5kOvxswAgK7GCx8/AeeO
Ol6sC4XRqKoCM9UZ1QhQ1VPJVWbsanPMuw7YeDtK3MXecSjO/VEifcO8BM+ncFsP
9rr65WyeUeDBaY1+fPFaONXoCCIkYV3wBmfb6HI/W7KFz3qb12LuN9+lMRcEhKfe
z/tx+z5ZE3Pk1v/m/71qwsG0P2iNPUAncGensJJF9YmHY+TuDXOCCFC5lDh7Aa9L
TmOvzMd1NtckMaTOeVn/uhp7Er2DSiu0IWruGsZmWAS0MBYTO/YL2j5J4sQha67a
bXpJVDCMXbsBvu1BYI+dmxsmj3iZ3mbah4ULuF/rkyazfSIMhQ3Qw7kyBrm6vKFj
JRwXcdZYHSG1OEu6QaEr6CrCE/hwTEu4ENVJJi33KreyXka6Ww1u6h/30e65D30N
vPSVFwlReEBc/QOpzJHK
=4Jdo
-----END PGP SIGNATURE-----

--ovrXfS9h7F7fiKKpcS0eM3iV64QNUpPi7--
