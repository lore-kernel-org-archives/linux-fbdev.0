Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606725013BC;
	Thu,  1 Oct 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861871; cv=none; b=tAzZr6nbQ5d0lwP4bpMp+7kzAs8CsI0/WXdDiwJZfmgku59WIREQBps6vJGkaTpWpg4qdaMd0/pAejBk3VbdtvBOOqQ3emZdYOP6M/xj+u5AettnM0qU0IYDBX4NWiXgDalvL3trquc9SZQsI7rH0aRzIwPHhbDUD9Ne2vbKphk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861871; c=relaxed/simple;
	bh=Saz9SlGs4/Kh5i6DeEBqQeb3DrMcvcRT3uIDgqXBaB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0xC7tbuAcm+MO2bLXOV8eDyUJ9kGLmyWH0csHMeUT3SNfDjprtwkWiDHakvhq2WLdHUWoc0YfcUA6O3b+WomYNX2Atq96+nmVmBk1Qli2KTVtunMv5b+ebokCB2H1yPzoY9NpFKX3UX4pWoHe43CmvE1atnyMsvJ7FUnY/B4QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cGMtjDDe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=deXJyUZM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cGMtjDDe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="deXJyUZM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA9461FB65;
	Thu,  1 Oct 2026 13:37:41 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xur6Q7aEGMqRccf2wLH8As4ISpa1+AAdVN8Lu0/C2g=;
	b=cGMtjDDe+6nnoVrvAdYWMlp7dQFrJ9njdidBnv2D4M8b2HTXMvoLI5bf2MQLLeosPA37Md
	9UdVfUANWWnClupcUSHkM+NZkZggVFK10pB4flkncf6xvvr9NhG2OxtJOCMeFyePmb35xc
	VQgM94jWAQBQJFQ0mOcUmiOCCEtFXHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xur6Q7aEGMqRccf2wLH8As4ISpa1+AAdVN8Lu0/C2g=;
	b=deXJyUZM404kLauniDWvlblU46+tBNMya53/sKFR7BFIudcdYUe/AT6ZY6wvGND1TbTybj
	4Gpu4RA3gmffy9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 604C813B78;
	Thu,  1 Oct 2026 13:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ih09KyRivmrGOQAAD6G6ig:T2
	(envelope-from <tzimmermann@suse.de>); Thu, 01 Oct 2026 13:37:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	decui@microsoft.com,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] drm/hyperv: Add missing include statements
Date: Thu,  1 Oct 2026 15:35:37 +0200
Message-ID: <20261001133736.802604-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001133736.802604-1-tzimmermann@suse.de>
References: <20261001133736.802604-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DA9461FB65
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Hyperv-drm gets a number of headers via <drm/drm_simple_kms_helper.h>.
Include the files directly so that the simple-kms header doesn't have
to.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hyperv/hyperv_drm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index 29e6f54af15f..f4262a37af36 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -6,6 +6,11 @@
 #ifndef _HYPERV_DRM_H_
 #define _HYPERV_DRM_H_
 
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_plane.h>
+
 #define VMBUS_MAX_PACKET_SIZE 0x4000
 
 struct hv_drm_device {
-- 
2.55.0

