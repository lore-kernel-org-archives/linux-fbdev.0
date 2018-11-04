From: Eric Wong <e@80x24.org>
Date: Sun, 04 Nov 2018 04:23:28 +0000
Subject: radeon vs radeonfb Mobility quirks (Thinkpad X32)
Message-Id: <20181104042328.jzavn47y2wloprbs@untitled>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>

My Thinkpad X32 (r100, Mobility M6) can't suspend or hibernate
with KMS using the "radeon" driver.  "radeonfb" and the VESA
fallback (no KMS) are both fine.

It seems to be the same bug as:
https://bugs.freedesktop.org/show_bug.cgi?id8554
http://bugs.debian.org/cgi-bin/bugreport.cgi?bugX3120

The problem manifests in the console and inside X11,
and with 0 or 3 in /proc/sys/kernel/acpi_video_flags.
"radeontool light off" to disable the backlight doesn't
help, either (no VGA plugged in)

Looking at drivers/video/fbdev/aty/radeon_pm.c, I notice it sets
a D2 sleep mode for my X32:

	BUGFIX("IBM Thinkpad X31/X32",
	       PCI_VENDOR_ID_IBM, 0x052f,
	       radeon_pm_d2, NULL),

Which I suspect is what allows "radeonfb" to work for me

But I can't find the corresponding quirk in drivers/gpu/drm/radeon/,
so I now believe a missing quirk is the cause of this problem
with the "radeon" driver.

I poked around but couldn't figure out what changes to make to
the "radeon" driver to enable the corresponding, but I'm willing
to test patches.

Setting "dynpm" in /sys/**/power_method didn't seem to change
things, either.

Help greatly appreaciated.  Thanks


I've mainly been using the X32 as a server this decade so didn't
use suspend/hibernate so I didn't investigate until recently
(because my netbook died).
