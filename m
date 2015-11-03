From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 03 Nov 2015 22:25:00 +0000
Subject: Re: Mobility Radeon HD 4530/4570/545v: flicker in 1920x1080
Message-Id: <CADnq5_P8TOQ14NiWKgV-YUy0_8P+K842pZ4h7WuU6XBu4o9fyQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151031201344.GA30459@amd> <563522C5.1000206@amd.com>
 <20151031212259.GA6253@amd>
 <CADnq5_MoThbrDADBHBRXiEGWC8jukwOLyfjfX9-7d0fB0kbpMA@mail.gmail.com>
 <20151103220919.GA4824@amd>
In-Reply-To: <20151103220919.GA4824@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel list <linux-kernel@vger.kernel.org>

On Tue, Nov 3, 2015 at 5:09 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> >4.3-rc7 kernel, graphics works reasonably well in 1600x1200 mode. But
>> >> >my monitor is native 1920x1080, so that mode looks pretty ugly on
>> >> >screen. If I go to 1920x1080, I see colored horizontal lines (often
>> >> >black) as soon as there's graphics activity.
>> >> >
>> >> >pavel@half:~$ xrandr
>> >> >Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x 8192
>> >> >VGA-0 connected 1920x1080+0+0 (normal left inverted right x axis y
>> >> >axis) 478mm x 268mm
>> >> >    1920x1080     60.00*+
>> >> >       1600x1200     60.00
>> >> >          1680x1050     59.95
>> >> >         1280x1024     75.02    60.02
>> >> >            1440x900      59.89
>> >> >               1024x768      75.08    60.00
>> >> >                  800x600       75.00    60.32
>> >> >                     640x480       75.00    60.00
>> >> >                        720x400       70.08
>> >> >  pavel@half:~$ xrandr --output VGA-0 --mode 1600x1200
>> >> >  pavel@half:~$ xrandr --output VGA-0 --mode 1920x1080
>> >> >  pavel@half:~$ xrandr --output VGA-0 --mode 1600x1200
>> >> >
>
>> >> >Any ideas?
>> >>
>> >> Alex probably knows more about this, but it sounds like problems with
>> >> switching the memory clocks on 3D load.
>> >
>> >> Try to disable power management completely with radeon.dpm=0 on the kernel
>> >> command line or nailing the hardware at a specific power level using
>> >> sysfs.
>> >
>> > I tried that, but it still flickers.
>>
>> It's probably pll stability.  There seem to be a number of regressions
>> since the pll code was rewritten to support matching the hdmi clocks
>> more closely.  Does this patch help?
>>
>> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c
>> b/drivers/gpu/drm/radeon/atombios_crtc.c
>> index dac78ad..b86f06a 100644
>> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
>> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
>> @@ -569,6 +569,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
>>         radeon_crtc->pll_flags = 0;
>>
>>         if (ASIC_IS_AVIVO(rdev)) {
>> +               radeon_crtc->pll_flags |= RADEON_PLL_PREFER_MINM_OVER_MAXP;
>> +
>>                 if ((rdev->family = CHIP_RS600) ||
>>                     (rdev->family = CHIP_RS690) ||
>>                     (rdev->family = CHIP_RS740))
>>
>
> Help.. maybe... it is tricky to tell. It definitely does _not_ fix the
> issue completely.

You could also try the old pll algorithm:

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c
b/drivers/gpu/drm/radeon/atombios_crtc.c
index dac78ad..8c6e8fa 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -1094,8 +1094,8 @@ static void atombios_crtc_set_pll(struct
drm_crtc *crtc, struct drm_display_mode
                radeon_compute_pll_legacy(pll,
radeon_crtc->adjusted_clock, &pll_clock,
                                          &fb_div, &frac_fb_div,
&ref_div, &post_div);
        else if (ASIC_IS_AVIVO(rdev))
-               radeon_compute_pll_avivo(pll,
radeon_crtc->adjusted_clock, &pll_clock,
-                                        &fb_div, &frac_fb_div,
&ref_div, &post_div);
+               radeon_compute_pll_legacy(pll,
radeon_crtc->adjusted_clock, &pll_clock,
+                                         &fb_div, &frac_fb_div,
&ref_div, &post_div);
        else
                radeon_compute_pll_legacy(pll,
radeon_crtc->adjusted_clock, &pll_clock,
                                          &fb_div, &frac_fb_div,
&ref_div, &post_div);


>
>> Unfortunately, it can't be applied as is because we had a similar
>> patch which was reverted because it regressed a bunch of other
>> systems.  The actual pll limits probably need to be tweaked.
>
> Any ideas how to tweak the pll limits?

Adjust the the algorithm in radeon_compute_pll_avivo() in radeon_display.c

Alex
