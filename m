From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Sun, 24 Apr 2016 10:16:34 +0000
Subject: Re: [PATCH 2/8] drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
Message-Id: <CACvgo50K2zsrazdcNCCXgTtQTab2FTAvF1-8m=o=+MUwJHN8fg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-3-git-send-email-noralf@tronnes.org>
 <20160420174241.GP2510@phenom.ffwll.local>
 <5717C742.7080807@tronnes.org>
 <20160421072847.GW2510@phenom.ffwll.local>
 <57191988.3020904@tronnes.org>
 <20160422082415.GG2510@phenom.ffwll.local>
In-Reply-To: <20160422082415.GG2510@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On 22 April 2016 at 09:24, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, Apr 21, 2016 at 08:18:48PM +0200, Noralf Trønnes wrote:
>>
>> Den 21.04.2016 09:28, skrev Daniel Vetter:
>> >On Wed, Apr 20, 2016 at 08:15:30PM +0200, Noralf Trønnes wrote:
>> >>Den 20.04.2016 19:42, skrev Daniel Vetter:
>> >>>On Wed, Apr 20, 2016 at 05:25:23PM +0200, Noralf Trønnes wrote:
>> >>>>Now that drm_fb_helper gets deferred io support, the
>> >>>>drm_fb_helper_sys_{fillrect,copyarea,imageblit} functions will schedule
>> >>>>the worker that calls the deferred_io callback. This will break this
>> >>>>driver so use the sys_{fillrect,copyarea,imageblit} functions directly.
>> >>>>
>> >>>>Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
>> >>>I think this intermediately breaks the build, if you disable fbdev
>> >>>support. That's now supported in the fbdev helpers core generically across
>> >>>all drivers.
>> >>>
>> >>>Not sure how to best fix this up, since the only way would be to squash
>> >>>these patches, plus generic deferred io plus the conversion patches for
>> >>>udl/qxl all into one. Tricky.
>> >>Yes you're right, I missed that.
>> >>How about this:
>> >>#ifdef CONFIG_FB
>> >>         sys_fillrect(info, rect);
>> >>#endif
>> >>
>> >>The later patch will then remove this ugliness...
>> >Yeah I think we have to bite the bullet and take this temporary ugliness
>> >:(
>>
>> Turns out the #ifdef isn't necessary since FB is always selected.
>>
>> Both udl and qxl have this:
>>         select DRM_KMS_HELPER
>>         select DRM_KMS_FB_HELPER
>>
>> And then we have:
>>
>> config DRM_KMS_HELPER
>>         tristate
>>         depends on DRM
>>
>> config DRM_KMS_FB_HELPER
>>         bool
>>         depends on DRM_KMS_HELPER
>>         select FB
>>         ...
>>         select FB_SYS_FILLRECT
>>         select FB_SYS_COPYAREA
>>         select FB_SYS_IMAGEBLIT
>
> Hm ... the thing that actually builds fbdev emulation is
> DRM_FBDEV_EMULATION, and you can disable that. Otoh the select FB stuff
> seems to be at the wrong level and probably should be moved.
>
> But indeed I tried doing this and it's an impossible config. I guess I
> need to type a patch to ditch all these selects from drivers ;-)
That's a great idea imho.

Note that some drivers still partially use FB directly - radeon comes
to mind. Last time I've looked there was no particular reason for
that, as relevant fb_helper already exists.
In general I'm wondering if one cannot check-in a new cocci script
with each function that get factored out. Even if they don't produce
nice (enough) patches they will serve as a nice warning/sanity check,
right ?

If anyone is wondering "Why should we bother?", mostly because people
(too) often base their work before said functionality/helper has
landed. There's also that we cannot catch everything during review ;-)

Regards,
Emil
