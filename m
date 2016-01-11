From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 11 Jan 2016 11:51:42 +0000
Subject: Re: [PATCH] video: fbdev: pxafb: fix out of memory error path
Message-Id: <5693974E.2000604@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ibg1XeMJwXn4iGdQ6tPPU76K9o9UjROiv"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450527271-21841-1-git-send-email-robert.jarzmik@free.fr>
 <87io31dvsj.fsf@belgarion.home>
In-Reply-To: <87io31dvsj.fsf@belgarion.home>
To: Robert Jarzmik <robert.jarzmik@free.fr>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

--ibg1XeMJwXn4iGdQ6tPPU76K9o9UjROiv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/01/16 22:27, Robert Jarzmik wrote:
> Robert Jarzmik <robert.jarzmik@free.fr> writes:
>=20
>> As seen by Julia, the initial allocation memory is not checked anymore=

>> after commit "video: fbdev: pxafb: initial devicetree conversion".
>> Introduce back the removed test.
>>
>> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> ---
>>  drivers/video/fbdev/pxafb.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c=

>> index 8588dd683105..54666424a720 100644
>> --- a/drivers/video/fbdev/pxafb.c
>> +++ b/drivers/video/fbdev/pxafb.c
>> @@ -2252,6 +2252,8 @@ static int pxafb_probe(struct platform_device *d=
ev)
>>  	ret =3D -ENOMEM;
>>  	pdata =3D dev_get_platdata(&dev->dev);
>>  	inf =3D devm_kmalloc(&dev->dev, sizeof(*inf), GFP_KERNEL);
>> +	if (!inf)
>> +		goto failed;
>> =20
>>  	if (pdata) {
>>  		*inf =3D *pdata;
> Tomi, Jean-Christophe,
>=20
> Can you carry out this fix please ?

Thanks, queued for 4.5.

 Tomi


--ibg1XeMJwXn4iGdQ6tPPU76K9o9UjROiv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWk5dOAAoJEPo9qoy8lh71GDAP/RcL8uL0SwDHLakIalSfB5wP
oddT4b/KKK+EoVxl/bdrjCF0gBz+Nrsz4i6JRcjFWZUrpwhWeN7c1p1E5f/QkbV/
BVmnl59nlKyHcs0sovXdp40jRLjIaJwxClmqlCxcRh4J6wf4g0R6kcGAmmx5PBqo
6DTSy0O5VKTgFrSvmhtJhQHQxGN8jFDsIY8WFU2QBbV7ngfFUdW54peraOwFzzOY
flTRSG1hHZCFLEMnWL0o906mAGJKMBUqpyDY6SJ1POTVGIg4+hO3laW64w8uDGLY
7SgJYq2yGQyILYMX/aDyeX3OCRlCT8KHETar6ia1oOX70FoN0Rfz/dXMC54hGFsp
6wOUQOvoR7Vk0yxn1Z0EHEvgAMrRPsXjrnLXCAyqEvibVkm9fzAvU856mnBg/pab
SzRDstrd+0cZ+3ZIihUElJdTMYbWoNdb9w8chaUGVSSGG5ofeNSfbp4b3FqVyKqn
51e1iwskS4nBnkuQqGP7y7SSTskq4E3HVH3g1x8KbKTtHxkNyLP4r84OWEz8QyOR
gzz4AV1vrpMd1LSPeTDF7Ko5dCNWPzgq1589fVPoMQIYHPGtyRK3RJQhyhrww4yV
cwpBuLl/rCUxs/toYoIK/9TkYjJw7p6ISZ2G9QNf8Q++J4RC39EIGNTDE6OBUZcw
t1/fUpVjwddpk277PMBA
=cyJv
-----END PGP SIGNATURE-----

--ibg1XeMJwXn4iGdQ6tPPU76K9o9UjROiv--
