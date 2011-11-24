From: Dave Airlie <airlied@gmail.com>
Date: Thu, 24 Nov 2011 08:52:45 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
	<Pine.GSO.4.62.1111232223110.18154@umail>
In-Reply-To: <Pine.GSO.4.62.1111232223110.18154@umail>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ilija Hadzic <ihadzic@research.bell-labs.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Thu, Nov 24, 2011 at 5:59 AM, Ilija Hadzic
<ihadzic@research.bell-labs.com> wrote:
>
>
> On Wed, 23 Nov 2011, Dave Airlie wrote:
>
>> So another question I have is how you would intend this to work from a
>> user POV, like how it would integrate with a desktop environment, X or
>> wayland, i.e. with little or no configuration.
>>
>
> First thing to understand is that when a virtual CRTC is created, it looks
> to the user like the GPU has an additional DisplayPort connector.
> At present I "abuse" DisplayPort, but I have seen that you pushed a patch
> from VMware that adds Virtual connector, so eventually I'll switch to that
> naming. The number of virtual CRTCs is determined when the driver loads and
> that is a static configuration parameter. This does not restrict the user
> because unused virutal CRTCs are just like disconnected connectors on the
> GPU. In extreme case, a user could max out the number of virtual CRTCs (i.e.
> 32 minus #-of-physical-CRTCs), but in general the system needs to be booted
> with maximum number of anticipated CRTCs. Run-time addition and removal of
> CRTCs is not supported at this time and that would be much harder to
> implement and would affect the whole DRM module everywhere.
>
> So now we have a system that booted up and DRM sees all of its real
> connectors as well as virtual ones (as DisplayPorts at present). If there is
> no CTD device attached to virtual CRTCs, these virtual connectors are
> disconnected as far as DRM is concerned. Now the userspace must call
> "attach/fps" ioctl to associate CTDs with CRTCs. I'll explain shortly how to
> automate that and how to eliminate the burden from the user, but for now,
> please assume that "attach/fps" gets called from userland somehow.
>
> When the attach happens, that is a hotplug event (VCRTCM generates it) to
> DRM, just like someone plugged in the monitor. Then when XOrg starts, it
> will use the DisplayPort that represents a virtual CRTC just like any other
> connector. How it will use it, will depend on what the xorg.conf says, but
> the key point is that this connector is no different from any other
> connector that the GPU provides and is thus used as an "equal citizen". No
> special configuration is necessary once attached to CTD.
>
> If CTD is detached and new CTD attached, that is just like yanking out
> monitor cable and plugging in the new one. DRM will get all hotplug events
> and windowing system will do the same thing it would normally do with any
> other port. If RANDR is called to resize the desktop it will also work and X
> will have no idea that one of the connectors is on a virtual CRTC. I also
> have another feature, where when CTD is attached, it can ask the device it
> drives for the connection status and propagate that all the way back to DRM
> (this is useful for CTD devices that drive real monitors, like DisplayLink).

Okay so thats pretty much how I expected it to work, I don't think
Virtual makes sense for a displaylink attached device though,
again if you were using a real driver you would just re-use whatever
output type it uses, though I'm not sure how well that works,

Do you propogate full EDID information and all the modes or just the
supported modes? we use this in userspace to put monitor names in
GNOME display settings etc.

what does xrandr output looks like for a radeon GPU with 4 vcrtcs? do
you see 4 disconnected connectors? that again isn't a pretty user
experience.

> So this is your hotplug demo, but the difference is that the new desktop can
> use direct rendering. Also, everything that would work for a normal
> connector works here without having to do any additional tricks. RANDR also
> works seamlessly without having to do anything special. If you move away
> from Xorg, to some other system (Wayland?), it still works for as long as
> the new system knows how to deal with connectors that connect and
> disconnect.

My main problem with this is as I'll explain below it only covers some
of the use cases, and I don't want a 50% solution at this point, by
doing something like this you are making it harder to get proper
support into something like wayland as they can ignore some of the
problems, however since this doesn't solve all the other problems it
means getting to a finished solution is actually less likely to
happen.

>> I still foresee problems with tiling, we generally don't encourage
>> accel code to live in the kernel, and you'll really want a
>> tiled->untiled blit for this thing,
>
> Accel code should not go into the kernel (that I fully agree) and there is
> nothing here that would behove us to do so. Restricting my comments to
> Radeon GPU (which is the only one that I know well enough), shaders for blit
> copy live in the kernel and irrespective of VCRTCM work. I rely on them to
> move the frame buffer out of VRAM to CTD device but I don't add any
> additional features.
>
> Now for detiling, I think that it should be the responsibility of the
> receiving CTD device, not the GPU pushing the data (Alan mentioned that
> during the initial set of comments, and although I didn't say anything to it
> that has been my view as well).

That is a pretty much a fundamental problem, there is no way you can
enumerate all the detiling necessary in the CTD device and there is no
way I'd want to merge that code to the kernel. r600 has 16 tiling
modes (we might only see 2 of these on scanout), r300->r500 have
another different set, r100->r200 have another different set, nouveau
has an major amount of modes, and intel has a full set and has crazy
memory configuration dependant swizzling, then gma500, etc. This just
won't be workable or scalable.

> Even if you wanted to use GPU for detiling (which I'll explain shortly why
> you should not), it would not require any new accel code in the kernel. It
> would merely require one bit flip in the setup of blit copy that already
> lives in the kernel.

That is fine for radeon, not so much for intel, nouveau etc.

> However, de-tiling in GPU is a bad idea for two reasons. I tried to do that
> just as an experiment on Radeon GPUs and watched with the PCI Express
> analyzer what happens on the bus (yeah, I have some "heavy weapons" in my
> lab). Normally a tile is a continuous array of memory locations in VRAM. If
> blit-copy function is told to assume tiled source and linear destination
> (de-tiling) it will read a continuous set of addresses in VRAM, but then
> scatter 8 rows of 8 pixels each on non-contignuous set of addresses of the
> destination. If the destination is the PCI-Express bus, it will result in 8
> 32-byte write transactions instead of 2 128-byte transactions per each tile.
> That will choke the throughput of the bus right there.

The thing is this is how optimus works, the nvidia gpus have an engine
that you can program to move data from the nvidia tiled VRAM format to
the intel main memory tiled format, and make if efficent. radeon's
also have some engines that AMD so far haven't told us about, but
someone with no NDA with AMD could easily start REing that sort of
thing.

>
> Yes the read would be from UMA. I have not yet looked at Intel GPUs in
> detail, so I don't have an answer for you on what problems would pop up and
> how to solve them, but I'll be glad to revisit the Intel discussion once I
> do some homework.

Probably a good idea to do some more research on intel/nvidia GPUs.
With intel you can't read back from UMA since it'll be uncached memory
so unuseable, so you'll need to use the GPU to detile and move to some
sort of cached linear area you can readback from.

>> It also doesn't solve the optimus GPU problem in any useful fashion,
>> since it can't deal with all the use cases, so we still have to write
>> an alternate solution that can deal with them, so we just end up with
>> two answers.
>>
>
> Can you elaborate on some specific use cases that are of your concern? I
> have had this case in mind and I think I can make it work. First I would
> have to add CTD functionality to Intel driver. That should be
> straightforward. Once I get there, I'll be ready to experiment and we'll
> probably be in better position to discuss the specifics then (i.e. when we
> have something working to compare with what you did in PRIME experiemnt),
> but it would be good to know your specific concerns early.
>

Switchable/Optimus mode has two modes of operation,

a) nvidia GPU is rendering engine and the intel GPU is just used as a
scanout buffer for the LVDS panel. This mode is used when an external
digital display is plugged in, or in some plugged in configurations.

b) intel GPU is primary rendering engine, and the nvidia gpu is used
as an offload engine. This mode is used when on battery or power
saving, with no external displays plugged in. You can completely turn
on/off the nvidia GPU.

Moving between a and b has to be completely dynamic, userspace apps
need to deal with the whole world changing beneath them.

There is also switchable graphics mode, where there is a MUX used to
switch the outputs between the two GPUs.

So the main problem with taking all this code on-board is it sort of
solves (a), and (b) needs another bunch of work. Now I'd rather not
solve 50% of the issue and have future userspace apps just think they
can ignore the problem. As much as I dislike the whole dual-gpu setups
the fact is they exist and we can't change that, so writing userspace
to ignore the problem because its too hard isn't going to work. So if
I merge this VCRTC stuff I give a lot of people an excuse for not
bothering to fix the harder problems that hotplug and dynamic GPUs put
in front of you.

Dave.
>
> thanks,
>
> Ilija
>
>
