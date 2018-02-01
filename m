From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Thu, 01 Feb 2018 15:30:36 +0000
Subject: Re: [PATCH] drm/fb-helper: Scale back depth to supported maximum
Message-Id: <27c55fd6-4c8f-101a-aa44-16c7918adb5d@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180201130446.6165-1-linus.walleij@linaro.org>
 <20180201131907.GO5453@intel.com>
 <0214a021-caae-e21f-f99f-74277b889608@tronnes.org>
In-Reply-To: <0214a021-caae-e21f-f99f-74277b889608@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-fbdev@vger.kernel.org, David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, linux-arm-kernel@lists.infradead.org


Den 01.02.2018 16.15, skrev Noralf Trønnes:
>
> Den 01.02.2018 14.19, skrev Ville Syrjälä:
>> On Thu, Feb 01, 2018 at 02:04:46PM +0100, Linus Walleij wrote:
>>> The following happened when migrating an old fbdev driver to DRM:
>>>
>>> The Integrator/CP PL111 supports 16BPP but only ARGB1555/ABGR1555
>>> or XRGB1555/XBGR1555 i.e. the maximum depth is 15.
>>>
>>> This makes the initialization of the framebuffer fail since
>>> the code in drm_fb_helper_single_fb_probe() assigns the same value
>>> to sizes.surface_bpp and sizes.surface_depth. I.e. it simply assumes
>>> a 1-to-1 mapping between BPP and depth, which is true in most cases
>>> but typically not for this hardware.
>>>
>>> To support the odd case of a driver supporting 16BPP with only 15
>>> bits of depth, this patch will make the code loop over the formats
>>> supported on the primary plane and cap the depth to the maximum
>>> supported.
>>>
>>> On the PL110 Integrator, this makes drm_mode_legacy_fb_format()
>>> select DRM_FORMAT_XRGB1555 which is acceptable for this driver, and
>>> thus we get framebuffer, penguin and console on the Integrator/CP.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>>   drivers/gpu/drm/drm_fb_helper.c | 40 
>>> +++++++++++++++++++++++++++++++++++++++-
>>>   1 file changed, 39 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c 
>>> b/drivers/gpu/drm/drm_fb_helper.c
>>> index e56166334455..5076f9103740 100644
>>> --- a/drivers/gpu/drm/drm_fb_helper.c
>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>>> @@ -1720,6 +1720,8 @@ static int 
>>> drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
>>>       int i;
>>>       struct drm_fb_helper_surface_size sizes;
>>>       int gamma_size = 0;
>>> +    struct drm_plane *plane;
>>> +    int best_depth = 0;
>>>         memset(&sizes, 0, sizeof(struct drm_fb_helper_surface_size));
>>>       sizes.surface_depth = 24;
>>> @@ -1727,7 +1729,10 @@ static int 
>>> drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
>>>       sizes.fb_width = (u32)-1;
>>>       sizes.fb_height = (u32)-1;
>>>   -    /* if driver picks 8 or 16 by default use that for both 
>>> depth/bpp */
>>> +    /*
>>> +     * If driver picks 8 or 16 by default use that for both depth/bpp
>>> +     * to begin with
>>> +     */
>>>       if (preferred_bpp != sizes.surface_bpp)
>>>           sizes.surface_depth = sizes.surface_bpp = preferred_bpp;
>>>   @@ -1762,6 +1767,39 @@ static int 
>>> drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper,
>>>           }
>>>       }
>>>   +    /*
>>> +     * If we run into a situation where, for example, the primary 
>>> plane
>>> +     * supports RGBA5551 (16 bpp, depth 15) but not RGB565 (16 bpp, 
>>> depth
>>> +     * 16) we need to scale down the depth of the sizes we request.
>>> +     */
>>> +    drm_for_each_plane(plane, fb_helper->dev) {
>>> +        /* Only check the primary plane */
>>> +        if (plane->type != DRM_PLANE_TYPE_PRIMARY)
>>> +            continue;
>> I think this should look at crtc->primary for each of the crtcs managed
>> by the fb_helper.
>>
>> Also this probably shouldn't look at YUV formats at all?
>>
>> I do wonder if instead we should just have the driver specify the
>> pixel format explicitly instead of trying to guess based on bpp?
>
> Can drm_mode_config.preferred_depth be used for this? The comment says 
> that
> it is used for dumb buffers and drm_mode_create_dumb_ioctl() does this:
>     cpp = DIV_ROUND_UP(args->bpp, 8);
>
> So it looks like it should be possible to do preferred_depth.
>

Hmm, maybe not. vc4 sets preferred_depth$, should that be RGB888 or
XRGB8888? The driver prefers 32bpp, but would end up with 24bpp.

I'm working on generic fbdev emulation coupled with a in-kernel client
api, so I'm interested in a solution to this for the client api.

> Noralf.
>
>>> +
>>> +        for (i = 0; i < plane->format_count; i++) {
>>> +            const struct drm_format_info *fmt;
>>> +
>>> +            fmt = drm_format_info(plane->format_types[i]);
>>> +            /* We found a perfect fit, great */
>>> +            if (fmt->depth = sizes.surface_depth)
>>> +                break;
>>> +
>>> +            /* Skip depths above what we're looking for */
>>> +            if (fmt->depth > sizes.surface_depth)
>>> +                continue;
>>> +
>>> +            /* Best depth found so far */
>>> +            if (fmt->depth > best_depth)
>>> +                best_depth = fmt->depth;
>>> +        }
>>> +    }
>>> +    if (sizes.surface_depth != best_depth) {
>>> +        DRM_DEBUG("requested bpp %d, scaled depth down to %d",
>>> +              sizes.surface_bpp, best_depth);
>>> +        sizes.surface_depth = best_depth;
>>> +    }
>>> +
>>>       crtc_count = 0;
>>>       for (i = 0; i < fb_helper->crtc_count; i++) {
>>>           struct drm_display_mode *desired_mode;
>>> -- 
>>> 2.14.3
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>

