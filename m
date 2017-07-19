From: Dave Airlie <airlied@gmail.com>
Date: Wed, 19 Jul 2017 00:00:51 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CAPM=9tyE88nz92e252vqgoqAK+OUut3EZKzTu9L8nwLE_hLQkQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
 <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
 <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
 <CA+55aFyU3QrFeq4Lr9tgxR+6D9-eXZFZTzfqHdozHS72qE5q1w@mail.gmail.com>
 <CAPM=9twzgAJir3b+3UAxOfuTtOBTp2bUtoCcTawmHcEbcVAEew@mail.gmail.com> <CAPM=9twsWFjFcgjP6S4wt7-t9-wYP_gBH1zt6kL-CF4Tr7t2dg@mail.gmail.com>
In-Reply-To: <CAPM=9twsWFjFcgjP6S4wt7-t9-wYP_gBH1zt6kL-CF4Tr7t2dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>

On 19 July 2017 at 09:16, Dave Airlie <airlied@gmail.com> wrote:
> On 19 July 2017 at 09:16, Dave Airlie <airlied@gmail.com> wrote:
>> On 19 July 2017 at 08:22, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> On Tue, Jul 18, 2017 at 2:21 PM, Dave Airlie <airlied@gmail.com> wrote:
>>>>
>>>> Oh and just FYI, the machine I've tested this on has an mgag200 server
>>>> graphics card backing the framebuffer, but with just efifb loaded.
>>>
>>> Yeah, it looks like it needs special hardware - and particularly the
>>> kind of garbage hardware that people only have on servers.
>>>
>>> Why do server people continually do absolute sh*t hardware? It's crap,
>>> crap, crap across the board outside the CPU. Nasty and bad hacky stuff
>>> that nobody else would touch with a ten-foot pole, and the "serious
>>> enterprise" people lap it up like it was ambrosia.
>>>
>>> It's not just "graphics is bad anyway since we don't care". It's all
>>> the things they ostensibly _do_ care about too, like the disk and the
>>> fabric infrastructure. Buggy nasty crud.
>>
>> I've tried to reproduce now on:
>> Intel(R) Core(TM) i7-6820HQ CPU @ 2.70GHz
>> using some address space from
>> 02:00.0 3D controller: NVIDIA Corporation GM108M [GeForce 940MX] (rev a2)
>>
>> And I don't see the issue.
>>
>> I'll try and track down some more efi compatible mga or other wierd server chips
>> stuff if I can.
>>
>>> Anyway, rant over. I wonder if we could show this without special
>>> hardware by just mapping some region that doesn't even have hardware
>>> in it as WC. Do we even expose the PAT settings to user space, though,
>>> or do we always have to have some fake module to create the PAT stuff?
>>
>> I do wonder wtf the hw could be doing that would cause this, but I've no idea
>> how to tell what difference a write combined PCI transaction would have on the
>> bus side of things, and what the device could generate that would cause such
>> a horrible slowdown.
>>
>> Dave.
>

More digging:
Single CPU system:
Intel(R) Xeon(R) CPU E5-2620 v2 @ 2.10GHz
01:00.1 VGA compatible controller: Matrox Electronics Systems Ltd. MGA G200EH

Now I can't get efifb to load on this (due to it being remote and I've
no idea how to make
my install efi onto it), but booting with no framebuffer, and running
the tests on the mga,
show no slowdown on this.

Now I'm starting to wonder if it's something that only happens on
multi-socket systems.

Dave.
