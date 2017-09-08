From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 08 Sep 2017 15:08:09 +0000
Subject: Re: [PATCH 0/3] fb/drm: Add support for a panel-orientation connector prop
Message-Id: <89ebc158-4a36-2214-0d16-8213db079dc1@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170908115444.19122-1-hdegoede@redhat.com>
 <20170908120514.3bhkvqlqggnjtzg7@phenom.ffwll.local>
In-Reply-To: <20170908120514.3bhkvqlqggnjtzg7@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>, Daniel Vetter <daniel.vetter@intel.com>

Hi,

On 08-09-17 14:05, Daniel Vetter wrote:
> On Fri, Sep 08, 2017 at 01:54:41PM +0200, Hans de Goede wrote:
>> Hi All,
>>
>> Some x86 clamshell design devices use portrait tablet LCD panels and a
>> display engine which cannot (transparently) rotate in hardware, so we
>> need to rotate things in software / let user space deal with this.
>>
>> The fbcon code has a set of DMI based quirks to automatically detect
>> such tablet LCD panels and rotate the fbcon to compensate.
>>
>> The plan was for userspace (e.g. a Wayland compositor) to simply read
>> /sys/class/graphics/fbcon/rotate and apply the rotation from there to
>> the LCD panel to compensate.
>>
>> However this will not work when an external monitor gets plugged in,
>> since with fbcon rotation is not per output, so the fbcon quirk code
>> disables the rotation when an external monitor is present.
> 
> Hm, where is that handled? Afaiui the fbdev emulation in drm completel
> hides that there's possibly multiple monitors connected, which means I
> have no idea how fbcon can even figure this out. Can you give some
> pointers to relevant code?

The quirk code is added by this commit:

https://github.com/bzolnier/linux/commit/b0d8e409c3626eae42b59a3d76574804f2cef5ef

As you can see the check for a quirk match not only checks for
DMI strings, but also for the fbcon resolution, there are 2 reasons
for this:

1) Since these devices tend to be cheap and thus sometimes have generic
DMI strings, this is an extra check to avoid false positives

2) Since fbcon rotate is an all or nothing thing (not per output)
the question becomes what to do on these devices when using an
external output. Rotating the external output seems wrong, more
wrong then leaving the internal panel as is, esp. since these
devices tend to have small screens, so when an external output
is used chances are the user will mainly be using that.

TL;DR: we do not want to do fbcon rotation to compensate for
the panel orientation when an external output is used, the
resolution check gives us this since when an external output
is present (at boot) the fbcon resolution will (almost always)
be different.


And perhaps more importantly then me coming to the conclusion that
userspace cannot use /sys/class/graphics/fbcon/rotate having the
panel orientation be a property on the drm_connector simply seems
like the right thing to do from a design perspective.

As mentioned this will also help with the upside-down LCD panel
case, in which case I believe we can simply get the orientation
from the VBT table and I expect no DMI quirks to be necessary.

Note the 90 degree rotation is not in the VBT table, I believe this
is because the hardware and thus the GOP cannot handle this.

Regards,

Hans



>> Using /sys/class/graphics/fbcon/rotate will not help in that case
>> since it will indicate no rotation is in use. So instead we are going
>> to need a drm connecter property for this.
>>
>> This patch-series introduces such a drm connector properperty, it
>> consists of 3 patches:
>>
>> 1) Make the fbcon quirk table usable outside of the fbcon code
>> 2) Add drm_connector_create_panel_orientation_property and
>>     drm_connector_attach_panel_orientation_property functions
>> 3) Hook things up in intel_panel.c
>>
>> Regards,
>>
>> Hans
>>
>>
>> p.s.
>>
>> Note this series does not yet get the panel orientation from the VBT
>> on Intel devices. I think that for devices which have the panel
>> upside-down (rather then rotated 90 degrees) this should work, but
>> I've an i915 patch series pending which corrects for the upside-down
>> scanario fully inside the i915 driver hiding the upside-down ness
>> from userspace (and fbcon) and if that series gets merged then in
>> the upside-down case the "panel orientation" property should read
>> "Normal" and not "Upside Down", so I've left out hooking up the VBTs
>> idea of the panel orientation for now.
>>
>> Note that we could use the new "panel orientation" property for the
>> upside-down case too and drop my "[v4] drm/i915: Deal with upside-down
>> mounted LCD panels" patch:
>> https://patchwork.freedesktop.org/patch/173781/
>>
>> That patch is not universally liked anyways, so just dropping it and
>> using the new prop this series introduces might be best.
>>   
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
