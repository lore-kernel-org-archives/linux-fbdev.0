Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA6F3BBCE
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206920; cv=none; b=ZDBJBkOSJfcTpo0sZU0TSIcrKldT7pOnp09wRFfzw8jgA2JnvQl+jkGGYfEU9GJvSdYye7w7r4J/wC7CuxgyMD0IxQiEyYgMKSrnHrNsLGAEiJur5etYNkhdt3qmG7l951Ywo1oyLt7zdjQB9M7+fIubzzsnFvCb0FSkbydq/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206920; c=relaxed/simple;
	bh=9NCeiHw/pI0q1akIqoQSlaU7NeHT9SWyjW7WQSdsL3I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJI0X2klQhBT8Fa1+sKjCrhNaGRapoDXjRbPgesIloQk9dfkK8fFKLSks2lwood+sR0aoE1F8MWc0ax5ZWa2RNuxv5svYabaGlvFSsmKaHcdBSnSRaABKMePCOybMidbPSWFsPS6lxzdFaMhz9oE2ecUxaM66eCDSkDSxXZCHqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aurbL6TI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aurbL6TI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721206917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ynu5l0dA8yLcoF8+u6imCBMvI85koxu/QAk/w/8RBTM=;
	b=aurbL6TIHUUMixvDpvRTeESC56iKviMW7wYOVNpRFBrXSRcTHKCSQcXvZaAlpBRulDifBX
	5VjjlYZts0LNTm+xqjtC5Fv+ca8NUEffQ9NiH1yQstoiCpf9CF02D1zIfaWRxgul8JguKY
	s6NgqMFNOCm5M549rBB1SX0GbmQUVrI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-CdEsZnMnOkujsJ1i0E8BUg-1; Wed,
 17 Jul 2024 05:01:50 -0400
X-MC-Unique: CdEsZnMnOkujsJ1i0E8BUg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82A3E1955D53;
	Wed, 17 Jul 2024 09:01:48 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3CAD81955F40;
	Wed, 17 Jul 2024 09:01:43 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 1/3] drm/panic: Add drm_panic_is_enabled()
Date: Wed, 17 Jul 2024 10:48:39 +0200
Message-ID: <20240717090102.968152-2-jfalempe@redhat.com>
In-Reply-To: <20240717090102.968152-1-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

It allows to check if the drm device supports drm_panic.
Prepare the work to have better integration with fbcon and vtconsole.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 20 ++++++++++++++++++++
 include/drm/drm_panic.h     |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 948aed00595e..d9a25c2d0a65 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -703,6 +703,26 @@ static void debugfs_register_plane(struct drm_plane *plane, int index)
 static void debugfs_register_plane(struct drm_plane *plane, int index) {}
 #endif /* CONFIG_DRM_PANIC_DEBUG */
 
+/**
+ * drm_panic_is_enabled
+ * @dev: the drm device that may supports drm_panic
+ *
+ * returns true if the drm device supports drm_panic
+ */
+bool drm_panic_is_enabled(struct drm_device *dev)
+{
+	struct drm_plane *plane;
+
+	if (!dev->mode_config.num_total_plane)
+		return false;
+
+	drm_for_each_plane(plane, dev)
+		if (plane->helper_private && plane->helper_private->get_scanout_buffer)
+			return true;
+	return false;
+}
+EXPORT_SYMBOL(drm_panic_is_enabled);
+
 /**
  * drm_panic_register() - Initialize DRM panic for a device
  * @dev: the drm device on which the panic screen will be displayed.
diff --git a/include/drm/drm_panic.h b/include/drm/drm_panic.h
index 73bb3f3d9ed9..c3a358dc3e27 100644
--- a/include/drm/drm_panic.h
+++ b/include/drm/drm_panic.h
@@ -148,11 +148,13 @@ struct drm_scanout_buffer {
 
 #ifdef CONFIG_DRM_PANIC
 
+bool drm_panic_is_enabled(struct drm_device *dev);
 void drm_panic_register(struct drm_device *dev);
 void drm_panic_unregister(struct drm_device *dev);
 
 #else
 
+bool drm_panic_is_enabled(struct drm_device *dev) {return false; }
 static inline void drm_panic_register(struct drm_device *dev) {}
 static inline void drm_panic_unregister(struct drm_device *dev) {}
 
-- 
2.45.2

