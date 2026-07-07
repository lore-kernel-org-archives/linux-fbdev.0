Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD112169AD2
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Jul 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432665; cv=none; b=nXERhsdrgNtXyh1uoOwuRC1NLRTQ6EcqJ/HuzhQy19UGj+D3XR4wqGPbv2ssN3N9SroWD36aeDLts2U+kooO3Rx3fEzo6lJdHZT2gSsIiA6Lj41GCP+7zZ2EFI4uyo7X9/++qux/kXaLphl7U1Dhf5LR7CkARf78TlPi2ICv97Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432665; c=relaxed/simple;
	bh=xZi2bEEfjHQdc0A4TnmqNIgo1N200ReLXjdlAyaRiJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks9MqO/mXrQeZLEAxr2hO3Nz0eMECRg7RnMb7DC/fPikOAEU/TzEZAahwXxpIk6om9h62lOc82dCVrY6LVqRCFovm/6BMlf3wPOnOlFFL+4JwP7QaEdxkh2qws7ywXGVXS/8Pc5OdBj6y6YKKQtutbNBmuunaCcJJ01vbww34OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fjee/qWD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UkTCT6/L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fjee/qWD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UkTCT6/L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fjee/qWD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UkTCT6/L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fjee/qWD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UkTCT6/L"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89242759FB;
	Tue,  7 Jul 2026 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783432652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVbhDO3tD/f+sXvWZ0QDGfmfPXEwkaYwwxjIby5hPfQ=;
	b=fjee/qWDTE4L172t9HqVJC7oot8Y3DwZkVNBMAjVimgxthqiN4gPKFQdrENpHBE3fL339b
	HC6xesriwqWICO3Ij5tMgVwKELd0i1vw2XNWjM/uVX7+CCzqe8u6L5qdVbG6wIYWWMKFhj
	al01LGs+uX9DenRTzoDwq9OwQPOhzF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783432652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVbhDO3tD/f+sXvWZ0QDGfmfPXEwkaYwwxjIby5hPfQ=;
	b=UkTCT6/LgHZZcg24NHMVTdYznwOKtZe8WYkn7MaYmpKuhha+2+xbjFMLBtZWqNoHsw6FIC
	ATc80/DCwGRLCOCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783432652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVbhDO3tD/f+sXvWZ0QDGfmfPXEwkaYwwxjIby5hPfQ=;
	b=fjee/qWDTE4L172t9HqVJC7oot8Y3DwZkVNBMAjVimgxthqiN4gPKFQdrENpHBE3fL339b
	HC6xesriwqWICO3Ij5tMgVwKELd0i1vw2XNWjM/uVX7+CCzqe8u6L5qdVbG6wIYWWMKFhj
	al01LGs+uX9DenRTzoDwq9OwQPOhzF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783432652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zVbhDO3tD/f+sXvWZ0QDGfmfPXEwkaYwwxjIby5hPfQ=;
	b=UkTCT6/LgHZZcg24NHMVTdYznwOKtZe8WYkn7MaYmpKuhha+2+xbjFMLBtZWqNoHsw6FIC
	ATc80/DCwGRLCOCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 070E8779AF;
	Tue,  7 Jul 2026 13:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cNWHAMwFTWoFSgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 07 Jul 2026 13:57:32 +0000
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
Subject: [PATCH 05/10] drm/amdgpu: Implement struct vga_switcheroo_client_ops.pre_switch
Date: Tue,  7 Jul 2026 15:38:12 +0200
Message-ID: <20260707135724.247562-6-tzimmermann@suse.de>
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
	NEURAL_HAM_SHORT(-0.18)[-0.912];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Level: 
X-Spam-Score: -2.78

Call drm_client_dev_acquire_outputs() from vga_switcheroo's pre_switch
callback. Pushes fbcon updates from vga_switcheroo into DRM's fbdev
emulation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 78c96c7102e4..87a59a79a019 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1699,10 +1699,18 @@ static bool amdgpu_switcheroo_can_switch(struct pci_dev *pdev)
 	return atomic_read(&dev->open_count) == 0;
 }
 
+static void amdgpu_switcheroo_pre_switch(struct pci_dev *pdev)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+
+	drm_client_dev_acquire_outputs(dev);
+}
+
 static const struct vga_switcheroo_client_ops amdgpu_switcheroo_ops = {
 	.set_gpu_state = amdgpu_switcheroo_set_state,
 	.reprobe = NULL,
 	.can_switch = amdgpu_switcheroo_can_switch,
+	.pre_switch = amdgpu_switcheroo_pre_switch,
 };
 
 /**
-- 
2.54.0

