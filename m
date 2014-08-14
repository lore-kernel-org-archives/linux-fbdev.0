From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 14 Aug 2014 10:15:58 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 3/4] simplefb: disable dt node upon remove
Message-Id: <CACxGe6v1UPHMF5aPpe-boh+RuoPArJmKK_cQWr7aXsRjDUZrfQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-4-git-send-email-libv@skynet.be>
 <CACxGe6vaPUa4QvYWBA-QY7MTmJYoeqnPt9Zh5jpky6S9UYbrvQ@mail.gmail.com>
 <CANq1E4ReOB87RX8VhnW1Ln=SK3Tw5V962ujcsfuz-2E9Uc61yQ@mail.gmail.com>
 <CACxGe6vQrhd8QOAyGnjRppmuANpT60Ao2+KmkDfF4FNeoZSZgw@mail.gmail.com>
 <20140813094524.GC31326@skynet.be> <20140813101923.GD31326@skynet.be>
 <CAKON4OwLOAq1EOzZmuefcnZ4hw0i35e3k0F6XGNRy-5jer2vyA@mail.gmail.com>
 <CACxGe6szX3LyhGHbVHrEFfaWGYUcgcxgkuhfc9ac-R0qJs-HXw@mail.gmail.com>
 <CAKON4OzQbuaQsbTCDXuaqxLRxvat_5+wmf71S-rWXdfiT1gkvA@mail.gmail.com>
In-Reply-To: <CAKON4OzQbuaQsbTCDXuaqxLRxvat_5+wmf71S-rWXdfiT1gkvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Aug 13, 2014 at 9:41 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Wed, Aug 13, 2014 at 3:14 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Wed, Aug 13, 2014 at 1:54 PM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
>>> On Wed, Aug 13, 2014 at 6:19 AM, Luc Verhaegen <libv@skynet.be> wrote:
>>>> On Wed, Aug 13, 2014 at 11:45:24AM +0200, Luc Verhaegen wrote:
>>>>> On Wed, Aug 13, 2014 at 10:23:14AM +0100, Grant Likely wrote:
>>>>> >
>>>>> > The majority of the DT code is based on the assumption of a static
>>>>> > tree. Pantelis has been working on being able to modify it at runtime
>>>>> > with overlays, but he has had to go through a lot of rework because it
>>>>> > is not a trivial task. When you get into modifying the DT, you need to
>>>>> > have a lot more understanding of the side effects to changing the
>>>>> > tree. The DT structure also has a lifecycle that can go beyond the
>>>>> > current lifecycle of the kernel. The kexec tool will extract the
>>>>> > current tree from the kernel, make the appropriate modifications, and
>>>>> > use that to boot the next kernel. Allowing any driver to modify the
>>>>> > tree has side effects beyond just the current kernel.
>>>>> >
>>>>> > In this specific case, it will interact badly with the work Pantelis
>>>>> > is doing to make platform devices work with overlays. Modifying the
>>>>> > status property will cause the associated struct device to get removed
>>>>> > in the middle of probing a driver for that device! That will most
>>>>> > likely cause an oops.
>>>>> >
>>>>> > Besides, Luc straight out *said*: "...even though it has no real value
>>>>> > today". In what circumstance is that justification for modifying the
>>>>> > tree?
>>>>>
>>>>> With that sentence i meant that given the current state of things, it
>>>>> has no real value.
>>>>>
>>>>> It has no value currently as re-probing simplefb is not going to happen.
>>>>> But it's not a big leap to turn simplefb into a proper module. Not that
>>>>> that makes much sense, but that's never stopped anyone.
>>>>>
>>>>> To me it seemed simple, dt is what drives simplefb, so dt then also
>>>>> becomes responsible for making sure that simplefb or another driver does
>>>>> not attempt to blindly use this info again. The way this is implemented
>>>>> i do not care for in any way, i just knew that i could not do nothing
>>>>> here, given the catastrophic effect disabling the clocks has on simplefb
>>>>> on sunxi. Given the discussion that errupted here, i'd say that this
>>>>> does need some resolution, and altering the dt is going to have to be
>>>>> part of the solution.
>>>>>
>>>>> In any case, i will gladly drop this patch, as it is not absolutely
>>>>> necessary. But it should be very clear that there is no going back on
>>>>> this dt node after the clocks were released once.
>>>>>
>>>>> Luc Verhaegen.
>>>>
>>>> What about approaching this from the other end? U-Boot could add a
>>>> property named "once-only" or so.
>>>
>>> Device tree is supposed to be a static description of the hardware
>>> usable on all operating systems. It is the wrong mechanism for
>>> communicating between uboot and the kernel. Use something like atags
>>> or the kernel command line to tell the kernel that the console has
>>> already been set up.
>>
>> Not accurate. While it is primarily hardware description, it is also
>> used for firmware communication. There is loads of precedence for
>> this. The /chosen node is the most significant example, but there are
>> other places where the tree is used to provide state. For example, the
>> current-speed property on UART nodes.
>
> I do seem to recall you telling me a long time ago that those chosen
> nodes were a mistake (or maybe it was Matt Sealey). I'm pretty wary of
> opening to door to device trees carrying a bunch of state.  Five years
> from now the DT is going to look like a Christmas tree.

Wasn't me. Carrying state in the DT provided by firmware is perfectly
reasonable in my opinion.

g.
