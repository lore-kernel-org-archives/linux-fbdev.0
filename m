Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58D1ABED8
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Dec 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840619; cv=none; b=nsPwpntxoQgVMlZRhju8dc4A0PxEJXmY6n3qQbO3ey745jtFH4bbVRqnwLDZX0e5kKxQB4ILU9r9oCawPeE6HuX2FniqulisvT6UmDU1sHROX8t8AV214qn+TuCrAP6UJFXpA8RO+Tj3LG06YjoM5aqD+J/ypDvVsDUy9dVxsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840619; c=relaxed/simple;
	bh=KCjXVSjG1XocdryoTp8V9KCqM2AA9jDI44vYnE4bmnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvpSroUlY0Y5ZZrtaDFAasx6CtRJlybvj8D+VHEwXwtwloiymNGlgOKfUjEEIAyMyF2wRzK7PGI3RzKCP4O9psUy7fuOpcbHtZl9swQcedI4BacnEfF+oDHG+gQ30Ue93DbcXU+0/CAcuU83QUSstiAmjfRccEzrIGowOq9kltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Tk/yLqaF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rnAQv/TZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S8l43o1d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6a+vj5BN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Tk/yLqaF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rnAQv/TZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S8l43o1d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6a+vj5BN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9CF171F460;
	Tue, 10 Dec 2024 14:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733840616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx6rbcNd1hjFNN0rndHtniA38P7kWX7gVt0dXlqViUA=;
	b=Tk/yLqaFJ/UI/mjUomSCvOcDyhfCH21WEoqLN6CYm07bZl6mWBpnj0AXpjsXVuLdlE0AeH
	jgnwH3oTGUUyQ7h9Mkp68aSwntRoKFptWuxBt8OmH5s8cMaNxUHET1zsKqIesb90ymde6E
	zzRJbhSBgn1NSnKREa3sDCV6kVy6dqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733840616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx6rbcNd1hjFNN0rndHtniA38P7kWX7gVt0dXlqViUA=;
	b=rnAQv/TZKFFB0KsLKu5SFkwB/5z7C12EgWTndKwREkz/Dzm1uUcqoIQJEKnhk4RVVPscrE
	ciZQKo8O7DwGojCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=S8l43o1d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6a+vj5BN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733840615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx6rbcNd1hjFNN0rndHtniA38P7kWX7gVt0dXlqViUA=;
	b=S8l43o1dfs6Y5/KUTXJGNLHJ+lmX8nktxfhdoZSB5a4P0tN7BXffpXtGnIeYGLGzzcKpnB
	XpElXjJCGVlfA+dGrpF3O3jjrjvsGO0Yai+DiN/2K1mQHUtjGFWRfmbdLmgq4/EGh34uyY
	SKR8hrw+NWkl2o1DMpe/BUap67d5jSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733840615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lx6rbcNd1hjFNN0rndHtniA38P7kWX7gVt0dXlqViUA=;
	b=6a+vj5BNnGCtaOjNlcsq5Sdb/cE4uyN9z3xcDtWqSvrNwN5lQcz1cRLYMrJ0kRilhnhw1r
	gRx+LHmZMGNnzOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5262213A5C;
	Tue, 10 Dec 2024 14:23:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EB7OEudOWGfREwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 10 Dec 2024 14:23:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	arnd@arndb.de,
	deller@gmx.de,
	simona@ffwll.ch,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/3] drm/fbdev: Select FB_CORE dependency for fbdev on DMA and TTM
Date: Tue, 10 Dec 2024 15:09:55 +0100
Message-ID: <20241210142329.660801-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210142329.660801-1-tzimmermann@suse.de>
References: <20241210142329.660801-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9CF171F460
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,arndb.de,gmx.de,ffwll.ch,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,patchwork.freedesktop.org:url];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLtfyjk8sg4x43ngtem9djprcp)];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Select FB_CORE if GEM's DMA and TTM implementations support fbdev
emulation. Fixes linker errors about missing symbols from the fbdev
subsystem.

Also see [1] for a related SHMEM fix.

Fixes: dadd28d4142f ("drm/client: Add client-lib module")
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/series/141411/ # 1
---
 drivers/gpu/drm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index c181b2ee78b6..6105a55eb464 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -288,6 +288,7 @@ config DRM_TTM_HELPER
 	tristate
 	depends on DRM
 	select DRM_TTM
+	select FB_CORE if DRM_FBDEV_EMULATION
 	select FB_SYSMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  Helpers for ttm-based gem objects
@@ -295,6 +296,7 @@ config DRM_TTM_HELPER
 config DRM_GEM_DMA_HELPER
 	tristate
 	depends on DRM
+	select FB_CORE if DRM_FBDEV_EMULATION
 	select FB_DMAMEM_HELPERS_DEFERRED if DRM_FBDEV_EMULATION
 	help
 	  Choose this if you need the GEM DMA helper functions
-- 
2.47.1

