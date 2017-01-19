From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 19 Jan 2017 15:08:27 +0000
Subject: Re: [PATCH v2 4/5] fbdev/ssd1307fb: add support to enable VBAT
Message-Id: <c0372d48-b538-64ce-f187-0502a9a4a00e@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T9IJq4abRnjGMjb3b3HrXaIoUQ6xFiapH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484303628.git.jsarha@ti.com>
 <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha@ti.com>
 <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop>
 <754f3644-a157-bb90-1494-aba4fc1264f8@ti.com>
 <CAL_JsqLjTa2SWP_cNU9AV4tRZLDcjJsUV7pUvy=4UhQix7ZjQQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLjTa2SWP_cNU9AV4tRZLDcjJsUV7pUvy=4UhQix7ZjQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

--T9IJq4abRnjGMjb3b3HrXaIoUQ6xFiapH
Content-Type: multipart/mixed; boundary="empFKEKU7rT8g3iVWOQK2EbjOP3F9PMFn";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Rob Herring <robh@kernel.org>
Cc: Jyri Sarha <jsarha@ti.com>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Benoit Cousson <bcousson@baylibre.com>
Message-ID: <c0372d48-b538-64ce-f187-0502a9a4a00e@ti.com>
Subject: Re: [PATCH v2 4/5] fbdev/ssd1307fb: add support to enable VBAT
References: <cover.1484303628.git.jsarha@ti.com>
 <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha@ti.com>
 <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop>
 <754f3644-a157-bb90-1494-aba4fc1264f8@ti.com>
 <CAL_JsqLjTa2SWP_cNU9AV4tRZLDcjJsUV7pUvy=4UhQix7ZjQQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLjTa2SWP_cNU9AV4tRZLDcjJsUV7pUvy=4UhQix7ZjQQ@mail.gmail.com>

--empFKEKU7rT8g3iVWOQK2EbjOP3F9PMFn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/01/17 17:03, Rob Herring wrote:

>>> According to the datasheet, SSD1307 has 2 supplies: Vdd and Vcc
>>>
>>> I don't see any mention of a charge pump, so that must be an external=

>>> component.
>>
>> VBAT is for SSD1306. Perhaps the DT doc should mention it.
>=20
> Datasheet says VBAT is reserved, connect to Vdd. I would just describe
> Vdd and Vcc in that case.

I'm no HW guy, but as far as I understand, you can wire it up two ways.
One has VBAT connected to VDD. The other one has VBAT connected to
external supply. See "Figure 1 : Application Example of SSD1306Z with
charge bump".

 Tomi


--empFKEKU7rT8g3iVWOQK2EbjOP3F9PMFn--

--T9IJq4abRnjGMjb3b3HrXaIoUQ6xFiapH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYgNZrAAoJEPo9qoy8lh71oqIP/2n12MJoZ7Q66EiK4FHpYAQU
OWs8GH09IqCklw6LoCp1e2GJGr7rGTIwSzJ+771VOlnXPZiGsVAKhoSzrXnFXJLW
XArFG5qz4RiUVVcW24D8t7qByH7hrJHfbUubQbGRcCKpaq78Er7q9+4Q9DRIOvCB
9YjZJJfiKCFscf47kXkrosjtAnRJzPgO1AKXjphr5Xg2lZ/CmaDgb1zdBDPD6Aq5
8eB6+YXbg3F+4WWJi3Wwyf6UjlOi8y6wzns+327fbbPBaJHYQmqxONgSCV7df1PL
Ezqf2NqL39HUhM2nZFhdLJQu2Co4ZGSQd/fFVUGGE0tlGPfw0hG+TYZbnKbB3S8R
5/5r/lfEeS9NoehtEYgLvyUrIP8Ov7ucotpTbZmIN5Cc1OJWXD3bJpFBAHAxYd9R
4eD61X2i5wgiTJ+QFh69xqyVqQ+KZNVjIhGUa9QP7LQ1fyHtn8vy9In3lKCWxWBk
U6fqgtK2dEF3LKGJmUuGTg99aFd0PmIcjWcUCWpeTkbHD0/RgNsHD+W1n5spvXw5
GpCbojcQiM2A2XvGva6f1aY+/EFu3OPrSeHNWyxzsOR/TOAyXwRVG6zLAJ4uzNlk
CN+aYATwOyuIyhCSQwrNC/5v+H8gzrihHFCkbKz4woN3bDu27K8+CsZJWhaW1JLS
0WFVIG+65bcpxEPTjZ0+
=5Ef5
-----END PGP SIGNATURE-----

--T9IJq4abRnjGMjb3b3HrXaIoUQ6xFiapH--
