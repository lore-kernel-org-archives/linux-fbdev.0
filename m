From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 23 May 2014 14:26:01 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <537F5A79.2080801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XL1mCHiimlT1kATX4m3IJnFnjol51s5gh"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--XL1mCHiimlT1kATX4m3IJnFnjol51s5gh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23/05/14 17:14, Arnd Bergmann wrote:
> On Friday 23 May 2014 17:10:35 Tomi Valkeinen wrote:
>> On 23/05/14 16:13, Alexander Shiyan wrote:
>>
>>>> Would it be possible to add the new driver along the old driver, and=
 use
>>>> the new driver only for the boards you have, and for boards for whic=
h
>>>> it's clear the the old driver is not working? This could be merged f=
or 3.16.
>>>
>>> At this time yes, we can. But since I plan to add multiplatform suppo=
rt
>>> for this SOC, this seems not possible.
>>> I can try to make multiplatform support optional, then it could be do=
ne...
>>
>> Hmm, why is that not possible with multiplatform support? What do you
>> mean with multiplatform support here?
>=20
> We are migrating all ARM platforms to allow building them into a single=

> kernel. However, that means that device drivers cannot access platform
> specific header files any more and have to get hardware information fro=
m
> DT or through platform data. The existing driver however uses mach/hard=
ware.h.

Ah, I see. So the problem is not with two different drivers for the same
hardware device as such, but that in this case the older driver just
doesn't play well with multiplatform.

 Tomi



--XL1mCHiimlT1kATX4m3IJnFnjol51s5gh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTf1p5AAoJEPo9qoy8lh711PYP/R7SvEuf+HZQJzpfNhPpOBpn
qOG/XibTQkhmrBwHMvt5pV5p37E/pxYDWtKEiLmL8Gdsj1c74QSAhO1nAfihS4W0
fGnkW+5BVyX9NZnzv+vm56ZUmfTkpNe7aLz1+f5Q37b6Cgy5bMlaDDHs0RdGTZSn
MuG4NByBb3IV0sxZLn9DAEijc9nfrifyrRVFHRHURRSsbycI12lzwnPB0Y04oxL7
cFBkAjDYYxV/FZRA8QxG1L+nXU4DMOqwkK7D/XdhZYQtPIcD1Ng+xuBwymCULENh
gUgFLdKJHaTNWK13jzuIhTtcWLDpPaiRNW8UPNWXcgCrn5TGrQ2NfhHP89sXYbcX
J/ncH5picP3c3R2NCWFTSSA4ktPRiasJFTqhC2CyjrjuQxpA0M3QbFH+NiIAEMAn
/xhHpTptwIP2rt6uGa5ubV/1oceCHy8we8/ZNnhBce5Rbcg/9eXy8oKRtfOhm2Mb
bl/VRnkUaVZjxNHrLgm54+H+J6qwJvetG9vZV0ShDawoWGEBbF5rNuhwMpRerL23
L+pa4JQRiR5BfENoZPkLsLx5yNSXzMAqTq8BSPfbf7tdMgOyp5TDsdQAfoSzMkuS
SG1SRY/qdFBExhOBVYDL6QPMww1H8HIXg9NBGsCXberAMtfdTyRIP7uWOPTQLMq/
Uh7+NX7s5zHDOULUlz9T
=mDNW
-----END PGP SIGNATURE-----

--XL1mCHiimlT1kATX4m3IJnFnjol51s5gh--
