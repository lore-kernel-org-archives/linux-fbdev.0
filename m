From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 09 Jan 2014 13:03:33 +0000
Subject: Re: [PATCH] fbdev: sh_mipi_dsi/sh_mobile_hdmi: clk_round_rate() can return a zero upon error
Message-Id: <52CE9E25.9080201@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="saiFwjOveSrAGgmeCH7XScTkPWkBoOTxk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.02.1311261651300.11450@tamien>
In-Reply-To: <alpine.DEB.2.02.1311261651300.11450@tamien>
To: linux-fbdev@vger.kernel.org

--saiFwjOveSrAGgmeCH7XScTkPWkBoOTxk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-27 02:53, Paul Walmsley wrote:
>=20
> Treat both negative and zero return values from clk_round_rate() as
> errors.  This is needed since subsequent patches will convert
> clk_round_rate()'s return value to be an unsigned type, rather than a
> signed type, since some clock sources can generate rates higher than
> (2^31)-1 Hz.
>=20
> Eventually, when calling clk_round_rate(), only a return value of zero
> will be considered a error.  All other values will be considered valid
> rates.  The comparison against values less than 0 is kept to preserve
> the correct behavior in the meantime.
>=20
> Signed-off-by: Paul Walmsley <pwalmsley@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>=20
> Applies on v3.13-rc1.  See also:

I'm not able to apply this, I'm just getting "patch doesn't apply". I
tried both the patch saved from my email client, and the patch from
patchworks...

Can you rebase to, say, rc6, and resend?

 Tomi



--saiFwjOveSrAGgmeCH7XScTkPWkBoOTxk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSzp4lAAoJEPo9qoy8lh71xvEP/jgYUzXgYTxC0ldx+KhaVHeY
HQCUUF7CDLNvqHd6EIiRD9OUMfAWUAuDTFwEZcW63g3RSuS/PU46GxFFK97CQBai
CJL30scaQ/3EqYkjZL3HpCPcnMFLFqZjlVEvcJp4Wq3Wpin+iYtiot04UFEmA2Pn
s3n6wNl5aoBJW/71UKADNbBu6AMLEY9kLz+JDDL0GfA5tFCm+2Jj/jbAyTMVkRT1
aWXU4BRsZYKKuNgkaOhectlKSHDLPDcna+PJjk5wcg5t5C4gPQVJB9y9ptsbwHgm
eGxHTBMnLc1JxQz/PPgjrcV3WMXekFRDfGCey6Jk6nkcbaqeGoHBxm5fRaX717Ct
eLW31bsIbXaaU8bSQeDKQY/2wokOZOT3tx+LWiT++kRh/zE6OIgw7THKyvqsBZNR
s7UGvyD2fcJlUhC8r6TitjrG7tTmNk5n3+eky2y7cNgWxIhP6bgeKJcdCywDQkd9
GYBQnQEJCruJLpDdPj8xCjCjZIxPk7mt+AiFMW2RxAi4VMG3ToMRLJKl/Oqfpz9w
mekEZitgAjHDxvqjpurFRSzokrfZ02v5OyAdAlFO25GGwk6xtGfNA44c48YPnKwJ
ATwGp1nSToF+vlFK8a5or841r+6cX+Dr8DxruE4RExPqsizQUZi76tRxBDGlkprX
qb4e2eRrPxSadHfjRh6D
=TfJY
-----END PGP SIGNATURE-----

--saiFwjOveSrAGgmeCH7XScTkPWkBoOTxk--
