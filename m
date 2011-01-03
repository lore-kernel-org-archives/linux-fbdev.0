From: Dave Airlie <airlied@gmail.com>
Date: Mon, 03 Jan 2011 20:37:15 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <AANLkTi=trysd5MJR2mtp-89jJiKQ+nhrGVBrwk_Q+2R8@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294072336.17576.7.camel@lithium>
	<20110103.105827.112602895.davem@davemloft.net>
	<1294083541.17576.11.camel@lithium>
In-Reply-To: <1294083541.17576.11.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex.buell@munted.org.uk
Cc: David Miller <davem@davemloft.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 4, 2011 at 5:39 AM, Alex Buell <alex.buell@munted.org.uk> wrote:
> On Mon, 2011-01-03 at 10:58 -0800, David Miller wrote:
>> From: Alex Buell <alex.buell@munted.org.uk>
>> Date: Mon, 03 Jan 2011 16:32:16 +0000
>>
>> > I'm aware the s3fb driver has big endian issues, I can help fix those
>> > issues so I can get the card working. Or in other words, I'd welcome
>> > advice on how to proceed with this.
>>
>> It's not endian issues, this driver has other problems.
>>
>> It uses the VGA register accessors with a NULL regbase, which is not
>> going to work on sparc64.
>>
>> It needs to access the VGA register space relative to the I/O space
>> of the PCI controller domain it is behind.
>>
>> Probably if you replace the NULL values passes to vga_r*() and
>> vga_w*() with the I/O space resource base of the chip (should be
>> resource "1") it might work.
>
> I've had a look at linux/include/video/vga.h, and yes I see what you
> mean now.
>
> Secondly, is Linux fully capable of handling different graphic cards
> simultaneously? For example, plug in a pair of monitors and have
> consoles on both with disparate graphic cards i.e. XVR-500 and S3ViRGE
> etc?

Not currently, since you would also need some way to sanely route input.

You can put different VTs on different consoles but thats about it.

Dave.
