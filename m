From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Aug 2016 08:35:37 +0000
Subject: Re: [PATCH 2/5] video: ARM CLCD: fix endpoint lookup logic
Message-Id: <8830198c-0d03-1b80-9b9f-eca228996a4b@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2aBr56iR3tk22K3R4EbAFF1tV2VBTceU2"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826152546.604384-1-arnd@arndb.de>
 <20160826152546.604384-3-arnd@arndb.de>
 <CACRpkdZ5W4bJfg_rWpYzN1Nrj748_ttZdju7GFJ_5ZDv0vNd_w@mail.gmail.com>
In-Reply-To: <CACRpkdZ5W4bJfg_rWpYzN1Nrj748_ttZdju7GFJ_5ZDv0vNd_w@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Colin Ian King <colin.king@canonical.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Russell King <linux@armlinux.org.uk>

--2aBr56iR3tk22K3R4EbAFF1tV2VBTceU2
Content-Type: multipart/mixed; boundary="XkLFUODjaHwuOGLq1opvHotbGXlEnPeKe";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Colin Ian King <colin.king@canonical.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 Russell King <linux@armlinux.org.uk>
Message-ID: <8830198c-0d03-1b80-9b9f-eca228996a4b@ti.com>
Subject: Re: [PATCH 2/5] video: ARM CLCD: fix endpoint lookup logic
References: <20160826152546.604384-1-arnd@arndb.de>
 <20160826152546.604384-3-arnd@arndb.de>
 <CACRpkdZ5W4bJfg_rWpYzN1Nrj748_ttZdju7GFJ_5ZDv0vNd_w@mail.gmail.com>
In-Reply-To: <CACRpkdZ5W4bJfg_rWpYzN1Nrj748_ttZdju7GFJ_5ZDv0vNd_w@mail.gmail.com>

--XkLFUODjaHwuOGLq1opvHotbGXlEnPeKe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 29/08/16 16:18, Linus Walleij wrote:
> On Fri, Aug 26, 2016 at 5:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> [I don't see why Torvalds was CC'ed on this patch? Was there
> some specific complaint from his side that I screw things up
> or just the wrong Linus?]
>=20
>> The addition of the Nomadik support in this driver introduced
>> a bug in clcdfb_of_init_display(), which now calls init_panel
>> with an uninitialized 'endpoint' pointer, as "gcc -Wmaybe-uninitialize=
d"
>> warns:
>>
>> drivers/video/fbdev/amba-clcd.c: In function 'clcdfb_of_init_display':=

>> drivers/video/fbdev/amba-clcd.c:785:5: error: 'endpoint' may be used u=
ninitialized in this function [-Werror=3Dmaybe-uninitialized]
>>
>> This reverts the broken part of the function to what it was before
>> the patch, which is the best guess I have to what it should be.
>> I assume this was left over from an attempted rework of the
>> code that was partially backed out.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 046ad6cdeb3f ("video: ARM CLCD: support Nomadik variant")
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Tomi: I think this bug was also reported by Ian King, so suggest
> adding his
> Reported-by: Colin Ian King <colin.king@canonical.com>
>=20

Thanks, queued for v4.9.

 Tomi


--XkLFUODjaHwuOGLq1opvHotbGXlEnPeKe--

--2aBr56iR3tk22K3R4EbAFF1tV2VBTceU2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxUVZAAoJEPo9qoy8lh71MlEQAIWFH43ZWwVnFvcRGIp3NTog
/v3AW++Gv5kK+tI334Zm7fwvjPRy1PLptA3MezuDn8lbICnXPnYLbIl+E0jPUsUY
CLO0C9uusmTkXZAaC/MBI1+9LTHo5FZivhIimDT/3qkP+8t35tgaL2vYr22k52rY
1crM5SJTHNOSeQPdPeUcLVZB5TjSn2Hxhd5t3z2Omw+XHzmrW8EjRgdC6C1J8jOL
A2lr+ecDhvtUsgzSAS6VT65W/W6nRDYp/rprpWMzBdkVxED60OGXOjV187+oQmc0
DJOwyPHXCVFfdha57NdtsBrDO3w6nE2jErEcr2EfvncHpu+CBrQ/+Whz4mwkqn+S
emCTzB+Bo58ApRNIMTvQQJhvMtB8/BZEVdZ0PNwSe0r92Rz5gh3Qagpa9fbSn8KW
SlhoRf+62T7mO6iUd3UwKRBF5AfDucmmO1X06cIFA+sIWWqsnJA3Tq86V6eNEsYW
YRvkdcXMHfOpRZqStGqtlJ3Br9ZA3mLOFsNMavQJ5sKfVir83XCTfubFl+ebUiZ5
GOkc2R8Z6qNVg9oKlFcSi+tYhG4GGbgKa+JoEJCdqmYLjt1dMBMdcwavFxJDGIie
I6RSGmbI21gFkzJ2khzDXypoNkEog1T0SeDpoy9qT1mDe91VjLuGC04cHmNDi9GK
eezYA/MON0H/vQAouwMs
=hJoD
-----END PGP SIGNATURE-----

--2aBr56iR3tk22K3R4EbAFF1tV2VBTceU2--
