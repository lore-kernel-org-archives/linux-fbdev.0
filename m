From: Michal Suchanek <hramrach@gmail.com>
Date: Tue, 26 Aug 2014 08:45:51 +0000
Subject: Re: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
Message-Id: <CAOMqctT-P=UEBo43yW01XM2LU=ex248aCr6D7VYox-XuZ1hk3A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <53EB9471.3090204@wwwdotorg.org> <20140813170106.GT15297@lukather>
 <20140825121228.GB4163@ulmo.nvidia.com>
 <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com> <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com> <20140825145854.GA15297@lukather>
 <20140825150501.GE14763@ulmo.nvidia.com> <20140825152232.GE15297@lukather>
 <20140826080432.GD17263@ulmo>
In-Reply-To: <20140826080432.GD17263@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 26 August 2014 10:04, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Mon, Aug 25, 2014 at 05:22:32PM +0200, Maxime Ripard wrote:
>> On Mon, Aug 25, 2014 at 05:05:04PM +0200, Thierry Reding wrote:
>> > On Mon, Aug 25, 2014 at 04:58:54PM +0200, Maxime Ripard wrote:
>> > > On Mon, Aug 25, 2014 at 04:16:29PM +0200, Thierry Reding wrote:
>> > > > On Mon, Aug 25, 2014 at 03:47:43PM +0200, Hans de Goede wrote:
>> > > > > On 08/25/2014 03:39 PM, Thierry Reding wrote:
>> > > > > > On Mon, Aug 25, 2014 at 02:44:10PM +0200, Maxime Ripard wrote:
>> > > > > >> On Mon, Aug 25, 2014 at 02:12:30PM +0200, Thierry Reding wrote:
>> > > > > >>> On Wed, Aug 13, 2014 at 07:01:06PM +0200, Maxime Ripard wrote:
>> > > > > >>>> On Wed, Aug 13, 2014 at 10:38:09AM -0600, Stephen Warren wrote:
>> > > > > >>> [...]
>> > > > > >>>>> If not, perhaps the clock driver should force the clock to be
>> > > > > >>>>> enabled (perhaps only if the DRM/KMS driver isn't enabled?).
>> > > > > >>>>
>> > > > > >>>> I'm sorry, but I'm not going to take any code that will do that in our
>> > > > > >>>> clock driver.
>> > > > > >>>>
>> > > > > >>>> I'm not going to have a huge list of ifdef depending on configuration
>> > > > > >>>> options to know which clock to enable, especially when clk_get should
>> > > > > >>>> have the consumer device as an argument.
>> > > > > >>>
>> > > > > >>> Are you saying is that you want to solve a platform-specific problem by
>> > > > > >>> pushing code into simple, generic drivers so that your platform code can
>> > > > > >>> stay "clean"?
>> > > > > >>
>> > > > > >> Are you saying that this driver would become "dirty" with such a patch?
>> > > > > >
>> > > > > > Yes. Others have said the same and even provided alternative solutions
>> > > > > > on how to solve what's seemingly a platform-specific problem in a
>> > > > > > platform-specific way.
>> > > > >
>> > > > > This is not platform specific, any platform with a complete clock driver
>> > > > > will suffer from the same problem (the clock driver disabling unclaimed
>> > > > > ahb gates, and thus killing the video output) if it wants to use simplefb
>> > > > > for early console support.
>> > > >
>> > > > It is platform specific in that your platform may require certain clocks
>> > > > to remain on.
>> > >
>> > > The platform doesn't. simplefb does. simplefb is the obvious consumer
>> > > for these clocks, and given the current API and abstraction we have,
>> > > it should be the one claiming the clocks too.
>> >
>> > No. simplefb just wants to write to some memory that hardware has been
>> > set up to scan out. The platform requires that the clocks be on. Other
>> > platforms may not even allow turning off the clocks.
>>
>> Like what? the rpi? Come on. Just because the videocore is some black
>> box we know nothing about doesn't mean we should use it as an example.
>
> You make it sound like the Raspberry Pi is somehow less important than
> sunxi.

No. It's just bad example for driver development because on rpi you
are not in control of the hardware. Then the issue of enabling and
disabling clock becomes moot because you do not have access to clock
at all.

>
>> Any decent enough SoC, with a decent support in the kernel will have
>> clocks for this, and I really wonder how simplefb will behave once its
>> clocks will be turned off...
>
> There are other devices besides ARM SoCs that may want to use this
> driver and that don't have clock support.

Then the clock support part should be compiled out in that case. Just
like any other driver that has code that is disabled when some kernel
susbsystem is compiled out.

>
> But you're missing my point. What I'm saying is that the simplefb driver
> is meant to serve as a way to take over whatever framebuffer a firmware
> set up. Therefore I think it makes the most sense to assume that nothing
> needs to be controlled in any way since already been set up by firmware.
> Eventually there should be a driver that takes over from simplefb that
> knows how to properly handle the device's specifics, but that's not
> simplefb.

The simplefb driver is not controlling anything but is using resources
set up by firmware.

Currently DT has no way to express that state so the proposed solution
is to state in DT that simplefb controls the resources that are needed
for the framebuffer on the platform. Which resources are that is
platform specific and that platform specific is handled by the
bootloader that fills in what resources simplefb so 'controls' in its
DT node.

This way the resource is not disabled by the generic kernel framework
such as the clock framework.

>
> The goal of this patch series is to keep clocks from being turned off.
> But that's not what it does. What it does is turn clocks on to prevent
> them from being turned off. In my opinion that's a workaround for a
> deficiency in the kernel (and the firmware/kernel interface) and I think
> it should be fixed at the root. So a much better solution would be to
> establish a way for firmware to communicate to the kernel that a given
> resource has been enabled by firmware and shouldn't be disabled.

That's not the case here. If you later decide you do not want a
framebuffer you should be able to stop simplefb, disable the clock
that it claimed and reclaim the fb memory even if you do not replace
it with a full KMS driver. That way you would not need a special
'headless server bootloader' so long as you do not mind your server os
installation enables the display temporarily during boot.

Thanks

Michal
