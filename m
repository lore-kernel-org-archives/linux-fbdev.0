From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 2/2] drm/i915: fixup per-crtc locking in intel_release_load_detect_pipe
Date: Wed, 23 Jan 2013 17:25:09 +0100
Message-ID: <1358958309-5342-3-git-send-email-daniel.vetter@ffwll.ch>
References: <1358958309-5342-1-git-send-email-daniel.vetter@ffwll.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358958309-5342-1-git-send-email-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, DRI Development <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, Daniel Vetter <daniel.vetter@ffwll.ch>

One of the early return cases missed the mutex unlocking. Hilarity
ensued.

This regression has been introduced in

commit 7b24056be6db7ce907baffdd4cf142ab774ea60c
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed Dec 12 00:35:33 2012 +0100

    drm: don't hold crtc mutexes for connector ->detect callbacks

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=59750
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/i915/intel_display.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 26df9e3..ece4afd 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -6522,6 +6522,7 @@ void intel_release_load_detect_pipe(struct drm_connector *connector,
 			drm_framebuffer_unreference(old->release_fb);
 		}
 
+		mutex_unlock(&crtc->mutex);
 		return;
 	}
 
-- 
1.7.10.4
