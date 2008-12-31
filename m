From: "Dave Hylands" <dhylands@gmail.com>
Subject: Re: [RFC 2.6.28 1/1] gpiolib: add set/get batch v3
Date: Wed, 31 Dec 2008 07:22:08 -0800
Message-ID: <c32efac40812310722x238c8348j5f4ed48ae87c4704@mail.gmail.com>
References: <12307156721518-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756524AbYLaPWW@vger.kernel.org>
In-Reply-To: <12307156721518-git-send-email-jayakumar.lkml@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <eric.miao@marvell.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Geert Uytterhoeven <geert@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>, Russell King <rmk@arm.linux.org.uk>, Ben Gardner <bgardner@wabtec.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi Jaya,

...snip...
> There was a question about why have both bitmask AND width when width
> could be worked out from bitmask. The reason for having both bitmask and
> length is for performance. Let's compare the following two scenarios:
>
> /* flash to black */
> for (i=0; i < 800*600; i++)
>        gpio_set_batch(DB0, 0x00000000, 0x0000FFFF)
>
> Internally, the above implementation has to work out the length of bits
> that are being set in bitmask in order to figure out which register
> boundaries are being crossed. That means looping through the bitmask
> and counting bits. That would need to be repeated for every call of
> gpio_set_batch in the above loop and would be a relatively high expense.
>
> /* flash to black */
> for (i=0; i < 800*600; i++)
>        gpio_set_batch(DB0, 0x00000000, 0x0000FFFF, 16)
>
> In the 2nd case, the implementation is able to skip all the bit counting.
> This usage method is also the intuitive way for drivers that are trying
> to push data across a gpio bus since they explicitly know the bus length.
...snip...

I haven't been following too closely, but what about

        gpio_set_batch(DB0, 0x00000000, 0x00FF00FF, 16)

That also has 16 bits set, but in different positions.

Shouldn't you just not bother with the length and optimize particular
bitmasks (i.e. 0xFF, 0xFFFF, 0xFFFFFF, 0xFFFFFFFF)?

-- 
Dave Hylands
Shuswap, BC, Canada
http://www.DaveHylands.com/
