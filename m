From: Dave Airlie <airlied@gmail.com>
Date: Tue, 18 Jul 2017 21:21:14 +0000
Subject: Re: [PATCH] efifb: allow user to disable write combined mapping.
Message-Id: <CAPM=9twtiyJb2M3tBBb6Xy3ausVxhn3Be+NTr+BAV9FTMGPkug@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170718060909.5280-1-airlied@redhat.com> <20170718143404.omgxrujngj2rhiya@redhat.com>
 <CA+55aFwKzwDPYFsPpuQNfBaS-dL2aD0=z1hGEnkaTT1MMfWB6Q@mail.gmail.com> <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
In-Reply-To: <CAPM=9tyWv79U9=-YNacf34don_Gn5RGggBsZG7R9FNuV8_qe1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Jones <pjones@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>

On 19 July 2017 at 06:44, Dave Airlie <airlied@gmail.com> wrote:
> On 19 July 2017 at 05:57, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Tue, Jul 18, 2017 at 7:34 AM, Peter Jones <pjones@redhat.com> wrote:
>>>
>>> Well, that's kind of amazing, given 3c004b4f7eab239e switched us /to/
>>> using ioremap_wc() for the exact same reason.  I'm not against letting
>>> the user force one way or the other if it helps, though it sure would be
>>> nice to know why.
>>
>> It's kind of amazing for another reason too: how is ioremap_wc()
>> _possibly_ slower than ioremap_nocache() (which is what plain
>> ioremap() is)?
>
> In normal operation the console is faster with _wc. It's the side effects
> on other cores that is the problem.
>
>> Or maybe it really is something where there is one global write queue
>> per die (not per CPU), and having that write queue "active" doing
>> combining will slow down every core due to some crazy synchronization
>> issue?
>>
>> x86 people, look at what Dave Airlie did, I'll just repeat it because
>> it sounds so crazy:
>>
>>> A customer noticed major slowdowns while logging to the console
>>> with write combining enabled, on other tasks running on the same
>>> CPU. (10x or greater slow down on all other cores on the same CPU
>>> as is doing the logging).
>>>
>>> I reproduced this on a machine with dual CPUs.
>>> Intel(R) Xeon(R) CPU E5-2609 v3 @ 1.90GHz (6 core)
>>>
>>> I wrote a test that just mmaps the pci bar and writes to it in
>>> a loop, while this was running in the background one a single
>>> core with (taskset -c 1), building a kernel up to init/version.o
>>> (taskset -c 8) went from 13s to 133s or so. I've yet to explain
>>> why this occurs or what is going wrong I haven't managed to find
>>> a perf command that in any way gives insight into this.
>>
>> So basically the UC vs WC thing seems to slow down somebody *else* (in
>> this case a kernel compile) on another core entirely, by a factor of
>> 10x. Maybe the WC writer itself is much faster, but _others_ are
>> slowed down enormously.
>>
>> Whaa? That just seems incredible.
>
> Yes I've been staring at this for a while now trying to narrow it down, I've
> been a bit slow on testing it on a wider range of Intel CPUs, I've
> only really managed
> to play on that particular machine,
>
> I've attached two test files. compile both of them (I just used make
> write_resource burn-cycles).
>
> On my test CPU core 1/8 are on same die.
>
> time taskset -c 1 ./burn-cycles
> takes about 6 seconds
>
> taskset -c 8 ./write_resource wc
> taskset -c 1 ./burn-cycles
> takes about 1 minute.
>
> Now I've noticed write_resource wc or not wc doesn't seem to make a
> difference, so
> I think it matters that efifb has used _wc for the memory area already
> and set PAT on it for wc,
> and we always get wc on that BAR.
>
> From the other person seeing it:
> "I done a similar test some time ago, the result was the same.
> I ran some benchmarks, and it seems that when data set fits in L1
> cache there is no significant performance degradation."

Oh and just FYI, the machine I've tested this on has an mgag200 server
graphics card backing the framebuffer, but with just efifb loaded.

Dave.
