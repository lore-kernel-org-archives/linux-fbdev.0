From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Mar 2014 12:23:21 +0000
Subject: Re: [PATCH v5 1/2] video: ARM CLCD: Add DT support
Message-Id: <531DAEB9.3020502@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aa37lV0Gl3uBSegaRCa4iE0mmFJ7XIJ9U"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1394036606-17784-1-git-send-email-pawel.moll@arm.com>	
 <53184C2E.3000807@ti.com> <1394119431.4160.84.camel@hornet>	
 <5319AF00.5030602@ti.com> <1394453382.3853.6.camel@hornet>
In-Reply-To: <1394453382.3853.6.camel@hornet>
To: linux-arm-kernel@lists.infradead.org

--aa37lV0Gl3uBSegaRCa4iE0mmFJ7XIJ9U
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 10/03/14 14:09, Pawel Moll wrote:

>> Note that the same DT bindings you add here should also work for the D=
RM
>> driver in the future. So, in fact, the question is extended to: will t=
he
>> fbdev=20
>=20
> No, I don't think so. It's a end of line for it, I believe. From my
> personal point of view the main goal is to fill the last gap between DT=

> and non-DT support on one of the Versatile Express boards - CLCD works
> fine when booted with ATAGs, doesn't work when booted with DT. It looks=

> bad.

The DT describes the hardware, and there should be only one description
of it, no matter what the used SW is. I see compatible =3D "arm,pl111" in=

the dts. PL111 is the LCD controller, right? What will the DRM driver
use, then, if the "arm,pl111" DT data is designed to work only for the
fbdev?

 Tomi



--aa37lV0Gl3uBSegaRCa4iE0mmFJ7XIJ9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHa65AAoJEPo9qoy8lh71rFoP/1oOoTi8QqCu54d4HJLCg6i+
mJlEqeUBwpjyMPojQGU7oUs99qOHiqy1LlpLP6TQ35RO26LkkWHJnw3wtZBHubr0
nsXQnE4rPr4K8qd/3y0uPaw5oS2pqUiV3580LZ7ZkEStdaj0WhQxgjgHxLjGgvPU
LFHehIuHl2lLl9hVbnVvyymkpxgpd1t44npPGX3rIFP9j+SPV5nfr5W9oaluJH6Q
6HWoCletZ11A7fYW6r3yqLI5sjxaslidhAdBGiQpGE1zy0eXBHknyWE+1o1zbzBQ
cbcS6+JkT6JnWAsFcyg59PdpjIwQt8lXn8LBl22dbWI60tf8XDOpNu7tYqgxfOVG
zMCuRXRFd47IY4VmkJJrXJKL/vGADwKMKMzDjDUDLlhKALElZEYa2mV40JKPOxJ8
omniOYd9b/c8aPsHimOZKpvWZKMlE2RFTDRohmVwzKCquJdaJ2XR7ZnEsBoYAiU4
TpM0t7600JTnR7v/JJsTyyVXrbuwn3T41Tm/kfiz11EOP+9JlUtBi+atDTK8O5J7
kG+sZQ9ogL6jGM1VYf4/7X2GUibsG60hmLd7cGeh4/K2DxhwS2tXAMw1Ha+2gLrz
qXsMw8gafIqhOFM9ASrihA+FzLGhjZYS+WHxESCgjkm7U/j5cutUCNGi0i/FW4ZF
dGgOpaVw9Zalztvc62oH
=9fd9
-----END PGP SIGNATURE-----

--aa37lV0Gl3uBSegaRCa4iE0mmFJ7XIJ9U--
