From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jan 2011 20:39:39 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <20110103.123939.02282416.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1294083541.17576.11.camel@lithium>
	<20110103.114301.102556157.davem@davemloft.net>
	<1294086801.17576.14.camel@lithium>
In-Reply-To: <1294086801.17576.14.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex.buell@munted.org.uk
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Mon, 03 Jan 2011 20:33:21 +0000

> On Mon, 2011-01-03 at 11:43 -0800, David Miller wrote:
>> From: Alex Buell <alex.buell@munted.org.uk>
>> Date: Mon, 03 Jan 2011 19:39:01 +0000
>> 
>> > Secondly, is Linux fully capable of handling different graphic cards
>> > simultaneously? For example, plug in a pair of monitors and have
>> > consoles on both with disparate graphic cards i.e. XVR-500 and S3ViRGE
>> > etc? 
>> 
>> Technically I don't think it can do it currently.  Maybe just for
>> kernel message logging, but not for actual login consoles.
>> 
>> One TTY device is marked as the "console" and that's where all
>> tty[0-9]+ devices get instantiated upon.
> 
> Hmm, maybe it would be nice to introduce that capability. How doable
> would it be? I understand the BKL is going away, perhaps it would now be
> easier to introduce such a facility?

It has nothing to do with the big kernel lock.

> I've just started digging into the innards of the s3fb driver, my first
> attempt provoked this, simply by commenting out the check to see if it's
> not the primary device and exits with -ENODEV: 
> 
> Jan  3 20:16:29 sodium kernel: ERROR(1): Cheetah error trap taken
> afsr[0030100000000000] afar[00000000000003d0] TL1(0)
> Jan  3 20:16:29 sodium kernel: ERROR(1): TPC[105918d8] TNPC[105918dc]
> O7[10591884] TSTATE[4411001606]
> Jan  3 20:16:29 sodium kernel: ERROR(1): TPC<s3_pci_probe+0x194/0x63c
> [s3fb]>
> Jan  3 20:16:29 sodium kernel: ERROR(1): M_SYND(0),  E_SYND(0), Multiple
> Errors, Privileged

I know, this is what happens if you call vga_*() with a NULL first parameter
on sparc64.  It's accessing garbage addresses.
