From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 08 Sep 2016 10:00:31 +0000
Subject: Re: [PATCH 5/6] ARM: dts: Add NextThing GR8 dtsi
Message-Id: <20160908100031.GO8913@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Thv7PGoFpDPJ7Oar"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160831081817.5191-6-maxime.ripard@free-electrons.com>
 <20160907175148.c3fioqbr2k2pdqri@x1-6-00-0f-9f-c6-3e-90.cpe.webspeed.dk>
In-Reply-To: <20160907175148.c3fioqbr2k2pdqri@x1-6-00-0f-9f-c6-3e-90.cpe.webspeed.dk>
To: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk>, Rob Herring <robh+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Daniel Vetter <daniel.vetter@intel.com>, Alexander Kaplan <alex@nextthing.co>, Mylene Josserand <mylene.josserand@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


--Thv7PGoFpDPJ7Oar
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2016 at 07:51:48PM +0200, Rask Ingemann Lambertsen wrote:
> On Wed, Aug 31, 2016 at 4:18 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > From: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>
> >
> > The GR8 is an SoC made by Nextthing loosely based on the sun5i family.
> >
> > Since it's not clear yet what we can factor out and merge with the A10s=
 and
> > A13 support, let's keep it out of the sun5i.dtsi include tree. We will
> > figure out what can be shared when things settle down.
> >
> > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/gr8.dtsi | 1080 ++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 1080 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/gr8.dtsi
> >
> > diff --git a/arch/arm/boot/dts/gr8.dtsi b/arch/arm/boot/dts/gr8.dtsi
> > new file mode 100644
> > index 000000000000..d21cfa3f3c14
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/gr8.dtsi
>=20
> In the node names, you sometimes use underscores and sometimes use hyphen=
s.
> Here are the ones I spotted:
>=20
> > +               osc3M: osc3M_clk {
> > +               pll3x2: pll3x2_clk {
> > +               pll7x2: pll7x2_clk {
> > +       display-engine {
> > +               sram-controller@01c00000 {
> > +                               otg_sram: sram-section@0000 {
> > +               dma: dma-controller@01c02000 {
> > +               tve0: tv-encoder@01c0a000 {
> > +               tcon0: lcd-controller@01c0c000 {
> > +               intc: interrupt-controller@01c20400 {
> > +                       lcd_rgb666_pins: lcd_rgb666@0 {
> > +                       nand_pins_a: nand_base0@0 {
> > +                       nand_cs0_pins_a: nand_cs@0 {
> > +                       nand_rb0_pins_a: nand_rb@0 {
> > +                       uart1_cts_rts_pins_a: uart1-cts-rts@0 {
> > +               fe0: display-frontend@01e00000 {
> > +               be0: display-backend@01e60000 {
>=20
> Underscores should not be used in node names. [1][2] Since you're adding a
> new file here, please use hyphens instead.

I wonder what the rationale behind this is. The ePAPR clearly
documents the underscore as being a valid character for the node
names.

I'll change the few inconsistencies though.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--Thv7PGoFpDPJ7Oar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJX0Ta/AAoJEBx+YmzsjxAg5/AP92m+TID+ce5Vm0+2MO0hKOVY
DWbn6GvhTKpV8L0udss7/SdkDBwZluCe5oIqPc7oeqGM0y0w8/UcHpYrXcMdCidv
9chZltqnf0f9zR6yvk0dxJf3pK+R6daE+a8h14WBiUdhs/J29HewtlvHLrbR9Ga6
TlplTD5vymxIcHN1nOR8Z9XXeKUWIxzmDIoZQ6//3gsw92wRS5TQAoeuH3IfnG/j
vbQD3AIp4oNo65FyrSIss3f3CZlmu2rT5BjZWjal71Qzqdp+DNsCFq3+Lz2CV+tj
4x96H81so2d1VQoe0phZzYCFqFzWMZrTTgBsiexQsTcI7cHodemt6o5+oaFLky5j
nBKr8pzmmpMm0/YJtnX7HJD4+8v2fjRicGZp9TZU2akjLrwJqpv1KWDNhl4tW2SB
wrKo6vOxqZk0KBB3a9C/kaAw6+NtaYUBHisrNNwiDM8OeA0Ly7NEzeoOzUqYL8RO
PR6+qyodPowCwAWxqM82114uN28wR9/ATqipn1zIENt7on06zwnlI+KZ02/1y3sl
zFIixvEftjvIWRiTf+a+UYTA7SxJxL+aVBr+ILmezzJZCNcX5WTXy1tZl0TcskHU
TKsPlUKNtUcEwKVj6A1DGUJg0geXHHJpgo+851dd/Z2zHRViq9LXq5+FgBh+Rt9s
2V1VR6Gnx6W0ZCkDWH8=
=q49B
-----END PGP SIGNATURE-----

--Thv7PGoFpDPJ7Oar--
