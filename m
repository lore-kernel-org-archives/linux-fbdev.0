From: krzysztof.h1@poczta.fm
Subject: =?UTF-8?q?Re:_[Linux-fbdev-devel]_[PATCH]_cyblafb:_fix_color_component_length_for_pseudocolor_modes?=
Date: 31 Mar 2009 09:25:17 +0200
Message-ID: <20090331072517.DC8B37DC90D@f20.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756235AbZCaHZn@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="iso-8859-1"
To: Michal Januszewski <spock@gentoo.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Knut_Petersen@t-online.de

Michal Januszewski napisa=B3(a):
> cyblafb incorrectly sets the length of the color fields to 6 bits
> for PSEUDOCOLOR modes, even though 8 bits are always used per pixel.
> Fix this by setting the length to 8.
>=20
> Signed-off-by: Michal Januszewski >spock@gentoo.org>
> Cc: Knut Petersen >Knut_Petersen@t-online.de>
> ---
> diff --git a/drivers/video/cyblafb.c b/drivers/video/cyblafb.c
> index 9704b73..8e3a264 100644
> --- a/drivers/video/cyblafb.c
> +++ b/drivers/video/cyblafb.c
> @@ -615,9 +615,9 @@ static int cyblafb_check_var(struct fb_var_screen=
info
> *var,
>  		var->red.offset =3D 0;
>  		var->green.offset =3D 0;
>  		var->blue.offset =3D 0;
> -		var->red.length =3D 6;
> -		var->green.length =3D 6;
> -		var->blue.length =3D 6;
> +		var->red.length =3D 8;
> +		var->green.length =3D 8;
> +		var->blue.length =3D 8;
>  		break;
>  	case 16:
>  		var->red.offset =3D 11;
>=20
> ---------------------------------------------------------------------=
---------
>=20

This driver is already removed in the -mm tree (remove-cyblafb-driver.p=
atch).

Regards,
Krzysztof

----------------------------------------------------------------------
Wybierz i wygraj wielkanocna nagrod=EA!
Sprawdz >>> http://link.interia.pl/f20e8
