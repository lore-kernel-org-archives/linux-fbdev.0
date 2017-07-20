From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 20 Jul 2017 04:28:27 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CALCETrWFe+qSC9r+waf3XH-9XcrtfRMtG3AL6ndgG4PQ4QdPHQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
 <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
 <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
 <CA+55aFyU3QrFeq4Lr9tgxR+6D9-eXZFZTzfqHdozHS72qE5q1w@mail.gmail.com>
 <CAPM=9twzgAJir3b+3UAxOfuTtOBTp2bUtoCcTawmHcEbcVAEew@mail.gmail.com>
 <CAPM=9twsWFjFcgjP6S4wt7-t9-wYP_gBH1zt6kL-CF4Tr7t2dg@mail.gmail.com>
 <CAPM=9tyE88nz92e252vqgoqAK+OUut3EZKzTu9L8nwLE_hLQkQ@mail.gmail.com>
 <CA+55aFz7+_DsGRk1weqBNcX6GavK6rUUMSk5oaSbt4yp=EGt=Q@mail.gmail.com> <CAPM=9tx0CytpjmYy2r1fdiG-KcZUXmxVQKWDAfiLcAfE=ZT7dQ@mail.gmail.com>
In-Reply-To: <CAPM=9tx0CytpjmYy2r1fdiG-KcZUXmxVQKWDAfiLcAfE=ZT7dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>

On Wed, Jul 19, 2017 at 9:07 PM, Dave Airlie <airlied@gmail.com> wrote:
>
> Yes hoping someone can give some insight.
>
> Scrap the multi-socket it's been seen on a single-socket, but not as
> drastic, 2x rather than 10x slowdowns.
>
> It's starting to seem like the commonality might be the Matrox G200EH
> which is part of the HP remote management iLO hardware, it might be that
> the RAM on the other side of the PCIE connection is causing some sort of
> wierd stalls or slowdowns. I'm not sure how best to validate that either.

It shouldn't be that hard to hack up efifb to allocate some actual RAM
as "framebuffer", unmap it from the direct map, and ioremap_wc() it as
usual.  Then you could see if PCIe is important for it.

WC streaming writes over PCIe end up doing 64 byte writes, right?
Maybe the Matrox chip is just extremely slow handling 64b writes.
