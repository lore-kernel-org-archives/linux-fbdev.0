From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Aug 2014 19:59:00 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53FCE704.4030103@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather> <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com> <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather> <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
In-Reply-To: <20140826143550.GB3027@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/26/2014 04:35 PM, Thierry Reding wrote:
> On Tue, Aug 26, 2014 at 03:53:41PM +0200, Maxime Ripard wrote:
>> On Tue, Aug 26, 2014 at 10:04:33AM +0200, Thierry Reding wrote:
>>>>> No. simplefb just wants to write to some memory that hardware has been
>>>>> set up to scan out. The platform requires that the clocks be on. Other
>>>>> platforms may not even allow turning off the clocks.
>>>>
>>>> Like what? the rpi? Come on. Just because the videocore is some black
>>>> box we know nothing about doesn't mean we should use it as an example.
>>>
>>> You make it sound like the Raspberry Pi is somehow less important than
>>> sunxi.
>>
>> No. What I mean is that it seems like we are somehow punished, or at
>> least blamed, for having a better and more complete kernel support.
>
> This isn't a competition. Nobody's punishing or blaming anyone. This is
> about finding the best solution for the problem at hand.
>
>>>> Any decent enough SoC, with a decent support in the kernel will have
>>>> clocks for this, and I really wonder how simplefb will behave once its
>>>> clocks will be turned off...
>>>
>>> There are other devices besides ARM SoCs that may want to use this
>>> driver and that don't have clock support.
>>
>> And in this case, with this patch, simplefb will not claim any clock,
>> nor will fail probing.
>>
>>> But you're missing my point. What I'm saying is that the simplefb driver
>>> is meant to serve as a way to take over whatever framebuffer a firmware
>>> set up. Therefore I think it makes the most sense to assume that nothing
>>> needs to be controlled in any way since already been set up by firmware.
>>> Eventually there should be a driver that takes over from simplefb that
>>> knows how to properly handle the device's specifics, but that's not
>>> simplefb.
>>
>> I guess such a hand over if it were to happen in the kernel would
>> involve the second driver claiming the resources before the first one
>> release them. How is that different in this case?
>
> It's different in that that driver will be hardware specific and know
> exactly what clock and other resources are required. It will have a
> device-specific binding.
>
>>> The goal of this patch series is to keep clocks from being turned off.
>>> But that's not what it does. What it does is turn clocks on to prevent
>>> them from being turned off. In my opinion that's a workaround for a
>>> deficiency in the kernel (and the firmware/kernel interface) and I think
>>> it should be fixed at the root. So a much better solution would be to
>>> establish a way for firmware to communicate to the kernel that a given
>>> resource has been enabled by firmware and shouldn't be disabled. Such a
>>> solution can be implement for all types of resources and can be reused
>>> by all drivers since they don't have to worry about these details.
>>
>> Mike Turquette repeatedly said that he was against such a DT property:
>> https://lkml.org/lkml/2014/5/12/693
>
> Mike says in that email that he's opposing the addition of a property
> for clocks that is the equivalent of regulator-always-on. That's not
> what this is about. If at all it'd be a property to mark a clock that
> should not be disabled by default because it's essential.
>
> Adding Mike on this subthread too.
>
> Either way, Mark already suggested a different alternative in another
> subthread, namely to add a new kind of checkpoint at which subsystems
> can call a "disable unused" function that's called later than a late
> initcall. This is not going to fix things for you immediately because
> the clocks will still be switched off (only later) if you don't have
> a real driver that's claiming the clocks. But you can work around that
> for now by making the relevant clocks always on and remove that
> workaround once a real driver is loaded that knows how to handle them
> properly.

This will simply not work, and is a ton more complicated then
simply teaching simplefb about a clocks property, which is a really simple
and clean patch.

First of all let me explain why this won't work. When should those
subsystems call this "later then a late initcall" call ? the kms driver
may very well be a kernel module, which will be loaded by userspace,
so we would need this to be triggered by userspace, but when ?

When the initrd is done? What then if the kms driver is not in the initrd,
so maybe when udev is done enumerating devices, but what then if the kernel
is still enumerating hardware at this time? Will we just put a sleep 30
in our initscripts to make sure the kernel is done scanning all busses,
will that be long enough? Maybe we need to re-introduce the scsi_wait_done
kernel module which was added as an ugly hack to allow userspace to wait
for the kernel to have finished scanning scsi (and ata / sata) busses,
for controllers found at the time the module was load. Which never worked
reliable, because it would be possible that the controller itself still
needed to be discovered. We've spend years cleaning up userspace enough
to be able to kill scsi_wait_done. We've already been down this road of
waiting for hw enumeration to be done, and the problem is that on
modern systems *it is never done*.

So second of all, Thierry, what exactly is the technical argument against
adding support for dealing with clocks to simplefb ? I've heard a lot of
people in favor of it, and only pretty much you against it, and your
argument so far seems to boil down to "I don't like it", which is not
really a technical sound argument IMHO. Moreover all the alternatives
seem to be horribly complicated and most of them also seem to have
several issues which will make them simply not work reliable.

Regards,

Hans
