Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117439B49C
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Apr 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553992; cv=none; b=ZHLMbKK07BSd8QqxooH/o+GXxN7+GLzyG1zcGzHINeLIKKp/qmp+a7nq03YWZDzWaJA32Oaetx7yI4iB2eAr2zjKA9oBhbvcTO2g+ZqZUDn57+OdIqYOouhQi28yhSQCgdhL7eQ/DsqTx/MbJRfk6l6W8tWGUszPFg4wTdLDAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553992; c=relaxed/simple;
	bh=Qioa5y+ETd9nP6o0/bt9KzMuqtj3j4mO/QsaeV4d6ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcJj5o+D9OXMqPnxfSq76Sze/yHSez/ynajCy1iB/PRvjVmXJFJ/ob0dJ8+2vAw7DDH/LLj5shxmPh39oks8+LVjTsJH1wHOcRqsj9LIKz+hzRhM6PfPPSQkue2NYPfQZtKmnXYxFpCmljyvfOi7GdFQ8W4IByT16NALm6wWVsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7A124E3A6;
	Tue,  7 Apr 2026 09:26:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FA5B4A0B1;
	Tue,  7 Apr 2026 09:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SOb0HanN1GmDVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 07 Apr 2026 09:26:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	geert@linux-m68k.org,
	simona@ffwll.ch,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 04/10] lib/fonts: Clean up Makefile
Date: Tue,  7 Apr 2026 11:23:15 +0200
Message-ID: <20260407092555.58816-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407092555.58816-1-tzimmermann@suse.de>
References: <20260407092555.58816-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: C7A124E3A6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Simplify the Makefile. Drop font-obj-y and sort the fonts by dictionary
order. Done in preparation for supporting optional font rotation.

v2:
- sort Makefile font entries by Family/Size in ascending order (Geert, Jiri)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/Makefile | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
index 30a85a4292fa..b176af53d53e 100644
--- a/lib/fonts/Makefile
+++ b/lib/fonts/Makefile
@@ -1,23 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
 # Font handling
 
-font-objs := fonts.o
+font-y := fonts.o
 
-font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
-font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
-font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
-font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
-font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
-font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
-font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
-font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
-font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
-font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
-font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
-font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
-font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
-font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
+# Built-in fonts; sorted by Family-Size in ascending order
+font-$(CONFIG_FONT_6x8)       += font_6x8.o
+font-$(CONFIG_FONT_6x10)      += font_6x10.o
+font-$(CONFIG_FONT_6x11)      += font_6x11.o
+font-$(CONFIG_FONT_7x14)      += font_7x14.o
+font-$(CONFIG_FONT_8x8)       += font_8x8.o
+font-$(CONFIG_FONT_8x16)      += font_8x16.o
+font-$(CONFIG_FONT_10x18)     += font_10x18.o
+font-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
+font-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
+font-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
+font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
+font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
+font-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
+font-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
 
-font-objs += $(font-objs-y)
-
-obj-$(CONFIG_FONT_SUPPORT)         += font.o
+obj-$(CONFIG_FONT_SUPPORT) += font.o
-- 
2.53.0

