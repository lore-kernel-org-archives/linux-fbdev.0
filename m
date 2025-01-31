Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802C31CAA79
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jan 2025 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738332077; cv=none; b=Vjd1feLUxtAI0p4sLkF8yajwlS1Eb4MD0f8Xvcc2nV2VoA2iaVkUApw1w6b67RsjP9HENiWJuLKf6Ms7cObAVi0AcvpMTqEa9MT+V//B2vTnXMGfvaJVo1faXqATpajW8UZjJ9egi6uF42xa91kpg0+102DNBzLt1N8am6RS6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738332077; c=relaxed/simple;
	bh=2H2aRYfwbc+ZZK0FnO1N49qSol/pH5ZUprt0zFl9ryU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mN42ucHnBKwk4q1VjFke6sz0LddwM5UfjqSGcZV6mXi95d6Ln6NuWKiFs+mphfqkSfIKPwXjpJbrvXYKjOZFm94LOyKq9uTUcQvV+6x3NLDqjMaKb/LqndgPlh3wlz7x71ZqOHq3aO3I8n1UC9AqKMTF2mGsDulsTAWh7+cTPuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 623631F397;
	Fri, 31 Jan 2025 14:01:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13372133A6;
	Fri, 31 Jan 2025 14:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aGBmA6fXnGfbcQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 31 Jan 2025 14:01:11 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lee@kernel.org,
	danielt@kernel.org,
	jingoohan1@gmail.com,
	michael.hennerich@analog.com,
	support.opensource@diasemi.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 11/16] backlight: locomolcd: Do not include <linux/fb.h>
Date: Fri, 31 Jan 2025 14:58:42 +0100
Message-ID: <20250131140103.278158-12-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 623631F397
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
 drivers/video/backlight/locomolcd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index 346d3e29a8435..1b493fb0516db 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -16,7 +16,6 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
-#include <linux/fb.h>
 #include <linux/backlight.h>
 
 #include <asm/hardware/locomo.h>
-- 
2.48.1

