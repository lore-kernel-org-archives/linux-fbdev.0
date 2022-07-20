Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB797CCA487
	for <linux-fbdev@archiver.kernel.org>; Wed, 20 Jul 2022 14:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiGTO1q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbiGTO1m (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 20 Jul 2022 10:27:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00383E75F
        for <linux-fbdev@vger.kernel.org>; Wed, 20 Jul 2022 07:27:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2C8D3501E;
        Wed, 20 Jul 2022 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658327256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EZDvfPE66GG3fviAlJzOKesYJSQCp8hvUpf+BMjfa0=;
        b=wRlPxUr78aAPd5XcbN05MRwvmg3ATHnqkXw9n6h1QUtAI9wiRBHUZ3GW/wulujij5VQPyd
        vhk0HkxQtLGBopN+MtBnergAo5NwnccdoFfnbMkzKnS6161Yep/Fsmhmea95cXqXub4Y5L
        od3ymMEBs9HlmhVk/oy0qCxE9gNLnQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658327256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EZDvfPE66GG3fviAlJzOKesYJSQCp8hvUpf+BMjfa0=;
        b=brKm/zFDOgRveUCDbAxRBGSJXOAFCX1vpSFhGkCjuT6mg8bo1FCcllhe+uzIuXTuyro7PW
        zIvqXRIIAItyntCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7957413ABB;
        Wed, 20 Jul 2022 14:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oAS8HNgQ2GLfHgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 20 Jul 2022 14:27:36 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     javierm@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
        deller@gmx.de, maxime@cerno.tech, sam@ravnborg.org,
        msuchanek@suse.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 08/10] drm/ofdrm: Add CRTC state
Date:   Wed, 20 Jul 2022 16:27:30 +0200
Message-Id: <20220720142732.32041-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720142732.32041-1-tzimmermann@suse.de>
References: <20220720142732.32041-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add a dedicated CRTC state to ofdrm to later store information for
palette updates.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/ofdrm.c | 62 ++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index 6c062b48d354..ad673c9b5502 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -277,6 +277,21 @@ static struct resource *ofdrm_find_fb_resource(struct ofdrm_device *odev,
  * Modesetting
  */
 
+struct ofdrm_crtc_state {
+	struct drm_crtc_state base;
+};
+
+static struct ofdrm_crtc_state *to_ofdrm_crtc_state(struct drm_crtc_state *base)
+{
+	return container_of(base, struct ofdrm_crtc_state, base);
+}
+
+static void ofdrm_crtc_state_destroy(struct ofdrm_crtc_state *ofdrm_crtc_state)
+{
+	__drm_atomic_helper_crtc_destroy_state(&ofdrm_crtc_state->base);
+	kfree(ofdrm_crtc_state);
+}
+
 /*
  * Support all formats of OF display and maybe more; in order
  * of preference. The display's update function will do any
@@ -395,13 +410,54 @@ static const struct drm_crtc_helper_funcs ofdrm_crtc_helper_funcs = {
 	.atomic_disable = ofdrm_crtc_helper_atomic_disable,
 };
 
+static void ofdrm_crtc_reset(struct drm_crtc *crtc)
+{
+	struct ofdrm_crtc_state *ofdrm_crtc_state;
+
+	if (crtc->state) {
+		ofdrm_crtc_state_destroy(to_ofdrm_crtc_state(crtc->state));
+		crtc->state = NULL; /* must be set to NULL here */
+	}
+
+	ofdrm_crtc_state = kzalloc(sizeof(*ofdrm_crtc_state), GFP_KERNEL);
+	if (!ofdrm_crtc_state)
+		return;
+	__drm_atomic_helper_crtc_reset(crtc, &ofdrm_crtc_state->base);
+}
+
+static struct drm_crtc_state *ofdrm_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
+{
+	struct drm_crtc_state *crtc_state = crtc->state;
+	struct ofdrm_crtc_state *ofdrm_crtc_state;
+	struct ofdrm_crtc_state *new_ofdrm_crtc_state;
+
+	if (!crtc_state)
+		return NULL;
+
+	ofdrm_crtc_state = to_ofdrm_crtc_state(crtc_state);
+
+	new_ofdrm_crtc_state = kzalloc(sizeof(*new_ofdrm_crtc_state), GFP_KERNEL);
+	if (!new_ofdrm_crtc_state)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &new_ofdrm_crtc_state->base);
+
+	return &new_ofdrm_crtc_state->base;
+}
+
+static void ofdrm_crtc_atomic_destroy_state(struct drm_crtc *crtc,
+					    struct drm_crtc_state *crtc_state)
+{
+	ofdrm_crtc_state_destroy(to_ofdrm_crtc_state(crtc_state));
+}
+
 static const struct drm_crtc_funcs ofdrm_crtc_funcs = {
-	.reset = drm_atomic_helper_crtc_reset,
+	.reset = ofdrm_crtc_reset,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
-	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state = ofdrm_crtc_atomic_duplicate_state,
+	.atomic_destroy_state = ofdrm_crtc_atomic_destroy_state,
 };
 
 static int ofdrm_connector_helper_get_modes(struct drm_connector *connector)
-- 
2.36.1

