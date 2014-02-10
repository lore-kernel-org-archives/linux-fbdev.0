From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Feb 2014 12:21:29 +0000
Subject: Re: [PATCH] video: imxfb: Use regulator API with LCD class for powering
Message-Id: <52F8C449.2080502@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9l2p0o7VUsEvVLbiaM5tJLbTFQCHHtnJM"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
 <52F8C091.50704@ti.com> <1392034587.333931582@f419.i.mail.ru>
In-Reply-To: <1392034587.333931582@f419.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org

--9l2p0o7VUsEvVLbiaM5tJLbTFQCHHtnJM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/02/14 14:16, Alexander Shiyan wrote:
> =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA, 10 =
=D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2014, 14:05 +02:00 =D0=BE=D1=82=
 Tomi Valkeinen <tomi.valkeinen@ti.com>:
>> On 21/12/13 13:08, Alexander Shiyan wrote:
>>> This patch replaces custom lcd_power() callback with
>>> regulator API over LCD class.
>>>
>>> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
>>> ---
>>>  .../devicetree/bindings/video/fsl,imx-fb.txt       |  1 +
>>>  arch/arm/mach-imx/mach-mx27ads.c                   | 55 ++++++++++++=
+++--
>>>  drivers/video/imxfb.c                              | 71
>> +++++++++++++++++++---
>>>  include/linux/platform_data/video-imxfb.h          |  1 -
>>>  4 files changed, 114 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
>> b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
>>> index 46da08d..e6b1ee9 100644
>>> --- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
>>> +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
>>> @@ -15,6 +15,7 @@ Required nodes:
>>>  	- fsl,pcr: LCDC PCR value
>>> =20
>>>  Optional properties:
>>> +- lcd-supply: Regulator for LCD supply voltage.
>>>  - fsl,dmacr: DMA Control Register value. This is optional. By defaul=
t, the
>>>  	register is not modified as recommended by the datasheet.
>>>  - fsl,lscr1: LCDC Sharp Configuration Register value.
>>> diff --git a/arch/arm/mach-imx/mach-mx27ads.c
> ...
>>> +static void __init mx27ads_regulator_init(void)
>>> +{
>>> +	struct gpio_chip *vchip;
>>> +
>>> +	vchip =3D kzalloc(sizeof(*vchip), GFP_KERNEL);
>>> +	vchip->owner		=3D THIS_MODULE;
>>> +	vchip->label		=3D "LCD";
>>> +	vchip->base		=3D MX27ADS_LCD_GPIO;
>>> +	vchip->ngpio		=3D 1;
>>> +	vchip->direction_output	=3D vgpio_dir_out;
>>> +	vchip->set		=3D vgpio_set;
>>> +	gpiochip_add(vchip);
>>> +
>>> +	platform_device_register_data(&platform_bus, "reg-fixed-voltage",
>>> +				      PLATFORM_DEVID_AUTO,
>>> +				      &mx27ads_lcd_regulator_pdata,
>>> +				      sizeof(mx27ads_lcd_regulator_pdata));
>>> +}
>>> +
>>
>> Hmm, isn't all this something that should be in the board's .dts?
>=20
> There are no DT support for this board yet.

Oh, ok. You added 'lcd-supply' to devtree binding documentation, so I
presumed DT is being used.

The drivers/video side looks fine. I can either merge this via fbdev
tree if I get an ack from arch/arm/mach-imx/mach-mx27ads.c's maintainer,
or this can go via imx tree with my ack.

 Tomi



--9l2p0o7VUsEvVLbiaM5tJLbTFQCHHtnJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+MRJAAoJEPo9qoy8lh71URAQAKcECE/7gtLs0BTuXAVh/yAA
xOrz7ECR7TvxD2k/AdQLLry/PRYpdIpzULJVuFj5/BYFi51kZfMjGwruN9JOgJms
EOKA5zTDfKaftyhGmRCNgsm1FCZ2bMYTGsB464j4PGl0bmlm9uAjtw27EzSMYmgH
cw0Og2tYPzK0b88AGIUdr+VgqHQGdoIUZej42wh+PjoKUOF0GWP+jsvSd1BL/S6W
aMeqH+qUXLoHo1r36iP3smHzjhsBYEJMd3vALACV3ywbJg1wW9csz16i52NT3q0x
KB2VqG0Kddbuwf8xB04dOK8rqQhsEaOeyt2876P/mb6c5B9rZ3PvSCrWUQlWvD0a
j2pVR5wh7zINMfdO5uDgTT9Ofvdv5qWHR5kicHtnHsCCcnOa7GSIMJE1szt/AdCJ
NVJyCc3oN+tLcolumLubFB2iKBlLdx2UXNs1KHXbJnG9dibljLIRlJrsgvV5IJ6z
gElZZlhWYZ2x+jC1BzhwANLAFK2Ius1Y1oNcCPL5sCgGe9VZZHi0Ccmcf48vTbiu
OwwRipYKpl3u5tcuyKPcxBzP9E/fiA112uaeAqSZslRlsFq5b/oz9w/YoMryUglI
0nbynHgS4opRT98tJDxi0knzV5uPXs1lqLZaIkko3sLyzryRpjnXA9TOZH/P1o2G
rdK6d3oBtZ+all5Cfdjq
=vVTZ
-----END PGP SIGNATURE-----

--9l2p0o7VUsEvVLbiaM5tJLbTFQCHHtnJM--
