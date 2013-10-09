From: Michal Simek <monstr@monstr.eu>
Date: Wed, 09 Oct 2013 11:18:50 +0000
Subject: Re: [PATCH v2 1/3] video: xilinxfb: Use standard variable name convention
Message-Id: <52553B9A.6090901@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="rHVM98jJUei5I1WoM7B7f6V9mWmbi38s1"
List-Id: <linux-fbdev.vger.kernel.org>
References: <631df9a44b366af4129d00f1d4e1d3baad7d4903.1381315928.git.michal.simek@xilinx.com> <20131009110651.GH4981@e106331-lin.cambridge.arm.com>
In-Reply-To: <20131009110651.GH4981-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rHVM98jJUei5I1WoM7B7f6V9mWmbi38s1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/09/2013 01:06 PM, Mark Rutland wrote:
> On Wed, Oct 09, 2013 at 11:52:12AM +0100, Michal Simek wrote:
>> s/op/pdev/ in xilinxfb_of_probe().
>> No functional chagnes.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>> Changes in v2: None
>>
>>  drivers/video/xilinxfb.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
>> index 0e1dd33..d12345f 100644
>> --- a/drivers/video/xilinxfb.c
>> +++ b/drivers/video/xilinxfb.c
>> @@ -411,7 +411,7 @@ static int xilinxfb_release(struct device *dev)
>>   * OF bus binding
>>   */
>>
>> -static int xilinxfb_of_probe(struct platform_device *op)
>> +static int xilinxfb_of_probe(struct platform_device *pdev)
>>  {
>>  	const u32 *prop;
>>  	u32 tft_access =3D 0;
>> @@ -425,7 +425,7 @@ static int xilinxfb_of_probe(struct platform_devic=
e *op)
>>  	/* Allocate the driver data region */
>>  	drvdata =3D kzalloc(sizeof(*drvdata), GFP_KERNEL);
>>  	if (!drvdata) {
>> -		dev_err(&op->dev, "Couldn't allocate device private record\n");
>> +		dev_err(&pdev->dev, "Couldn't allocate device private record\n");
>>  		return -ENOMEM;
>>  	}
>>
>> @@ -433,7 +433,7 @@ static int xilinxfb_of_probe(struct platform_devic=
e *op)
>>  	 * To check whether the core is connected directly to DCR or BUS
>>  	 * interface and initialize the tft_access accordingly.
>>  	 */
>> -	of_property_read_u32(op->dev.of_node, "xlnx,dcr-splb-slave-if",
>> +	of_property_read_u32(pdev->dev.of_node, "xlnx,dcr-splb-slave-if",
>>  			     &tft_access);
>>
>>  	/*
>> @@ -457,29 +457,29 @@ static int xilinxfb_of_probe(struct platform_dev=
ice *op)
>>  	}
>>  #endif
>>
>> -	prop =3D of_get_property(op->dev.of_node, "phys-size", &size);
>> +	prop =3D of_get_property(pdev->dev.of_node, "phys-size", &size);
>>  	if ((prop) && (size >=3D sizeof(u32)*2)) {
>>  		pdata.screen_width_mm =3D prop[0];
>>  		pdata.screen_height_mm =3D prop[1];
>>  	}
>=20
> While you're changing these lines, it would be nice to change this
> pattern (here and elsewhere) to use of_property_read_u32_array, so that=

> it's endian-safe and consistent with other devicetree parsing code:
>=20
>   of_property_read_u32_array(pdev->dev.of_node, "phys-size", prop, 2);
>=20
> It won't read the values if the property data's too short, so that
> should be consistent with the existing code.
>=20
> It would also make the diffstat negative :)

The intention of this patch is simple rename which is exactly how
patch should look like. It means one change per patch.

It means these changes you have describe should be in separate patch
and I definitely agree with them.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--rHVM98jJUei5I1WoM7B7f6V9mWmbi38s1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJVO5oACgkQykllyylKDCHAhACghAAMQdQ5kp067E6Cd0L4LdbI
PrgAnisV7CG7ukAzjIc5p/2dxbDG8hv6
=oZ5p
-----END PGP SIGNATURE-----

--rHVM98jJUei5I1WoM7B7f6V9mWmbi38s1--
