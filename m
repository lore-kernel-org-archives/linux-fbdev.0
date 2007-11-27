From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 2/9] ps3: Use symbolic names for
	video modes
Date: Tue, 27 Nov 2007 11:05:38 +1100
Message-ID: <20071127110538.32f8dfef.sfr@canb.auug.org.au>
References: <20071126172455.308741000@pademelon.sonytel.be>
	<20071126172712.128301000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1878853972=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwnxW-0000EG-5I for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 16:05:50 -0800
Received: from chilli.pcug.org.au ([203.10.76.44] helo=smtps.tip.net.au)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwnxU-000277-Ex
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 16:05:50 -0800
In-Reply-To: <20071126172712.128301000@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

--===============1878853972==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__27_Nov_2007_11_05_38_+1100_2OITvKt3g7Xo4vQc"

--Signature=_Tue__27_Nov_2007_11_05_38_+1100_2OITvKt3g7Xo4vQc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Nov 2007 18:24:57 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@s=
onycom.com> wrote:
>
> @@ -594,20 +594,21 @@ static const struct {
>  	unsigned mask : 19;
>  	unsigned id :  4;
>  } ps3av_preferred_modes[] =3D {
> -	{ .mask =3D PS3AV_RESBIT_WUXGA		<< SHIFT_VESA,	.id =3D 13 },
> -	{ .mask =3D PS3AV_RESBIT_1920x1080P	<< SHIFT_60,	.id =3D 5 },
> -	{ .mask =3D PS3AV_RESBIT_1920x1080P	<< SHIFT_50,	.id =3D 10 },
> -	{ .mask =3D PS3AV_RESBIT_1920x1080I	<< SHIFT_60,	.id =3D 4 },
> -	{ .mask =3D PS3AV_RESBIT_1920x1080I	<< SHIFT_50,	.id =3D 9 },
> -	{ .mask =3D PS3AV_RESBIT_SXGA		<< SHIFT_VESA,	.id =3D 12 },
> -	{ .mask =3D PS3AV_RESBIT_WXGA		<< SHIFT_VESA,	.id =3D 11 },
> -	{ .mask =3D PS3AV_RESBIT_1280x720P	<< SHIFT_60,	.id =3D 3 },
> -	{ .mask =3D PS3AV_RESBIT_1280x720P	<< SHIFT_50,	.id =3D 8 },
> -	{ .mask =3D PS3AV_RESBIT_720x480P		<< SHIFT_60,	.id =3D 2 },
> -	{ .mask =3D PS3AV_RESBIT_720x576P		<< SHIFT_50,	.id =3D 7 },
> +	{ PS3AV_RESBIT_WUXGA      << SHIFT_VESA, PS3AV_MODE_WUXGA   },
> +	{ PS3AV_RESBIT_1920x1080P << SHIFT_60,   PS3AV_MODE_1080P60 },
> +	{ PS3AV_RESBIT_1920x1080P << SHIFT_50,   PS3AV_MODE_1080P50 },
> +	{ PS3AV_RESBIT_1920x1080I << SHIFT_60,   PS3AV_MODE_1080I60 },
> +	{ PS3AV_RESBIT_1920x1080I << SHIFT_50,   PS3AV_MODE_1080I50 },
> +	{ PS3AV_RESBIT_SXGA       << SHIFT_VESA, PS3AV_MODE_SXGA    },
> +	{ PS3AV_RESBIT_WXGA       << SHIFT_VESA, PS3AV_MODE_WXGA    },
> +	{ PS3AV_RESBIT_1280x720P  << SHIFT_60,   PS3AV_MODE_720P60  },
> +	{ PS3AV_RESBIT_1280x720P  << SHIFT_50,   PS3AV_MODE_720P50  },
> +	{ PS3AV_RESBIT_720x480P   << SHIFT_60,   PS3AV_MODE_480P    },
> +	{ PS3AV_RESBIT_720x576P   << SHIFT_50,   PS3AV_MODE_576P    },

Why did you remove the C99 style initialisers?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__27_Nov_2007_11_05_38_+1100_2OITvKt3g7Xo4vQc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHS19WTgG2atn1QN8RAhxjAJwO8pMQu5fv7MzhHK+grvUvE3S7FACfUQMh
H/2Vj3Wuoo0daPBQ+TH9kxc=
=GFUR
-----END PGP SIGNATURE-----

--Signature=_Tue__27_Nov_2007_11_05_38_+1100_2OITvKt3g7Xo4vQc--


--===============1878853972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1878853972==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1878853972==--
