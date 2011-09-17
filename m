From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 17 Sep 2011 16:11:47 +0000
Subject: Re: Proposal for a low-level Linux display framework
Message-Id: <4E74C6C3.2000704@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1316088425.11294.78.camel@lappyti>	<yunboul7sx7.fsf@aiko.keithp.com>	<1316100594.23214.65.camel@deskari>	<yun8vpp7qk7.fsf@aiko.keithp.com>	<4E72320B.6020000@gmx.de>	<CADnq5_NnzLtJmSzOgyppnBtv96DRTJ71u6ZSrs56KJ-F5CC-mw@mail.gmail.com>	<4E724659.5080709@gmx.de>	<20110915195804.4e6d965b@lxorguk.ukuu.org.uk>	<CAMP44s1ywhCV+FaudnwjwJUvj5Cf3_oz1M++kjXxRDGQpJ6-0w@mail.gmail.com>
	<CAF6AEGu2-O+2KuCrQPJ6-xejg8TCScrFVZSimgkAV_5Xs-bgkg@mail.gmail.com>
In-Reply-To: <CAF6AEGu2-O+2KuCrQPJ6-xejg8TCScrFVZSimgkAV_5Xs-bgkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Clark <rob@ti.com>
Cc: linux-fbdev@vger.kernel.org, linaro-dev@lists.linaro.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

On 09/17/2011 03:16 PM, Rob Clark wrote:
>>From userspace perspective, fbdev doesn't go away.  It is just a
> legacy interface provided on top of DRM/KMS driver mostly via helper
> functions.  With this approach, you get the richer KMS API (and all
> the related plumbing for hotplug, EDID parsing, multi-head support,
> flipping, etc) for userspace stuff that needs that, but can keep the
> fbdev userspace interface for legacy apps.  It is the best of both
> worlds.  There isn't really any good reason to propagate standalone
> fbdev driver anymore.

I disagree. This depends on the functionality the hardware has, the desired
userspace and the manpower one has to do it. And of course if you just want fb
having fb via DRM/KMS has some overhead/bloat. It's perfectly okay to have just
an fb driver for devices that can't do more anyway.
And fb is no legacy interface but actively developed, just with other goals than
DRM/KMS is, it aims for stability and to provide a direct interface, not needing
any X or wayland crap.


Best regards,

Florian Tobias Schandinat
