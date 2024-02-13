Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98BD20B02
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Feb 2024 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813850; cv=none; b=QuvUucWdztptplOEtlBKP18H6I7p2IUMffjw0y9SavnKbSwc33nfA2VxXUqJZf6Ni83eBFYU1Hm8S800RrkDV8OI8y9Lb9TP7RVBXX8LtEY/X4/Qiyp4oUCTnvjkcQm/k6D06+z/JZ0/bSO0jwABF6kbYAverSWQn1T0klru/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813850; c=relaxed/simple;
	bh=IqWeXk+2RV/3naHYSZb9KYF/9IpvCSmKn/S6dkNM5Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/6Moy7NRPHxq9YCSRwiBrEzUlmjFzoSwY4kyGPDFn/PJ7r8OD656FQ5kj97Ha5fIS9AeYt0YFazAOGLr5GFcLd23g4GKlMSt33LACtDW37mXz9UNuuHElcVkBkPEu2Z1iVWEQP9od20tkvisLDVrB5nSZSiTRgrB/7am1MuMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1D5B7220BF;
	Tue, 13 Feb 2024 08:44:07 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B49771329E;
	Tue, 13 Feb 2024 08:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0A7iKtYry2VOFwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Tue, 13 Feb 2024 08:44:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	kherbst@redhat.com,
	lyude@redhat.com,
	dakr@redhat.com,
	jani.nikula@linux.intel.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-staging@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/8] staging/fbtft: Include <linux/backlight.h>
Date: Tue, 13 Feb 2024 09:42:20 +0100
Message-ID: <20240213084403.20995-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213084403.20995-1-tzimmermann@suse.de>
References: <20240213084403.20995-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 1D5B7220BF
X-Spam-Flag: NO

Resolved the proxy include via <linux/fb.h>, which does not require the
backlight header.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/staging/fbtft/fb_ssd1351.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index b8d55aa8c5c75..72172e870007e 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#include <linux/backlight.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.43.0

