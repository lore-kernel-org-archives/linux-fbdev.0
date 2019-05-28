From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:03:03 +0000
Subject: [PATCH 32/33] staging/olpc_dcon: Add drm conversion to TODO
Message-Id: <20190528090304.9388-33-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Jens Frederich <jfrederich@gmail.com>, Daniel Drake <dsd@laptop.org>, Jon Nettleton <jon.nettleton@gmail.com>

this driver is pretty horrible from a design pov, and needs a complete
overhaul. Concrete thing that annoys me is that it looks at
registered_fb, which is an internal thing to fbmem.c and fbcon.c. And
ofc it gets the lifetime rules all wrong (it should at least use
get/put_fb_info).

Looking at the history, there's been an attempt at dropping this from
staging in 2016, but that had to be reverted. Since then not real
effort except the usual stream of trivial patches, and fbdev has been
formally closed for any new hw support. Time to try again and drop
this?

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
---
 drivers/staging/olpc_dcon/TODO | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/olpc_dcon/TODO b/drivers/staging/olpc_dcon/TODO
index 665a0b061719..fe09efbc7f77 100644
--- a/drivers/staging/olpc_dcon/TODO
+++ b/drivers/staging/olpc_dcon/TODO
@@ -1,4 +1,11 @@
 TODO:
+	- complete rewrite:
+	  1. The underlying fbdev drivers need to be converted into drm kernel
+	     modesetting drivers.
+	  2. The dcon low-power display mode can then be integrated using the
+	     drm damage tracking and self-refresh helpers.
+	  This bolted-on self-refresh support that digs around in fbdev
+	  internals, but isn't properly integrated, is not the correct solution.
 	- see if vx855 gpio API can be made similar enough to cs5535 so we can
 	  share more code
 	- convert all uses of the old GPIO API from <linux/gpio.h> to the
-- 
2.20.1
