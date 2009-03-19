From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] Fix typo.
Date: Thu, 19 Mar 2009 21:10:01 +0100
Message-ID: <1237493401.11987.1.camel@mattotaupa.wohnung.familie-menzel.net>
References: <1236983171.4376.3.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4306065252570141957=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1LkOZn-00018i-DM for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Mar 2009 20:10:51 +0000
Received: from b186.blue.fastwebserver.de ([62.141.42.186] helo=mail.gw90.de)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LkOZc-0004mX-LD
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Mar 2009 20:10:43 +0000
Received: from f053041106.adsl.alicedsl.de ([78.53.41.106]
	helo=[192.168.178.20])
	by mail.gw90.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1LkOZa-0005c5-7S for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Mar 2009 20:10:38 +0000
In-Reply-To: <1236983171.4376.3.camel@mattotaupa.wohnung.familie-menzel.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


--===============4306065252570141957==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-nX2HfQy1axVnMshZO8Uz"


--=-nX2HfQy1axVnMshZO8Uz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Dear developers,


will I get a confirmation if this is accepted or do I have to send this
patch somewhere else additionally?


Thanks,

Paul

Am Freitag, den 13.03.2009, 23:26 +0100 schrieb Paul Menzel:
> Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
> ---
>  drivers/video/aty/radeon_base.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_b=
ase.c
> index 8db675c..e33a1ea 100644
> --- a/drivers/video/aty/radeon_base.c
> +++ b/drivers/video/aty/radeon_base.c
> @@ -701,8 +701,8 @@ static void __devinit radeon_get_pllinfo(struct radeo=
nfb_info *rinfo)
>  found:
>  	/*
>  	 * Some methods fail to retrieve SCLK and MCLK values, we apply default
> -	 * settings in this case (200Mhz). If that really happne often, we coul=
d
> -	 * fetch from registers instead...
> +	 * settings in this case (200Mhz). If that really happens often, we
> +	 * could fetch from registers instead...
>  	 */
>  	if (rinfo->pll.mclk =3D=3D 0)
>  		rinfo->pll.mclk =3D 20000;

--=-nX2HfQy1axVnMshZO8Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAknCppMACgkQPX1aK2wOHVhiYgCdFGGBIj9sjVep4a6I5hnjy5YG
uJoAnjmVCUvMXyFgLDBV/mfphK/mMgDh
=IV89
-----END PGP SIGNATURE-----

--=-nX2HfQy1axVnMshZO8Uz--



--===============4306065252570141957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
--===============4306065252570141957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============4306065252570141957==--
