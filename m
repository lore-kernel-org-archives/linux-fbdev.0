From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 19 Apr 2015 19:29:19 +0000
Subject: Re: Question abouf FB actual size
Message-Id: <CAMuHMdWD3gEpnQsoP-XhO4o88J4m=qRDYe1DiZpcjnvTTZoL-Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAFAVkqVPVG_h+Kwq-KjdivMWh+2WthJdJvQqRcf1m-qjHTpX1A@mail.gmail.com>
In-Reply-To: <CAFAVkqVPVG_h+Kwq-KjdivMWh+2WthJdJvQqRcf1m-qjHTpX1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Sun, Apr 19, 2015 at 7:39 PM, Paolo Niccol=C3=B2 Giubelli
<paoloniccolo.giubelli@gmail.com> wrote:
> There's something wrong with the math, because i have a 1366x768x32
> FB, but my finfo.line_length (finfo is obtained via
> FBIOGET_FSCREENINFO) is 5504 bytes. Well, 5504/4 (4 is 4 bytes per
> pixel) is 1376 that is 10 pixels more than 1366.

1366 * 4 is not a multiple of 64. 5504 is.
I guess your hardware requires each line to start at an address which is a
multiple of 64.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
