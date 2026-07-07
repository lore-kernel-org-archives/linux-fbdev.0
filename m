Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD63ED135
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Jul 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432653; cv=none; b=sFeNd6k4Eww2QCtVNXReC8V3i/a6w9UWi8KVjHCXOPCZS3L+64tGjbM0//B7udkI2Uaql8a0/noEgo07sp5Xn8I1r5sETd0FSduEC2bjAW2cjxqPPD1A2CN1tBveZPNF3zkC++iQZsS9t4zueHExmYAQpGaBWtrKFDX6CU54MWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432653; c=relaxed/simple;
	bh=VHoeNjEaIEeK3eHclaanOhQArgnjrabQCrpEEvE0ltI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/PcUN9XnHJjSDRvnkQBHYv9J+GX0lGdYNPWsaSqKEtveBHDaE3Nx7AahAMomUSW2xZQ/WrbbN+HQKYD1REdYsNhh+9BX+udJpdDjxRloh928b3RJIazEeqaMxuLo6bZzv0hOkHOGGtJ7Ficr0AK6YfvffzXaeLv2FvN3th/O1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J6wpNNM/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=68iXdv7V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J6wpNNM/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=68iXdv7V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J6wpNNM/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="68iXdv7V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J6wpNNM/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="68iXdv7V"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4171B759D1;
	Tue,  7 Jul 2026 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783432650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XctuVESh7ZeNSsRmaxqwIzT4LaneT22++w9e8ig4CGA=;
	b=J6wpNNM/Ut2sYlZlD0xseOall5lm0rzwyt2Tn12vpUbDkQqLjaZmaIYDq8MXXCSsMzJnKl
	T5TcfVDr5IC9ydVjHFjSksqh7RWAOQ3eqU/8mum9Rn7SfvGBf6liJ0hzimtxjrcL/48GOc
	GGJYihbwClC0PMlyeH7rmVbF/WvP+HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783432650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XctuVESh7ZeNSsRmaxqwIzT4LaneT22++w9e8ig4CGA=;
	b=68iXdv7VpVpEib/TDsAtlN5u5sb7jnb0Wjb20OErKJ3VYGCdssuNiwk68Dmo3CNZI730fc
	+szfA+09I8JMfvCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783432650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XctuVESh7ZeNSsRmaxqwIzT4LaneT22++w9e8ig4CGA=;
	b=J6wpNNM/Ut2sYlZlD0xseOall5lm0rzwyt2Tn12vpUbDkQqLjaZmaIYDq8MXXCSsMzJnKl
	T5TcfVDr5IC9ydVjHFjSksqh7RWAOQ3eqU/8mum9Rn7SfvGBf6liJ0hzimtxjrcL/48GOc
	GGJYihbwClC0PMlyeH7rmVbF/WvP+HM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783432650;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XctuVESh7ZeNSsRmaxqwIzT4LaneT22++w9e8ig4CGA=;
	b=68iXdv7VpVpEib/TDsAtlN5u5sb7jnb0Wjb20OErKJ3VYGCdssuNiwk68Dmo3CNZI730fc
	+szfA+09I8JMfvCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5A29779AF;
	Tue,  7 Jul 2026 13:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GGwnJ8kFTWoFSgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 07 Jul 2026 13:57:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lukas@wunner.de,
	jfalempe@redhat.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tursulin@ursulin.net,
	lyude@redhat.com,
	dakr@kernel.org,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 01/10] drm/edid: Include <linux/fb.h>
Date: Tue,  7 Jul 2026 15:38:08 +0200
Message-ID: <20260707135724.247562-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707135724.247562-1-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.913];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Level: 
X-Spam-Score: -2.78

We currently get <linux/fb.h> via <linux/vga_switcheroo.h>. Include it
explicitly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_edid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 07970e5b5f65..86ae2d8d4de2 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -32,6 +32,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/cec.h>
 #include <linux/export.h>
+#include <linux/fb.h> /* for KHZ2PICOS() */
 #include <linux/hdmi.h>
 #include <linux/i2c.h>
 #include <linux/kernel.h>
-- 
2.54.0

