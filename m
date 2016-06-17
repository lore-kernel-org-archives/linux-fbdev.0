From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Jun 2016 07:11:42 +0000
Subject: Re: [powerpc] offb: red / blue color inversion
Message-Id: <CAMuHMdWWMW08o9xGBJmZ0ry9Vuatavk47qz5iwV=X4=oX6Q=FA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+7wUsw+LHgCz6SDHxrbPiwrpN53WB7+KxaAgnVYdwrp4OyVQQ@mail.gmail.com>
In-Reply-To: <CA+7wUsw+LHgCz6SDHxrbPiwrpN53WB7+KxaAgnVYdwrp4OyVQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Mathieu,

On Thu, Jun 9, 2016 at 2:25 PM, Mathieu Malaterre <malat@debian.org> wrote:
> I am trying to fix an issue with color inversion in the current offb.c
> implementation. I am using a Mac Mini G4 (PPC) with:
>
> [    0.844144] fb0: Open Firmware frame buffer device on
> /pci@f0000000/ATY,RockHopper2Parent@10/ATY,RockHopper2_A@0
>
> reported as [*]. I have tried looking at the upstream code source, and
> it appears that my configuration falls into the 'cmap_simple'. But
> other than that I failed to understand what could be wrong (palette
> would be setup backward).

The palette code for cmap_simple writes the color components in the
order RGB, while your card seems to need BGR.

Hence either the cmap_addr/cmap_data registers are wrong, or
you have to add a cmap_inverted type that writes in the BGR order.

For both cases, you have to add a check to offb_init_palette_hacks() in
drivers/video/fbdev/offb.c.

> What are the low level tool (user-space) I can use to try to
> understand what is wrong with offb on my machine without rebuilding
> the kernel (CONFIG_FB_OF is not a module) ?

I'm afraid you can't do much from userspace.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
