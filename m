From: Charles Lohr <charles@cnlohr.com>
Date: Mon, 19 Mar 2018 06:42:16 +0000
Subject: [PATCH] Allow non-desktop displays when not in strict mode
Message-Id: <5a4c3dab-69ed-6804-ac62-6163754c5786@cnlohr.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Keith Packard <keithp@keithp.com>
Cc: David Airlie <airlied@redhat.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Charles Lohr <lohr85@gmail.com>, dri-devel <dri-devel@lists.freedesktop.org>

Considering the lukewarm reception of my last past request and Keith's recommendation, I've created and tested a new patch, to bring the intended functionality back, only prohibiting non-desktop devices if a regular desktop screen is present.

Previous email chain: https://lists.freedesktop.org/archives/dri-devel/2018-March/169558.html

I believe I've finally found a way of sending emails with word wrap turned off.

Thank you for your time and help understanding how this submission process works.

Charles



Signed-off-by: Charles Lohr <lohr85@gmail.com>

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 035784ddd..ed08153ee 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2109,7 +2109,7 @@ static bool drm_connector_enabled(struct drm_connector *connector, bool strict)
  {
      bool enable;

-    if (connector->display_info.non_desktop)
+    if (connector->display_info.non_desktop && strict)
          return false;

      if (strict)
