From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 05 Aug 2013 21:14:05 +0000
Subject: Re: [PATCH] fbdev: suppress warning when assigning vga-save/restore base
Message-Id: <5200159D.1010106@zytor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375637141-2878-1-git-send-email-dh.herrmann@gmail.com> <51FE907A.2090201@zytor.com> <20130804.185146.1621476659301936865.davem@davemloft.net> <20130805202955.GH22789@localhost> <520012D4.7020701@zytor.com>
In-Reply-To: <520012D4.7020701@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zajicek <santiago@crfreenet.org>
Cc: David Miller <davem@davemloft.net>, dh.herrmann@gmail.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, Ondrej Zary <linux@rainbow-software.org>

On 08/05/2013 02:02 PM, H. Peter Anvin wrote:
> On 08/05/2013 01:29 PM, Ondrej Zajicek wrote:
>>
>> How this could even work? AFAIK these cards have to be explicitly programmed
>> to enable MMIO (which was not done in the patches). These patches claim that
>> it is for multi-domain PCI. I would guess that vgabase is NULL in common
>> configurations but if it is non-NULL, it probably wouldn't work, unless
>> there is some hardware magic that transparently converts MMIO (from CPU PoV)
>> to port IO (from card/PCI PoV).
>>
> 
> They presumably use iowrite/ioread, which use either I/O instructions or
> memory instructions depending on the address.
> 

So the confusion really is in the iowrite interface, which can take
either a physical port address or a virtual memory address...

	-hpa


