From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 06 Oct 2014 07:27:01 +0000
Subject: Re: Fixing boot-time hiccups in your display
Message-Id: <54324445.9070400@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAKON4OxRFCvMPMfZhxYNVaxscgAs5AX46YzK-4SU5o6E-iTD1w@mail.gmail.com>	<20141005200150.4379.28017@quantum>
 <CAKON4OxunQNC_Ebf5u9yh9EnGS2A+DdWCRyoFcJWS7GSNoLoqA@mail.gmail.com>
In-Reply-To: <CAKON4OxunQNC_Ebf5u9yh9EnGS2A+DdWCRyoFcJWS7GSNoLoqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 10/05/2014 10:34 PM, jonsmirl@gmail.com wrote:
> On Sun, Oct 5, 2014 at 4:01 PM, Mike Turquette <mturquette@linaro.org> wrote:
>> Quoting jonsmirl@gmail.com (2014-10-05 10:09:52)
>>> I edited the subject line to something more appropriate. This impacts
>>> a lot of platforms and we should be getting more replies from people
>>> on the ARM kernel list. This is likely something that deserves a
>>> Kernel Summit discussion.
>>
>> ELC-E and LPC are just around the corner as well. I am attending both. I
>> suppose some of the others interested in this topic will be present?
>>
>>>
>>> To summarize the problem....
>>>
>>> The BIOS (uboot, etc) may have set various devices up into a working
>>> state before handing off to the kernel.  The most obvious example of
>>> this is the boot display.
>>>
>>> So how do we transition onto the kernel provided device specific
>>> drivers without interrupting these functioning devices?
>>>
>>> This used to be simple, just build everything into the kernel. But
>>> then along came multi-architecture kernels where most drivers are not
>>> built in. Those kernels clean up everything (ie turn off unused
>>> clocks, regulators, etc) right before user space starts. That's done
>>> as a power saving measure.
>>>
>>> Unfortunately that code turns off the clocks and regulators providing
>>> the display on your screen. Which then promptly gets turned back on a
>>> half second later when the boot scripts load the display driver. Let's
>>> all hope the boot doesn't fail while the display is turned off.
>>
>> I would say this is one half of the discussion. How do you ever really
>> know when it is safe to disable these things? In a world with loadable
>> modules the kernel cannot know that everything that is going to be
>> loaded has been loaded. There really is no boundary that makes it easy
>> to say, "OK, now it is truly safe for me to disable these things because
>> I know every possible piece of code that might claim these resources has
>> probed".
> 
> Humans know where this boundary is and can insert the clean up command
> at the right point in the bootscript.

No they don't, we've been over this so many times already it just is
not funny anymore. So I'm not even go to repeat the same old technical
arguments why this is not true.

There is only one 100% correct moment when it is safe to turn of resources
used by something like simplefb, which is when a real driver takes over.

The same for any other resources used by any other firmware setup things,
the right moment to release those resources is at handover time, and
the handover time may differ from driver to driver, so there is no
single magic moment to disable this.

Also this non-solution completely discards the use case where e.g. simplefb
is used as an early bringup mechanism and there may complete be no real
driver for a long time (months if not years). So then again there is no
right magic moment to turn the resources off, because in this use case the
magic moment is *never*.

I'm all for finding a proper solution for this, but you seem to be blind
to anything other then your own idea that this is just a boot ordering problem,
which it is not, the problem is that things like simplefb simply need to claim
the resources they use, and then all ordering problems go away.

We've tried this "ordering magic" kind of solutions before, see e.g. the
scsi_wait_scan module hack, which was not enough, so then initrd-s started
inserting sleeps to wait for storage to be available, and the hacks just got
uglier and uglier, until we moved to an event based system, and instead
of waiting for a "magic moment", actually waited for the storage device
we're looking for to show up, which is exactly the same as what we should
do here, wait for the real driver to show up.

This also means that we need to tie resources to devices like simplefb,
because the event causing their release will be that the real driver for
the display pipeline loaded, which is not a single event for all similar
drivers. And since there is no single event, there is no single moment
to do the magic ioctl for this.

Really this is a solved problem, The only 100% correct solution is to tie
the ordering of releasing the resources to the lifetime of the simplefb,
which is easily achieved by making the simplefb properly claim the resources
it needs.

Regards,

Hans
