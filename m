From: "Nilofer, Samreen" <samreen@ti.com>
Date: Fri, 22 Oct 2010 04:19:22 +0000
Subject: RE: [PATCH v2] OMAP: DSS2: Add NEC NL8048HL11-01B display panel
Message-Id: <FCCFB4CDC6E5564B9182F639FC356087034BBEC4B7@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1287663940-27327-1-git-send-email-samreen@ti.com>
 <AANLkTimfQ78Y+fGXCTxPaLHR7xbYonjB2iODH1cOd8Oo@mail.gmail.com>
In-Reply-To: <AANLkTimfQ78Y+fGXCTxPaLHR7xbYonjB2iODH1cOd8Oo@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, Roger Quadros <roger.quadros@nokia.com>, "Mittal, Mukund" <mmittal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Erik Gilling <konkers@android.com>, Rajkumar N <rajkumar.nagarajan@ti.com>, Subbu Venkatesh <subramani.venkatesh@windriver.com>

Grazvydas Ignotas wrote:
> On Thu, Oct 21, 2010 at 3:25 PM, Samreen <samreen@ti.com> wrote:
>> From: Erik Gilling <konkers@android.com>
>>=20
>> NEC WVGA LCD NL8048HL11-01B panel support has been added.
>> This panel is being used in zoom2/zoom3/3630 sdp boards.
>>=20
>=20
> <snip>
>=20
>> diff --git
> a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
>> b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
>> new file mode 100644
>> index 0000000..0327731
>> --- /dev/null
>> +++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
>=20
> <snip>
>=20
>> +static int spi_send(struct spi_device *spi, unsigned char reg_addr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned char reg_data)
>=20
> you could be more consistent and name it nec_8048_spi_send.
[Samreen]
     Will take care of this.
>=20
>> +{
>> + =A0 =A0 =A0 int ret =3D 0;
>> + =A0 =A0 =A0 unsigned int cmd =3D 0, data =3D 0;
>> +
>> + =A0 =A0 =A0 cmd =3D 0x0000 | reg_addr; /* register address write */
>> + =A0 =A0 =A0 data =3D 0x0100 | reg_data ; /* register data write */
>> + =A0 =A0 =A0 data =3D (cmd << 16) | data;
>> +
>> + =A0 =A0 =A0 ret =3D spi_write(spi, (unsigned char *)&data, 4); + =A0 =
=A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("error in spi_write %x\n", data); +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +
>=20
> one blank line is enough
[Samreen]
  Will fix this
>=20
>> +static int init_nec_8048_wvga_lcd(struct spi_device *spi) {
>> + =A0 =A0 =A0 /* Initialization Sequence */
>> + =A0 =A0 =A0 /* spi_send(spi, REG, VAL) */
>> + =A0 =A0 =A0 spi_send(spi, 3, 0x01);
>> + =A0 =A0 =A0 spi_send(spi, 0, 0x00);
>> + =A0 =A0 =A0 spi_send(spi, 1, 0x01); =A0 =A0/* R1 =3D 0x01 (normal), 0x=
03 +(reversed) */
>> + =A0 =A0 =A0 spi_send(spi, 4, 0x00);
>> + =A0 =A0 =A0 spi_send(spi, 5, 0x14);
>> + =A0 =A0 =A0 spi_send(spi, 6, 0x24);
>=20
> This code wastes quite a bit of space (at least 3 mov and one
> bl instruction for every such write on ARM), you could better do something
> like:=20
>=20
> static const struct {
>   u8 address;
>   u8 value;
> } nec_8048_init_seq[] =3D {
>   { 3, 0x01 },
>   { 0, 0x00 },
>   { 1, 0x01 },
>   ...
> };
[Samreen]
  Agree, I'll surely take this more optimized approach
>=20
> static int init_nec_8048_wvga_lcd(struct spi_device *spi) {   int i, ret;
>   for (i =3D 0; i < ARRAY_SIZE(nec_8048_init_seq); i++) {
>     ret =3D nec_8048_spi_send(spi,
> nec_8048_init_seq[i].address, nec_8048_init_seq[i].value);     if (ret < =
0)
>       break;
>   }
>   udelay(20);
>   nec_8048_spi_send(spi, 2, 0x00);
> }
>=20
>=20
>> +MODULE_DESCRIPTION("Nec Driver");
>=20
> could use more complete description here.
[Samreen]
  Sure..