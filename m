From: Mark Brown <broonie@kernel.org>
Date: Thu, 12 Dec 2013 18:07:53 +0000
Subject: Re: [PATCH] video: amba-clcd: Make CLCD driver available on more platforms
Message-Id: <20131212180753.GR11044@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9uazBBczf8QSjDPd"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386868390-12231-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1386868390-12231-1-git-send-email-broonie@kernel.org>
To: linux-fbdev@vger.kernel.org


--9uazBBczf8QSjDPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2013 at 06:48:49PM +0100, Geert Uytterhoeven wrote:

> Currently ARM_AMBA exists on arm/arm64 only.
> Is there a patch in the pipeline to change that? Without such a change,

I don't know but it's plausible given how common AMBA is.

> this patch doesn't make any difference.

No, it does mean that ARM64 is included - previously the dependency was
only on ARM so it wasn't available on ARM64.  COMPILE_TEST won't have an
impact though.

--9uazBBczf8QSjDPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqft2AAoJELSic+t+oim9TVMP/3tLfGTEQ3m5o2BSRoVvnSTn
bPVdGJT3s3wJ0jaIvaj4vSVsMMfRfIfsrFb2HctqC5P28ZVHRYb3cg3YP1+TS/Gf
Uu/KOYfEfDZyWgbR+1TP6i3+QFdZbr3QQwvwW6JjC91yvQGSKOR+ix+tQ+7TSOLY
59k8iUNIv3eEX4bSg7E/RpYb62cQJ7X5Fvm5rZf1L0e5sJr/yxwVTfmf71y1E0uL
RMhIxkczz6jTwHNPajTM5DW4qc2XhCGX5HLx5pRgIXoFT/30eMhKo+MhrgxtHk6N
8xVGYScOGV18DVLo7J9JpxuglzxnNbZwYaPq9+lpeXUGJg4YNhswgKw7l6R0PGXO
+SNGZnnFL3dn3uKWcEsh4uRal3gkI30bxrBvS0oA/Au+qcxYfOCy/mz/WjibpZsm
sXTFvZ4UAX/Muxv/sF2ATETtgXhreKNbQ6ewsFBOaI7cxnRviOPNi1IKRs/+ViJu
1yQaKtcxh1NncjxNNWrwTG8jahWmUVkrV2xIloLxz7XNKHnRBbVeYmmAQSUsgV/w
Jj/NhaMJfq17wI4U73iZLI3E+BRW8kRSk+ucIv6zID8q2Uwl8yOw9ZGPbiz6VyWg
9mVCmtup6tTUBZDdivjbqr+StkDLd31E2faItt6rqXfqwiiJbsZjIzxo69eFis0O
B7EgN8WueELKX25RAn9O
=btVs
-----END PGP SIGNATURE-----

--9uazBBczf8QSjDPd--
