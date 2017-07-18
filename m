From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Jul 2017 22:22:43 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CA+55aFyU3QrFeq4Lr9tgxR+6D9-eXZFZTzfqHdozHS72qE5q1w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
 <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com> <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
In-Reply-To: <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>

On Tue, Jul 18, 2017 at 2:21 PM, Dave Airlie <airlied@gmail.com> wrote:
>
> Oh and just FYI, the machine I've tested this on has an mgag200 server
> graphics card backing the framebuffer, but with just efifb loaded.

Yeah, it looks like it needs special hardware - and particularly the
kind of garbage hardware that people only have on servers.

Why do server people continually do absolute sh*t hardware? It's crap,
crap, crap across the board outside the CPU. Nasty and bad hacky stuff
that nobody else would touch with a ten-foot pole, and the "serious
enterprise" people lap it up like it was ambrosia.

It's not just "graphics is bad anyway since we don't care". It's all
the things they ostensibly _do_ care about too, like the disk and the
fabric infrastructure. Buggy nasty crud.

Anyway, rant over. I wonder if we could show this without special
hardware by just mapping some region that doesn't even have hardware
in it as WC. Do we even expose the PAT settings to user space, though,
or do we always have to have some fake module to create the PAT stuff?

               Linus
