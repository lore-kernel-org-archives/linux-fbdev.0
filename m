From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 13:17:09 +0000
Subject: Re: [PATCH resend] fbdev: bfin-lq035q1-fb: Use dev_pm_ops
Message-Id: <51CAE9D5.7050701@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2NXWGHPAQJLXIQPWJNHVQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371746326-5087-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1371746326-5087-1-git-send-email-lars@metafoo.de>
To: linux-fbdev@vger.kernel.org

------enig2NXWGHPAQJLXIQPWJNHVQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 20/06/13 19:38, Lars-Peter Clausen wrote:
> Use dev_pm_ops instead of the legacy suspend/resume callbacks.
>=20
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
> Since Rafael said he won't take the pm_sleep_ops_ptr() macro, just a re=
send of
> the previous version of the patch.
> ---
>  drivers/video/bfin-lq035q1-fb.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)

I've added this to fbdev-3.11 branch.

 Tomi



------enig2NXWGHPAQJLXIQPWJNHVQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyunVAAoJEPo9qoy8lh71VUIP/RsbMmovHBb0jS81ISHkkA8d
w4e0ZyYykjxWjuRzz5AWswiVpxnrxSEG4IH2HofTCPNPlqcbcQdr3jpmuUoyTB75
ByZy6UsgHjTjHwTFzfQJlqg6tk1Biq/T+2/xnpvQe1yC7BDPTJgY2dycoplJD8O1
9br7qKPJu+B9r2S1mVcgf2oGHSxLBQ9ldcl72B+d7ZkhCmf3K/Yyt6mpCI3Wnb9O
9iwgET332MmmKf/o2DDoNfngkrVJ1R3RQxR3p57sVWBIbx3qn6idaEasMwlMhaW7
v4mYwPaZOfDgICGOjurv7jrifI92Hi128pfAwWHw9UN/MrNkgShtH8Nh90P9NUZp
7xfrS1ACLhWGMD8UPZi62byMjYwdZ0sSFp5Ot2V31QdtAr2FieE031saBN/cPsab
hlE8yZhJPGWMgXQAuMfEBzm+XxWyw7ueRjkaeYu8tpMtj0ZMWkUugx0C798ebamT
nynJBgNB+8TSon/I6SLyrZ3SOsvKUJPxxJqIfHrsQEpi5bgR0lIuwJe3/tOUG/ss
jmHqfhNcro8trcVNUfF/HHTfzDg78+YAPgFsaQE06iC/8WEtbxoUBfSk7OQGNngX
rSbBSo1rVT3H1k8FJIL+Xtk7oAq6l7Hbxv2+Yo2cyEYVPZ56J5e7GK81nGyHKB+5
cNXdB2fbOFSLrSvteuQG
=r8E0
-----END PGP SIGNATURE-----

------enig2NXWGHPAQJLXIQPWJNHVQ--
