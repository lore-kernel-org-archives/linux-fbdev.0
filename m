From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 03 Jul 2015 09:13:55 +0000
Subject: Re: [PATCH 1/3] video/logo: use list of logos to find logo
Message-Id: <CAMuHMdXhh07qH+neBVqBtHEfkgSqNjmxTqZ47pi37h1CYk2cLQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435912696-17546-1-git-send-email-urs.fassler@bytesatwork.ch>
	<1435912696-17546-2-git-send-email-urs.fassler@bytesatwork.ch>
In-Reply-To: <1435912696-17546-2-git-send-email-urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, oliver.staebler@bytesatwork.ch, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Jul 3, 2015 at 10:38 AM, Urs F=C3=A4ssler <urs.fassler@bytesatwork.=
ch> wrote:
> -#ifdef CONFIG_LOGO_MAC_CLUT224
> -               /* Macintosh Linux logo on m68k */
> -               if (MACH_IS_MAC)
> -                       logo =3D &logo_mac_clut224;
> +#if defined(CONFIG_LOGO_MAC_CLUT224) && MACH_IS_MAC
> +       /* Macintosh Linux logo on m68k */
> +       &logo_mac_clut224,
>  #endif

That won't work, as depending on kernel configuration, MACH_IS_MAC
can be a run-time test, cfr.

arch/m68k/include/asm/setup.h:#  define MACH_IS_MAC (0)
arch/m68k/include/asm/setup.h:#  define MACH_IS_MAC (m68k_machtype =3D MACH=
_MAC)
arch/m68k/include/asm/setup.h:#  define MACH_IS_MAC (1)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
