Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF41EA78
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496133; cv=none; b=plJ0pGIX2iSolb1Ih6W66MZ9XJge5AWt9wiO32uBvPo6IFIXA0HYO5ydDAFulUAt4PPDEN5Fz16EKB7wX+D8Y65a6QAsXsMsTNUkxd90jCvrM5PbQ1NEXHLptOns2fQqPnzoY1YVJf0oJr2sxpoXEWUhsQ6rPjH0saANqvKKEnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496133; c=relaxed/simple;
	bh=6KVVX7ffH/EenxDNdpXWD1z0BG9SnBiqYO27MrXMZWI=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Level:X-Spam-Score:X-Spamd-Result:
	 X-Spam-Flag; b=isrCsphXOVG/2m3HgJqsBjE+VnFxQUFVgWOjN74dQhg7C5KI8YDFRAT/pI7zH1wXVFuaRm53+urCCMZsXs716MgqLu2KjYWsLMdbrNRYCStYmWdr+w8s4T6f+mIqc2PaY7gSYix9dEM9k4Iy0aITWkkUZSsgbhOX72m7LFjU8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F9wmm5rq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jVLu+Qmk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F9wmm5rq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jVLu+Qmk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F9wmm5rq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVLu+Qmk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F9wmm5rq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jVLu+Qmk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B04322271;
	Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705496130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBvwA7BZDRUiHYfR4QddANdC/tStltJYXhFSoH8kmwU=;
	b=F9wmm5rqcaNhvQG+407fEVd1etzpRnvqN983qMSjI+2meA1/AbPQVBZ971B9/4gtjgi8Bk
	K850WJoO+uN+niI0vg0qi5M4FiYtZ2pHVZMUMr5vC8aBrLwVSg7jcrGhKhbD9eh+nDyfh7
	mj7Y6guMKta03qgmsruIeoN1Ol5jqw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705496130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBvwA7BZDRUiHYfR4QddANdC/tStltJYXhFSoH8kmwU=;
	b=jVLu+QmkE3oBR3ar1gJ10AfMqlEcmsLL0V/ckBpHFfL2F+A4DMWqHu1LgW2qAoDPq7yGCF
	Q7As0NAqgvCNkzCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705496130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBvwA7BZDRUiHYfR4QddANdC/tStltJYXhFSoH8kmwU=;
	b=F9wmm5rqcaNhvQG+407fEVd1etzpRnvqN983qMSjI+2meA1/AbPQVBZ971B9/4gtjgi8Bk
	K850WJoO+uN+niI0vg0qi5M4FiYtZ2pHVZMUMr5vC8aBrLwVSg7jcrGhKhbD9eh+nDyfh7
	mj7Y6guMKta03qgmsruIeoN1Ol5jqw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705496130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GBvwA7BZDRUiHYfR4QddANdC/tStltJYXhFSoH8kmwU=;
	b=jVLu+QmkE3oBR3ar1gJ10AfMqlEcmsLL0V/ckBpHFfL2F+A4DMWqHu1LgW2qAoDPq7yGCF
	Q7As0NAqgvCNkzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A94C13800;
	Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6G5KCULOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/8] firmware/sysfb: Create firmware device only for enabled PCI devices
Date: Wed, 17 Jan 2024 13:39:09 +0100
Message-ID: <20240117125527.23324-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117125527.23324-1-tzimmermann@suse.de>
References: <20240117125527.23324-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de,kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Test if the firmware framebuffer's parent PCI device, if any, has
been enabled. If not, the firmware framebuffer is most likely not
working. Hence, do not create a device for the firmware framebuffer
on disabled PCI devices.

So far, efifb tracked the status of the PCI parent device internally
and did not bind if it was disabled. This patch implements the
functionality for all firmware framebuffers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/sysfb.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 8a42da3f67a9..48a550bd1a93 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -70,6 +70,27 @@ void sysfb_disable(void)
 }
 EXPORT_SYMBOL_GPL(sysfb_disable);
 
+static __init bool sysfb_pci_dev_is_enabled(struct pci_dev *pdev)
+{
+#if defined(CONFIG_PCI)
+	/*
+	 * TODO: Try to integrate this code into the PCI subsystem
+	 */
+	int ret;
+	u16 command;
+
+	ret = pci_read_config_word(pdev, PCI_COMMAND, &command);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return false;
+	if (!(command & PCI_COMMAND_MEMORY))
+		return false;
+	return true;
+#else
+	// Getting here without PCI support is probably a bug.
+	return false;
+#endif
+}
+
 static __init int sysfb_init(void)
 {
 	const struct screen_info *si = &screen_info;
@@ -87,8 +108,11 @@ static __init int sysfb_init(void)
 	sysfb_apply_efi_quirks();
 
 	pparent = screen_info_pci_dev(si);
-	if (pparent)
+	if (pparent) {
+		if (!sysfb_pci_dev_is_enabled(pparent))
+			goto unlock_mutex;
 		parent = &pparent->dev;
+	}
 
 	/* try to create a simple-framebuffer device */
 	compatible = sysfb_parse_mode(si, &mode);
-- 
2.43.0

