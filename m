From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 19 Jan 2017 13:15:12 +0000
Subject: Re: [PATCH v2 4/5] fbdev/ssd1307fb: add support to enable VBAT
Message-Id: <754f3644-a157-bb90-1494-aba4fc1264f8@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Ure9sRBtNQVVGCULQ4quSEnFL86vckWnm"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484303628.git.jsarha@ti.com>
 <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha@ti.com>
 <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop>
In-Reply-To: <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop>
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org

--Ure9sRBtNQVVGCULQ4quSEnFL86vckWnm
Content-Type: multipart/mixed; boundary="Sjog6FrwHbP5vDGJmaPtmRkRD7K494JsV";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Rob Herring <robh@kernel.org>, Jyri Sarha <jsarha@ti.com>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 b.zolnierkie@samsung.com, maxime.ripard@free-electrons.com,
 bcousson@baylibre.com
Message-ID: <754f3644-a157-bb90-1494-aba4fc1264f8@ti.com>
Subject: Re: [PATCH v2 4/5] fbdev/ssd1307fb: add support to enable VBAT
References: <cover.1484303628.git.jsarha@ti.com>
 <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha@ti.com>
 <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop>
In-Reply-To: <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop>

--Sjog6FrwHbP5vDGJmaPtmRkRD7K494JsV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/01/17 00:33, Rob Herring wrote:
> On Fri, Jan 13, 2017 at 12:35:48PM +0200, Jyri Sarha wrote:
>> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>
>> SSD1306 needs VBAT when it is wired in charge pump configuration. This=

>> patch adds support to the driver to enable VBAT regulator at init time=
=2E
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Reviewed-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>  .../devicetree/bindings/display/ssd1307fb.txt        |  1 +
>>  drivers/video/fbdev/ssd1307fb.c                      | 20 +++++++++++=
++++++++-
>>  2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b=
/Documentation/devicetree/bindings/display/ssd1307fb.txt
>> index 6617df6..209d931 100644
>> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
>> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
>> @@ -16,6 +16,7 @@ Required properties:
>>  Optional properties:
>>    - reset-gpios: The GPIO used to reset the OLED display, if availabl=
e. See
>>                   Documentation/devicetree/bindings/gpio/gpio.txt for =
details.
>> +  - vbat-supply: The supply for VBAT
>=20
> According to the datasheet, SSD1307 has 2 supplies: Vdd and Vcc
>=20
> I don't see any mention of a charge pump, so that must be an external=20
> component.

VBAT is for SSD1306. Perhaps the DT doc should mention it.

 Tomi


--Sjog6FrwHbP5vDGJmaPtmRkRD7K494JsV--

--Ure9sRBtNQVVGCULQ4quSEnFL86vckWnm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYgLvgAAoJEPo9qoy8lh717r4P/Ra3s7JLrp+KgH8lBmcyuXNJ
8muDEaI8ltQ/f4+U7pc78voU4C+Xbh4eItgOO6t0vT5hMkbKuJeWogs305Tbc5Xn
MymvbtF4A3Bn24APABHJASJOSbKmAF/snfl3D+SAk1fbyQ49ZvMW+RJEDmFNbJyG
tV1m0XRwusn+KsidL3GAfLUBh3NaBUfE0wSkzizKTXekEKli5z9yft7rhltUUs2U
ii1LtXwerGCb5ZI2P6q3/n70Oaxqp00dm87qmubUJXuPLN0jdMOIjG06pjEHZEbD
HiDyOUYpijV5g6CTQOFVGq+y4z2cqfpFXz2v04d9JfB1vXLE3JI2N665X3DT5EWh
kKaN3h1LvJ6Jq/he1pobCV+qW7/1vWys4EIv0nw5sMN1AHSNrR2hZEVVmhm3mBs+
6lW7iQ8cXPtqO57lFDEdJce4MFrSqjOxa9bAUqXRp6+Qb2kGlgduRkLcGj+dyygP
Xcr0+h8BuRdEVR3ukRKr+vn/dAhRxRXcP6EY9vFkswEfn9eT0hxs6tBBugRqWgKQ
mDW5RZ101T055AodYL9vLQ0+yAu+LrFiuuc5Q0+oCgQ+Km00f1U4Tiswvvkv8N/m
ok6sb22lvn72CWd2d+DkZG95WxmzUGB0o9Ebknjdgp6LHp9guJuZI6Zll7t8rO4L
8BylSEM/YOXEuVHzQy3I
=Hrsc
-----END PGP SIGNATURE-----

--Ure9sRBtNQVVGCULQ4quSEnFL86vckWnm--
