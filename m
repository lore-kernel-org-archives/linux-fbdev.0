From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 29 Nov 2012 08:42:18 +0000
Subject: Re: [PATCH] video: da8xx-fb: clk_get on connection id fck
Message-Id: <50B71FEA.1070503@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig0A1AA4ECCFD9C00AF2536F0E"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353415261-30080-1-git-send-email-prakash.pm@ti.com>
 <50AB7F7E.1070400@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3E9FB8D9@DBDE01.ent.ti.com>
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3E9FB8D9@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org

--------------enig0A1AA4ECCFD9C00AF2536F0E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-11-23 06:33, Manjunathappa, Prakash wrote:
> Hi Tomi,
>=20
> On Tue, Nov 20, 2012 at 18:32:54, Nori, Sekhar wrote:
>> On 11/20/2012 6:11 PM, Manjunathappa wrote:
>>> do clk_get on connection id "fck" to support OMAP based
>>> platforms having multiple clocks for module. Without this
>>> driver change clk_get fails on am335x.
>>>
>>> This patch is based on the discussion in community
>>> http://marc.info/?l=3Dlinux-kernel&m=3D135166018907827&w=3D2
>>>
>>> Signed-off-by: Manjunathappa <prakash.pm@ti.com>
>>> Cc: Vaibhav Hiremath <hvaibhav@ti.com>
>>
>> For the mach-davinci changes:
>>
>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>>
>> Florian,
>>
>> I assume you will want to take this through your tree?
>>
>=20
> Could you please pull in this?

Merged this and the "da8xx-fb: LCDC driver cleanup" to:

git://gitorious.org/linux-omap-dss2/linux.git for-next

 Tomi



--------------enig0A1AA4ECCFD9C00AF2536F0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQtx/qAAoJEPo9qoy8lh71vnoP/1iO2TY8S+/ERARVD5q+crq/
Cxzp5FWZ2UCrKxPkBDQ+v/Oy4B7Cf1mS4NiYCShmKTx/CxtSTaECGMuYDdh87snz
UT65R6qmN2pwhXRCrwZIunxoEjA6FRfFMaC5YpdYQ5Zti1XAaxsb5N3ddwibe0Ak
nbiCMj9hyQORlcVEdkpEvVksXrqJW2CwiZ4Bl9mvpCAWVvKmVEflhmS5K4q5EVca
n+lDjToygDYADBZGPWjQ52p6+Sw1ZlgAbFhrz3MAn2ovu11uf7ZG7+jvj9E7cmdP
Dw186KFBducjnWPusMwvbMV5IsFryIF0mBtSeMb8K4pdCD61aErqBK6bMJNyW/46
YGgnB04il1KE0LGO25rBNJfXpOQdGI8Ng9TJMmAnB5w+00hKLR25oLP+znUljLJ0
VQ1OsgzB3kVAoxYRfZIjilgWfkXgiaOHs0205t/zkfxM3sntVzHAHcaBztSo4NmS
voflfZR4EVeuHo5T1M3mLbt04UhA+b6l1p4D7KmCMWk4Gx1JRQ+yYLdkys/nyaaa
1aTBR3WtLWz+6zXlJTO944DaMxdOVxaEVJ41Ql3IxwRLJlD+nEeS9ParyHJUA1VQ
JXzzLYdohkTAWV5ceBpHvtYQ0rJ08kYQDe2huMyDZg/8ucvgPWYVYGVAUZ8SQ291
NsCje3LwP4d8Tm5ildA2
=0lDL
-----END PGP SIGNATURE-----

--------------enig0A1AA4ECCFD9C00AF2536F0E--
