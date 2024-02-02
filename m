Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFDF13E202
	for <linux-fbdev@vger.kernel.org>; Fri,  2 Feb 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875308; cv=none; b=fHnfDH7ySDfsz3trC3R7GeyPGPNMEcFXxhtY3Trn3+vpEcCYNqZn/N92G1GPfBXjIHXzIP/Ar4JEGFmVUrU4dU9zJpTEpMH0G/+m1NsAAmOnSFkiC/iLJ7nBs8AdnRCJCrlSYFq+spVGCZK3iY53ruqsAruTNE/gBjDmujnP3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875308; c=relaxed/simple;
	bh=6tWw+E6ss0MedYruHAjwNan651IcnQktnq1N0/91lYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STgLMXAVC7VLT1yIfvqspEX8pgx8rGPIlwezWatSCsKpCnYQswX+w+ovUt+DHr2twOkmFPRW+w+kXI4HMEWD1xV0FZLXmdUlflSNmFcI8v1o4bZ/tlFA/IoSpDdka7D0JsZ75x8Jm0EF7DRdnxW89B5AzGw+itzIlhWUz1vu5FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fIVScKlp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v57W4w6S; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fIVScKlp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v57W4w6S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fIVScKlp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v57W4w6S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fIVScKlp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v57W4w6S"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7FE3A2234F;
	Fri,  2 Feb 2024 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706875304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nIJiLe5quPC+6Ikbcjh207Bt00KbJX4HrhaGRAuxM4=;
	b=fIVScKlpHSStKUHu111oI8yGGg9big06TWs5EElvwjcq/5oKAdxwUj01KN7sKuT/wQ67bW
	wyKxJViTuLaqMAft3N4knMtAbpuSw62+g7Q6On9/Ei66n/uDHWMw1qujDhx+1BQrQ3SCir
	ads15bBD34UqU6jwnYOqupTIo7iX4eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706875304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nIJiLe5quPC+6Ikbcjh207Bt00KbJX4HrhaGRAuxM4=;
	b=v57W4w6S4F79VHo7AMrzIAqnlatLNNRvCDESZg5dJxZwpEzePysbN+CyKHwultsPk8v7rF
	Pk7o2NI+OS6keIBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706875304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nIJiLe5quPC+6Ikbcjh207Bt00KbJX4HrhaGRAuxM4=;
	b=fIVScKlpHSStKUHu111oI8yGGg9big06TWs5EElvwjcq/5oKAdxwUj01KN7sKuT/wQ67bW
	wyKxJViTuLaqMAft3N4knMtAbpuSw62+g7Q6On9/Ei66n/uDHWMw1qujDhx+1BQrQ3SCir
	ads15bBD34UqU6jwnYOqupTIo7iX4eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706875304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nIJiLe5quPC+6Ikbcjh207Bt00KbJX4HrhaGRAuxM4=;
	b=v57W4w6S4F79VHo7AMrzIAqnlatLNNRvCDESZg5dJxZwpEzePysbN+CyKHwultsPk8v7rF
	Pk7o2NI+OS6keIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 403D113A63;
	Fri,  2 Feb 2024 12:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EPOEDqjZvGWfeAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 02 Feb 2024 12:01:44 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 6/8] fbdev/efifb: Do not track parent device status
Date: Fri,  2 Feb 2024 12:58:47 +0100
Message-ID: <20240202120140.3517-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202120140.3517-1-tzimmermann@suse.de>
References: <20240202120140.3517-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fIVScKlp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v57W4w6S
X-Spamd-Result: default: False [1.19 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de,kernel.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[21.09%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.19
X-Rspamd-Queue-Id: 7FE3A2234F
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

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

