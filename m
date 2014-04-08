From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 08 Apr 2014 10:24:09 +0000
Subject: Re: [PATCH 0/3] video: clps711x: New CLPS711X FB driver
Message-Id: <5343CE49.9080000@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Eo0NJ7gG6JbTRVRXSKaH5oRcP3nHQasKe"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395332675-23135-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1395332675-23135-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--Eo0NJ7gG6JbTRVRXSKaH5oRcP3nHQasKe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/04/14 13:15, Alexander Shiyan wrote:
> Tue, 8 Apr 2014 12:56:24 +0300 =D0=BE=D1=82 Tomi Valkeinen <tomi.valkei=
nen@ti.com>:
>> Hi,
>>
>> On 20/03/14 18:24, Alexander Shiyan wrote:
>>> This series adds a new framebuffer driver for Cirrus Logic CLPS711X
>>> CPUs. Since all code rewritten from scratch, patch is designed as a
>>> replacement of the old (not updated for a long time) for a new one.
>>
>> Why was it rewritten from scratch? It's almost always better to improv=
e
>> the old one, than write a new, replacing one.
> Hello.
>=20
> Most of the code has been rewritten. It will be very difficult to see t=
he changes,
> if it is presented as a patch for the old driver.

Well, now it's impossible to see the changes, except opening both files
and going through line by line. You don't even list any new features in
the description, or give any reason why a new driver is required.

And of course one huge patch changing the old driver to the new form is
bad also.

The proper way would be to gradually change the old driver with a patch
series. Then it's possible to review the patches and see what is
actually changed.

 Tomi



--Eo0NJ7gG6JbTRVRXSKaH5oRcP3nHQasKe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTQ85JAAoJEPo9qoy8lh71mlwP/29Y5VOyfoThqON71bBrYpfB
UMOTdk0FuxNwVqrhVPKaJ6GBxmKocvq/cmrxXKnBaa7XYqwL3z6eZax2ScrS8L0X
meyMomf0UIfGS//i92pnDaeJKr7UYiSeEFz74sPmrwYMcuBLTqeaWrX4IQcgzb8T
+jkNjgMr7lyxSuIUgVARXL6GhnChNeWXLbqmAFDQQq1RvV1TzwqM3GdJ8lUaeFS6
x1xrZEuAqPlCK2iX5ZXRbrbLPjVYjRgJoZ3d0gsIyyXiKagiR0C36qGRc9r0zrEF
wQxIlwZMVhkoESUsOwrQwso4han7X6OcAJ8ZOtIpoKu3AjOWIAlvZrYrFj507N2F
9P4vG36INzNntYP5NUrNeChcaeWZJThIKtxb1zHCRsDwwph+pbkNIL60ANRGDidW
zPqfFgNQV6IlAL0IGSEoRVc+zY5hcKanyLDR9DXkzpHqj6lo81h8kUPq3I3C348g
z/VZE30X4J813kKCgyoTxB2wSuxFZSnWsbgqwSz2pmIrsKkZai6EU49yxEaUgqKQ
8gk+lDk3nNzUZay1JOELNohGCtTiO35pbPpf845ibK/iFr/Z3/in62TnKjW8wwAY
TBgBeC0D2xJx1/0tpcfwR5Sd8PNk5uIsH6DoqfdHI7TnrF/OtF2xJM7YyOUdi2xq
rcUeMGLhtTGcV4JSgWOQ
=epTu
-----END PGP SIGNATURE-----

--Eo0NJ7gG6JbTRVRXSKaH5oRcP3nHQasKe--
