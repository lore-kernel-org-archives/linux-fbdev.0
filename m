From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 18 Jul 2017 19:57:29 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
In-Reply-To: <20170718143404.omgxrujngj2rhiya@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>
Cc: Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>

On Tue, Jul 18, 2017 at 7:34 AM, Peter Jones <pjones@redhat.com> wrote:
>
> Well, that's kind of amazing, given 3c004b4f7eab239e switched us /to/
> using ioremap_wc() for the exact same reason.  I'm not against letting
> the user force one way or the other if it helps, though it sure would be
> nice to know why.

It's kind of amazing for another reason too: how is ioremap_wc()
_possibly_ slower than ioremap_nocache() (which is what plain
ioremap() is)?

The difference is literally _PAGE_CACHE_MODE_WC vs _PAGE_CACHE_MODE_UC_MINUS.

Both of them should be uncached, but WC should allow much better write
behavior. It should also allow much better system behavior.

This really sounds like a band-aid patch that just hides some other
issue entirely. Maybe we screw up the cache modes for some PAT mode
setup?

Or maybe it really is something where there is one global write queue
per die (not per CPU), and having that write queue "active" doing
combining will slow down every core due to some crazy synchronization
issue?

x86 people, look at what Dave Airlie did, I'll just repeat it because
it sounds so crazy:

> A customer noticed major slowdowns while logging to the console
> with write combining enabled, on other tasks running on the same
> CPU. (10x or greater slow down on all other cores on the same CPU
> as is doing the logging).
>
> I reproduced this on a machine with dual CPUs.
> Intel(R) Xeon(R) CPU E5-2609 v3 @ 1.90GHz (6 core)
>
> I wrote a test that just mmaps the pci bar and writes to it in
> a loop, while this was running in the background one a single
> core with (taskset -c 1), building a kernel up to init/version.o
> (taskset -c 8) went from 13s to 133s or so. I've yet to explain
> why this occurs or what is going wrong I haven't managed to find
> a perf command that in any way gives insight into this.

So basically the UC vs WC thing seems to slow down somebody *else* (in
this case a kernel compile) on another core entirely, by a factor of
10x. Maybe the WC writer itself is much faster, but _others_ are
slowed down enormously.

Whaa? That just seems incredible.

Dave - while your test sounds very simple, can you package it up some
way so that somebody inside of Intel can just run it on one of their
machines?

The patch itself (to allow people to *not* do WC that is supposed to
be so much better but clearly doesn't seem to be) looks fine to me,
but it would be really good to get intel to look at this.

                    Linus
