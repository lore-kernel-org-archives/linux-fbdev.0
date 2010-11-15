From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Nov 2010 18:24:00 +0000
Subject: Re: [PATCH 02/10] MCDE: Add configuration registers
Message-Id: <AANLkTimXBf0Qii2H7ewar+x2shFifhxcwXosekiV1hiz@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<201011121614.51528.arnd@arndb.de>
	<20101112153423.GC3619@n2100.arm.linux.org.uk>
	<201011151525.54380.arnd@arndb.de>
	<20101115145918.GD24194@n2100.arm.linux.org.uk>
In-Reply-To: <20101115145918.GD24194@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Nov 15, 2010 at 15:59, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 15, 2010 at 03:25:54PM +0100, Arnd Bergmann wrote:
>> On Friday 12 November 2010, Russell King - ARM Linux wrote:
>> > It is a bad idea to describe device registers using C structures, and
>> > especially enums.
>> >
>> > The only thing C guarantees about structure layout is that the elements
>> > are arranged in the same order which you specify them in your definition.
>> > It doesn't make any guarantees about placement of those elements within
>> > the structure.
>>
>> Right, I got carried away when seeing the macro overload. My example
>> would work on a given architecture since the ABI is not changing, but
>> we should of course not advocate nonportable code.
>
> That is a mistake.  You can't rely on architectures not changing their
> ABIs.  See ARM as an example where an ABI change has already happened.
>
> We actually have two ABIs at present - one ('native ARM') where enums
> are sized according to the size of their values, and the Linux one
> where we guarantee that enums are always 'int'.

JFYI, on ppc64 there are 64-bit enum values, which sparse complains about.
But gcc handles them fine.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
