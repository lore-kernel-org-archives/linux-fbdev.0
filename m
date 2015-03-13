From: Archit Taneja <architt@codeaurora.org>
Date: Fri, 13 Mar 2015 06:37:07 +0000
Subject: Re: [RFC 1/6] drm: Add top level Kconfig option for DRM fbdev emulation
Message-Id: <550282C3.10903@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425980493-27533-1-git-send-email-architt@codeaurora.org>
 <1425980493-27533-2-git-send-email-architt@codeaurora.org>
 <20150310094756.GE3800@phenom.ffwll.local> <54FEBEF1.5000103@codeaurora.org>
 <20150310100547.GG3800@phenom.ffwll.local> <54FEC5F1.90208@codeaurora.org>
 <20150310121702.GO3800@phenom.ffwll.local> <54FFFAEE.3020301@codeaurora.org>
 <20150311151731.GJ3800@phenom.ffwll.local>
In-Reply-To: <20150311151731.GJ3800@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, daniel@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, benjamin.gaignard@linaro.org, treding@nvidia.com



On 03/11/2015 08:47 PM, Daniel Vetter wrote:
> On Wed, Mar 11, 2015 at 01:51:02PM +0530, Archit Taneja wrote:
>>
>>
>> On 03/10/2015 05:47 PM, Daniel Vetter wrote:
>>> On Tue, Mar 10, 2015 at 03:52:41PM +0530, Archit Taneja wrote:
>>>> On 03/10/2015 03:35 PM, Daniel Vetter wrote:
>>>>> On Tue, Mar 10, 2015 at 03:22:49PM +0530, Archit Taneja wrote:
>>>>>> On 03/10/2015 03:17 PM, Daniel Vetter wrote:
>>>>>>> On Tue, Mar 10, 2015 at 03:11:28PM +0530, Archit Taneja wrote:
>>>>>>>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>>>>>>>> index 151a050..38f83a0 100644
>>>>>>>> --- a/drivers/gpu/drm/Kconfig
>>>>>>>> +++ b/drivers/gpu/drm/Kconfig
>>>>>>>> @@ -40,6 +40,24 @@ config DRM_KMS_FB_HELPER
>>>>>>>>   	help
>>>>>>>>   	  FBDEV helpers for KMS drivers.
>>>>>>>>
>>>>>>>> +config DRM_FBDEV_EMULATION
>>>>>>>> +	bool "Enable legacy fbdev support for your modesetting driver"
>>>>>>>> +	depends on DRM
>>>>>>>> +	select DRM_KMS_HELPER
>>>>>>>> +	select DRM_KMS_FB_HELPER
>>>>>>>> +	select FB_SYS_FILLRECT
>>>>>>>> +	select FB_SYS_COPYAREA
>>>>>>>> +	select FB_SYS_IMAGEBLIT
>>>>>>>> +	select FB_SYS_FOPS
>>>>>>>> +	select FB_CFB_FILLRECT
>>>>>>>> +	select FB_CFB_COPYAREA
>>>>>>>> +	select FB_CFB_IMAGEBLIT
>>>>>>>> +	default y
>>>>>>>> +	help
>>>>>>>> +	  Choose this option if you have a need for the legacy fbdev
>>>>>>>> +	  support. Note that this support also provide the linux console
>>>>>>>> +	  support on top of your modesetting driver.
>>>>>>>
>>>>>>> Maybe clarify that for linux console support you also need
>>>>>>> CONFIG_FRAMEBUFFER_CONSOLE? fbdev alone isn't enough.
>>>>>>
>>>>>> DRM_KMS_FB_HELPER selects that for us, right?
>>>>>
>>>>> Hm right I've missed that. Reminds me that you need one more patch at the
>>>>> end to remove all the various select DRM_KMS_FB_HELPER from all drm
>>>>> drivers. Otherwise this knob here won't work by default if you e.g. select
>>>>> radeon. In general we can't mix explicit options with menu entries with a
>>>>> select.
>>>>
>>>> I was trying that out. Removing DRM_KMS_FB_HELPER and having
>>>> DRM_FBDEV_EMULATION disabled breaks drivers which use FB stuff internally in
>>>> their respective xyz_fbdev.c files.
>>>
>>> But with the stubbed out functions that should work, right? Why doesn't
>>> it?
>>
>> There are still calls to functions from fb core like fb_set_suspend and
>> register_framebuffer which aren't covered by the drm fb helper functions.
>
> Hm, sounds like we need another patch to stub out fb_set_suspend when
> fbdev isn't enabled. Is there anything else?

There are a handful of fb core functions which are called by drm drivers:

fb_alloc_cmap/fb_dealloc_cmap

fb_sys_read/fb_sys_write

register_framebuffer/unregister_framebuffer/unlink_framebuffer/
remove_conflicting_framebuffers

fb_set_suspend

fb_deferred_io_init/fb_deferred_io_cleanup

framebuffer_alloc/framebuffer_release


>
>>>> Are you saying that we should remove DRM_KMS_FB_HELPER for such drivers and
>>>> replace them with 'select DRM_FBDEV_EMULATION'?
>>>>
>>>> Another option would be to provide #ifdef DRM_FBDEV_EMULATION wrap-arounds
>>>> for fb related function calls/declarations in each driver, something that's
>>>> already done for i915 and msm drivers.
>>>
>>> The problem with the patch as-is the massive amounts of selects the FB
>>> helper still has. We need to get rid of them so that when you disable
>>> fbdev emulation you can indeed disable fbcon and the entire fbdev
>>> subsystem. I've thought that remove the hidden symbol DRM_KMS_FB_HELPER
>>> and moving all the selects to DRM_FBDEV_EMULATION should work out? If that
>>> doesn't work we need to look again how to better stub things out I think.
>>
>> That's true. Also, as Jani pointed out, maybe it isn't the best idea to make
>> every kms driver select DRM_FBDEV_EMULATION?
>>
>> Maybe the drivers that are currently built with fbdev emulation by default
>> can add a 'depends on DRM_FBDEV_EMULATION'? Since the config defaults to y,
>> the drivers should run as is. Later, we could take up each driver and build
>> the fb stuff only when DRM_FBDEV_EMULATION is set, like how we do for i915
>> and msm?
>
> Yeah we definitely can't mix select with a user-visible option. I think we
> just need to fix up the remaining functions and create stubs for them if
> needed and then drop all the selects. Well in DRM_FBDEV_EMULATION we
> should still select for fbcon since otherwise tons of bug reports about
> "where is my fbcon with kms?".

I'll give this a try. Although, it would be a better idea to make the 
drivers not call these at all when fbdev emulation isn't asked for. With 
the stubs, if someone does try to use the driver with 
DRM_FBDEV_EMULATION not set, the worst that'll happen would be that the 
driver fails to probe. Which isn't so bad.

Archit

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
