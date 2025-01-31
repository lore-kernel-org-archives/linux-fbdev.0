Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E981A1C5D47
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332073; cv=none; b=evtSZ0pNSj0PttHLZszYukIzt4CXxYzujV6I8l6ZGldAGxtPURql9e0f6nnb4XnK77nFS60lW+YghC3WxFQC8G17aXQaRs90ghekEoQaZdlaTyBpFQZ0EERpBUbnd/4To8Nss5ziHSDt0zZDF9fBhtgkkaJSYt/nlRACW59tj4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332073; c=relaxed/simple;
	bh=lcUqDdhfms5/oHgxes20Dq/V9UNsr4pd6IqRTg3OJ4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd/Opmwc3zJunnuHW2YyM+SyDtPb+xdLmw3AohBeAQLRhg463wdr6iO+lcb4T73RNhKVGFN0g9irihLQ7NVmnNJDqa44dpSsAqFbojWbo+izPL7gGVq+HfeCCBWvMc05prO0h4Yp8YTSnA7Ilwc4JlIHDdjSQRwB3L+u5dGNewM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CNt5nwiG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4N7mxjRo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CNt5nwiG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4N7mxjRo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93E9A1F38F;
	Fri, 31 Jan 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwzhKi978OX+6eV1dpseMviZCH0GFDu4NdtSmY/6DCA=;
	b=CNt5nwiGt3Auawkn6KksCjEIbL52v6RQD/Pm9JtECsdkKZazYvxkrjB3AvA32BaYXvMQal
	oAkDCnGpg7E/kPlIuBjdss1ZD9QHJKilDvthctbRaZCk7iISH078JXeiGDdmhlkaA4NYXh
	3wQKxwlCu5Ax10Fe09EUJjOYnbukz5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwzhKi978OX+6eV1dpseMviZCH0GFDu4NdtSmY/6DCA=;
	b=4N7mxjRowtGmZ9GCC/w51iJj/Dbpe+e9RAjN8wMBtXGA8eLxV2MaqEkyggrldvb9TGCPEr
	CptCcC4k7msOeyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4927413A7F;
	Fri, 31 Jan 2025 14:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EICgEKTXnGfbcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 31 Jan 2025 14:01:08 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	michael.hennerich@analog.com,
	support.opensource@diasemi.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/16] backlight: adp5520_bl: Do not include <linux/fb.h>
Date: Fri, 31 Jan 2025 14:58:33 +0100
Message-ID: <20250131140103.278158-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131140103.278158-1-tzimmermann@suse.de>
References: <20250131140103.278158-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 93E9A1F38F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

This driver does not require <linux/fb.h>. Remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/adp5520_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
index aa5c15e8db86e..81c40d355aae4 100644
--- a/drivers/video/backlight/adp5520_bl.c
+++ b/drivers/video/backlight/adp5520_bl.c
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/mfd/adp5520.h>
 #include <linux/slab.h>
-- 
2.48.1

