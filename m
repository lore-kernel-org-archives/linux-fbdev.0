From: David Herrmann <dh.herrmann@gmail.com>
Date: Fri, 09 Dec 2016 13:57:24 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <CANq1E4S51c-fwJMN2P9MnhuErANvwfy41W2WBSSXrFPS3DXPkg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdWsKqgvB8QtG6SjHO-mceB5fRK9G51y8RYeos0Ym7pgdA@mail.gmail.com>
 <20161208140210.rfyjf2265flsfpfj@phenom.ffwll.local>
 <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
 <1481232877.26959.52.camel@kernel.crashing.org>
 <1481234249.26959.55.camel@kernel.crashing.org>
 <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
 <1481283856.27965.11.camel@kernel.crashing.org>
 <20161209133339.3cpvuxerimoc5huf@phenom.ffwll.local>
In-Reply-To: <20161209133339.3cpvuxerimoc5huf@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hey

On Fri, Dec 9, 2016 at 2:33 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
>> > So it is possible, only reason vram dumb buffers look worse is that there's
>> > only 3 and no one cares about them, vs about 20 and a very active community
>> > of contributors (also for core drm improvements) for the other case.
>>
>> Well, we could move offb to drm while at it I suppose that would be another
>> one (offb is the "dumb driver based on pre-programmed output by firmware).
>
> One of the still in-flight drm drivers is the simpledrm thing meant for
> all kinds of firmware drivers like efifb and similar things on arm for
> pre-programmed output set up by firmware. I.e. no modeset support and
> otherwise a lot of fake to make it work as drm driver, but the idea that
> it's good enough until your real drm driver takes over.

The x86 platform device fixups for SimpleDRM went in some weeks ago,
so maybe I should resend the patches. The driver could easily do
'offb'-like devices as well. Trivial to add.

Anyway, Benjamin is right, we always do shadow buffering for trivial
drivers. Even in SimpleDRM I blit the shadow buffer on page-flip or
dirty-ioctl. Reason is that we cannot easily expose the real
framebuffer in DRM via FB-objects. But I also never saw a use-case for
it, since all trivial devices I worked with were only either used as
fallback or nobody cared for performance.

The generic DRM API is designed for dynamic FB allocation. If your
hardware does not allow you to change the scanout source, you will
have a hard time trying to expose the static buffers via the dynamic
FB-object API. Furthermore, all DRM user-space expects dynamic FB
management to work, preferably without a ridiculously low memory
limit. That's also why I never bothered changing the drivers.

Despite all of this I still see no reason why a driver could not
expose the static, real frambuffers via private ioctls. You can get
all your fancy acceleration that way. Then fix user-space to use this
API. If enough drivers end up with something similar, move it into the
core. Just like we always do in DRM.

Thanks
David
