From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 Aug 2014 08:00:23 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <53FD9017.40705@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com> <20140825141600.GA14763@ulmo.nvidia.com>
 <20140825145854.GA15297@lukather> <20140825150501.GE14763@ulmo.nvidia.com>
 <20140825152232.GE15297@lukather> <20140826080432.GD17263@ulmo>
 <20140826135341.GM15297@lukather> <20140826143550.GB3027@ulmo>
 <20140826210248.GO15297@lukather> <20140827065440.GG15640@ulmo>
In-Reply-To: <20140827065440.GG15640@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 08/27/2014 08:54 AM, Thierry Reding wrote:
> On Tue, Aug 26, 2014 at 11:02:48PM +0200, Maxime Ripard wrote:
>> On Tue, Aug 26, 2014 at 04:35:51PM +0200, Thierry Reding wrote:
>>>>>> Any decent enough SoC, with a decent support in the kernel will have
>>>>>> clocks for this, and I really wonder how simplefb will behave once its
>>>>>> clocks will be turned off...
>>>>>
>>>>> There are other devices besides ARM SoCs that may want to use this
>>>>> driver and that don't have clock support.
>>>>
>>>> And in this case, with this patch, simplefb will not claim any clock,
>>>> nor will fail probing.
>>>>
>>>>> But you're missing my point. What I'm saying is that the simplefb driver
>>>>> is meant to serve as a way to take over whatever framebuffer a firmware
>>>>> set up. Therefore I think it makes the most sense to assume that nothing
>>>>> needs to be controlled in any way since already been set up by firmware.
>>>>> Eventually there should be a driver that takes over from simplefb that
>>>>> knows how to properly handle the device's specifics, but that's not
>>>>> simplefb.
>>>>
>>>> I guess such a hand over if it were to happen in the kernel would
>>>> involve the second driver claiming the resources before the first one
>>>> release them. How is that different in this case?
>>>
>>> It's different in that that driver will be hardware specific and know
>>> exactly what clock and other resources are required. It will have a
>>> device-specific binding.
>>
>> Except that you made simplefb a generic driver. So we have two choices
>> here: either we don't anything but the trivial case, and no one with a
>> rather more advanced hardware will be able to use it, or we try to
>> grab any resource that might be of use, which means clocks,
>> regulators, reserved memory region, or whatever, so that we pretty
>> much cover all cases. It really is as simple as that.
> 
> No, it should be even simpler. simplefb shouldn't have to know any of
> this. It's just taking what firmware has set up and uses that. It's a
> stop-gap solution to provide information on the display until a real
> driver can be loaded and initializes the display hardware properly.
> 
>>>>> The goal of this patch series is to keep clocks from being turned off.
>>>>> But that's not what it does. What it does is turn clocks on to prevent
>>>>> them from being turned off. In my opinion that's a workaround for a
>>>>> deficiency in the kernel (and the firmware/kernel interface) and I think
>>>>> it should be fixed at the root. So a much better solution would be to
>>>>> establish a way for firmware to communicate to the kernel that a given
>>>>> resource has been enabled by firmware and shouldn't be disabled. Such a
>>>>> solution can be implement for all types of resources and can be reused
>>>>> by all drivers since they don't have to worry about these details.
>>>>
>>>> Mike Turquette repeatedly said that he was against such a DT property:
>>>> https://lkml.org/lkml/2014/5/12/693
>>>
>>> Mike says in that email that he's opposing the addition of a property
>>> for clocks that is the equivalent of regulator-always-on. That's not
>>> what this is about. If at all it'd be a property to mark a clock that
>>> should not be disabled by default because it's essential.
>>
>> It's just semantic. How is "a clock that should not be disabled by
>> default because it's essential" not a clock that stays always on?
> 
> Because a clock that should not be disabled by default can be turned off
> when appropriate. A clock that is always on can't be turned off.
> 
>> Plus, you should read the mail further. It's clearly said that
>> consumer drivers should call clk_prepare_enable themselves, and that
>> the only exception to that is the case where we don't have such a
>> driver (and only valid as a temporary exception, which I guess you'll
>> soon turn into temporary-until-a-drm-kms-driver-is-merged).
> 
> Exactly. simplefb is only a temporary measure. It's not meant to be used
> as a full-blown framebuffer driver. There are two use-cases where it is
> an appropriate solution:
> 
>   1) As a stop-gap solution for when the platform doesn't support a full
>      display driver yet. In that case you will want simplefb to stay
>      around forever.
> 
>   2) To get early boot output before a full display driver can be loaded
>      in which case simplefb should go away after the display driver has
>      taken over.
> 
> In case of 2) the most straightforward solution is to not disable any
> clocks until all drivers have had a chance to claim them. When the full
> driver has been probed it should have claimed the clocks so they would
> no longer get disabled.

Please read my long reply from yesterday evening why this will never
work, as there is not a well defined moment when "all drivers have had a
chance to claim them"

I've been doing low level Linux development for 10 years now and I've
worked a lot on storage (raid, iscsi, fcoe support, etc.) in the past.

We've been down this road before, and all it leads to is pain, some more
pain and then even more pain. Followed by the conclusion that everything
needed to be refactored to use a hotplug model, and that instead of
waiting for hardware / disk-enumeration to be done (so we can mount
filesystems), the right thing to do is to actually wait for the block
device(s) holding said filesystems to show up.

The same applies here, the right thing to do is to wait for the kms
driver claiming the clocks to actually show up. And the easiest and
cleanest way to do that is to have simplefb claim the clocks, and
have it release them when the kms driver loads and asks simplefb
to unload.

Oh and one more thing, this whole make a list of special clocks which
should be disabled later model is flawed too, because it assumes a
fixed list of clocks, but which clocks actually get used may very well
depend on whether e.g. a vga or hdmi monitor is attached, so u-boot
would then still need to communicate the list of clocks actually used
somehow, and if it needs to pass a list of clocks, the most natural
way to do so is through a clocks property...

Regards,

Hans
