Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C481C8FD4
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332078; cv=none; b=ovoNTqNY3YS7Smz0c2PLjNBg6cJFkArBGHfU3PGnUS8y+1a+P6nAAtVvUxXcZgk9tnjQ1tJeA6FhsiS2lezikOFOGEVu5gM92SNbymt1XdYFXwF/qHJE+PK9KhqlXcopfh1DKB/vsNxH3AiMEC+eVueGYDOzZOirx5N5iADQ8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332078; c=relaxed/simple;
	bh=zx1ZxjXzV190IT6fYTVN8BS5JbD+j5Cnu6Uy7wZ0RxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Khci+FdU84w2AFylkip1gacNgP5IpRoa6Q5DJoJIitDCP9/LJTGOedMph750V7ilabZb82DP42owp52/1y/2R9hgh8We+xYu6Q3taNW/7Zv2AuEB0cTHZCoWuRQFYH7IX0ugiPPmA78XUi8denjzxniTFEFNhlQlryBWZ93Gq/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E11291F443;
	Fri, 31 Jan 2025 14:01:12 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CC94139B1;
	Fri, 31 Jan 2025 14:01:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFn1JKjXnGfbcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 31 Jan 2025 14:01:12 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	michael.hennerich@analog.com,
	support.opensource@diasemi.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 16/16] backlight: wm831x_bl: Do not include <linux/fb.h>
Date: Fri, 31 Jan 2025 14:58:47 +0100
Message-ID: <20250131140103.278158-17-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E11291F443
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

This driver does not require <linux/fb.h>. Remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/wm831x_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/wm831x_bl.c b/drivers/video/backlight/wm831x_bl.c
index c5aaee205bdfb..49027f04a1ecb 100644
--- a/drivers/video/backlight/wm831x_bl.c
+++ b/drivers/video/backlight/wm831x_bl.c
@@ -9,7 +9,6 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 #include <linux/slab.h>
 
-- 
2.48.1

