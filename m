From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Date: Wed, 04 Nov 2015 07:36:32 +0000
Subject: Re: Mobility Radeon HD 4530/4570/545v: flicker in 1920x1080
Message-Id: <5639B580.1050409@vodafone.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151031201344.GA30459@amd> <563522C5.1000206@amd.com>
 <20151031212259.GA6253@amd>
 <CADnq5_MoThbrDADBHBRXiEGWC8jukwOLyfjfX9-7d0fB0kbpMA@mail.gmail.com>
 <20151103220919.GA4824@amd>
 <CADnq5_P8TOQ14NiWKgV-YUy0_8P+K842pZ4h7WuU6XBu4o9fyQ@mail.gmail.com>
 <20151103230329.GA4167@amd>
In-Reply-To: <20151103230329.GA4167@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>, Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel list <linux-kernel@vger.kernel.org>

On 04.11.2015 00:03, Pavel Machek wrote:
> Hi!
>
>
>>>>>>> Any ideas?
>>>>>> Alex probably knows more about this, but it sounds like problems with
>>>>>> switching the memory clocks on 3D load.
>>>>>> Try to disable power management completely with radeon.dpm=0 on the kernel
>>>>>> command line or nailing the hardware at a specific power level using
>>>>>> sysfs.
>>>>> I tried that, but it still flickers.
>>>> It's probably pll stability.  There seem to be a number of regressions
>>>> since the pll code was rewritten to support matching the hdmi clocks
>>>> more closely.  Does this patch help?
>>>>
>>>> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c
>>>> b/drivers/gpu/drm/radeon/atombios_crtc.c
>>>> index dac78ad..b86f06a 100644
>>>> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
>>>> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
>>>> @@ -569,6 +569,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
>>>>          radeon_crtc->pll_flags = 0;
>>>>
>>>>          if (ASIC_IS_AVIVO(rdev)) {
>>>> +               radeon_crtc->pll_flags |= RADEON_PLL_PREFER_MINM_OVER_MAXP;
>>>> +
>>>>                  if ((rdev->family = CHIP_RS600) ||
>>>>                      (rdev->family = CHIP_RS690) ||
>>>>                      (rdev->family = CHIP_RS740))
>>>>
>>> Help.. maybe... it is tricky to tell. It definitely does _not_ fix the
>>> issue completely.
>> You could also try the old pll algorithm:
> I reverted the patch above, and switched to the old algorithm.
>
> The flicker is still there. (But maybe its less horrible, like with
> RADEON_PLL_PREFER_MINM_OVER_MAXP).

The flickering would vanish completely if that's the reason for the 
issue you are seeing.

Try setting ref_div_min and ref_div_max to 2 in radeon_compute_pll_avivo().

But I'm not 100% convinced that this is actually a PLL problem, try to 
compile the firmware it complains about into the kernel as well.

Regards,
Christian.

>
> Thanks,
> 								Pavel
> 								

