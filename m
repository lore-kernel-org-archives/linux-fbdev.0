From: Michal Suchanek <hramrach@gmail.com>
Date: Thu, 02 Oct 2014 13:59:08 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAOMqctSjSJTBVvc11tvmKPz=JwWBoNJMFjtZW-COGxSSojJLQQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo> <20140929114643.GB4081@lukather>
 <20140929134708.GB30998@ulmo> <20140929155517.GR16977@sirena.org.uk>
 <20140930050923.GB29874@ulmo> <20140930173928.GH4273@sirena.org.uk>
 <20141001074139.GB18463@ulmo>
 <CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>
 <20141001123250.GY4273@sirena.org.uk> <20141001124800.GA21733@ulmo>
 <20141001170517.GF4273@sirena.org.uk> <542C3934.3040409@redhat.com>
 <CAKON4OxzerMyuza-GSfmYiLMqA=Y3HOXko7a8rOcP_8PkHVF3w@mail.gmail.com>
 <542C4404.8040501@wwwdotorg.org> <542CF3C3.2050708@redhat.com>
 <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
 <542D476D.50004@redhat.com>
 <CAKON4OwOFVFZjxN-SJpDJLcyCpNOT4_mjjr9OpgGXmTYvZwT+A@mail.gmail.com>
 <542D4FB9.6090805@redhat.com>
 <CAKON4Oyb3KBWhGgKfwNop7+cwR=p=ZpVs-jfH0iQwm5scfOJ-A@mail.gmail.com>
In-Reply-To: <CAKON4Oyb3KBWhGgKfwNop7+cwR=p=ZpVs-jfH0iQwm5scfOJ-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 2 October 2014 15:27, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Thu, Oct 2, 2014 at 9:14 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/02/2014 02:56 PM, jonsmirl@gmail.com wrote:
>>> On Thu, Oct 2, 2014 at 8:39 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>> Hi,
>>>>
>>>> On 10/02/2014 02:22 PM, jonsmirl@gmail.com wrote:
>>>>> On Thu, Oct 2, 2014 at 2:42 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> You need both.
>>>>>
>>>>> 1) temporary early boot console -- this is nothing but an address in
>>>>> RAM and the x/y layout. The character set from framebuffer is built
>>>>> into the kernel.  The parallel to this is early-printk and how it uses
>>>>> the UARTs without interrupts. This console vaporizes late in the boot
>>>>> process -- the same thing happens with the early printk UART driver.
>>>>> EARLYPRINTK on the command line enables this.
>>>>>
>>>>> 2) a device specific driver -- this sits on initrd and it loaded as
>>>>> soon as possible. The same thing happens with the real UART driver for
>>>>> the console. CONSOLE= on the command line causes the transition. There
>>>>> is an API in the kernel to do this transition, I believe it is called
>>>>> set_console() but it's been a while.
>>>>
>>>> Eventually we need both, yes. But 1) should stay working until 2) loads,
>>>> not until some phase of the bootup is completed, but simply until 2) loads.
>>>
>>> No, that is where you get into trouble. The device specific driver has
>>> to go onto initrd where it can be loaded as early in the boot process
>>> as possible.
>>
>> This is an argument in the "you cannot do that" / "your use case is not valid"
>> category, IOW this is not a technical argument. You say I cannot do that I
>> say I can, deadlock.
>
> It is certainly possible to extend an earlyframebuffer to be able to
> run as a user space console. It is just going to turn into a
> Frankenmonster driver with piles of device specific, special case code
> in it.

What is device specific about code that reads a list of clocks and
just asks tells kernel it uses them all?

That's been discussed to death in this thread already.

>
> I think that device specific code belongs in a device specific driver
> and earlyframebuffer should handoff to it as soon as possible.

Even it that case it needs to tell the kernel it needs the clocks so
that they are not shut of until that handoff happens.

>
>>
>> I've already explained that we not only can do that (we already have working
>> code proving that), but also that this is something which we absolutely need:
>>
>>>> One example why this is necessary is e.g. to debug things where the problem
>>>> is that the right module is not included in the initrd.
>
> A generic earlyframebuffer would show this error.
>
> Just use earlyprintk as a guideline, if earlyprintk shows the error
> earlyframebuffer would also show it.
>

It does not. It hands off to an uart driver built into the kernel. The
handoff is broken on sunxi and the earlyprintk continues to work
indefinitely replicating all kernel messages twice on the serial
console unless something happens to reconfigure the uart used for
earlyprink later on. When that does happen the early console can fail
very early, even way before the time you would load an initrd. It just
happens to work most of the time because when you use earlyprintk most
of the time you also use serial console with the same parameters on
the same pins.

Thanks

Michal
