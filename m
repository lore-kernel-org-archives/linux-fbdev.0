From: Shashank Sharma <shashank.sharma@intel.com>
Date: Fri, 25 Mar 2016 08:29:30 +0000
Subject: [PATCH 0/5] Add aspect ratio parsing
Message-Id: <1458893855-3930-1-git-send-email-shashank.sharma@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-fbdev@vger.kernel.org
Cc: daniel.vetter@intel.com, intel-gfx@lists.freedesktop.org, plagnioj@jcrosoft.com

Currently DRM framework doesn't parse aspect ratio of a videomode
while converting it from a umode->kmode or viceversa. This causes
modeset of CEA modes with incorrect aspect ratio.

While running HDMI complaince, tests (like 7-27) expect the DUT
to apply the mode as per the VIC, but as driver does not consider
the aspect ratio part while searching a mode from modedb, we end
up setting mode with a wrong VIC, causing the test to fail.

What this patch set does:
Patch 1-2
- Adds aspect ratio flags in the DRM layer, in form of flags.
- Adds parsing of aspect ratio, during conversion of a umode->kmode
  and viceversa.
- Adds aspect ratio check while finding a mode, during modeset.

Patch 3-5
- Adds some new aspect ratio defined in CEA-861-F specs to
  support HDMI 2.0 displays, in DRM and I915 layer.

Shashank Sharma (5):
  drm: add picture aspect ratio flags
  drm: Add aspect ratio parsing in DRM layer
  video: Add new aspect ratios for HDMI 2.0
  drm: Add flags for new aspect ratios
  drm/i915: Add support for new aspect ratios

 drivers/gpu/drm/drm_modes.c       | 46 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/intel_hdmi.c |  6 +++++
 drivers/gpu/drm/i915/intel_sdvo.c |  6 +++++
 drivers/video/hdmi.c              |  4 ++++
 include/linux/hdmi.h              |  2 ++
 include/uapi/drm/drm_mode.h       | 24 +++++++++++++++-----
 6 files changed, 83 insertions(+), 5 deletions(-)

-- 
1.9.1

