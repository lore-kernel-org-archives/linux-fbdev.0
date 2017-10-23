From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Mon, 23 Oct 2017 07:14:18 +0000
Subject: [PATCH v3 0/7] drm/fbdev: Panel orientation connector property support
Message-Id: <20171023071425.5090-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>, Bastien Nocera <hadess@hadess.net>

Hi All,

Here is v3 of my series to add a "panel orientation" property to
the drm-connector for the LCD panel to let userspace know about LCD
panels which are not mounted upright, as well as detecting upside-down
panels without needing quirks (like we do for 90 degree rotated screens).

As requested by Daniel this version moves the quirks over from the fbdev
subsys to the drm subsys. I've done this by simpy starting with a copy of
the quirk table and eventually removing the fbdev version.

The 1st patch in this series is a small fbdev/fbcon patch, patches 2-5
are all drm patches since patches 2-5 depend on patch 1 I believe it
would be best to merge patches 1-5 through the drm tree.

For merging patches 6-7 I see 3 options:

1) Wait a kernel cycle, things will work fine without them, they are really
just there to remove the fbdev copy of the quirks

2) Merge all 7 patches through the drm tree

3) Use a stable tag in the drm tree which the fbdev tree can merge and then
merge patches 6-7 through the drm tree.

Regards,

Hans
