Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D63390228
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Jul 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432652; cv=none; b=HcyPJI6P/va8T5qmK3n6EXOF7D7KYpMdBbteXlC52IoU080E9MmV/9je7fKlPdE42+3m0fPl1LUrT4u05gaG/C8KjJyfVXr3a1TO6a3BRkGF7Mf20pPmXI4OgaS+Iy3fpj1D34F8DvnBxzrXw64eNj2xxE61gKWVVEyy4oRpDWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432652; c=relaxed/simple;
	bh=3ZCjCxoRGovES91sOQuFkxihX0t2iDbf5Gqm502J5DI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4zyHwQNaiPhzAXU/692km+N/Oo7ScgIph1ovlojq5sff/s+veu9W8kmWyWTVxnYyDrs9jG7eq9xwvnCktmAbRm+QA/5jehj0Qzpx2srq+O3i4j+aPgF+4q+y78QF0BqgaCEcz8DyyTfyrcLMAMyMnPQyVLrQ+YRoBhZ17m87f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZMcKQXP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C+RyRdWP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZMcKQXP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C+RyRdWP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZMcKQXP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C+RyRdWP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZMcKQXP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C+RyRdWP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DF37726F2;
	Tue,  7 Jul 2026 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783432649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/BZajym9uebxwqSIz0M7fPVZU/Sl2uebGIt4iYrAV9g=;
	b=JZMcKQXPD3wy5PFRcdEITfw+miSKvKJ5RTlRAuxpEpPsS5l8wPBhu7f94fvq1bAr/WOr+0
	pUsglwjcyaxwYnrT281uqhdnEzEsoLSpufH5gEu8rNbl0G+vLT7wj+TNMpLAvAf9fzIZ7E
	SO+h0aYfew01KkkLL+kgOIcGFv6WVZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783432649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/BZajym9uebxwqSIz0M7fPVZU/Sl2uebGIt4iYrAV9g=;
	b=C+RyRdWPPLFcwhiNscmhIGQS0IMWLqWZiaNhJ0EJauZjg3KpsekXPUg7vgQhjJxISCOmvl
	+TLK6kAXvGZsgVAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JZMcKQXP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=C+RyRdWP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783432649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/BZajym9uebxwqSIz0M7fPVZU/Sl2uebGIt4iYrAV9g=;
	b=JZMcKQXPD3wy5PFRcdEITfw+miSKvKJ5RTlRAuxpEpPsS5l8wPBhu7f94fvq1bAr/WOr+0
	pUsglwjcyaxwYnrT281uqhdnEzEsoLSpufH5gEu8rNbl0G+vLT7wj+TNMpLAvAf9fzIZ7E
	SO+h0aYfew01KkkLL+kgOIcGFv6WVZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783432649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/BZajym9uebxwqSIz0M7fPVZU/Sl2uebGIt4iYrAV9g=;
	b=C+RyRdWPPLFcwhiNscmhIGQS0IMWLqWZiaNhJ0EJauZjg3KpsekXPUg7vgQhjJxISCOmvl
	+TLK6kAXvGZsgVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19C6C779AE;
	Tue,  7 Jul 2026 13:57:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1EnlBMkFTWoFSgAAD6G6ig
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
Subject: [PATCH 00/10] vga_switcheroo, drm: Push fbcon handling into DRM clients
Date: Tue,  7 Jul 2026 15:38:07 +0200
Message-ID: <20260707135724.247562-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9DF37726F2
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[22];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Vga_switcheroo currently invokes fb_switch_outputs() to inform fbcon
about switching of the physical outputs among framebuffer devices. But
new DRM clients to not use fbdev/fbcon and might require their own
vga_switcheroo support. Let's strictly separate them from each other.

Remove fbdev/fbcon from vga_switcheroo. Introduce a pre_switch callback
for vga_switcheroo clients to do the fbcon update. Allows for removing
all direct interactions between vga_switcheroo and fbdev/fbcon.

Also replace the existing reprobe hook with post_switch for symetry.

At the same time, push the fbcon update into DRM's client for fbdev
emulation. Do this with the new DRM client callback acquire_outputs,
so that other clients can have their own handling of vga_switcheroo.

There are only four drivers that support vga_switcheroo: amdgpu,
radeon, i915 and nouveau. Update each of them with the new callbacks.
When vga_switcheroo now invokes pre_switch, each DRM driver forwards
to aquire_outputs and lets the DRM clients handle the new outputs.

Tested with radeon on a notebook with Radeon HD 4225 and HD 5430.

Thomas Zimmermann (10):
  drm/edid: Include <linux/fb.h>
  drm/client: Add acquire_outputs callback; implement for fbdev
    emulation
  vga_switcheroo: Add pre_switch callback to client ops
  vga_switcheroo: Add post_switch callback to client ops
  drm/amdgpu: Implement struct vga_switcheroo_client_ops.pre_switch
  drm/i915: Implement vga_switcheroo_client_ops.pre_switch
  drm/nouveau: Implement vga_switcheroo_client_ops.pre_switch
  drm/nouveau: Implement vga_switcheroo_client_ops.post_switch
  drm/radeon: Implement struct vga_switcheroo_client_ops.pre_switch
  vga-switcheroo: Remove unused interfaces

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 ++++-
 drivers/gpu/drm/clients/drm_fbdev_client.c | 23 ++++++++----
 drivers/gpu/drm/drm_client_event.c         | 18 ++++++++++
 drivers/gpu/drm/drm_edid.c                 |  1 +
 drivers/gpu/drm/i915/i915_switcheroo.c     | 11 +++++-
 drivers/gpu/drm/nouveau/nouveau_vga.c      | 28 +++++++++------
 drivers/gpu/drm/radeon/radeon_device.c     |  9 ++++-
 drivers/gpu/vga/vga_switcheroo.c           | 41 +++++-----------------
 drivers/video/fbdev/core/fbcon.c           |  8 -----
 include/drm/drm_client.h                   | 14 ++++++++
 include/drm/drm_client_event.h             |  3 ++
 include/linux/vga_switcheroo.h             | 30 +++++++++-------
 12 files changed, 122 insertions(+), 73 deletions(-)


base-commit: cd8abe2554ec7eba16c1d48ab508732bf93534eb
-- 
2.54.0

