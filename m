From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Thu, 28 Nov 2019 14:03:47 +0000
Subject: Re: [Intel-gfx] [PATCH 02/13] drm/fb-helper: don't preserve fb_ops across deferred IO use
Message-Id: <a725ccfb-1da9-6659-c3ab-1187077897d6@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
 <e2b1685703878612093a37189d37685303fa15e9.1574871797.git.jani.nikula@intel.com>
 <f8292d00-5d62-cd3c-9d17-37a3feebd74b@tronnes.org> <87lfs0mcjh.fsf@intel.com>
In-Reply-To: <87lfs0mcjh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jani Nikula <jani.nikula@intel.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org



Den 28.11.2019 13.05, skrev Jani Nikula:
> On Thu, 28 Nov 2019, Noralf Trønnes <noralf@tronnes.org> wrote:
>> Den 27.11.2019 17.31, skrev Jani Nikula:
>>> Deferred IO now preserves the fb_ops.
>>>
>>> Cc: Noralf Trønnes <noralf@tronnes.org>
>>> Cc: dri-devel@lists.freedesktop.org
>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>> ---
>>>  drivers/gpu/drm/drm_fb_helper.c | 18 ++----------------
>>>  1 file changed, 2 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
>>> index 0c088ea70ad0..a5a2a538d085 100644
>>> --- a/drivers/gpu/drm/drm_fb_helper.c
>>> +++ b/drivers/gpu/drm/drm_fb_helper.c
>>> @@ -1954,7 +1954,6 @@ static int drm_fbdev_fb_release(struct fb_info *info, int user)
>>>  static void drm_fbdev_cleanup(struct drm_fb_helper *fb_helper)
>>>  {
>>>  	struct fb_info *fbi = fb_helper->fbdev;
>>> -	struct fb_ops *fbops = NULL;
>>>  	void *shadow = NULL;
>>>  
>>>  	if (!fb_helper->dev)
>>> @@ -1963,15 +1962,11 @@ static void drm_fbdev_cleanup(struct drm_fb_helper *fb_helper)
>>>  	if (fbi && fbi->fbdefio) {
>>>  		fb_deferred_io_cleanup(fbi);
>>>  		shadow = fbi->screen_buffer;
>>> -		fbops = fbi->fbops;
>>>  	}
>>>  
>>>  	drm_fb_helper_fini(fb_helper);
>>>  
>>> -	if (shadow) {
>>> -		vfree(shadow);
>>> -		kfree(fbops);
>>> -	}
>>> +	vfree(shadow);
>>>  
>>>  	drm_client_framebuffer_delete(fb_helper->buffer);
>>>  }
>>> @@ -2062,23 +2057,14 @@ static int drm_fb_helper_generic_probe(struct drm_fb_helper *fb_helper,
>>>  	drm_fb_helper_fill_info(fbi, fb_helper, sizes);
>>>  
>>>  	if (drm_fbdev_use_shadow_fb(fb_helper)) {
>>> -		struct fb_ops *fbops;
>>>  		void *shadow;
>>>  
>>> -		/*
>>> -		 * fb_deferred_io_cleanup() clears &fbops->fb_mmap so a per
>>> -		 * instance version is necessary.
>>> -		 */
>>> -		fbops = kzalloc(sizeof(*fbops), GFP_KERNEL);
>>>  		shadow = vzalloc(fbi->screen_size);
>>> -		if (!fbops || !shadow) {
>>> -			kfree(fbops);
>>> +		if (!shadow) {
>>>  			vfree(shadow);
>>
>> This vfree can is a no-op now and can be dropped. With that:
> 
> D'oh!
> 
> With that I think I'd also drop the shadow local variable and assign to
> fbi->screen_buffer directly. Fine with that?

Sure, that's even better.

Noralf.

> 
> Thanks.
> 
> BR,
> Jani.
> 
>>
>> Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
>>
>>>  			return -ENOMEM;
>>>  		}
>>>  
>>> -		*fbops = *fbi->fbops;
>>> -		fbi->fbops = fbops;
>>>  		fbi->screen_buffer = shadow;
>>>  		fbi->fbdefio = &drm_fbdev_defio;
>>>  
>>>
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 
