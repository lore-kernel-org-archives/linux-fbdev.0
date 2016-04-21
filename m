From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Thu, 21 Apr 2016 18:18:48 +0000
Subject: Re: [PATCH 2/8] drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
Message-Id: <57191988.3020904@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
 <1461165929-11344-3-git-send-email-noralf@tronnes.org>
 <20160420174241.GP2510@phenom.ffwll.local> <5717C742.7080807@tronnes.org>
 <20160421072847.GW2510@phenom.ffwll.local>
In-Reply-To: <20160421072847.GW2510@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, laurent.pinchart@ideasonboard.com, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org


Den 21.04.2016 09:28, skrev Daniel Vetter:
> On Wed, Apr 20, 2016 at 08:15:30PM +0200, Noralf Tr=F8nnes wrote:
>> Den 20.04.2016 19:42, skrev Daniel Vetter:
>>> On Wed, Apr 20, 2016 at 05:25:23PM +0200, Noralf Tr=F8nnes wrote:
>>>> Now that drm_fb_helper gets deferred io support, the
>>>> drm_fb_helper_sys_{fillrect,copyarea,imageblit} functions will schedule
>>>> the worker that calls the deferred_io callback. This will break this
>>>> driver so use the sys_{fillrect,copyarea,imageblit} functions directly.
>>>>
>>>> Signed-off-by: Noralf Tr=F8nnes <noralf@tronnes.org>
>>> I think this intermediately breaks the build, if you disable fbdev
>>> support. That's now supported in the fbdev helpers core generically acr=
oss
>>> all drivers.
>>>
>>> Not sure how to best fix this up, since the only way would be to squash
>>> these patches, plus generic deferred io plus the conversion patches for
>>> udl/qxl all into one. Tricky.
>> Yes you're right, I missed that.
>> How about this:
>> #ifdef CONFIG_FB
>>          sys_fillrect(info, rect);
>> #endif
>>
>> The later patch will then remove this ugliness...
> Yeah I think we have to bite the bullet and take this temporary ugliness
> :(

Turns out the #ifdef isn't necessary since FB is always selected.

Both udl and qxl have this:
         select DRM_KMS_HELPER
         select DRM_KMS_FB_HELPER

And then we have:

config DRM_KMS_HELPER
         tristate
         depends on DRM

config DRM_KMS_FB_HELPER
         bool
         depends on DRM_KMS_HELPER
         select FB
         ...
         select FB_SYS_FILLRECT
         select FB_SYS_COPYAREA
         select FB_SYS_IMAGEBLIT


Noralf.

