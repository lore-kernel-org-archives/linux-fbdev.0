From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jun 2011 12:09:25 +0000
Subject: Re: [PATCH] video: Add GRVGA framebuffer device driver
Message-Id: <BANLkTinDM_JYvXVY1UG+d_HBCj9xm98SUQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1308128180-14645-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1308128180-14645-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Wed, Jun 15, 2011 at 13:52, Kristoffer Glembo <kristoffer@gaisler.com> wrote:
> Geert Uytterhoeven wrote:
>> At first sight, nothing in this driver seems to be SPARC-specific, so
>> perhaps this can be relaxed
>> to e.g. depends on OF_DEVICE?
>
> It uses of_ioremap/unmap which are SPARC-specific. I have been bitten by things like this before
> when thinking I was portable so this time I just depended on SPARC. The core is not used on any
> other platforms and is not very likely to be used either.

Ah, your're right. I just thought all OF-capable platforms had of_ioremap().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
