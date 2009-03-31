From: krzysztof.h1@poczta.fm
Subject: =?UTF-8?q?Re:_[Linux-fbdev-devel]_[PATCH]_cirrusfb:_fix_color_component_length_for_pseudocolor_modes?=
Date: 31 Mar 2009 09:23:51 +0200
Message-ID: <20090331072351.5028D7DC90B@f20.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755429AbZCaHYe@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="iso-8859-1"
To: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Michal Januszewski napisa=B3(a):
> cirrusfb incorrectly sets the length of the color fields to 6 bits
> for PSEUDOCOLOR modes, even though 8 bits are always used per pixel.
> Fix this by setting the length to 8.
>=20
> Signed-off-by: Michal Januszewski >spock@gentoo.org>
> ---
> diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
> index a2aa6dd..2dfe0e7 100644
> --- a/drivers/video/cirrusfb.c
> +++ b/drivers/video/cirrusfb.c
> @@ -550,7 +550,7 @@ static int cirrusfb_check_var(struct fb_var_scree=
ninfo
> *var,
> =20
>  	case 8:
>  		var->red.offset =3D 0;
> -		var->red.length =3D 6;
> +		var->red.length =3D 8;
>  		var->green =3D var->red;
>  		var->blue =3D var->red;
>  		break;
>=20

This is already fixed in the -mm tree (cirrusfb-check_var-improvements.=
patch).

Regards,
Krzysztof

----------------------------------------------------------------------
Widziales zajaca? Zgubil nagrody!
Sprawdz >>> http://link.interia.pl/f20e9
