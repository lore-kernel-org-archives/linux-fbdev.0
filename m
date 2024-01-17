Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8421EA8D
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jan 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496135; cv=none; b=WlfkG5cyfDUNa/h+f4MOFaF8uRjIiYwiTk8oEsWuGe0cIyyvSoyD6mEtulLyjQq4FAFglv5tEyokx2FhKJerDF/TItrHRnwES0iJ1HWui032sVzALUj7FsACpBP97Woh3WnO/az21KCnjiaot6ML34HsT3i4XwPh5hjv6AOWc7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496135; c=relaxed/simple;
	bh=fSA8zcZrHBWWq3ITDCWczZxEnd4YOa67fjD8RK+xJuw=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Level:X-Spam-Flag:
	 X-Spam-Score; b=mC6ScJ4+Rc7trWjn5JFLMAUmNRq7TjYZ5iZoewGaNY44zL+IRmGnIg8pC5qu5VQBA7x0JlyhM2iu4YeZQIdDi8oWiO/JALSn19dgoqd2279FZcDsEpOpUfStSzr0OfdOaeWvf6eFC8NO4IEVtgh7vbyQRp3RLKPvFCuBK81JWY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sja7KLRH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tb/4UCng; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sja7KLRH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tb/4UCng; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sja7KLRH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tb/4UCng";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sja7KLRH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tb/4UCng"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 991B11FC29;
	Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705496130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk+Qpa6bIiUGIOnj4KlszwjOOcmi8bHVvD2y/i2cdD4=;
	b=sja7KLRHq+khOwqVWWaXDxKzHbIhdt3u6htrlcbAcIpQsNylED5GOfw3AhTnfDUGP/bvIn
	j6qYIyOcXxKegRT/dcdLCPJyX0O4UYnfzeRWJQuWPdY1IQNRQOU54gC6gE6YeyuogMtFrO
	ohVHuVD9k7kfDx//dGG/akFCmUTAoJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705496130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk+Qpa6bIiUGIOnj4KlszwjOOcmi8bHVvD2y/i2cdD4=;
	b=tb/4UCngbE2Jcsn4J6dkoMh7fIIrI/b2yC2k6KUGnlA8KlOlw/1KjKmCWZjt8GYyNFEdPI
	xbwKdUmuNK1wDoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705496130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk+Qpa6bIiUGIOnj4KlszwjOOcmi8bHVvD2y/i2cdD4=;
	b=sja7KLRHq+khOwqVWWaXDxKzHbIhdt3u6htrlcbAcIpQsNylED5GOfw3AhTnfDUGP/bvIn
	j6qYIyOcXxKegRT/dcdLCPJyX0O4UYnfzeRWJQuWPdY1IQNRQOU54gC6gE6YeyuogMtFrO
	ohVHuVD9k7kfDx//dGG/akFCmUTAoJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705496130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jk+Qpa6bIiUGIOnj4KlszwjOOcmi8bHVvD2y/i2cdD4=;
	b=tb/4UCngbE2Jcsn4J6dkoMh7fIIrI/b2yC2k6KUGnlA8KlOlw/1KjKmCWZjt8GYyNFEdPI
	xbwKdUmuNK1wDoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6010F13808;
	Wed, 17 Jan 2024 12:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aAhWFkLOp2X1YQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Jan 2024 12:55:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	pjones@redhat.com,
	deller@gmx.de,
	ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/8] fbdev/efifb: Do not track parent device status
Date: Wed, 17 Jan 2024 13:39:10 +0100
Message-ID: <20240117125527.23324-7-tzimmermann@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[redhat.com,gmx.de,kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

There will be no EFI framebuffer device for disabled parent devices
and thus we never probe efifb in that case. Hence remove the tracking
code from efifb.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/efifb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index e66ef35fa6b6..f76b7ae00751 100644
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

