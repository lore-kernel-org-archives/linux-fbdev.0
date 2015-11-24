From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 24 Nov 2015 16:15:48 +0000
Subject: Re: [PATCH] video: fbdev: fsl: fix kernel crash when diu_ops is not implemented
Message-Id: <56548D34.6010605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OITX0JREhAHMJHrt0km20dAvRKkGqHHO0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1448346450-47403-1-git-send-email-dongsheng.wang@freescale.com>
To: linux-fbdev@vger.kernel.org

--OITX0JREhAHMJHrt0km20dAvRKkGqHHO0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24/11/15 18:04, Timur Tabi wrote:
> On Tue, Nov 24, 2015 at 5:46 AM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
>> On 24/11/15 08:27, Dongsheng Wang wrote:
>>> @@ -1697,6 +1700,9 @@ static int fsl_diu_probe(struct platform_device=
 *pdev)
>>>       unsigned int i;
>>>       int ret;
>>>
>>> +     if (!diu_ops.set_pixel_clock)
>>> +             return -ENODEV;
>>> +
>>>       data =3D dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_=
data),
>>>                                  &dma_addr, GFP_DMA | __GFP_ZERO);
>>>       if (!data)
>>>
>>
>> Thanks, queued for 4.5.
>=20
> Could you please wait for me to review the patch first?  I am the
> maintainer for the driver, and I see a problem with it.

Sorry, I was too hasty (and tired). I thought I was looking at a patch
that's been on the list for a while, but apparently it was only posted
today...

Anyway, dropped this.

 Tomi


--OITX0JREhAHMJHrt0km20dAvRKkGqHHO0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWVI00AAoJEPo9qoy8lh715BgP/3wDiAhhH/HsNs1wu8l1CmUA
vzWj5R6dmo82PgJ3c6g+H5udovRYo5WsvEq+wYYyRULWl6WCmQueC1Qd0J4Kr5Se
sMjvFtgY8ULQ0PZrJb9mWfV8MYwdhAzMOIofFOIGXf+U40D15Ll95OyAUMLve30c
NLnaEg76dQ7JgtXCWrz5YqAJRGKVcOa5ZQ7/JmhOLj49ZVWa/97cuSFtZ6RJhD0c
40w5oRQBgdw4EoM5UrhC0ScJtM8L/2quhCfw6OIH7e977+4bgqaoEjz36XYyp6n3
7EwqkS1qKktYGk1u54hcs+Kzlv8olSNMNHjSuR5XG7/5+Zz+u9oBXCtQUWDMC5QZ
p6uU605zTj3N6EOGD0TmEiILeHXZh7xP/wuaNzY4eLdszFUpM/2WgI0uwC+DWZqn
dQ0/yCqKvc9YxRHvoDLKuTfFd1+N9Yhq0Pi/jD8ZMJik9ZnR/TWf1w7fBISXRbBA
RR58wGa2GsaV9o8Tx8ElvDYpR/kaWNKdG+1ZxFpwVJmSZ9bm9hUS91Oz+FLmt9sr
fnhpbeR0JZrOq7OYTBI/gYsaqj7QuooFmkJ8tZ5DIM4QBTZnn0/lXtSBcPj7odRj
0LYd2s8H8KvnirWfFIUSkF3v6lJPmNybxCD6ByMzWauuUrtelhsyhQa1ox5+9dQ0
3irFF6Bw0fp3FIPabtz/
=5SJu
-----END PGP SIGNATURE-----

--OITX0JREhAHMJHrt0km20dAvRKkGqHHO0--
