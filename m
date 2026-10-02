Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED84718CD;
	Fri,  2 Oct 2026 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945156; cv=none; b=Lvhy5kgSpNiaLv/QZEIIWjXI9FpUYyICB5cp7coRDGj3G0uma60EVn7cNw37ZNGw10g2oPpQQmFyTfwWkbEmMczC6V5ZmPpmftrP42+Z8mzg0Slw/23jktgIN9QFX+2XnIAA5sE+W0uyfuDrNwOycXZ5PczFgPQZ+cgOzY1OlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945156; c=relaxed/simple;
	bh=W4iDPF51RZuJs0cvKIUS4CFIUtJ7Lg6KkJj527u7mJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kyr6O0x1286NKMhWntBg+5LWAgebcj6xMB0tlG77IdDgXlhLpb9g0aB9ZCP5fzFJX91yPXwXrzR+1eWA40JLzUwahM8FM7+fu2sdG7fHdCuxBcvUzvL9AhDJxgZxmU6FfnGr6EY8LGgaFTp7wjP0SbBcqgKXqcR8i7qDZOmF6FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1tIypbe8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oiTWPMn6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0nRaH746; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=s6FDUjMj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1tIypbe8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oiTWPMn6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0nRaH746";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s6FDUjMj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5439B21E58;
	Fri,  2 Oct 2026 12:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790945114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le20LK0izKJvpzcJsn/wk9Ur8I1yBsaG8v0UNbq6iZw=;
	b=1tIypbe82+mG/ODX5eDIMAdErwIgCGn3jIxD4MKhHhvAjxLVmoGCVN4fhY7p5sIxL+23yX
	d6iKq4VjX3aTAiPWmQjTngvYeOl5tMyxKV3/pRY5jjT2eIJ+an55HZHyW1PVv5SysRs+J8
	SD8J4VViiA9oI6Ruqmc3uuqHU+I436Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le20LK0izKJvpzcJsn/wk9Ur8I1yBsaG8v0UNbq6iZw=;
	b=oiTWPMn6Lqgdj4HLFzHXhZdxrCSmLo7LAGsOmvHWnAPpGna3NLjEr4pH1YXCMjGeWj3eR2
	FesZbbTfmK2JmNAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0nRaH746;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=s6FDUjMj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790945110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le20LK0izKJvpzcJsn/wk9Ur8I1yBsaG8v0UNbq6iZw=;
	b=0nRaH746fHYZi5EPa6vJDMBEThb8sy3slM716DX2ZnoIseUyIRnC5Y+LTv0uobyUCTN4X8
	34hFkDccBT//m9IsaLGRolqubXqjzxZzGHKY7TJkzhq91v7/lcoz3ifd95aeWvek7XubXA
	ggItxDvXiS8PgwqaG7IEcQJpKAj0x3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790945110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le20LK0izKJvpzcJsn/wk9Ur8I1yBsaG8v0UNbq6iZw=;
	b=s6FDUjMjiSjnXBM3UfciYAHUwFO8A3WhQQZn1FefKXiPNSRgZitualkAaTodW/saCFK0C2
	dHYsg0ii4hSfdvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4B7713C99;
	Fri,  2 Oct 2026 12:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V/hJI0ynv2rNTwAAD6G6ig:T8
	(envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:45:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	decui@microsoft.com,
	ssengar@linux.microsoft.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 7/7] drm/vc4: Do not include <drm/drm_simple_kms_helper.h>
Date: Fri,  2 Oct 2026 14:41:57 +0200
Message-ID: <20261002124456.741011-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124456.741011-1-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5439B21E58
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

The vc4 driver does not require anything from the simple-kms
header. Do not include it.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/vc4/vc4_dpi.c  | 1 -
 drivers/gpu/drm/vc4/vc4_dsi.c  | 1 -
 drivers/gpu/drm/vc4/vc4_hdmi.c | 1 -
 drivers/gpu/drm/vc4/vc4_vec.c  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index 53f36626a50d..686903b8864b 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -19,7 +19,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/media-bus-format.h>
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 0148f2befed1..5ed3c35ee9c7 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -38,7 +38,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "vc4_drv.h"
 #include "vc4_regs.h"
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 3a90dbb61f4e..6b00581f304f 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -41,7 +41,6 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/gpio/consumer.h>
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index 792b7b39be59..215b5d3dc5c5 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -19,7 +19,6 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/of.h>
-- 
2.55.0

