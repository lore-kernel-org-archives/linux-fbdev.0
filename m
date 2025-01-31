Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97661C3C05
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332074; cv=none; b=fi0J/EquFw75lGfxJQKSHgrt1GXWKViTi31lsuwYoyTfF4JykH+ZtOV28UFhEq9h1BCpE+/AtKEtniuyvSWouzYPRZsPPlsOCWt2o0IxL4HKlX0+gqgRAH7JXGatiVkm8S2BAeM2i4VTsuiI1YQZHu7Xay6oY3m44TZ/QWvc0L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332074; c=relaxed/simple;
	bh=sebUnyGXQwxURnqCGhCMLQ5KvdPoer0Gc3mxbSkbmHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvHB6T9RspIvBU5Wtu/b3eTD0uLLl6ieiysd+X/zSTjmjHwwVmLWOQ751CtWPI7sPvksGTiNLNDvPnIzdA6tQXGi1T+ZxT2BlkaoqLnuNKOk75j2Gd9ZgoFfPeWpJTk2SgjgsDAxaYTqv1hzxr8Xy5npctAjVWg5Lla3c8vMoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PA7Vc4XJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=woAuwMSz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PA7Vc4XJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="woAuwMSz"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 474601F38E;
	Fri, 31 Jan 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738332068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtNbOnTYpkqJ5Ufgw9BKzMAZrj2cDa4ZTQkXZhZK6tw=;
	b=PA7Vc4XJ+0wpzWZtbGDO9TFZqou2ZaxaImuwgU6zkfRRWMCA4Y8NxLGRb5Wh1FG2wWi2Rr
	QXXe/hRVo0QR9ElAeYTFkkxBa3UzKUB8ceIr8+r70t+gYWeobqUvTEp09OCkKwD2pKBEXk
	2eMd4nuU9OOFX11zQ08+/lM+GEkbvjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738332068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtNbOnTYpkqJ5Ufgw9BKzMAZrj2cDa4ZTQkXZhZK6tw=;
	b=woAuwMSzSv6noAp++A3yQF6xpJjFpRVtg2bMr+tL++8G1yIMnsNjc/p45AMIutJoVJ1WnW
	FM2odVJ6XreUt4Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF1F8139B1;
	Fri, 31 Jan 2025 14:01:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MEjqOKPXnGfbcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 31 Jan 2025 14:01:07 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	michael.hennerich@analog.com,
	support.opensource@diasemi.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 01/16] backlight: 88pm860x_bl: Do not include <linux/fb.h>
Date: Fri, 31 Jan 2025 14:58:32 +0100
Message-ID: <20250131140103.278158-2-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 474601F38E
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

This driver does not require <linux/fb.h>. Remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/backlight/88pm860x_bl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
index 720b5ada7fe85..0a1db28240763 100644
--- a/drivers/video/backlight/88pm860x_bl.c
+++ b/drivers/video/backlight/88pm860x_bl.c
@@ -11,7 +11,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/fb.h>
 #include <linux/i2c.h>
 #include <linux/backlight.h>
 #include <linux/mfd/88pm860x.h>
-- 
2.48.1

