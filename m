From: Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Thu, 24 Nov 2011 05:59:05 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <Pine.GSO.4.62.1111232223110.18154@umail>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
In-Reply-To: <CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org



On Wed, 23 Nov 2011, Dave Airlie wrote:

> So another question I have is how you would intend this to work from a
> user POV, like how it would integrate with a desktop environment, X or
> wayland, i.e. with little or no configuration.
>

First thing to understand is that when a virtual CRTC is created, it looks 
to the user like the GPU has an additional DisplayPort connector.
At present I "abuse" DisplayPort, but I have seen that you pushed a patch 
from VMware that adds Virtual connector, so eventually I'll switch to that 
naming. The number of virtual CRTCs is determined when the driver loads 
and that is a static configuration parameter. This does not restrict the 
user because unused virutal CRTCs are just like disconnected connectors on 
the GPU. In extreme case, a user could max out the number of virtual CRTCs 
(i.e. 32 minus #-of-physical-CRTCs), but in general the system needs to be 
booted with maximum number of anticipated CRTCs. Run-time addition and 
removal of CRTCs is not supported at this time and that would be much 
harder to implement and would affect the whole DRM module everywhere.

So now we have a system that booted up and DRM sees all of its real 
connectors as well as virtual ones (as DisplayPorts at present). If there 
is no CTD device attached to virtual CRTCs, these virtual connectors are 
disconnected as far as DRM is concerned. Now the userspace must call 
"attach/fps" ioctl to associate CTDs with CRTCs. I'll explain shortly how 
to automate that and how to eliminate the burden from the user, but for 
now, please assume that "attach/fps" gets called from userland somehow.

When the attach happens, that is a hotplug event (VCRTCM generates it) to 
DRM, just like someone plugged in the monitor. Then when XOrg starts, it
will use the DisplayPort that represents a virtual CRTC just like any 
other connector. How it will use it, will depend on what the xorg.conf 
says, but the key point is that this connector is no different from any 
other connector that the GPU provides and is thus used as an "equal 
citizen". No special configuration is necessary once attached to CTD.

If CTD is detached and new CTD attached, that is just like yanking out 
monitor cable and plugging in the new one. DRM will get all hotplug events 
and windowing system will do the same thing it would normally do with any 
other port. If RANDR is called to resize the desktop it will also work and 
X will have no idea that one of the connectors is on a virtual CRTC. I 
also have another feature, where when CTD is attached, it can ask the 
device it drives for the connection status and propagate that all the way 
back to DRM (this is useful for CTD devices that drive real monitors, like 
DisplayLink).

So now let's go back to the attach/fps ioctl. To attach a CTD device this 
ioctl must happen as a result of some policy. That can be done by having 
CTD device generate UDEV events when it loads for which one can write 
policies to determine which CTD device attaches to which virtual CRTC.
Ultimately that becomes an user configuration, but it's no different from 
what one has to do now with UDEV policies to customize the system.

Having explained this, let's take your hotplug example that you put up on 
your web page and redo it with virtual CRTCs. Here is how it would work: 
Boot up the system and tell the GPU to create a few virtual CRTCs. Bring 
up Xorg with no DisplayLink dongles in it. Now plug in the DisplayLink. 
Once the CTD driver loads as the result of the hotplug (right now UDLCTD 
is a separate driver, but as we discussed before, this is a temporary 
state and at some point its CTD function should be merged wither with 
UDLFB or with your UDL-V2) CTD function in the driver generates an UDEV 
event. The policy directs UDEV to call run the program that issues the 
ioctl to perform attach/fps. Attach/fps of the UDLCTD is now a hotplug 
event and DRM "thinks" that a new connector changed the status from 
disconnected to connected. That causes it to query the modes for the new 
connector and because it's the virtual CRTC, it lands in the virtual CRTC 
helpers in the GPU driver. Virtual CRTC helpers route it to VCRTCM, which 
further routes to it to CTD (UDLCTD in this case). CTD returns the modes 
and DRM gets them ... the rest you know better than me what happens ;-)

So this is your hotplug demo, but the difference is that the new desktop 
can use direct rendering. Also, everything that would work for a normal 
connector works here without having to do any additional tricks. RANDR 
also works seamlessly without having to do anything special. If you move 
away from Xorg, to some other system (Wayland?), it still works for as 
long as the new system knows how to deal with connectors that connect and 
disconnect.

Everything I described above is ready to go except the UDEV event from 
UDLCTD and UDEV rules to automate this. Both are straightforwar and won't 
take long to do. So very shortly, I'll be able to show the hotplug-bis.

From what you wrote in your blog, it sounds like this is exactly what you 
are looking for. I recognize that it disrupts your current views/plans on 
how this should be done, but I do want to work with you to find a suitable 
middle ground that covers most of the possiblities.

In case you are looking at my code to follow the above-described 
scenarios, please make sure you pull the latest stuff from my github 
repository. I have been pushing new stuff since my original annoucement.


> I still foresee problems with tiling, we generally don't encourage
> accel code to live in the kernel, and you'll really want a
> tiled->untiled blit for this thing,

Accel code should not go into the kernel (that I fully agree) and there is 
nothing here that would behove us to do so. Restricting my comments to 
Radeon GPU (which is the only one that I know well enough), shaders for 
blit copy live in the kernel and irrespective of VCRTCM work. I rely on 
them to move the frame buffer out of VRAM to CTD device but I don't add 
any additional features.

Now for detiling, I think that it should be the responsibility of the 
receiving CTD device, not the GPU pushing the data (Alan mentioned that 
during the initial set of comments, and although I didn't say anything to 
it that has been my view as well).

Even if you wanted to use GPU for detiling (which I'll explain shortly why 
you should not), it would not require any new accel code in the kernel. It 
would merely require one bit flip in the setup of blit copy that already 
lives in the kernel.

However, de-tiling in GPU is a bad idea for two reasons. I tried to do 
that just as an experiment on Radeon GPUs and watched with the PCI Express 
analyzer what happens on the bus (yeah, I have some "heavy weapons" in my 
lab). Normally a tile is a continuous array of memory locations in VRAM. 
If blit-copy function is told to assume tiled source and linear 
destination (de-tiling) it will read a continuous set of addresses in 
VRAM, but then scatter 8 rows of 8 pixels each on non-contignuous set of 
addresses of the destination. If the destination is the PCI-Express bus, 
it will result in 8 32-byte write transactions instead of 2 128-byte 
transactions per each tile. That will choke the throughput of the bus 
right there.

BTW, this is the crux of the blit-copy performance improvement that you 
got from me back in October. Since blit-copy deals with copying a linear 
array, playing with tiled/non-tiled bits only affects the order in which 
addresses are accessed, so the trick was to get rid of short PCIe 
transactions and also shape up linear to rectangle mapping to make address 
pattern more friendly for the host.


> also for Intel GPUs where you have
> UMA, would you read from the UMA.
>

Yes the read would be from UMA. I have not yet looked at Intel GPUs in 
detail, so I don't have an answer for you on what problems would pop up 
and how to solve them, but I'll be glad to revisit the Intel discussion 
once I do some homework.

Some initial thoughts is that frame buffer in Intel are at the end of the 
day pages in the system memory, so anyone/anything can get to them if they 
are correctly mapped.


> It also doesn't solve the optimus GPU problem in any useful fashion,
> since it can't deal with all the use cases, so we still have to write
> an alternate solution that can deal with them, so we just end up with
> two answers.
>

Can you elaborate on some specific use cases that are of your concern? I 
have had this case in mind and I think I can make it work. First I would 
have to add CTD functionality to Intel driver. That should be 
straightforward. Once I get there, I'll be ready to experiment and we'll 
probably be in better position to discuss the specifics then (i.e. when we 
have something working to compare with what you did in PRIME experiemnt), 
but it would be good to know your specific concerns early.


thanks,

Ilija

