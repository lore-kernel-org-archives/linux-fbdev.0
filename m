From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jul 2017 04:44:48 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CA+55aFxQAje18sTheaoszz0kQMZNUzQLVx=U8TfO2uyPDSaVmg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
 <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
 <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
 <CA+55aFyU3QrFeq4Lr9tgxR+6D9-eXZFZTzfqHdozHS72qE5q1w@mail.gmail.com>
 <CAPM=9twzgAJir3b+3UAxOfuTtOBTp2bUtoCcTawmHcEbcVAEew@mail.gmail.com>
 <CAPM=9twsWFjFcgjP6S4wt7-t9-wYP_gBH1zt6kL-CF4Tr7t2dg@mail.gmail.com>
 <CAPM=9tyE88nz92e252vqgoqAK+OUut3EZKzTu9L8nwLE_hLQkQ@mail.gmail.com>
 <CA+55aFz7+_DsGRk1weqBNcX6GavK6rUUMSk5oaSbt4yp=EGt=Q@mail.gmail.com>
 <CAPM=9tx0CytpjmYy2r1fdiG-KcZUXmxVQKWDAfiLcAfE=ZT7dQ@mail.gmail.com> <CALCETrWFe+qSC9r+waf3XH-9XcrtfRMtG3AL6ndgG4PQ4QdPHQ@mail.gmail.com>
In-Reply-To: <CALCETrWFe+qSC9r+waf3XH-9XcrtfRMtG3AL6ndgG4PQ4QdPHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Anvin <hpa@zytor.com>

On Wed, Jul 19, 2017 at 9:28 PM, Andy Lutomirski <luto@kernel.org> wrote:
>
> It shouldn't be that hard to hack up efifb to allocate some actual RAM
> as "framebuffer", unmap it from the direct map, and ioremap_wc() it as
> usual.  Then you could see if PCIe is important for it.

The thing is, the "actual RAM" case is unlikely to show this issue.

RAM is special, even when you try to mark it WC or whatever. Yes, it
might be slowed down by lack of caching, but the uncore still *knows*
it is RAM. The accesses go to the memory controller, not the PCI side.

> WC streaming writes over PCIe end up doing 64 byte writes, right?
> Maybe the Matrox chip is just extremely slow handling 64b writes.

.. or maybe there is some unholy "management logic" thing that catches
those writes, because this is server hardware, and server vendors
invariably add "value add" (read; shit) to their hardware to justify
the high price.

Like the Intel "management console" that was such a "security feature".

I think one of the points of those magic graphics cards is that you
can export the frame buffer over the management network, so that you
can still run the graphical Windows GUI management stuff. Because you
wouldn't want to just ssh into it and run command line stuff.

So I wouldn't be surprised at all if the thing has a special back
channel to the network chip with a queue of changes going over
ethernet or something, and then when you stream things at high speeds
to the GPU DRAM, you fill up the management bandwidth.

If it was actual framebuffer DRAM, I would expect it to be *happy*
with streaming 64-bit writes. But some special "management interface
ASIC" that tries to keep track of GPU framebuffer "damage" might be
something else altogether.

               Linus
