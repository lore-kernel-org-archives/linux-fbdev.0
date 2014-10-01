From: Mike Turquette <mturquette@linaro.org>
Date: Wed, 01 Oct 2014 18:17:23 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAPtuhTgJ7TLg8CKe3pQiBeEw9s33UrYEXPj6SDCga2yAh7WfEA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum>
 <20140929080637.GB12506@ulmo> <20140929092301.GC4388@lukather>
 <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo> <20140929113436.GA4081@lukather>
 <20140929135358.GC30998@ulmo> <20140930213753.19023.17605@quantum>
 <20141001073043.GA18463@ulmo>
In-Reply-To: <20141001073043.GA18463@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 1, 2014 at 12:30 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Tue, Sep 30, 2014 at 02:37:53PM -0700, Mike Turquette wrote:
>> Quoting Thierry Reding (2014-09-29 06:54:00)
>> > On Mon, Sep 29, 2014 at 01:34:36PM +0200, Maxime Ripard wrote:
>> > > On Mon, Sep 29, 2014 at 12:44:57PM +0200, Thierry Reding wrote:
>> > > > > >> Plus, speaking more specifically about the clocks, that won't prevent
>> > > > > >> your clock to be shut down as a side effect of a later clk_disable
>> > > > > >> call from another driver.
>> > > > >
>> > > > > > Furthermore isn't it a bug for a driver to call clk_disable() before a
>> > > > > > preceding clk_enable()? There are patches being worked on that will
>> > > > > > enable per-user clocks and as I understand it they will specifically
>> > > > > > disallow drivers to disable the hardware clock if other drivers are
>> > > > > > still keeping them on via their own referenc.
>> > > > >
>> > > > > Calling clk_disable() preceding clk_enable() is a bug.
>> > > > >
>> > > > > Calling clk_disable() after clk_enable() will disable the clock (and
>> > > > > its parents)
>> > > > > if the clock subsystem thinks there are no other users, which is what will
>> > > > > happen here.
>> > > >
>> > > > Right. I'm not sure this is really applicable to this situation, though.
>> > >
>> > > It's actually very easy to do. Have a driver that probes, enables its
>> > > clock, fails to probe for any reason, call clk_disable in its exit
>> > > path. If there's no other user at that time of this particular clock
>> > > tree, it will be shut down. Bam. You just lost your framebuffer.
>> > >
>> > > Really, it's just that simple, and relying on the fact that some other
>> > > user of the same clock tree will always be their is beyond fragile.
>> >
>> > Perhaps the meaning clk_ignore_unused should be revised, then. What you
>> > describe isn't at all what I'd expect from such an option. And it does
>> > not match the description in Documentation/kernel-parameters.txt either.
>>
>> From e156ee56cbe26c9e8df6619dac1a993245afc1d5 Mon Sep 17 00:00:00 2001
>> From: Mike Turquette <mturquette@linaro.org>
>> Date: Tue, 30 Sep 2014 14:24:38 -0700
>> Subject: [PATCH] doc/kernel-parameters.txt: clarify clk_ignore_unused
>>
>> Refine the definition around clk_ignore_unused, which caused some
>> confusion recently on the linux-fbdev and linux-arm-kernel mailing
>> lists[0].
>>
>> [0] http://lkml.kernel.org/r/<20140929135358.GC30998@ulmo>
>>
>> Signed-off-by: Mike Turquette <mturquette@linaro.org>
>> ---
>> Thierry,
>>
>> Please let me know if this wording makes the feature more clear.
>
> I think that's better than before, but I don't think it's accurate yet.
> As pointed out by Maxime unused clock may still be disabled if it's part
> of a tree and that tree is being disabled because there are no users
> left.

It is entirely accurate. This feature does in fact "prevent the clock
framework from *automatically* gating clock ...".

And it was merged by Olof so that he could use simplefb with the Chromebook!

>
> What I had argued is that it's unexpected behavior, because the clock
> is still unused (or becomes unused again), therefore shouldn't be
> disabled at that point either.

Leaving clocks enabled because nobody claimed them is not an option.

>
> So if you want to keep the current behaviour where an unused clock can
> still be disabled depending on what other users do, then I think it'd be
> good to mention that as a potential caveat.

Do you have a suggestion on the wording?

Thanks,
Mike

>
> Thierry
