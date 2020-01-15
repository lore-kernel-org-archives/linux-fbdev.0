From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 15 Jan 2020 13:09:36 +0000
Subject: Re: [PATCH] fbdev: potential information leak in do_fb_ioctl()
Message-Id: <6ed59903-afe7-d5b2-73eb-ca626616dd6f@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191029182320.GA17569@mwanda>
 <CGME20191029190229epcas3p4e9b24bd8cde962681ef3dc4644ed2c2e@epcas3p4.samsung.com>
 <87zhhjjryk.fsf@x220.int.ebiederm.org>
 <fd4e6f01-074b-def7-7ffb-9a9197930c31@samsung.com>
 <CAK8P3a2uLm9pJtx42qDXJSdD71-dVW6+iDcRAnEB85Ajak-HLw@mail.gmail.com>
In-Reply-To: <CAK8P3a2uLm9pJtx42qDXJSdD71-dVW6+iDcRAnEB85Ajak-HLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, security@kernel.org, Gerd Hoffmann <kraxel@redhat.com>, Kees Cook <keescook@chromium.org>, kernel-janitors@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Julia Lawall <Julia.Lawall@lip6.fr>, "Eric W. Biederman" <ebiederm@xmission.com>, Joe Perches <joe@perches.com>, Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>, Dan Carpenter <dan.carpenter@oracle.com>, Andrea Righi <righi.andrea@gmail.com>


On 1/13/20 1:49 PM, Arnd Bergmann wrote:
> On Fri, Jan 3, 2020 at 2:09 PM Bartlomiej Zolnierkiewicz
> <b.zolnierkie@samsung.com> wrote:
>> On 10/29/19 8:02 PM, Eric W. Biederman wrote:
>>>
>>> The goal is to avoid memory that has values of the previous users of
>>> that memory region from leaking to userspace.  Which depending on who
>>> the previous user of that memory region is could tell userspace
>>> information about what the kernel is doing that it should not be allowed
>>> to find out.
>>>
>>> I tried to trace through where "info" and thus presumably "info->fix" is
>>> coming from and only made it as far as  register_framebuffer.  Given
>>
>> "info" (and thus "info->fix") comes from framebuffer_alloc() (which is
>> called by fbdev device drivers prior to registering "info" with
>> register_framebuffer()). framebuffer_alloc() does kzalloc() on "info".
>>
>> Therefore shouldn't memcpy() (as suggested by Jeo Perches) be enough?
> 
> Is it guaranteed that all drivers call framebuffer_alloc() rather than
> open-coding it somewhere?
> 
> Here is a list of all files that call register_framebuffer() without first
> calling framebuffer_alloc:
> 
> $ git grep -wl register_framebuffer | xargs grep -L framebuffer_alloc
> Documentation/fb/framebuffer.rst
> drivers/media/pci/ivtv/ivtvfb.c
> drivers/media/platform/vivid/vivid-osd.c
> drivers/video/fbdev/68328fb.c
> drivers/video/fbdev/acornfb.c
> drivers/video/fbdev/amba-clcd.c
> drivers/video/fbdev/atafb.c
> drivers/video/fbdev/au1100fb.c
> drivers/video/fbdev/controlfb.c
> drivers/video/fbdev/core/fbmem.c
> drivers/video/fbdev/cyber2000fb.c
> drivers/video/fbdev/fsl-diu-fb.c
> drivers/video/fbdev/g364fb.c
> drivers/video/fbdev/goldfishfb.c
> drivers/video/fbdev/hpfb.c
> drivers/video/fbdev/macfb.c
> drivers/video/fbdev/matrox/matroxfb_base.c
> drivers/video/fbdev/matrox/matroxfb_crtc2.c
> drivers/video/fbdev/maxinefb.c
> drivers/video/fbdev/ocfb.c
> drivers/video/fbdev/pxafb.c
> drivers/video/fbdev/sa1100fb.c
> drivers/video/fbdev/stifb.c
> drivers/video/fbdev/valkyriefb.c
> drivers/video/fbdev/vermilion/vermilion.c
> drivers/video/fbdev/vt8500lcdfb.c
> drivers/video/fbdev/wm8505fb.c
> drivers/video/fbdev/xilinxfb.c
> 
> It's possible (even likely, the ones I looked at are fine) that they
> all correctly
> zero out the fb_info structure first, but it seems hard to guarantee, so
> Eric's suggestion would possibly still be the safer choice.

I've audited all above instances and they are all fine. They either
use the fb_info structure embedded in a driver specific structure
(which is zeroed out) or (in case of some m68k specific drivers) use
a static fb_info instance.

Since fbdev is closed for new drivers it should be now fine to use
the simpler approach (just use memcpy()).
 
Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
