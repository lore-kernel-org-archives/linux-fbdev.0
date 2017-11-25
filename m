From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Sat, 25 Nov 2017 19:35:46 +0000
Subject: [PATCH v7 0/7] drm/fbdev: Panel orientation connector property support
Message-Id: <20171125193553.23986-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Dave Airlie <airlied@redhat.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Here is v7 of my series to add a "panel orientation" property to
the drm-connector for the LCD panel to let userspace know about LCD
panels which are not mounted upright, as well as detecting upside-down
panels without needing quirks (like we do for 90 degree rotated screens).

Bartlomiej, can we please have your Acked-by for merging patches 1,
6 and 7 through the drm tree?

New in v7:
-Fix embarrassing build error in efifb due to me only rebuilding modules
 after cleanups from v6

New in v6:
-Fix / reference kernel-doc comments
-Don't export the DRM_MODE_PANEL_ORIENTATION_* defines in the UAPI
-Move i915 dsi hardware rotation state read-out to intel_dsi_init()

New in v5:
-Add kernel-doc comment documenting drm_get_panel_orientation_quirk()
-drm_fb_helper: Only use hardware (crtc primary plane) rotation for
 180 degrees for now as 9-/270 degrees rotation requires special handling

New in v4:
-Fix drm_fb_helper code setting an invalid rotation value on the primary
 plane of disabled/unused crtcs (caught by Fi.CI)

New in v3:
-As requested by Daniel v3 moves the quirks over from the fbdev
 subsys to the drm subsys. I've done this by simpy starting with a copy of
 the quirk table and eventually removing the fbdev version.

The 1st patch in this series is a small fbdev/fbcon patch, patches 2-5
are all drm patches and patches 6-7 are fbdev/fbcon patches again. As
discussed previously the plan is to merge all 7 patches through the
drm tree.

Regards,

Hans
