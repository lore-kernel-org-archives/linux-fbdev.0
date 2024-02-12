Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11F101C6
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707728866; cv=none; b=hEC9gq1tdGRUauDHtu2ri2ytV+mojR33g0E7uQS78G+kACj1p5pUbwtQqswCO+w3xJ7aZMdrgSX6DYRdzLBux/869BdmdGl7RFkKiBxJJspiP1pi5PX87BRpxsSi/cqreL5W2SVcNS/uOocgaFIQO50vBC3BqiLDd7RthzLqOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707728866; c=relaxed/simple;
	bh=6tWw+E6ss0MedYruHAjwNan651IcnQktnq1N0/91lYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaqLopJd38QEvYhcW6ydpk2KB326BVhvhD7ndF6790EmP/2lV310JXDtw/+PUKkh7r0Xju+Qxgr+msiHcUomZH7K4Q4mlb6GyRFhKppy9nC07ShVi1fLY3UqdWpReoX9qsPb3cmuSNpct7iEyp6pV3lj0GKQ0r5RuWAOyPqA4SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q96n3q48; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YZs3V0MW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q96n3q48; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YZs3V0MW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q96n3q48";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YZs3V0MW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q96n3q48";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YZs3V0MW"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EFC5221A5;
	Mon, 12 Feb 2024 09:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707728863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nIJiLe5quPC+6Ikbcjh207Bt00KbJX4HrhaGRAuxM4=;
	b=q96n3q48+yzTJVTpKUe4QGv2HsBbq+fVMmjuLpvfG6ncQysNgOpNqfsyoWfYcACxdzA8cs
	u+vYQ1p1a9pZspc4y6zsvTDdEHna1gkYiqlhF6pxkIbtjWhxNz0sd2DroDvF9TWvJKE2Q/
	u6mSA5pbqu/lOtrsJRNyxqTDAam+CUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707728863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nIJiLe5quPC+6Ikbcjh207Bt00KbJX4HrhaGRAuxM4=;
	b=YZs3V0MWrp7g3pCMNIr3IhPZmB0sg6IbKdiOr3lvZ5LSlU5kZkLGL8shJiGFmUsjJ6wLaU
	acYVyfjmIO0pcIDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707728863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nIJiLe5quPC+6Ikbcjh207Bt00KbJX4HrhaGRAuxM4=;
	b=q96n3q48+yzTJVTpKUe4QGv2HsBbq+fVMmjuLpvfG6ncQysNgOpNqfsyoWfYcACxdzA8cs
	u+vYQ1p1a9pZspc4y6zsvTDdEHna1gkYiqlhF6pxkIbtjWhxNz0sd2DroDvF9TWvJKE2Q/
	u6mSA5pbqu/lOtrsJRNyxqTDAam+CUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707728863;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nIJiLe5quPC+6Ikbcjh207Bt00KbJX4HrhaGRAuxM4=;
	b=YZs3V0MWrp7g3pCMNIr3IhPZmB0sg6IbKdiOr3lvZ5LSlU5kZkLGL8shJiGFmUsjJ6wLaU
	acYVyfjmIO0pcIDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CE47713A2D;
	Mon, 12 Feb 2024 09:07:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QHaHMN7fyWXecwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 09:07:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	sui.jingfeng@linux.dev,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 6/8] fbdev/efifb: Do not track parent device status
Date: Mon, 12 Feb 2024 10:06:14 +0100
Message-ID: <20240212090736.11464-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212090736.11464-1-tzimmermann@suse.de>
References: <20240212090736.11464-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q96n3q48;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YZs3V0MW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLd5zd8tio7mptchx3z93fk9kq)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[redhat.com,linux.dev,gmx.de,kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[30.35%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.49
X-Rspamd-Queue-Id: 1EFC5221A5
X-Spam-Flag: NO

There will be no EFI framebuffer device for disabled parent devices
and thus we never probe efifb in that case. Hence remove the tracking
code from efifb.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/efifb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index e66ef35fa6b62..f76b7ae007518 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -348,8 +348,6 @@ static struct attribute *efifb_attrs[] = {
 };
 ATTRIBUTE_GROUPS(efifb);
 
-static bool pci_dev_disabled;	/* FB base matches BAR of a disabled device */
-
 static struct resource *bar_resource;
 static u64 bar_offset;
 
@@ -377,7 +375,7 @@ static int efifb_probe(struct platform_device *dev)
 	if (!si)
 		return -ENOMEM;
 
-	if (si->orig_video_isVGA != VIDEO_TYPE_EFI || pci_dev_disabled)
+	if (si->orig_video_isVGA != VIDEO_TYPE_EFI)
 		return -ENODEV;
 
 	if (fb_get_options("efifb", &option))
@@ -653,7 +651,6 @@ static void record_efifb_bar_resource(struct pci_dev *dev, int idx, u64 offset)
 
 	pci_read_config_word(dev, PCI_COMMAND, &word);
 	if (!(word & PCI_COMMAND_MEMORY)) {
-		pci_dev_disabled = true;
 		dev_err(&dev->dev,
 			"BAR %d: assigned to efifb but device is disabled!\n",
 			idx);
-- 
2.43.0

