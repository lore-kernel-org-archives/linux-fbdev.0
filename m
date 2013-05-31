From: Michal Simek <monstr@monstr.eu>
Date: Fri, 31 May 2013 13:37:53 +0000
Subject: Re: [PATCH v3 7/8] video: xilinxfb: Fix sparse warnings
Message-Id: <51A8A7B1.3040709@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2USEAKSMNLQVTICJSCVEQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <ea3d6fcbb9f7a00a9cdbd3d0a7a4d3401265ebf0.1370004925.git.michal.simek@xilinx.com> <51A8A4ED.6070104@tabi.org>
In-Reply-To: <51A8A4ED.6070104@tabi.org>
To: Timur Tabi <timur@tabi.org>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2USEAKSMNLQVTICJSCVEQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/31/2013 03:26 PM, Timur Tabi wrote:
> On 05/31/2013 07:55 AM, Michal Simek wrote:
>=20
>> diff --git a/drivers/video/xilinxfb.c b/drivers/video/xilinxfb.c
>> index f3d4a69..e27a4f6 100644
>> --- a/drivers/video/xilinxfb.c
>> +++ b/drivers/video/xilinxfb.c
>> @@ -131,7 +131,7 @@ struct xilinxfb_drvdata {
>>  	dcr_host_t      dcr_host;
>>  	unsigned int    dcr_len;
>>  #endif
>> -	void		*fb_virt;	/* virt. address of the frame buffer */
>> +	void __iomem	*fb_virt;	/* virt. address of the frame buffer */
>>  	dma_addr_t	fb_phys;	/* phys. address of the frame buffer */
>>  	int		fb_alloced;	/* Flag, was the fb memory alloced? */
>>
>> @@ -273,8 +273,10 @@ static int xilinxfb_assign(struct platform_device=
 *pdev,
>>  		drvdata->fb_virt =3D ioremap(pdata->fb_phys, fbsize);
>>  	} else {
>>  		drvdata->fb_alloced =3D 1;
>> -		drvdata->fb_virt =3D dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
>> -					&drvdata->fb_phys, GFP_KERNEL);
>> +		drvdata->fb_virt =3D (__force void __iomem *)
>> +				   dma_alloc_coherent(dev, PAGE_ALIGN(fbsize),
>> +						      &drvdata->fb_phys,
>> +						      GFP_KERNEL);
>=20
> I think this is wrong.  At least, it would be on PowerPC.
> dma_alloc_coherent() allocates regular RAM, not I/O memory.  So it
> should not be __iomem.

The same is for Microblaze. Driver shares fb_virt for IO memory
and for allocated memory. The purpose of this driver wasn't
to change the driver logic just resolved sparse warnings.
The other way is also wrong.
I have compiled this driver with ppc toolchain and it should
remove sparse warnings for PPC.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



------enig2USEAKSMNLQVTICJSCVEQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGop7EACgkQykllyylKDCHvrACfel0FR3AcgZnTGNRlQqMHMON3
do8An2E5o4HjtAIpd8bgBK723De0/Bp6
=SByF
-----END PGP SIGNATURE-----

------enig2USEAKSMNLQVTICJSCVEQ--
