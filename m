Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB161714B4;
	Tue, 15 Oct 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728976237; cv=none; b=rwmtny/swQ8J+ODJFbrT7454/a4ivHOS/soCTJ5eElRIXb2vCRT7NuJ8elJcCNbqt9yjX/ySuZw43tWBtjV6Wkfzs9ZQO6NnNGK+Z/BHrZJK+0P9jVH1BGoKGGppztpW7/D7BvbY6D46+PYxh9STvyRjxgRlmjb24aAhfCAbtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728976237; c=relaxed/simple;
	bh=vkS1lpdNzovMyqYIhrI1bTnWGJPHf0McR3oHkVUH2QE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t94bBo4yNl/kydfb0JsbJu93T16vYRV9StTO/tE41+SRw4GdDa4L6KzNrDdPqZucOYu1DDTcDQpsQlFn3jrgnsEikEYVTKrudcxRtixD4o+S9qWGp79LCL/ST4SijXiW/cet68IyzJlWTl9M4VMGX4lX39gnvrI8asrQq5pN5r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CtmW0oJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8+/RknvH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CtmW0oJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8+/RknvH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CtmW0oJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8+/RknvH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CtmW0oJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8+/RknvH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2BE521F7AB;
	Tue, 15 Oct 2024 07:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728976234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E6/mVLEz6LfWMBcytnz5k+mWrLmFJP2rfgNxnBYPvvQ=;
	b=CtmW0oJe4S68IBf/hr7xcz8mGB46uSAkoMfAkqx2ol9zSO9ptICBMpHIffXBvkrGDm/nn+
	foTXcoLFnOpfHQq/cBVmpk/af1UFlDeHzldwk2nEpQNkidIsOXqJVHGwvcGdF8LhAH+mEY
	EXrER/ibroh5nQEeCfgHPxysGVt6SOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728976234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E6/mVLEz6LfWMBcytnz5k+mWrLmFJP2rfgNxnBYPvvQ=;
	b=8+/RknvHcfED67yTcRvRXsp1SnWJvbsLzBK6jWhabLOgRaGHdhZCTmJgdixHUdF5DJ0s7U
	NqBskz0aYjwGgdDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728976234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E6/mVLEz6LfWMBcytnz5k+mWrLmFJP2rfgNxnBYPvvQ=;
	b=CtmW0oJe4S68IBf/hr7xcz8mGB46uSAkoMfAkqx2ol9zSO9ptICBMpHIffXBvkrGDm/nn+
	foTXcoLFnOpfHQq/cBVmpk/af1UFlDeHzldwk2nEpQNkidIsOXqJVHGwvcGdF8LhAH+mEY
	EXrER/ibroh5nQEeCfgHPxysGVt6SOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728976234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=E6/mVLEz6LfWMBcytnz5k+mWrLmFJP2rfgNxnBYPvvQ=;
	b=8+/RknvHcfED67yTcRvRXsp1SnWJvbsLzBK6jWhabLOgRaGHdhZCTmJgdixHUdF5DJ0s7U
	NqBskz0aYjwGgdDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F162913A42;
	Tue, 15 Oct 2024 07:10:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vDOMOWkVDmeUdgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Oct 2024 07:10:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gonzalo.silvalde@gmail.com,
	sfr@canb.auug.org.au
Cc: linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] fbdev: sstfb: Fix build after CONFIG_FB_DEVICE changes
Date: Tue, 15 Oct 2024 09:09:20 +0200
Message-ID: <20241015071029.25639-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,suse.de:email,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com,canb.auug.org.au];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Spam-Score: -1.30
X-Spam-Flag: NO

Commit 7c0510bb3452 ("fbdev: sstfb: Make CONFIG_FB_DEVICE optional")
made sstfb's dependency on CONFIG_FB_DEVICE optional. Fix the build
error

drivers/video/fbdev/sstfb.c: In function 'sstfb_probe':
drivers/video/fbdev/sstfb.c:1439:2: error: invalid preprocessing directive #fdef; did you mean #ifdef?
 1439 | #fdef CONFIG_FB_DEVICE
      |  ^~~~
      |  ifdef
drivers/video/fbdev/sstfb.c:1442:2: error: #endif without #if
 1442 | #endif
      |  ^~~~~

plus some formatting changes.

Also remove the dependency in the Kconfig rule, so that the driver
can be selected without FB_DEVICE enabled.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20241015120119.533e65e8@canb.auug.org.au/raw
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 7c0510bb3452 ("fbdev: sstfb: Make CONFIG_FB_DEVICE optional")
Cc: Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/Kconfig | 1 -
 drivers/video/fbdev/sstfb.c | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ea36c6956bf3..44a8fdbab6df 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1236,7 +1236,6 @@ config FB_3DFX_I2C
 config FB_VOODOO1
 	tristate "3Dfx Voodoo Graphics (sst1) support"
 	depends on FB && PCI
-	depends on FB_DEVICE
 	select FB_IOMEM_HELPERS
 	help
 	  Say Y here if you have a 3Dfx Voodoo Graphics (Voodoo1/sst1) or
diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 8d2e9d1f8d80..50e9d2e64d4a 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -739,7 +739,7 @@ static ssize_t show_vgapass(struct device *device, struct device_attribute *attr
 }
 static struct device_attribute device_attrs[] = {
 	__ATTR(vgapass, S_IRUGO|S_IWUSR, show_vgapass, store_vgapass)
-	};
+};
 #endif
 
 static int sstfb_ioctl(struct fb_info *info, unsigned int cmd,
@@ -1436,7 +1436,8 @@ static int sstfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	sstfb_clear_screen(info);
-#fdef CONFIG_FB_DEVICE
+
+#ifdef CONFIG_FB_DEVICE
 	if (device_create_file(info->dev, &device_attrs[0]))
 		printk(KERN_WARNING "sstfb: can't create sysfs entry.\n");
 #endif
@@ -1468,6 +1469,7 @@ static void sstfb_remove(struct pci_dev *pdev)
 
 	info = pci_get_drvdata(pdev);
 	par = info->par;
+
 #ifdef CONFIG_FB_DEVICE
 	device_remove_file(info->dev, &device_attrs[0]);
 #endif
-- 
2.46.0

