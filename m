From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2015 18:35:35 +0000
Subject: Re: Font generation
Message-Id: <CAMuHMdWzhUU=tXFJBdTiAOv-0QWwijk_on4Pw6RVE0rHkZcRxw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdUV1DYDpQOvEJ1K=dMxMpndMdBjXTALGA6U3ePmOAaE2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUV1DYDpQOvEJ1K=dMxMpndMdBjXTALGA6U3ePmOAaE2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Sagar,

> Thanks for the pointers, I tried xxd/convert/font2c but nothing worked out for me!
> In the fbtest how is the penguin_data[] and clut [] array populated ?

They're created from images/penguin.ppm using pnmtohex/pnmtohex.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
