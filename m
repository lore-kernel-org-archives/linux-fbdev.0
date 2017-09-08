From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 08 Sep 2017 11:54:41 +0000
Subject: [PATCH 0/3] fb/drm: Add support for a panel-orientation connector prop
Message-Id: <20170908115444.19122-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>

Hi All,

Some x86 clamshell design devices use portrait tablet LCD panels and a
display engine which cannot (transparently) rotate in hardware, so we
need to rotate things in software / let user space deal with this.

The fbcon code has a set of DMI based quirks to automatically detect
such tablet LCD panels and rotate the fbcon to compensate.

The plan was for userspace (e.g. a Wayland compositor) to simply read
/sys/class/graphics/fbcon/rotate and apply the rotation from there to
the LCD panel to compensate.

However this will not work when an external monitor gets plugged in,
since with fbcon rotation is not per output, so the fbcon quirk code
disables the rotation when an external monitor is present.

Using /sys/class/graphics/fbcon/rotate will not help in that case
since it will indicate no rotation is in use. So instead we are going
to need a drm connecter property for this.

This patch-series introduces such a drm connector properperty, it
consists of 3 patches:

1) Make the fbcon quirk table usable outside of the fbcon code
2) Add drm_connector_create_panel_orientation_property and
   drm_connector_attach_panel_orientation_property functions
3) Hook things up in intel_panel.c

Regards,

Hans


p.s.

Note this series does not yet get the panel orientation from the VBT
on Intel devices. I think that for devices which have the panel
upside-down (rather then rotated 90 degrees) this should work, but
I've an i915 patch series pending which corrects for the upside-down
scanario fully inside the i915 driver hiding the upside-down ness
from userspace (and fbcon) and if that series gets merged then in
the upside-down case the "panel orientation" property should read
"Normal" and not "Upside Down", so I've left out hooking up the VBTs
idea of the panel orientation for now.

Note that we could use the new "panel orientation" property for the
upside-down case too and drop my "[v4] drm/i915: Deal with upside-down
mounted LCD panels" patch:
https://patchwork.freedesktop.org/patch/173781/

That patch is not universally liked anyways, so just dropping it and
using the new prop this series introduces might be best.
 
