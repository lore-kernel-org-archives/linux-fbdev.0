From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 02 Feb 2018 13:56:30 +0000
Subject: Re: [PATCH] drm/fb-helper: Scale back depth to supported maximum
Message-Id: <CACRpkdaFyKYxnVB-QuUiT+G9QcrpyPkzd2KXUm1sWNSgzyF9AA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180201130446.6165-1-linus.walleij@linaro.org>
 <20180201131907.GO5453@intel.com>
In-Reply-To: <20180201131907.GO5453@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: linux-fbdev@vger.kernel.org, David Lechner <david@lechnology.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Feb 1, 2018 at 2:19 PM, Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
> [Me]
>> +     /*
>> +      * If we run into a situation where, for example, the primary plane
>> +      * supports RGBA5551 (16 bpp, depth 15) but not RGB565 (16 bpp, depth
>> +      * 16) we need to scale down the depth of the sizes we request.
>> +      */
>> +     drm_for_each_plane(plane, fb_helper->dev) {
>> +             /* Only check the primary plane */
>> +             if (plane->type != DRM_PLANE_TYPE_PRIMARY)
>> +                     continue;
>
> I think this should look at crtc->primary for each of the crtcs managed
> by the fb_helper.
>
> Also this probably shouldn't look at YUV formats at all?

I guess I can look into doing it this way, sorry for not knowing how to
properly inspect DRM objects, I'm lost sometimes...

> I do wonder if instead we should just have the driver specify the
> pixel format explicitly instead of trying to guess based on bpp?

That makes a lot more sense to me actually. It would
give a better sense of control so the driver feel it knows
what is actually going on.

So I would just update
drm_fb_cma_fbdev_init() and drm_fb_helper_initial_config()
to pass a reasonable pixel format instead and refactor all the
way down?

It does hit a lot of code on the way, but if everyone thinks this
is a good idea I can very well take a stab at it.

Yours,
Linus Walleij
