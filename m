Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0320182CA
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Feb 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733040; cv=none; b=IOYeBat7e3CMx2IC4fGqm5e2mPHjbOLouDdz5vJYhPyh4kPz5izWoUb7Zvo348NRww0aAqADdPIguauVovq67d8XjvVRv8GzL17STKfSXHvpStfYE1Q0O06tj+ENxKdorRypJfX+9BcC+5KyW3gvQx+oR0kmjDA5pLDWtmnFCj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733040; c=relaxed/simple;
	bh=RkOj2nkSGigboeHf+lElbKflfD17DqpO0UBdmoihvrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmxU8oIzDpOc2WsW9BlMpbJaTo5x0VxX+k9ecy7qpUTj7RMY4OhcEeVPKOQhqYTi93oJB9bhi/r2WtQkFH8h5AqG2pSZT7Qbae2VJURs4YuaawQzGlmXcfqTIPlyp1TVL85FwfbiIp8FLA+tkL905rWQNJt119aJdj9l4rNqWcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NHlvh3pR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQZzA0MN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NHlvh3pR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQZzA0MN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NHlvh3pR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hQZzA0MN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NHlvh3pR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hQZzA0MN"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 061E321F45;
	Mon, 12 Feb 2024 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcc5bMYLvskXLSh2o8JaY59ivQvhYWD4zfcx3NqjS+w=;
	b=NHlvh3pRmsU3w5dByCE27UYpCcglLaDV2x+uz9FJGhg9TiOtAlO8cJydHOZLkjxSnq4b1H
	qF/TArzT6xOLPrin4Hyf04PPQQa2kVfTxUgRYNNrUJTTPz8TqcjcLCDeOEmm9HVUprTdl0
	+fGqzIu9CEfP4mGv1tEDJElLnM2suoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcc5bMYLvskXLSh2o8JaY59ivQvhYWD4zfcx3NqjS+w=;
	b=hQZzA0MNROwNDgqnBrGfljHGiqL7aLdpyzFwtBh4JFhdl141lG/xYMmncbOhqyZ+hcBjH9
	s0UzzkbxGSGTPMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707733037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcc5bMYLvskXLSh2o8JaY59ivQvhYWD4zfcx3NqjS+w=;
	b=NHlvh3pRmsU3w5dByCE27UYpCcglLaDV2x+uz9FJGhg9TiOtAlO8cJydHOZLkjxSnq4b1H
	qF/TArzT6xOLPrin4Hyf04PPQQa2kVfTxUgRYNNrUJTTPz8TqcjcLCDeOEmm9HVUprTdl0
	+fGqzIu9CEfP4mGv1tEDJElLnM2suoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707733037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcc5bMYLvskXLSh2o8JaY59ivQvhYWD4zfcx3NqjS+w=;
	b=hQZzA0MNROwNDgqnBrGfljHGiqL7aLdpyzFwtBh4JFhdl141lG/xYMmncbOhqyZ+hcBjH9
	s0UzzkbxGSGTPMCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id ABE0813A0E;
	Mon, 12 Feb 2024 10:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6DC+KCzwyWVdBgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 12 Feb 2024 10:17:16 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/7] fbdev: Do not include <linux/backlight.h> in header
Date: Mon, 12 Feb 2024 11:13:14 +0100
Message-ID: <20240212101712.23675-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212101712.23675-1-tzimmermann@suse.de>
References: <20240212101712.23675-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,ffwll.ch,gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.73%]
X-Spam-Flag: NO

Forward declare struct backlight_device and remove the include
statement.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/fb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 2ce2f5c2fca9a..7380d959c5d53 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -13,11 +13,11 @@
 #include <linux/workqueue.h>
 #include <linux/notifier.h>
 #include <linux/list.h>
-#include <linux/backlight.h>
 #include <linux/slab.h>
 
 #include <asm/fb.h>
 
+struct backlight_device;
 struct vm_area_struct;
 struct fb_info;
 struct device;
-- 
2.43.0

