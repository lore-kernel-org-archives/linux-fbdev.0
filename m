From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 28 Nov 2017 13:36:09 +0000
Subject: Re: [Intel-gfx] [PATCH v6 0/7] drm/fbdev: Panel orientation connector property support
Message-Id: <cdef944b-8dc4-67a0-c719-a216e657a03f@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171125173341.14162-1-hdegoede@redhat.com>
 <20171128102754.wn4wqyfickotmqgw@phenom.ffwll.local>
In-Reply-To: <20171128102754.wn4wqyfickotmqgw@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>, Hans de Goede <j.w.r.degoede@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>

Hi,

On 28-11-17 11:27, Daniel Vetter wrote:
> On Sat, Nov 25, 2017 at 06:33:34PM +0100, Hans de Goede wrote:
>> Hi All,
>>
>> Here is v6 of my series to add a "panel orientation" property to
>> the drm-connector for the LCD panel to let userspace know about LCD
>> panels which are not mounted upright, as well as detecting upside-down
>> panels without needing quirks (like we do for 90 degree rotated screens).
>>
>> Bartlomiej, can we please have your Acked-by for merging patches 1,
>> 6 and 7 through the drm tree?
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
> I think from the drm and i915 side of things this all looks ready (well
> pls double-check that CI also approves before merging).

The CI says state is warning, see:
https://patchwork.freedesktop.org/series/32447/
and specifically:
https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_7290/shards.html

Which I find hard to read as I see no tests going to orange, only
3 tests moving to red, which AFAICT is failed. Clicking on the tests
link to get history all 3 tests seem to fail in the same way quite
often (2 out of 3) or somewhat often (the last one). Also the failures
seem unrelated to my changes

So how do I deal with this, resend v7 to get CI to run again and hope
I get a success result for all tests this time ?

> Just needs an ack/review from Bart, and then it's probably simplest if you
> merge it all through drm-misc - the i915 side is tiny.

Ok, I will wait for an Ack from Bart and then merge this through drm-misc,
thank you for the review.

Regards,

Hans

