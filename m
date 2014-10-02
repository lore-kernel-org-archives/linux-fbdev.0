From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 02 Oct 2014 12:39:09 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <542D476D.50004@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140929101805.GB26008@ulmo>	<20140929114643.GB4081@lukather>	<20140929134708.GB30998@ulmo>	<20140929155517.GR16977@sirena.org.uk>	<20140930050923.GB29874@ulmo>	<20140930173928.GH4273@sirena.org.uk>	<20141001074139.GB18463@ulmo>	<CABxcv=nKErHGPRLM5yer2YnOc2VJPWLmeKgwXbXEU3r_XvsCyg@mail.gmail.com>	<20141001123250.GY4273@sirena.org.uk>	<20141001124800.GA21733@ulmo>	<20141001170517.GF4273@sirena.org.uk>	<542C3934.3040409@redhat.com>	<CAKON4OxzerMyuza-GSfmYiLMqA=Y3HOXko7a8rOcP_8PkHVF3w@mail.gmail.com>	<542C4404.8040501@wwwdotorg.org>	<542CF3C3.2050708@redhat.com>
 <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
In-Reply-To: <CAKON4Oy8sZ-d6JzWLi7pUeNFE5ge0fr5Tgoc_PSpKcOoiN-0yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/02/2014 02:22 PM, jonsmirl@gmail.com wrote:
> On Thu, Oct 2, 2014 at 2:42 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 10/01/2014 08:12 PM, Stephen Warren wrote:
>>> On 10/01/2014 11:54 AM, jonsmirl@gmail.com wrote:
>>>> On Wed, Oct 1, 2014 at 1:26 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>> ...
>>>>> We've been over all this again and again and again.
>>>>>
>>>>> AAAARRRRRGGGGGGGGGGGGGGGGGHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH!
>>>>>
>>>>> All solutions provided sofar are both tons more complicated, then the
>>>>> simple solution of simply having the simplefb dt node declare which
>>>>> clocks it needs. And to make things worse all of them sofar have
>>>>> unresolved issues (due to their complexity mostly).
>>>>>
>>>>> With the clocks in the simplefb node, then all a real driver has to do,
>>>>> is claim those same clocks before unregistering the simplefb driver,
>>>>> and everything will just work.
>>>>>
>>>>> Yet we've been discussing this for months, all because of some
>>>>> vague worries from Thierry, and *only* from Thierry that this will
>>>>> make simplefb less generic / not abstract enough, while a simple
>>>>> generic clocks property is about as generic as things come.
>>>
>>> Note: I haven't been following this thread, and really don't have the time to get involved, but I did want to point out one thing:
>>>
>>> As I think I mentioned very early on in this thread, one of the big concerns when simplefb was merged was that it would slowly grow and become a monster. As such, a condition of merging it was that it would not grow features like resource management at all. That means no clock/regulator/... support. It's intended as a simple stop-gap between early platform bringup and whenever a real driver exists for the HW. If you need resource management, write a HW-specific driver. The list archives presumably have a record of the discussion, but I don't know the links off the top of my head. If nobody
>>> other than Thierry is objecting, presumably the people who originally objected simply haven't noticed this patch/thread. I suppose it's possible they changed their mind.
>>>
>>> BTW, there's no reason that the simplefb code couldn't be refactored out into a support library that's used by both the simplefb we currently have and any new HW-specific driver. It's just that the simplefb binding and driver shouldn't grow.
>>
>> The whole reason why we want to use simplefb is not just to get things
>> running until HW specific driver is in place, but also to have early console
>> output (to help debugging boot problems on devices without a serial console),
>> in a world where most video drivers are build as loadable modules, so we
>> won't have video output until quite late into the boot process.
> 
> You need both.
> 
> 1) temporary early boot console -- this is nothing but an address in
> RAM and the x/y layout. The character set from framebuffer is built
> into the kernel.  The parallel to this is early-printk and how it uses
> the UARTs without interrupts. This console vaporizes late in the boot
> process -- the same thing happens with the early printk UART driver.
> EARLYPRINTK on the command line enables this.
> 
> 2) a device specific driver -- this sits on initrd and it loaded as
> soon as possible. The same thing happens with the real UART driver for
> the console. CONSOLE= on the command line causes the transition. There
> is an API in the kernel to do this transition, I believe it is called
> set_console() but it's been a while.

Eventually we need both, yes. But 1) should stay working until 2) loads,
not until some phase of the bootup is completed, but simply until 2) loads.

Which means we must reserve necessary resources so that they don't get
disabled until 2 loads.

One example why this is necessary is e.g. to debug things where the problem
is that the right module is not included in the initrd.

Regards,

Hans
