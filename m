From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 05 Jan 2011 20:37:41 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <AANLkTimW0xQ1F1d-_=jP_QKyQH=Yy6FZUbGD0Cm4JaBO@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294072336.17576.7.camel@lithium>
	<20110103.105827.112602895.davem@davemloft.net>
In-Reply-To: <20110103.105827.112602895.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: David Miller <davem@davemloft.net>
Cc: alex.buell@munted.org.uk, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 3, 2011 at 19:58, David Miller <davem@davemloft.net> wrote:
> From: Alex Buell <alex.buell@munted.org.uk>
> Date: Mon, 03 Jan 2011 16:32:16 +0000
>
>> I'm aware the s3fb driver has big endian issues, I can help fix those
>> issues so I can get the card working. Or in other words, I'd welcome
>> advice on how to proceed with this.
>
> It's not endian issues, this driver has other problems.
>
> It uses the VGA register accessors with a NULL regbase, which is not
> going to work on sparc64.
>
> It needs to access the VGA register space relative to the I/O space
> of the PCI controller domain it is behind.
>
> Probably if you replace the NULL values passes to vga_r*() and
> vga_w*() with the I/O space resource base of the chip (should be
> resource "1") it might work.

Probably s3fb also relies on a card having been initialized by the VGA BIOS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
