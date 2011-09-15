From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 15 Sep 2011 17:12:43 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <4E72320B.6020000@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti> <yunboul7sx7.fsf@aiko.keithp.com> <1316100594.23214.65.camel@deskari> <yun8vpp7qk7.fsf@aiko.keithp.com>
In-Reply-To: <yun8vpp7qk7.fsf@aiko.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keith Packard <keithp@keithp.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-dev@lists.linaro.org, "Clark, Rob" <rob@ti.com>, Archit Taneja <archit@ti.com>

On 09/15/2011 03:50 PM, Keith Packard wrote:
> On Thu, 15 Sep 2011 18:29:54 +0300, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> 
>> 1) It's part of DRM, so it doesn't help fb or v4l2 drivers. Except if
>> the plan is to make DRM the core Linux display framework, upon which
>> everything else is built, and fb and v4l2 are changed to use DRM.
> 
> I'd like to think we could make DRM the underlying display framework;
> it already exposes an fb interface, and with overlays, a bit more of the
> v4l2 stuff is done as well. Certainly eliminating three copies of mode
> setting infrastructure would be nice...

Interesting that this comes from the people that pushed the latest mode setting
code into the kernel. But I don't think that this will happen, the exposed user
interfaces will be around for decades and the infrastructure code could be
shared, in theory.
For fb and V4L2 I think we'll develop some level of interoperability, share
concepts and maybe even some code. The FOURCC pixel formats and overlays are
such examples. As Laurent is really interested in it I think we can get some
nice progress here.
For fb and DRM the situation is entirely different. The last proposal I remember
ended in the DRM people stating that only their implementation is acceptable as
is and we could use it. Such attitude is not helpful and as I don't see any
serious intention of the DRM guys to cooperate I think those subsystems are more
likely to diverge. At least I'll never accept any change to the fb
infrastructure that requires DRM.


Regards,

Florian Tobias Schandinat
