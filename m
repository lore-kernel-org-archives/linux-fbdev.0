From: Ilija Hadzic <ihadzic@research.bell-labs.com>
Date: Mon, 07 Nov 2011 13:52:25 +0000
Subject: Re: [RFC] Virtual CRTCs (proposal + experimental code)
Message-Id: <Pine.GSO.4.62.1111070728280.18351@umail>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+4h6Hk3gE+8ou6NSMhoGJWZJ-5aM1OgC0HFoKs55fjfQ-qN8g@mail.gmail.com>
	<CAPM=9tyHDGHrRt1uOYR6ksxpxbss7Cbq9brFjpLy1S+kOk9AVw@mail.gmail.com>
In-Reply-To: <CAPM=9tyHDGHrRt1uOYR6ksxpxbss7Cbq9brFjpLy1S+kOk9AVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org



On Mon, 7 Nov 2011, Dave Airlie wrote:

>
> So I expect the way I'd like this to work, is that we have full blown drm
> drivers for all the devices and then some sort of linkage layer between them,
> so one driver can export crtcs from another, instead of having special case
> ctd drivers.

I agree and that is actually a long-term plan from our side. CTD 
functionality should be integral part of existing drivers not the new 
driver, unless there is a new functionality that makes sense as CTD-only 
(like v4l2ctd).

In the world that I imagine, likage layer is VCRTCM. Unaccelerated 
frabebuffer devices (UDL for example, but in general anything that "lives" 
in fbdev world) can choose (based on some policy from userland) whether to 
act as CTD driver and register themselves with VCRTCM (when they want 
acceleration "assistance" from a GPU in the system) or to load as
normal fbdev devices (when they want to run on their own).


> Now I can see the reason for the v4l one, but I have for example
> a udl kms driver, and I'd like to have it work alongside this stuff,
> and userspace
> could bind the crtcs from it to another driver. I'm not sure how much work
> this would be or if its just a matter of adding a CTD interface to the udl kms
> device.
>

The only reason we wrote a new udlctd driver was  because it was quicker 
that way (we just ripped some code from udlfb driver and added our CTD 
functionality).

The plan was always to merge udlctd and udlfb at some point, but first 
I'd like to see how perceptive is the community to the concept. If the 
concept makes sense, then we'll throw in enough programming to consolidate 
the drivers. Nobody wants three competing drivers for the same device 
(udlfb, your udl kms driver and our udlctd).

Speaking of udl driver, is your udl-v2 branch competing with udlfb? 
Externally, they seem to do similar or the same thing, but one is based on 
DRM (and I guess the required DDX is xf86-video-modesetting), while the 
other is based on fbdev and the required DDX is xf8b-video-fbdev. While 
from my perspective both could be consilidated with a CTD functionality, 
but it makes me wonder in which direction is the community development 
moving: is everything from fbdev-world moving under DRM as a set of 
unaccelerated KMS drivers or is fbdev staying separate for good ?
Depending on what the trend is, one or the other udl driver (udl-v2 or 
udlfb) will make more sense to be merged with udlctd.

-- Ilija

