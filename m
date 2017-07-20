From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 20 Jul 2017 10:20:22 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <20170720102022.cwbqlf62nc3eal3f@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com>
 <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
 <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
 <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
 <CA+55aFyU3QrFeq4Lr9tgxR+6D9-eXZFZTzfqHdozHS72qE5q1w@mail.gmail.com>
In-Reply-To: <CA+55aFyU3QrFeq4Lr9tgxR+6D9-eXZFZTzfqHdozHS72qE5q1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jul 18, 2017 at 2:21 PM, Dave Airlie <airlied@gmail.com> wrote:
> >
> > Oh and just FYI, the machine I've tested this on has an mgag200 server
> > graphics card backing the framebuffer, but with just efifb loaded.
> 
> Yeah, it looks like it needs special hardware - and particularly the
> kind of garbage hardware that people only have on servers.
> 
> Why do server people continually do absolute sh*t hardware? It's crap,
> crap, crap across the board outside the CPU. Nasty and bad hacky stuff
> that nobody else would touch with a ten-foot pole, and the "serious
> enterprise" people lap it up like it was ambrosia.
> 
> It's not just "graphics is bad anyway since we don't care". It's all
> the things they ostensibly _do_ care about too, like the disk and the
> fabric infrastructure. Buggy nasty crud.

I believe it's crappy for similar reasons why almost all other large scale pieces 
of human technological infrastructure are crappy if you look deep under the hood: 
transportation and communication networks, banking systems, manufacturing, you 
name it.

The main reasons are:

 - Cost of a clean redesign is an order of magnitude higher that the next delta 
   revision, once you have accumulated a few decades of legacy.

 - The path dependent evolutionary legacies become so ugly after time that most
   good people will run away from key elements - so there's not enough internal 
   energy to redesign and implement a clean methodology from grounds up.

 - Even if there are enough good people, the benefits of a clean design are a long
   term benefit, constantly hindered by short term pricing.

 - For non-experts it's hard to tell a good, clean redesign from a flashy but
   fundamentally flawed redesign. Both are expensive and the latter can have 
   disastrous outcomes.

 - These are high margin businesses, with customers captured by legacies, where
   you can pass down the costs to customers, which hides the true costs of crap.

i.e. typical free market failure due high complexity combined with (very) long 
price propagation latencies and opaqueness of pricing.

I believe the only place where you'll find overall beautiful server hardware as a 
rule and not as an exception is in satellite technology: when the unit price is in 
excess of $100m, expected life span is 10-20 years with no on-site maintenance, 
and it's all running in a fundamentally hostile environment, then clean and robust 
hardware design is forced at every step by physics.

Humanity is certainly able to design beautiful hardware, once all other options 
are exhausted.

Thanks,

	Ingo
