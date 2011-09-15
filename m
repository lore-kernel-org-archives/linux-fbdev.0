From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 15 Sep 2011 18:39:21 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <4E724659.5080709@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>	<yunboul7sx7.fsf@aiko.keithp.com>	<1316100594.23214.65.camel@deskari>	<yun8vpp7qk7.fsf@aiko.keithp.com>	<4E72320B.6020000@gmx.de> <CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
In-Reply-To: <CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Keith Packard <keithp@keithp.com>, linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>, "Clark, Rob" <rob@ti.com>

On 09/15/2011 05:52 PM, Alex Deucher wrote:
> On Thu, Sep 15, 2011 at 1:12 PM, Florian Tobias Schandinat
> <FlorianSchandinat@gmx.de> wrote:
>> On 09/15/2011 03:50 PM, Keith Packard wrote:
>>> On Thu, 15 Sep 2011 18:29:54 +0300, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>>
>>>> 1) It's part of DRM, so it doesn't help fb or v4l2 drivers. Except if
>>>> the plan is to make DRM the core Linux display framework, upon which
>>>> everything else is built, and fb and v4l2 are changed to use DRM.
>>>
>>> I'd like to think we could make DRM the underlying display framework;
>>> it already exposes an fb interface, and with overlays, a bit more of the
>>> v4l2 stuff is done as well. Certainly eliminating three copies of mode
>>> setting infrastructure would be nice...
>>
>> Interesting that this comes from the people that pushed the latest mode setting
>> code into the kernel. But I don't think that this will happen, the exposed user
>> interfaces will be around for decades and the infrastructure code could be
>> shared, in theory.
>> For fb and V4L2 I think we'll develop some level of interoperability, share
>> concepts and maybe even some code. The FOURCC pixel formats and overlays are
>> such examples. As Laurent is really interested in it I think we can get some
>> nice progress here.
>> For fb and DRM the situation is entirely different. The last proposal I remember
>> ended in the DRM people stating that only their implementation is acceptable as
>> is and we could use it. Such attitude is not helpful and as I don't see any
>> serious intention of the DRM guys to cooperate I think those subsystems are more
>> likely to diverge. At least I'll never accept any change to the fb
>> infrastructure that requires DRM.
> 
> Not exactly.  This point was that the drm modesetting and EDID
> handling was derived from X which has had 20+ years of of quirks and
> things added to it to deal with tons of wonky monitors and such.  That
> information should be preserved.  As mode structs and EDID handling
> are pretty self contained, why not use the DRM variants of that code
> rather than writing a new version?

Well, I'm not against sharing the code and not against taking DRM's current
implementation as a base but the steps required to make it generally acceptable
would be to split it of, probably as a standalone module and strip all DRM
specific things off. Than all things that require EDID can use it, DRM can add
DRM-specific things on top and fb can add fb-specific things.

> While the DRM has historically targeted 3D acceleration, that is not a
> requirement to use the DRM KMS modesetting API.  The current fb API
> has no concept of display controllers or connectors or overlays, etc.
> To match it to modern hardware, it needs a major overhaul.  Why create
> a new modern fb interface that's largely the same as DRM KMS?  What if
> we just consider the KMS API as the new fb API?  If there are any
> inadequacies in the DRM KMS API we would be happy to work out any
> changes.

Well, I rather think that the fb API is more user centric to allow every program
to use it directly in contrast to the KMS/DRM API which aims to support every
feature the hardware has. For this the fb API should not change much, but I
understand some additions were needed for some special users, probably limited
to X and wayland.
One of my biggest problems with KMS is that it has (naturally) a lot more
complexity than the fb API which leads to instability. Basically it's very
difficult to implement a framebuffer in a way that it crashes your machine
during operation which is quite a contrast to my KMS/DRM experience on my toy
(on my work machines I use framebuffer only). And I really hate it when I have
to type my passwords again just because the KMS/DRM thing allowed a program to
crash my machine. Yes, those are driver bugs but the API encourages them and I
did not yet find the feature/config option DOES_NOT_CRASH or SLOW_BUT_STABLE.
And as I said already, I think the fb API is a lot better for direct interaction
with userspace programs and certainly has more direct users at the moment.

> Please don't claim that the DRM developers do not want to cooperate.
> I realize that people have strong opinions about existing APIs, put
> there has been just as much, if not more obstinacy from the v4l and fb
> people.

Well, I think it's too late to really fix this thing. We now have 3 APIs in the
kernel that have to be kept. Probably the best we can do now is figure out how
we can reduce code duplication and do extensions to those APIs in a way that
they are compatible with each other or completely independent and can be used
across the APIs.


Best regards,

Florian Tobias Schandinat
