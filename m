From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2015 19:44:18 +0000
Subject: Re: fbcon gives mirrored fonts on monochrome display
Message-Id: <CAMuHMdVEGF53VrObL0SBoqtJZJZDSwH2o=KbH1rqeVJZnsuuwA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <54C145B8.6080204@tronnes.org>
In-Reply-To: <54C145B8.6080204@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Noralf,

On Thu, Jan 22, 2015 at 7:47 PM, Noralf Tr=C3=B8nnes <notro@tronnes.org> wr=
ote:
> I'm playing with a SSD1306 128x64 monochrome display and fbcon gives me
> mirrored fonts and some extra lines.

> fbdev config:
>   info->var.bits_per_pixel =3D 1;
>   info->fix.visual =3D FB_VISUAL_MONO10;
>   info->var.red.length =3D 1;
>   info->var.red.offset =3D 0;
>   info->var.green.length =3D 1;
>   info->var.green.offset =3D 0;
>   info->var.blue.length =3D 1;
>   info->var.blue.offset =3D 0;
> Uses: sys_fillrect, sys_copyarea, sys_imageblit (and deferred_io)
>
> System: Raspberry Pi, ARM, Linux 3.18.3
>
> Does anyone see what this might be?

What's the value on CONFIG_FB_CFB_REV_PIXELS_IN_BYTE in your .config?
Does your driver set FB_NONSTD_REV_PIX_IN_B?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
