From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:04 +0000
Subject: [PATCH v2 03/15] drm/simple-kms-helper: Add mode_fixup() to simple display pipe
Message-Id: <20191014140416.28517-4-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

The mode fix-up function for simple display helpers is equivalent to the
regular pipeline's CRTC mode fix-up function. It's called to adjust the
CRTC's display mode for the encoder. Add this function for DRM fbconv
helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 15 +++++++++
 include/drm/drm_simple_kms_helper.h     | 43 +++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 046055719245..acd9b79bf92a 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -46,6 +46,20 @@ drm_simple_kms_crtc_mode_valid(struct drm_crtc *crtc,
 	return pipe->funcs->mode_valid(crtc, mode);
 }
 
+static bool
+drm_simple_kms_crtc_mode_fixup(struct drm_crtc *crtc,
+			       const struct drm_display_mode *mode,
+			       struct drm_display_mode *adjusted_mode)
+{
+	struct drm_simple_display_pipe *pipe;
+
+	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
+	if (!pipe->funcs || !pipe->funcs->mode_fixup)
+		return true;
+
+	return pipe->funcs->mode_fixup(crtc, mode, adjusted_mode);
+}
+
 static int drm_simple_kms_crtc_check(struct drm_crtc *crtc,
 				     struct drm_crtc_state *state)
 {
@@ -87,6 +101,7 @@ static void drm_simple_kms_crtc_disable(struct drm_crtc *crtc,
 
 static const struct drm_crtc_helper_funcs drm_simple_kms_crtc_helper_funcs = {
 	.mode_valid = drm_simple_kms_crtc_mode_valid,
+	.mode_fixup = drm_simple_kms_crtc_mode_fixup,
 	.atomic_check = drm_simple_kms_crtc_check,
 	.atomic_enable = drm_simple_kms_crtc_enable,
 	.atomic_disable = drm_simple_kms_crtc_disable,
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index 4d89cd0a60db..1b975ab67144 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -52,6 +52,49 @@ struct drm_simple_display_pipe_funcs {
 	enum drm_mode_status (*mode_valid)(struct drm_crtc *crtc,
 					   const struct drm_display_mode *mode);
 
+	/**
+	 * @mode_fixup:
+	 *
+	 * This callback is used to validate a mode. The parameter mode is the
+	 * display mode that userspace requested, adjusted_mode is the mode the
+	 * encoders need to be fed with. Note that this is the inverse semantics
+	 * of the meaning for the &drm_encoder and &drm_bridge_funcs.mode_fixup
+	 * vfunc. If the CRTC of the simple display pipe cannot support the
+	 * requested conversion from mode to adjusted_mode it should reject the
+	 * modeset.
+	 *
+	 * This function is optional.
+	 *
+	 * NOTE:
+	 *
+	 * This function is called in the check phase of atomic modesets, which
+	 * can be aborted for any reason (including on userspace's request to
+	 * just check whether a configuration would be possible). Atomic drivers
+	 * MUST NOT touch any persistent state (hardware or software) or data
+	 * structures except the passed in adjusted_mode parameter.
+	 *
+	 * Atomic drivers which need to inspect and adjust more state should
+	 * instead use the @atomic_check callback, but note that they're not
+	 * perfectly equivalent: @mode_valid is called from
+	 * drm_atomic_helper_check_modeset(), but @atomic_check is called from
+	 * drm_atomic_helper_check_planes(), because originally it was meant for
+	 * plane update checks only.
+	 *
+	 * Also beware that userspace can request its own custom modes, neither
+	 * core nor helpers filter modes to the list of probe modes reported by
+	 * the GETCONNECTOR IOCTL and stored in &drm_connector.modes. To ensure
+	 * that modes are filtered consistently put any CRTC constraints and
+	 * limits checks into @mode_valid.
+	 *
+	 * RETURNS:
+	 *
+	 * True if an acceptable configuration is possible, false if the modeset
+	 * operation should be rejected.
+	 */
+	bool (*mode_fixup)(struct drm_crtc *crtc,
+			   const struct drm_display_mode *mode,
+			   struct drm_display_mode *adjusted_mode);
+
 	/**
 	 * @enable:
 	 *
-- 
2.23.0
