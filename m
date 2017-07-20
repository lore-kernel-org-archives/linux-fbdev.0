From: Dave Airlie <airlied@gmail.com>
Date: Thu, 20 Jul 2017 04:07:57 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CAPM=9tx0CytpjmYy2r1fdiG-KcZUXmxVQKWDAfiLcAfE=ZT7dQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
 <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
 <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
 <CA+55aFyU3QrFeq4Lr9tgxR+6D9-eXZFZTzfqHdozHS72qE5q1w@mail.gmail.com>
 <CAPM=9twzgAJir3b+3UAxOfuTtOBTp2bUtoCcTawmHcEbcVAEew@mail.gmail.com>
 <CAPM=9twsWFjFcgjP6S4wt7-t9-wYP_gBH1zt6kL-CF4Tr7t2dg@mail.gmail.com>
 <CAPM=9tyE88nz92e252vqgoqAK+OUut3EZKzTu9L8nwLE_hLQkQ@mail.gmail.com> <CA+55aFz7+_DsGRk1weqBNcX6GavK6rUUMSk5oaSbt4yp=EGt=Q@mail.gmail.com>
In-Reply-To: <CA+55aFz7+_DsGRk1weqBNcX6GavK6rUUMSk5oaSbt4yp=EGt=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>

On 19 July 2017 at 11:15, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Jul 18, 2017 at 5:00 PM, Dave Airlie <airlied@gmail.com> wrote:
>>
>> More digging:
>> Single CPU system:
>> Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz
>> 01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200EH
>>
>> Now I can't get efifb to load on this (due to it being remote and I've
>> no idea how to make
>> my install efi onto it), but booting with no framebuffer, and running
>> the tests on the mga,
>> show no slowdown on this.
>
> Is it actually using write-combining memory without a frame buffer,
> though? I don't think it is. So the lack of slowdown might be just
> from that.
>
>> Now I'm starting to wonder if it's something that only happens on
>> multi-socket systems.
>
> Hmm. I guess that's possible, of course.
>
> [ Wild and crazy handwaving... ]
>
> Without write combining, all the uncached writes will be fully
> serialized and there is no buffering in the chip write buffers. There
> will be at most one outstanding PCI transaction in the uncore write
> buffer.
>
> In contrast, _with_ write combining, the write buffers in the uncore
> can fill up.
>
> But why should that matter? Maybe memory ordering. When one of the
> cores (doesn't matter *which* core) wants to get a cacheline for
> exclusive use (ie it did a write to it), it will need to invalidate
> cachelines in other cores. However, the uncore now has all those PCI
> writes buffered, and the write ordering says that they should happen
> before the memory writes. So before it can give the core exclusive
> ownership of the new cacheline, it needs to wait for all those
> buffered writes to be pushed out, so that no other CPU can see the new
> write *before* the device saw the old writes.
>
> But I'm not convinced this is any different in a multi-socket
> situation than it is in a single-socket one. The other cores on the
> same socket should not be able to see the writes out of order
> _either_.
>
> And honestly, I think PCI write posting rules makes the above crazy
> handwaving completely bogus anyway. Writes _can_ be posted, so the
> memory ordering isn't actually that tight.
>
> I dunno. I really think it would be good if somebody inside Intel
> would look at it..

Yes hoping someone can give some insight.

Scrap the multi-socket it's been seen on a single-socket, but not as
drastic, 2x rather than 10x slowdowns.

It's starting to seem like the commonality might be the Matrox G200EH
which is part of the HP remote management iLO hardware, it might be that
the RAM on the other side of the PCIE connection is causing some sort of
wierd stalls or slowdowns. I'm not sure how best to validate that either.

Dave.
