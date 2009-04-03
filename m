From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] fbdev: move logo externs to header file
Date: Fri, 3 Apr 2009 15:38:37 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0904031537250.32353@vixen.sonytel.be>
References: <alpine.LRH.2.00.0904031157550.32353@vixen.sonytel.be> <20090403123143.GA15598@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764291AbZDCNiv@vger.kernel.org>
In-Reply-To: <20090403123143.GA15598@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="ks_c_5601-1987"
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Krzysztof Helt <krzysztof.h1@wp.pl>, Andrew Morton <akpm@linux-foundation.org>, James Simmons <jsimmons@infradead.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, 3 Apr 2009, Sam Ravnborg wrote:
> On Fri, Apr 03, 2009 at 01:45:40PM +0200, Geert Uytterhoeven wrote:
> > Now we have __initconst, we can finally move the external declarati=
ons for the
> > various Linux logo structures to <linux/linux_logo.h>.
> >=20
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > Acked-By: James Simmons <jsimmons@infradead.org>
> > ---
> > James' ack dates back to the previous submission (way to long ago),=
 when the
> > logos were still __initdata, which caused failures on some platform=
s with some
> > toolchain versions.
> >=20
> > Note: you have to remove the generated logos, as they're not automa=
tically
> > regenerated if scripts/pnmtologo.c changes.
>=20
> Something like this to fix that bug?

Yep, after s/pnmtlogo/pnmtologo/g
(it cannot work as-is, as there's one place where you did spell `pnmtol=
ogo'
 correctly ;-)

Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

> Untested as I'm busy atm.
>=20
> 	Sam
>=20
> diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefil=
e
> index b91251d..6a26982 100644
> --- a/drivers/video/logo/Makefile
> +++ b/drivers/video/logo/Makefile
> @@ -37,22 +37,24 @@ extra-y +=3D $(call logo-cfiles,_clut224,ppm)
>  # Gray 256
>  extra-y +=3D $(call logo-cfiles,_gray256,pgm)
> =20
> +pnmtlogo :=3D scripts/pnmtologo
> +
>  # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
>  quiet_cmd_logo =3D LOGO    $@
> -	cmd_logo =3D scripts/pnmtologo \
> +	cmd_logo =3D $(pnmtologo) \
>  			-t $(patsubst $*_%,%,$(notdir $(basename $<))) \
>  			-n $(notdir $(basename $<)) -o $@ $<
> =20
> -$(obj)/%_mono.c: $(src)/%_mono.pbm FORCE
> +$(obj)/%_mono.c: $(src)/%_mono.pbm $(pnmtlogo) FORCE
>  	$(call if_changed,logo)
> =20
> -$(obj)/%_vga16.c: $(src)/%_vga16.ppm FORCE
> +$(obj)/%_vga16.c: $(src)/%_vga16.ppm $(pnmtlogo) FORCE
>  	$(call if_changed,logo)
> =20
> -$(obj)/%_clut224.c: $(src)/%_clut224.ppm FORCE
> +$(obj)/%_clut224.c: $(src)/%_clut224.ppm $(pnmtlogo) FORCE
>  	$(call if_changed,logo)
> =20
> -$(obj)/%_gray256.c: $(src)/%_gray256.pgm FORCE
> +$(obj)/%_gray256.c: $(src)/%_gray256.pgm $(pnmtlogo) FORCE
>  	$(call if_changed,logo)
> =20
>  # Files generated that shall be removed upon make clean

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
