From: Archit Taneja <architt@codeaurora.org>
Date: Wed, 25 Mar 2015 08:29:54 +0000
Subject: Re: [RFC 1/6] drm: Add top level Kconfig option for DRM fbdev emulation
Message-Id: <55126F32.90404@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425980493-27533-1-git-send-email-architt@codeaurora.org>
 <1425980493-27533-2-git-send-email-architt@codeaurora.org>
 <20150310094756.GE3800@phenom.ffwll.local> <54FEBEF1.5000103@codeaurora.org>
 <20150310100547.GG3800@phenom.ffwll.local> <54FEC5F1.90208@codeaurora.org>
 <20150310121702.GO3800@phenom.ffwll.local> <54FFFAEE.3020301@codeaurora.org>
 <20150311151731.GJ3800@phenom.ffwll.local> <550282C3.10903@codeaurora.org>
 <20150313090651.GZ3800@phenom.ffwll.local>
In-Reply-To: <20150313090651.GZ3800@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: robdclark@gmail.com, airlied@linux.ie, treding@nvidia.com, p.zabel@pengutronix.de, benjamin.gaignard@linaro.org, dri-devel@lists.freedesktop.org, daniel@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, linux-kernel@vger.kernel.org

Hi,

On 03/13/2015 02:36 PM, Daniel Vetter wrote:
> On Fri, Mar 13, 2015 at 11:55:07AM +0530, Archit Taneja wrote:
>>
>>
>> On 03/11/2015 08:47 PM, Daniel Vetter wrote:
>>> On Wed, Mar 11, 2015 at 01:51:02PM +0530, Archit Taneja wrote:
>>>>
>>>>
>>>> On 03/10/2015 05:47 PM, Daniel Vetter wrote:
>>>>> On Tue, Mar 10, 2015 at 03:52:41PM +0530, Archit Taneja wrote:
>>>>>> On 03/10/2015 03:35 PM, Daniel Vetter wrote:
>>>>>>> On Tue, Mar 10, 2015 at 03:22:49PM +0530, Archit Taneja wrote:
>>>>>>>> On 03/10/2015 03:17 PM, Daniel Vetter wrote:
>>>>>>>>> On Tue, Mar 10, 2015 at 03:11:28PM +0530, Archit Taneja wrote:
>>>>>>>>>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>>>>>>>>>> index 151a050..38f83a0 100644
>>>>>>>>>> --- a/drivers/gpu/drm/Kconfig
>>>>>>>>>> +++ b/drivers/gpu/drm/Kconfig
>>>>>>>>>> @@ -40,6 +40,24 @@ config DRM_KMS_FB_HELPER
>>>>>>>>>>   	help
>>>>>>>>>>   	  FBDEV helpers for KMS drivers.
>>>>>>>>>>
>>>>>>>>>> +config DRM_FBDEV_EMULATION
>>>>>>>>>> +	bool "Enable legacy fbdev support for your modesetting driver"
>>>>>>>>>> +	depends on DRM
>>>>>>>>>> +	select DRM_KMS_HELPER
>>>>>>>>>> +	select DRM_KMS_FB_HELPER
>>>>>>>>>> +	select FB_SYS_FILLRECT
>>>>>>>>>> +	select FB_SYS_COPYAREA
>>>>>>>>>> +	select FB_SYS_IMAGEBLIT
>>>>>>>>>> +	select FB_SYS_FOPS
>>>>>>>>>> +	select FB_CFB_FILLRECT
>>>>>>>>>> +	select FB_CFB_COPYAREA
>>>>>>>>>> +	select FB_CFB_IMAGEBLIT
>>>>>>>>>> +	default y
>>>>>>>>>> +	help
>>>>>>>>>> +	  Choose this option if you have a need for the legacy fbdev
>>>>>>>>>> +	  support. Note that this support also provide the linux console
>>>>>>>>>> +	  support on top of your modesetting driver.
>>>>>>>>>
>>>>>>>>> Maybe clarify that for linux console support you also need
>>>>>>>>> CONFIG_FRAMEBUFFER_CONSOLE? fbdev alone isn't enough.
>>>>>>>>
>>>>>>>> DRM_KMS_FB_HELPER selects that for us, right?
>>>>>>>
>>>>>>> Hm right I've missed that. Reminds me that you need one more patch at the
>>>>>>> end to remove all the various select DRM_KMS_FB_HELPER from all drm
>>>>>>> drivers. Otherwise this knob here won't work by default if you e.g. select
>>>>>>> radeon. In general we can't mix explicit options with menu entries with a
>>>>>>> select.
>>>>>>
>>>>>> I was trying that out. Removing DRM_KMS_FB_HELPER and having
>>>>>> DRM_FBDEV_EMULATION disabled breaks drivers which use FB stuff internally in
>>>>>> their respective xyz_fbdev.c files.
>>>>>
>>>>> But with the stubbed out functions that should work, right? Why doesn't
>>>>> it?
>>>>
>>>> There are still calls to functions from fb core like fb_set_suspend and
>>>> register_framebuffer which aren't covered by the drm fb helper functions.
>>>
>>> Hm, sounds like we need another patch to stub out fb_set_suspend when
>>> fbdev isn't enabled. Is there anything else?
>>
>> There are a handful of fb core functions which are called by drm drivers:
>>
>> fb_alloc_cmap/fb_dealloc_cmap
>>
>> fb_sys_read/fb_sys_write
>>
>> register_framebuffer/unregister_framebuffer/unlink_framebuffer/
>> remove_conflicting_framebuffers
>>
>> fb_set_suspend
>>
>> fb_deferred_io_init/fb_deferred_io_cleanup
>>
>> framebuffer_alloc/framebuffer_release
>
> Hm yeah that's somewhat annoying indeed. What about the following:
> 1. We move all the #include <linux/fb.h> from drivers into drm_fb_helper.h
>
> 2. Then we add stubs for these functions in drm_fb_helper.h, like this
>
> #if defined(CONFIG_FB)
> #include <linux/fb.h>
> #else
>
> /* static inline stubs for all the fb stuff used by kms drivers */
> #endif
>
> Imo this makes sense since kms drivers really have a bit a special
> situation with fbdev. They're not full-blown fbdev drivers and can be
> useful fully without fbdev.
>

I was trying this out. Removing 'linux/fb.h' and replacing stub fb funcs 
won't really work because struct declarations(like fb_info) also get 
removed.

I considered placing '#if IS_ENABLED(CONFIG_FB)' within linux/fb.h 
itself, but that seemed a bit too intrusive.

This is what I'm currently doing:

- Some funcs, like framebufer_alloc/release, alloc_cmap/dealloc_cmap 
would actually benefit if we have drm fb helpers for them. They are used 
in exactly the same manner by all the drivers.

- For the rest of the functions that are sparsely used, I was 
considering making very simple drm_fb_* wrapper functions. Something like:

void drm_fb_helper_deferred_io_init(struct drm_fb_helper *helper)
{
	if (helper->fbdev)
		fb_deferred_io_init(helper->fbdev);
}

We could have all fb calls called within drm_fb_helper.c, creating 
drm_fb_helper_* stub functions would then be an easier task. What do you 
think?

Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
