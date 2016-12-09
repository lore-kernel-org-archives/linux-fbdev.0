From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 09 Dec 2016 14:04:56 +0000
Subject: Re: [RFC PATCH 0/3] staging: remove fbdev drivers
Message-Id: <20161209140456.7ltqgd4fgg5tykoh@phenom.ffwll.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAMuHMdWtajvNmPvCzWhBTU0iXU0=Ho=9pHHRM=ZiEbWOwA325A@mail.gmail.com>
 <20161208153735.74d7d350@free-electrons.com>
 <CAMuHMdVGqM9JMqWHt+Gcm2PpOV=sdu23+HEPxXhs_8LQJiE=Bw@mail.gmail.com>
 <20161208152134.wnv4j4i6m5xpoycp@phenom.ffwll.local>
 <1481232877.26959.52.camel@kernel.crashing.org>
 <1481234249.26959.55.camel@kernel.crashing.org>
 <20161209083442.peoriqsto2llvl2t@phenom.ffwll.local>
 <1481283856.27965.11.camel@kernel.crashing.org>
 <20161209133339.3cpvuxerimoc5huf@phenom.ffwll.local>
 <CANq1E4S51c-fwJMN2P9MnhuErANvwfy41W2WBSSXrFPS3DXPkg@mail.gmail.com>
In-Reply-To: <CANq1E4S51c-fwJMN2P9MnhuErANvwfy41W2WBSSXrFPS3DXPkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Teddy Wang <teddy.wang@siliconmotion.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnaud Patard <arnaud.patard@rtp-net.org>

On Fri, Dec 09, 2016 at 02:57:24PM +0100, David Herrmann wrote:
> Hey
> 
> On Fri, Dec 9, 2016 at 2:33 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> >> > So it is possible, only reason vram dumb buffers look worse is that there's
> >> > only 3 and no one cares about them, vs about 20 and a very active community
> >> > of contributors (also for core drm improvements) for the other case.
> >>
> >> Well, we could move offb to drm while at it I suppose that would be another
> >> one (offb is the "dumb driver based on pre-programmed output by firmware).
> >
> > One of the still in-flight drm drivers is the simpledrm thing meant for
> > all kinds of firmware drivers like efifb and similar things on arm for
> > pre-programmed output set up by firmware. I.e. no modeset support and
> > otherwise a lot of fake to make it work as drm driver, but the idea that
> > it's good enough until your real drm driver takes over.
> 
> The x86 platform device fixups for SimpleDRM went in some weeks ago,
> so maybe I should resend the patches. The driver could easily do
> 'offb'-like devices as well. Trivial to add.
> 
> Anyway, Benjamin is right, we always do shadow buffering for trivial
> drivers. Even in SimpleDRM I blit the shadow buffer on page-flip or
> dirty-ioctl. Reason is that we cannot easily expose the real
> framebuffer in DRM via FB-objects. But I also never saw a use-case for
> it, since all trivial devices I worked with were only either used as
> fallback or nobody cared for performance.
> 
> The generic DRM API is designed for dynamic FB allocation. If your
> hardware does not allow you to change the scanout source, you will
> have a hard time trying to expose the static buffers via the dynamic
> FB-object API. Furthermore, all DRM user-space expects dynamic FB
> management to work, preferably without a ridiculously low memory
> limit. That's also why I never bothered changing the drivers.
> 
> Despite all of this I still see no reason why a driver could not
> expose the static, real frambuffers via private ioctls. You can get
> all your fancy acceleration that way. Then fix user-space to use this
> API. If enough drivers end up with something similar, move it into the
> core. Just like we always do in DRM.

Well, we don't need a private abi. If we dynamically remap the mmaps and
fixup fbdev to do the same then we could redirect frontbuffer rendering
for the currently displaying buffer to the static, real framebuffer. That
would fix the perf issues Ben is fearing I think.

And if we do some nice ttm helpers to hide this all to the level the cma
helpers are just plug-in-and-go then it'd be real nice I think. But thus
far no one has cared enough yet to make that happen.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
