From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Jan 2014 15:05:08 +0000
Subject: Re: [PATCH] video: vgacon: Don't build on arm64
Message-Id: <CAMuHMdVjb9GQ_UE2Y1+vqgQK+SM8ExBgR5X3xVPSAaoevrbGmA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387323421-26126-1-git-send-email-broonie@kernel.org>
In-Reply-To: <1387323421-26126-1-git-send-email-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jan 8, 2014 at 3:48 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 08 January 2014, Geert Uytterhoeven wrote:
>> VGA is special, in that it uses "ISA memory space". This is not a subset of
>> "PCI memory space", but something different. Some PCI host bridges
>> (IIRC, e.g. on Mac) do not allow access to this space.
>> Most other "PC I/O" use ISA I/O space, which is a subset of PCI I/O space.
>
> Right, but they often go together, and I think vgacon actually requires
> both, doesn't it? I'm not aware of anything else requiring access to the

Yes, VGA uses both.

> 0xa0000-0xfffff or the 0xf00000-0xffffff ISA memory windows except VGA,
> but I could be missing some less common devices. These are often not
> available on non-x86 systems, which prevents VGA from working even if
> low I/O space addresses are routed to PCI.

And MDA, for mdacon.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
