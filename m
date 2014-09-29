From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Sep 2014 11:32:44 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAMuHMdXrc4ED0N0Etb-mgCRc437spsxuNZ6Nq_15zhFXSt8Nug@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <53FF1D6C.6090205@redhat.com> <20140829070116.GC13106@ulmo>
 <20140829141244.GH15297@lukather> <20140829143812.GC31264@ulmo>
 <20140902092508.GR15297@lukather>
 <20140927235601.19023.31593@quantum> <20140929080637.GB12506@ulmo>
 <20140929092301.GC4388@lukather> <20140929101805.GB26008@ulmo>
 <CAMuHMdU4u7K5NUk+p2iT-Sc_PuOjOT2FpFBj6TQMm2ThOuVVqQ@mail.gmail.com>
 <20140929104454.GD26008@ulmo>
In-Reply-To: <20140929104454.GD26008@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Thierry,

On Mon, Sep 29, 2014 at 12:44 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
>> >> You know that you are going to call that for regulator, reset, power
>> >> domains, just as you would have needed to with the proper API, unless
>> >> that with this kind of solution, you would have to modify *every*
>> >> framework that might interact with any resource involved in getting
>> >> simplefb running?
>> >
>> > We have to add handling for every kind of resource either way. Also if
>> > this evolves into a common pattern we can easily wrap it up in a single
>> > function call.
>>
>> disable_all_power_management(), as this is not limited to clocks.
>
> Right. But it isn't all power management either. It just shouldn't turn
> everything unused off. Clocks, regulators, power domains and so on which
> are used can very well be power managed.

No they can't, as the clock/regulator/PM domain core cannot know if any
of the used ones are also used by a shim driver like simplefb.
Clocks and regulators may be shared. PM domains can contain multiple
hardware blocks. Without more knowledge, the only safe thing is not
disabling anything.

>> >> Plus, speaking more specifically about the clocks, that won't prevent
>> >> your clock to be shut down as a side effect of a later clk_disable
>> >> call from another driver.
>>
>> > Furthermore isn't it a bug for a driver to call clk_disable() before a
>> > preceding clk_enable()? There are patches being worked on that will
>> > enable per-user clocks and as I understand it they will specifically
>> > disallow drivers to disable the hardware clock if other drivers are
>> > still keeping them on via their own referenc.
>>
>> Calling clk_disable() preceding clk_enable() is a bug.
>>
>> Calling clk_disable() after clk_enable() will disable the clock (and
>> its parents)
>> if the clock subsystem thinks there are no other users, which is what will
>> happen here.
>
> Right. I'm not sure this is really applicable to this situation, though.

Yes it is: if all users of a clock/regulator/PM domain are gone, it will
be disabled. Bad luck for simplefb still needing them.

> Either way, if there are other users of a clock then they will just as
> likely want to modify the rate at which point simplefb will break just
> as badly.

BTW, this can also happen for clocks that are properly used.
I guess the clock core code does some arbitration to handle such cases.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
