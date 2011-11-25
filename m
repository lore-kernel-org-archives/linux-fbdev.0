From: Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Fri, 25 Nov 2011 04:08:36 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <Pine.GSO.4.62.1111241821200.21266@umail>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<CAPM=9tyPOkS7w3593-3ZtjSN6E+cO82125Lpmn2er8r9=PzROQ@mail.gmail.com>
	<Pine.GSO.4.62.1111232223110.18154@umail>
	<CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
In-Reply-To: <CAPM=9tx3ue8+PQ6QBxL_0Do2kLB01Q0yN-FOZrJkY2RKiyNm4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org



On Thu, 24 Nov 2011, Dave Airlie wrote:

> Okay so thats pretty much how I expected it to work, I don't think
> Virtual makes sense for a displaylink attached device though,
> again if you were using a real driver you would just re-use whatever
> output type it uses, though I'm not sure how well that works,

That is the consequence of the fact that virtual CRTCs are created at 
startup time when attached CTD is not known, while CTDs are attached at 
runtime. So when I register the virtual CRTC and the associated connector 
I have to use something for the connector type.

Admitting that my logic is biased by my design, to me "Virtual" connector 
type is an indicative that from GPU's perspective it's a connector that 
does not physically exist and is yet to be attached to some real display 
device. At that point the properties of the attached display become known 
to the system.

>
> Do you propogate full EDID information and all the modes or just the
> supported modes? we use this in userspace to put monitor names in
> GNOME display settings etc.
>

Right now we propagate the entire list of modes that the attached CTD 
device has queried from the connected display (monitor). Propagating full 
EDID is really easy to add. That's if the CTD is driver for some real 
display. If CTD is just a "make-believe" display whose purpose is to be 
the conduit to some other pixel-processing component (e.g. V4L2CTD), then 
at some point in the chain we have to make up the set of modes that the 
logical display accepts and in that case the EDID does not exist by 
definition.

> what does xrandr output looks like for a radeon GPU with 4 vcrtcs? do
> you see 4 disconnected connectors? that again isn't a pretty user
> experience.
>

Yes it shows 4 disconnected monitors. To me that is a logical consequence 
of the design in which virtual CRTCs and associated virtual connectors are 
always there. By know, it's clear to me that you are not too thrilled 
about it, but please allow me to turn the question back to you: in your 
solution with udl-v2 driver and a dedicated DDX for it, can you do the big 
desktop that spans across GPU's local and "foreign" displays and have 
acceleration on both? If not, what would it take you to get there and how 
complex the end result will be?

I'll get to Optimus/PRIME use case later, but if we for the moment focus 
on the use case in which a dumb framebuffer device extens the number of 
displays of a rendering-capable GPU, I think that VCRTCM offers quite a 
complete and universal solution and it is completely transparent with 
regard to the application, window manager, and display server.

Radeon + DisplayLink is the specific example. But in general it's Any GPU 
+ Any fbdev. It's not just one use case, it's a whole class of use cases
that would follow the same principle and for then the VCRTC alone 
suffices.


> My main problem with this is as I'll explain below it only covers some
> of the use cases, and I don't want a 50% solution at this point, by
> doing something like this you are making it harder to get proper
> support into something like wayland as they can ignore some of the
> problems, however since this doesn't solve all the other problems it
> means getting to a finished solution is actually less likely to
> happen.
>

I presume that by 50% solution you are referring to Optimus/PRIME use 
case. That case actually consists of two related, but different problems. 
First is "render on node X and display on node Y" and the second is 
"dynamically and hitlessly switch rendering between node X and Y".

I have never claimed that VCRTCs solve the second problem (I could switch 
by restarting Xorg, but I know that this is not the solution you are 
looking for). I fully understand why you want both problems solved at the 
same time. However, I don't understand why solving one first would inhibit 
solving the other.

On the other hand, the Radeon + DisplayLink tandem use case (or in general 
GPU + fbdev tandem) consists only of "render on X, display on Y" problem. 
Here, you will probably say that there one can switch between hardware and 
software rendering and that it also has both problems. That is true, but 
unlike the Optimus/PRIME use case, using fbdev as a display extension to 
GPU is still useful alone. My point is that there is a value in solving 
first one problem and then follow with the other.

I think the crux of the problem is that you are not convinced that the
VCRTCM solution for problem #1 will make solving problem #2 easier and 
maybe you are afraid that it will make it harder. If that's a fair 
statement and if having me create an existence proof for problem #2 that 
still uses VCRTCM will help bring our positions closer, I am perfectly 
willing to do so .... I guess I've just signed up for some hacking ;-)

Note that for hitless GPU switching, I fully agree that support must be in 
userspace (you have to swap out paths in Mesa and DDX before even getting 
to kernel), but like I said, that is a separate problem from redirecting 
the display to another node.


> r600 has 16 tiling
> modes (we might only see 2 of these on scanout)

But VCRTC emulates a CRTC, so the only ones relevant are those that we see 
on the scnout. Do we really anticipate using all 16 for CRTC buffers ?

>
> The thing is this is how optimus works, the nvidia gpus have an engine
> that you can program to move data from the nvidia tiled VRAM format to
> the intel main memory tiled format, and make if efficent. radeon's
> also have some engines that AMD so far haven't told us about, but
> someone with no NDA with AMD could easily start REing that sort of
> thing.
>

If we could have every GPU efficiently push out pixels in some "common 
denominator" format that would be ideal, but at this time, the reality is 
far from it. Whether the obstacles are technical or legal, doesn't matter.

I fully understand your concern about the number of tiling/detiling 
combinations getting out of control, but I am not sure that the problem is 
as bad as you picture it if CRTC buffer uses only a subset of available 
tiling modes.



>
> Switchable/Optimus mode has two modes of operation,
>
> a) nvidia GPU is rendering engine and the intel GPU is just used as a
> scanout buffer for the LVDS panel. This mode is used when an external
> digital display is plugged in, or in some plugged in configurations.
>
> b) intel GPU is primary rendering engine, and the nvidia gpu is used
> as an offload engine. This mode is used when on battery or power
> saving, with no external displays plugged in. You can completely turn
> on/off the nvidia GPU.
>
> Moving between a and b has to be completely dynamic, userspace apps
> need to deal with the whole world changing beneath them.
>

So case a) is "render on X display on Y" problem and case b) (when NVidia 
is turned off, offload aside) is just a traditional rendering on one 
(Intel) GPU.  Real sticky point is dynamic switching and offload.

> There is also switchable graphics mode, where there is a MUX used to
> switch the outputs between the two GPUs.
>

One question for my education: I understand that MUX is essentially a 
switch outside the two GPUs that selects whether the output takes NVidia's 
"connector" or Intel's "connector", right ? When MUX is involved, then you 
don't have "render on X display on Y" problem at all, but it's only the 
"dynamic switching" problem. Is my understanding correct ?

There are also MUX-less laptops, where you only have case a)/b) that you 
described above, right ?


> So the main problem with taking all this code on-board is it sort of
> solves (a), and (b) needs another bunch of work. Now I'd rather not
> solve 50% of the issue and have future userspace apps just think they
> can ignore the problem. As much as I dislike the whole dual-gpu setups
> the fact is they exist and we can't change that, so writing userspace
> to ignore the problem because its too hard isn't going to work. So if
> I merge this VCRTC stuff I give a lot of people an excuse for not
> bothering to fix the harder problems that hotplug and dynamic GPUs put
> in front of you.
>

Point taken. I still think that we are actually dealing with two separate 
problems, but you have your reasons why you want them solved together.
I also have a few more use cases which are solved with VCRTCM only and 
don't need dynamic switching, so these and also "3D Accel + DisplayLink" 
one will suffer by having to wait for full solution that covers all use 
cases, but that's your call and I don't question it.

I hope that you are not categorically dismissing an option that the 
solution can be implemented on the top of VCRTCM and that if I come back 
with some more code that shows that it addresses your concern that you 
will be perceptive to another round of review. I do appreciate you taking 
the time to look at this. I know that you are overbusy with day-to-day 
patches and merging.

I understand that the burden of building an existence proof falls on me 
and I am perfectly fine with that. BTW, If some poor soul reading this 
buys into my arguments and wants to join me in some hacking, I'd 
definitely welcome the collaboration ;-).

-- Ilija


