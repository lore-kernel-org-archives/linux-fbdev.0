From: Luc Verhaegen <libv@skynet.be>
Date: Wed, 13 Aug 2014 09:45:24 +0000
Subject: Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <20140813094524.GC31326@skynet.be>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
 <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
In-Reply-To: <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 10:23:14AM +0100, Grant Likely wrote:
> 
> The majority of the DT code is based on the assumption of a static
> tree. Pantelis has been working on being able to modify it at runtime
> with overlays, but he has had to go through a lot of rework because it
> is not a trivial task. When you get into modifying the DT, you need to
> have a lot more understanding of the side effects to changing the
> tree. The DT structure also has a lifecycle that can go beyond the
> current lifecycle of the kernel. The kexec tool will extract the
> current tree from the kernel, make the appropriate modifications, and
> use that to boot the next kernel. Allowing any driver to modify the
> tree has side effects beyond just the current kernel.
> 
> In this specific case, it will interact badly with the work Pantelis
> is doing to make platform devices work with overlays. Modifying the
> status property will cause the associated struct device to get removed
> in the middle of probing a driver for that device! That will most
> likely cause an oops.
> 
> Besides, Luc straight out *said*: "...even though it has no real value
> today". In what circumstance is that justification for modifying the
> tree?

With that sentence i meant that given the current state of things, it 
has no real value.

It has no value currently as re-probing simplefb is not going to happen. 
But it's not a big leap to turn simplefb into a proper module. Not that 
that makes much sense, but that's never stopped anyone.

To me it seemed simple, dt is what drives simplefb, so dt then also 
becomes responsible for making sure that simplefb or another driver does 
not attempt to blindly use this info again. The way this is implemented 
i do not care for in any way, i just knew that i could not do nothing 
here, given the catastrophic effect disabling the clocks has on simplefb 
on sunxi. Given the discussion that errupted here, i'd say that this 
does need some resolution, and altering the dt is going to have to be 
part of the solution.

In any case, i will gladly drop this patch, as it is not absolutely 
necessary. But it should be very clear that there is no going back on 
this dt node after the clocks were released once.

Luc Verhaegen.
