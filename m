From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 30 Dec 2015 08:06:36 +0000
Subject: Re: [RFC PATCH] fbdev: add support for Sigma Designs' smp8xxxfb.ko
Message-Id: <5683908C.5040001@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E9CQcEBDCTOkcqiRV1Dr0rk8Vv6f8v3Hq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <56828767.4050302@laposte.net>
 <CAH6sp9NrvapSMnPq5aagUFG2upf6-H9QJL1bkhMSscDL21Q-EQ@mail.gmail.com>
 <5682936E.2040904@laposte.net>
 <CAH6sp9OvJB+OPDPMWkEyNADcwO19N2=8U-5q49GrCmQTYObb_A@mail.gmail.com>
 <5682BA0B.9060001@laposte.net>
In-Reply-To: <5682BA0B.9060001@laposte.net>
To: Sebastian Frias <sf84@laposte.net>, Frans Klaver <fransklaver@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, mason <slash.tmp@free.fr>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>

--E9CQcEBDCTOkcqiRV1Dr0rk8Vv6f8v3Hq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 29/12/15 18:51, Sebastian Frias wrote:
> On 12/29/2015 03:16 PM, Frans Klaver wrote:
>> On Tue, Dec 29, 2015 at 3:06 PM, Sebastian Frias <sf84@laposte.net>
>> wrote:
>>> Right now we don't know if the driver will be upstreamed.
>>> Let me rephrase my question:
>>>
>>> - how would you recommend enabling FB_CFB_FILLRECT, FB_CFB_COPYAREA a=
nd
>>> FB_CFB_IMAGEBLIT for a driver that is not included in the kernel's tr=
ee?
>>>
>>> If that is not possible, I guess we will have to keep a forked tree
>>> until
>>> the driver is upstreamed, but we would like to avoid that, hence the
>>> question.
>>
>> I guess you'll have to keep on doing that indeed. I'm not aware of any=

>> location where out-of-tree drivers are considered. You should try
>> again when you have some actual code to upstream.
>>
>=20
> Ok, thanks.

Also note that I don't want new fbdev drivers into the mainline kernel.
You should implement a DRM based driver instead.

 Tomi


--E9CQcEBDCTOkcqiRV1Dr0rk8Vv6f8v3Hq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWg5CMAAoJEPo9qoy8lh71/SUP/0gZB37hpCQ51lzn5aQn2rk/
3ctqs+H0BTJUMbrBFRe9PvHZEdT1y19GtGbDTg3p72KErlvXQLdr+3qteKElx+fy
sMjxM7bccx+JL6gX/oAUDrvI/ebQi5VMn48j8+Z23D9KR7pWP54niVnuagtqbync
8MACx9A6xdcH/jKbyWgkQsQx2wtQsP6OERSnPyjkfU0YiZIhyzC8e1+WUi1muvf5
fAslbXoiTeNItnUDx+Mzm+CjXHpie3Fis0gblfEh8ZFn/o2Emz7kqpeIEvcNPaeR
/t9m+lGpOHsZuxgzxzAxHet4XwuaHUDUTS2NgiyxXzrgYJo28z6cv+W2fkxdB8DJ
p4yuD09fx2NJZbMRmtEfPnhRRFNEHr74Sg9kY9WnH00clCFAjmCepKJ58NtjzT5R
17lT4XcSu/grZgQENwk7wks6k/ag91vsGAQtE/uracJxqUzh0bze/NqQShbUOctK
KvnKNkXgNabRcDYUe2f1NDomg+QqzhIs5hNADgVTDF9IsUvqejTTi67jNWC6Y1aK
q2q1LWgSCgn+F8mq9AgYJJ7YahIk2MlkP/ZLrnD7GDTu1Q8WP4Om0shguDvvh06F
fRdpOW5ynC+rAoO4rRk4uBNOKt0IIFWnBtXR65mUcL3ZzwKNODcyNgaRfk112ub4
y1pT6wRE1+bOyCSlejU6
=E/Md
-----END PGP SIGNATURE-----

--E9CQcEBDCTOkcqiRV1Dr0rk8Vv6f8v3Hq--
