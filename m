From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Feb 2014 12:18:26 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <52F8C392.9040609@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="jLg906PgsmG2EUGA31BIloxM34ESn8CRc"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--jLg906PgsmG2EUGA31BIloxM34ESn8CRc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/01/14 06:32, Sachin Kamat wrote:
> Exynos is now a DT only platform. Hence there is no need
> for an explicit OF dependency. Remove it.

But the driver still depends on OF, doesn't it? I don't think it's very
good for the driver Kconfig to make presumptions about what ARCH_*
depend on.

 Tomi



--jLg906PgsmG2EUGA31BIloxM34ESn8CRc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+MOSAAoJEPo9qoy8lh71yt4P/34eoLSvToQWw/jMWv9mJz26
WtJBv0I2qwea9h5sCjVYY754e9dbFHNxZkk8jBY+WnjcrgllW/Ij+Rhs0IHr7+vn
65To+FBcC2o0dbu3GbshKC4LX4nxSgcGDVmO9zaLB7pR484nU0Y1YG2FwGpi/2sF
HD5XPwjvUCJGmiSHhW9iGYg10uJ5XEkDECXmn6N97D35l8C2a0E6Ikudui7Ey2Zw
D9kyLAFFOm2JTl2nQS8YbC827xebdoZAtFy2RIYu5nM2rC3kmH+WxwneNAd6CzqW
zbNDeXpBOr2X63fWXhzEvqN0DXKahyObutkpU0Qc2q9UYU+oOoBd3S+l+i/JtkJ1
pAlHF/wfohpWqKDKWt8w2ZyzQQiM0SmjUXJEZTVohp8rc2sS9kasC5tVlG79AraB
q4yI+XarFbXv+G2/j0eWD8Obo1v/b9vEwxQVG9bRBvZmlAZx8Rg7nIYTQIs6tHx2
1Vpwt9BSgnQT68vxFhgmKSHjacsusrv+jCY/jhfg1tDcwO43LXc9rZQG0lehxHIF
yWbzMmp9cH0vDs7UPsxWll49hsAlB7yURdd+f2TBeoDqPFPO5nI8BDFOjrlIF/BA
bxzKvEbknrUCmMHty5f+ECiDblve2yREAO/wHon1dzFexn+Yz65g+YwaHdH2NcqZ
Z2/23ai43hNzR173pAHX
=f6SV
-----END PGP SIGNATURE-----

--jLg906PgsmG2EUGA31BIloxM34ESn8CRc--
