From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Feb 2016 10:47:04 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <56D02D28.9080109@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3VhLwuJptRENgWd9QQ3xd8SuQ9A24i4MQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
 <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
In-Reply-To: <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--3VhLwuJptRENgWd9QQ3xd8SuQ9A24i4MQ
Content-Type: multipart/mixed; boundary="Ai5rwpjqHvpssBuIHBnmeOmdCu3CQ6KRB"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Joachim Eastwood <manabian@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh@kernel.org>,
 Russell King <linux@arm.linux.org.uk>
Message-ID: <56D02D28.9080109@ti.com>
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
 <56CF2FB1.106@ti.com>
 <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>
In-Reply-To: <CACRpkdYowXJinONTd2qREfCtEDCon+HSQtdd6t1QQA91f6PJdw@mail.gmail.com>

--Ai5rwpjqHvpssBuIHBnmeOmdCu3CQ6KRB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/02/16 21:30, Linus Walleij wrote:
> On Thu, Feb 25, 2016 at 5:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> On 25/02/16 16:04, Linus Walleij wrote:
>=20
>>> *All* the others
>>> will be very happy with *ONE* display defined as panel in the
>>> device tree, and off they go. Usually VGA. And that will look
>>
>> You keep mentioning VGA. So is there are VGA output? Or do you just me=
an
>> MIPI DPI panels, which happen to take the same video timings as VGA?
>=20
> Russell beat me to it, yes there is an external VGA encoder.
> It needs some bits set up through the "misc registers" system
> controller as indicated. From the CLCD hardware point of view
> it's no different than any other panel. So the DTS fragment looks
> like so:
>=20
>                         panel {
>                                 compatible =3D "panel-dpi";
>=20
>                                 port {
>                                         clcd_panel: endpoint {
>                                                 remote-endpoint =3D <&c=
lcd_pads>;
>                                         };
>                                 };
>=20
>                                 /* Standard 640x480 VGA timings */
>                                 panel-timing {
>                                         clock-frequency =3D <25175000>;=

>                                         hactive =3D <640>;
>                                         hback-porch =3D <48>;
>                                         hfront-porch =3D <16>;
>                                         hsync-len =3D <96>;
>                                         vactive =3D <480>;
>                                         vback-porch =3D <33>;
>                                         vfront-porch =3D <10>;
>                                         vsync-len =3D <2>;
>                                 };
>                         };
>=20
>=20
> This is reported as the default display type if no LCD panel
> is connected.
>=20
> If a LCD panel is also connected, it take precedence.

Ok. Well... It's all wrong, but I don't know how much time we want to
spend on fixing that.

Although one thing to consider is that if there is ever going to be a
DRM driver for CLCD, it would be good to have the device tree parts
correctly representing the hardware, so that the DRM driver could be
implemented in a cleaner, more generic way.

 Tomi


--Ai5rwpjqHvpssBuIHBnmeOmdCu3CQ6KRB--

--3VhLwuJptRENgWd9QQ3xd8SuQ9A24i4MQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW0C0oAAoJEPo9qoy8lh71QJQP/A7E8z8pjiG6r2oQgJOx4cSI
HWqXvGI3c8OOQ/7dnS6ejXX5/RHuXLGDEPbuYppj5FE4cj/KwdyIUkUq83q+CNEF
pzltoZ5SJwaxCl1pSk09UgKz/jtFPhJT91mzZx+Qkkg28OrhzibTh4r5OHAIQ2qx
63g6lexdpxsK6Ba8llQHVX1DQLf34wlB1F9jMYPFvH7FU2/vzc5PBq3l018mN+gK
5sYPC+BazpZlPY4KAkgZZDI7UskcCf42FCudtnBLyPcnl2/VR3DtQRaRTJzekpoQ
YzWuAQoINvy9i53PnCCycTz/8RPmMvhSC+cpyTIwmImtXl+KNpoW1s0iAB+wXZLQ
viFySFBTBWsrs2jG/zsLcyUIATmSyDjNKWTcgrbMU44sEaqfbc7oOIsWmsO3z7uQ
GV06GSAxeDupxd/QF45YMkabV04TT3fydXcfeVuGyyEbIbi3r9G72ln7q+/Bznj6
R35vBwsJAzfEfLw/mm5LGdqw7PgI65lksZtscYSevpKJYgbIwzBX1Qu4+9ix6FPa
i0tipss0i1k998oCDrQQFz0a/h2Wo5V7g3r0PgJ3d+HnPJ325JTVaUWwqN/FvQND
OHf+tr9mLuFqAz5xFVsXjUzvLDl1mhXkpz6EBDPi0N1KUackCPB2+NM9FQ42/6Ku
GHXwmlGGqRCNTE+GOSi/
=Wn79
-----END PGP SIGNATURE-----

--3VhLwuJptRENgWd9QQ3xd8SuQ9A24i4MQ--
