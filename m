From: Henrik =?ISO-8859-1?Q?Nordstr=F6m?= <henrik@henriknordstrom.net>
Date: Fri, 15 Aug 2014 00:45:12 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <1408063512.890.22.camel@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
 <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
 <20140813094524.GC31326@skynet.be> <20140813101923.GD31326@skynet.be>
 <CAKON4OwLOAq1EOzZmuefcnZ4hw0i35e3k0F6XGNRy-5jer2vyA@mail.gmail.com>
 <CACxGe6szX3LyhGHbVHrEFfaWGYUcgcxgkuhfc9ac-R0qJs-HXw@mail.gmail.com>
 <CAKON4OzQbuaQsbTCDXuaqxLRxvat_5+wmf71S-rWXdfiT1gkvA@mail.gmail.com>
 <CACxGe6v1UPHMF5aPpe-boh+RuoPArJmKK_cQWr7aXsRjDUZrfQ@mail.gmail.com>
 <CAKON4OypgToTSXxjShCt6uTGZBU69LpJxRwVoz=PnotpL=zm4w@mail.gmail.com>
In-Reply-To: <CAKON4OypgToTSXxjShCt6uTGZBU69LpJxRwVoz=PnotpL=zm4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

tor 2014-08-14 klockan 08:07 -0400 skrev jonsmirl@gmail.com:

> So what are the rules going to be? Once the OS is up and starts
> changing things the state in the DT and the OS are going to diverge.
> How does this get handled for a kernel driver that can load/unload?
> Should the kernel remove those state nodes as soon as it alters the
> state?

hardware that is no longer there should also not be represented/active
in DT.

A simple fb that have been torn down is no more, no different from never
having been there. It can be argued that it never was in the first place
(i.e. that it is not actually hardware) but that it another can of worms
and both have their benefits and drawbacks. One thing is certain
however, as far as simplefb is concerned it is hardware, not really any
different from a persistent framebuffer with hardwired settings in
hardware.

Regarding kexec, it's the responsibility of the kernel doing kexec to
make sure DT and hardware matches for the next started kernel. With
hardware that can be reconfigured it is not safe to assume that the DT
can be passed as-is from before the kernel reconfigured hardware. If the
currently running kernel wants to set up a framebuffer for simplefb use
by the next kernel than it's free to do so, but in either case it needs
to provide the right information to next kernel.

If it was given a simplefb node, but then killed the simplefb then no
simplefb node should be provided to the next kernel. If it was not given
a simplefb node, but have configured the hardware suitable for simplefb
node then it may provide a simplefb node.

A UART that have changed rate no longer have that rate.

Same applies to numerous other items as well. If a kernel remaps IRQs,
bus addresses, or whatever in hardware aspects where such changes is
possible then DT needs to be updated as well. A bit less common than a
simplefb being destroyed by driver reconfiguring the framebuffer, but if
you look at it from a little distance then the problem is exactly the
same. Hardware is not 100% static, and therefore hardware description
also can not be 100% static. And hardware is getting more and more
dynamically reconfigurable.

A DT that contains false information is generally worse than no DT / not
having that information at all.

Regards
Henrik

