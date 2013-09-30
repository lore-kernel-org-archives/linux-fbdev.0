From: Michal Simek <monstr@monstr.eu>
Date: Mon, 30 Sep 2013 12:05:53 +0000
Subject: Re: [PATCH 3/3] video: xilinxfb: Simplify error path
Message-Id: <52496921.9080603@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XxTxE7pCmwCwPpgW6iWNRQCcICRVfmPX6"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7016a90750626ba866dddc6f85cfdd71943f6891.1378965270.git.michal.simek@xilinx.com> <940bbdfc5c67282ab461b9c82b55f18fc34c959d.1378965270.git.michal.simek@xilinx.com> <5236D4BD.9050707@ti.com> <5236DE60.3020901@monstr.eu> <5236DEBF.7070003@ti.com>
In-Reply-To: <5236DEBF.7070003@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XxTxE7pCmwCwPpgW6iWNRQCcICRVfmPX6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

On 09/16/2013 12:34 PM, Tomi Valkeinen wrote:
> On 16/09/13 13:33, Michal Simek wrote:
>> On 09/16/2013 11:51 AM, Tomi Valkeinen wrote:
>>> On 12/09/13 08:54, Michal Simek wrote:
>>>
>>>> @@ -394,16 +382,12 @@ static int xilinxfb_release(struct device *dev=
)
>>>>  	/* Turn off the display */
>>>>  	xilinx_fb_out32(drvdata, REG_CTRL, 0);
>>>>
>>>> -	/* Release the resources, as allocated based on interface */
>>>> -	if (drvdata->flags & BUS_ACCESS_FLAG)
>>>> -		devm_iounmap(dev, drvdata->regs);
>>>>  #ifdef CONFIG_PPC_DCR
>>>> -	else
>>>> +	/* Release the resources, as allocated based on interface */
>>>> +	if (!(drvdata->flags & BUS_ACCESS_FLAG))
>>>>  		dcr_unmap(drvdata->dcr_host, drvdata->dcr_len);
>>>>  #endif
>>>
>>> I might be mistaken, and it's not strictly part of this series, but
>>> shouldn't dcr_unmap be called somewhere else also, if the probe fails=
?
>>
>> yes. It should.
>=20
> Do you want me to apply these patches as they are, or do you want to
> improve the series to include the dcr_unmap fix?

Sorry I have missed this email.

Yes please apply it as is. I don't have ppc hw here to be able to test th=
is
change.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--XxTxE7pCmwCwPpgW6iWNRQCcICRVfmPX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJJaSEACgkQykllyylKDCEN+wCdFEszRR6BNuuj/lCSEbXXQcTS
ngsAniagc4MhUrKjlQ4Ef7VbfX0srq6H
=J8Xy
-----END PGP SIGNATURE-----

--XxTxE7pCmwCwPpgW6iWNRQCcICRVfmPX6--
