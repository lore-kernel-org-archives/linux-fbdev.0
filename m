From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 04 Dec 2017 22:12:12 +0000
Subject: Re: [PATCH v7 0/7] drm/fbdev: Panel orientation connector property support
Message-Id: <7fff127d-b4aa-a422-fc4a-a7a32f4b8870@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125193602epcas2p4cbcc2891d085fb24f17c6e209a0d2024@epcas2p4.samsung.com>
 <20171125193553.23986-1-hdegoede@redhat.com> <8763653.ZUg3vedi83@amdc3058>
In-Reply-To: <8763653.ZUg3vedi83@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>

Hi,

On 01-12-17 19:02, Bartlomiej Zolnierkiewicz wrote:
> On Saturday, November 25, 2017 08:35:46 PM Hans de Goede wrote:
>> Here is v7 of my series to add a "panel orientation" property to
>> the drm-connector for the LCD panel to let userspace know about LCD
>> panels which are not mounted upright, as well as detecting upside-down
>> panels without needing quirks (like we do for 90 degree rotated screens).
>>
>> Bartlomiej, can we please have your Acked-by for merging patches 1,
>> 6 and 7 through the drm tree?
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Thank you.

> Given that you add (can be in a incremental patch) a comment to:
> 
>    drivers/gpu/drm/drm_panel_orientation_quirks.c [ at the top ]

I've fixed this up before merging, adding this comment:

  * Note the quirks in this file are shared with fbdev/efifb and as such
  * must not depend on other drm code.

> and
> 
>    drivers/gpu/drm/Kconfig [ to config DRM_PANEL_ORIENTATION_QUIRKS ]

Not everyone likes adding comments to Kconfig files I've had
push-back against that in the past. So I will post a follow-up patch
for this and then we will see from there.

> explaining that the code in question is shared with fbdev/efifb (so
> hopefully people will be careful and not try to make this code DRM
> specific at some point in a future).

Regards,

Hans



>> New in v7:
>> -Fix embarrassing build error in efifb due to me only rebuilding modules
>>   after cleanups from v6
>>
>> New in v6:
>> -Fix / reference kernel-doc comments
>> -Don't export the DRM_MODE_PANEL_ORIENTATION_* defines in the UAPI
>> -Move i915 dsi hardware rotation state read-out to intel_dsi_init()
>>
>> New in v5:
>> -Add kernel-doc comment documenting drm_get_panel_orientation_quirk()
>> -drm_fb_helper: Only use hardware (crtc primary plane) rotation for
>>   180 degrees for now as 9-/270 degrees rotation requires special handling
>>
>> New in v4:
>> -Fix drm_fb_helper code setting an invalid rotation value on the primary
>>   plane of disabled/unused crtcs (caught by Fi.CI)
>>
>> New in v3:
>> -As requested by Daniel v3 moves the quirks over from the fbdev
>>   subsys to the drm subsys. I've done this by simpy starting with a copy of
>>   the quirk table and eventually removing the fbdev version.
>>
>> The 1st patch in this series is a small fbdev/fbcon patch, patches 2-5
>> are all drm patches and patches 6-7 are fbdev/fbcon patches again. As
>> discussed previously the plan is to merge all 7 patches through the
>> drm tree.
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
