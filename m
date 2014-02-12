From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 12 Feb 2014 08:17:01 +0000
Subject: Re: [RFC PATCH] video: Use fb_sys_write rather than open-coding in drivers
Message-Id: <52FB2DFD.8080408@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="q4Fa2E4g585lCTfIN04iWTOsGhNm8JgPN"
List-Id: <linux-fbdev.vger.kernel.org>
References: <523BF40B.1090002@gmail.com> <52FA2E57.3010300@ti.com> <52FA7509.1060704@gmail.com> <52FB1AB0.6090601@ti.com> <52FB005E.1000207@gmail.com>
In-Reply-To: <52FB005E.1000207@gmail.com>
To: Ryan Mallon <rmallon@gmail.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--q4Fa2E4g585lCTfIN04iWTOsGhNm8JgPN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/02/14 07:02, Ryan Mallon wrote:

> Well, the alternative is to supply an fb_write() implementation for eac=
h
> driver that calls fb_sys_write(), and then updates the display. The
> fb_sync() additions can be removed. That would cut down the boiler-plat=
e
> code, and should keep the behaviour the same.
>=20
> If you don't think it is worth the effort, then the patch can just be
> dropped.

I'd be very cautious about doing cleanups on drivers that you cannot
test. Small innocent looking changes can break them.

For example, your patch sets info->screen_size, which is not set
currently. Does the fbdev framework use screen_size somewhere
differently than smem_len? I don't know, but that could lead to small
difference in operation. However, in this case, fb_sys_write() actually
uses smem_len if screen_size is 0, so that change is not even needed.

ssd1307fb_write() looks a bit different than fb_sys_write. I don't know
if the differences could cause issues. The other ones look copy-pasted
from fb_sys_write (but I didn't look at them carefully), so perhaps
those could be cleaned up safely.

 Tomi



--q4Fa2E4g585lCTfIN04iWTOsGhNm8JgPN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+y39AAoJEPo9qoy8lh71S2UP/2q6zyoIPmV8rd8YARCBZeDC
gH+bxsMC7jjgKZbaQMSR08gJU2ZKPj/N9Y/fUJ+2Q4ghZdjjyrmPzdro63MU+pb1
IMc0mVm+nJu92diq+zxl+WCuQa7qJW2Fzp5p2MOfxEv0iq/sn+RxRrbHUSr6O3m2
Appo5Yzb2bE5E0+lTCHiaTlk4K4SnUfRZE7pRxBVJd7ze4VZEm//EcGQBchOO0qj
Up1Z4vg0TeJSoNZO07V/0uK32CzdiDpuaya3e6M68/z6rybUo2Tx4xUBjnYHngHh
5EA+LNYm8HOXnWN60LEkY/qycud3VEaP+kDWKJI7KRpcrXffPw/nQmGbNaU17uUu
zyo0TsvRGaWW/lmJuQ7I2+snfEbsPDfY3xG42fGyBvoCcLDBrCSFRqrkHYIEciS4
AwGuANRrlC/ouIEtKzQT1mdSttCCImsodbUvG5o0zza+iFX8s+12aOv6D4JlVMvU
zrqgReWW1qd3/Vh0ecSFMd1Fw0wRDa0NeDDXFRDZybh8kJTWBRrDbhcYnwkXhR8R
yQXOAbnfeNdWjhye8UgyF20bJTVrf143lnlu+KNiDe9atRERjvydEReSsN9Jhr2a
vXxI7s/sl46tfcg419M2eb4Tt7/SoY9u18T/GaC4AbpSfxAQmV/+Ga/aZdPczj2L
Dxb/CWCk57ETEU9XKlzY
=t2N5
-----END PGP SIGNATURE-----

--q4Fa2E4g585lCTfIN04iWTOsGhNm8JgPN--
