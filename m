From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 11:58:31 +0000
Subject: Re: [PATCH v2 1/3] staging: sm7xxfb: move sm712fb out of staging
Message-Id: <5603E567.5000001@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3pCGgkAJ4rwarkBJ58xglEO8SfSF57aXj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437192539-14150-1-git-send-email-sudipm.mukherjee@gmail.com>
 <55E5A7BC.8060003@ti.com> <20150901135514.GB15833@sudip-pc>
 <55E6E45B.5030500@ti.com> <20150902124811.GA25301@sudip-pc>
In-Reply-To: <20150902124811.GA25301@sudip-pc>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, devel@driverdev.osuosl.org

--3pCGgkAJ4rwarkBJ58xglEO8SfSF57aXj
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 02/09/15 15:48, Sudip Mukherjee wrote:

> Now I am getting confused. :(
> Since this has already been merged I guess we need to maintain it now.

Oh, ok. I thought it was still in staging. I haven't been able to follow
the list properly lately...

Well, in theory we could still revert it, as it's only -rc2.

> So then should I fix the things you pointed out or should i instead
> give more priority to the DRM driver and fix these things later?

Is there a public datasheet for the HW?

The driver as it is now is quite horrible. Huge tables of raw data,
written directly to the registers. Lots of magic numbers all around.
Even with a datasheet, presuming it's public and it contains all those
values, the driver is rather unmaintainable.

All those need to be sorted out for the DRM driver anyway, so maybe it's
better to clean up the fb driver first.

> And, just to inform you, there are two more fbdev drivers in staging,
> staging/sm750fb and staging/fbtft. And the ultimate goal of any driver

Thanks for pointing this out, I need to check those and think how to
proceed.

 Tomi


--3pCGgkAJ4rwarkBJ58xglEO8SfSF57aXj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA+VnAAoJEPo9qoy8lh71LVgQAIQvuJI97K1Y6iJW12c0Id+F
ooqulrfJgW/VaV3mK9xfLI1436ZkkkwKGqqQGw4QJuLbwJp1mqHmZ4IlXB/zLJS7
Bd0EByq/eU3p+3K41KHMnco457nQXYkxth56w2jCUjllJaJ65SdBF3w4eFfVdyON
v7GAl9vpSm38Nia/IxVbLY4/9nJKSh347+4asKqWEtyDNTEwdwtSVDn4ir/w8sUa
KlRAIEPzMjpL191Dqb6F5fxpL+FfL7+IZW7pucSTyPyEpkt8AfMBhWejJaOagNCC
p1hDhNJCn4fgcAF4CSU7Cp3jQd3fQV2lqmTx2omFMD6bmMWPbMWA1nVO6D2FDshP
rXOAJbhTVC7ssY/hy+JKIusPEJgUX3V3MKR+2LgosBTVZTDTzMAMcKI85YKMVE7b
G2DaNts8VIZd/S2kzTOm/yf2LKq+RbpBg8Xsav/kaCYJdntCxu1X5ZM1RPSa2NWn
y7tqgleZqA1yzKbqx6My1Gn3eekvzZ2nZLIXc2eetGdCqzDMRfYs5YdzMwaZXo2a
YwzRFVv8hjq0/RBtMLpw0/7YOmk9jlewS4nq/UpM1D8rYrVv86fRN6EGn+GkYIf4
l9fSh1VWX20HHDs7/4Rp7nzK8zE/Ya7Cr2UybcOonPgNlUH5Z2la02IkKRDbcDA9
3JGx0mfEvYLxJKZ0Finw
=cj2Q
-----END PGP SIGNATURE-----

--3pCGgkAJ4rwarkBJ58xglEO8SfSF57aXj--
