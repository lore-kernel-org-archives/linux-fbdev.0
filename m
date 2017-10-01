From: Hans de Goede <j.w.r.degoede@gmail.com>
Date: Sun, 01 Oct 2017 15:33:13 +0000
Subject: [PATCH v2 0/4] fb/drm: Add support for a panel-orientation connector prop
Message-Id: <20171001153317.2343-1-hdegoede@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bastien Nocera <hadess@hadess.net>

Hi All,

This is a resend of v2 of my panel-orientation drm connector property
series. I already send this out 2 weeks ago from my Red Hat email, but
that does not get picked up by the drm subsys scripts to run tests, so
hence this resend from my gmail.

The 2 biggest changes in v2 are:

1) Add support to drm-fb-helper.c for the panel-orientation prop and
make it apply the rotation to the fb to get fbcon to show the right way up.

2) Change the patch to enable the panel-orientation prop in the i915 driver
to read back to rotation setup by the BIOS from the hardware (the VBT
has a panel rotation field for this, but it reads 0 on hardware where
the GOP does correctly rotate the screen, so its useless).

Regards,

Hans
