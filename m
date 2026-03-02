Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250AC3FD132
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460783; cv=none; b=nTdoP/rsSfBvZOkc7IGKtV3A8PCRpffR7c+mUBiSXU6Y0ecF7GoCskDttTP1ZTcmBPWIlH391eVW/SrJ5YXG+mImpU5UuBFucYC5Erfcsps72/6wU/7zjxLFXV/1ezqxAtFG7wokfoqBAh5vHIHjFHjx/kZcL92hC4oOs5vRSBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460783; c=relaxed/simple;
	bh=X7ZXt/Tvldpttx1rTGbhAfIensbsUVb6ys+73i6I5kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOprjavFRUMLYckvJb3FEMk7BMwHdKJ0VUptN5095mWOkXI8D+DIhVNrz3OfqxnvgyT/TzjFWDMlNQZpcYFbnBQMZY8mb/yo95mwnQdIshOWNSJqc8+2392rK6pYbjBpHtYiKGp6Y9kvCSHOtpPMhGmE/hUW3H+/iIP2S2IeaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TqKJdKsr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CAIj6N61; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TqKJdKsr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CAIj6N61; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TqKJdKsr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CAIj6N61";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TqKJdKsr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CAIj6N61"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A3673F7F6;
	Mon,  2 Mar 2026 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDdFaZ33ivCVSgFIvrCH2YTfOSd7wSVCMvjOyrWj3aI=;
	b=TqKJdKsryS2kvryXltCj3gTsn1zKaSMK+EYuhzjIBxqHxXJFRvkCN8TFeBIld9EFO9pZqM
	j2tjLSfNNfk0dJRyKqGqSwJKUsFCOQJXwnl3iu/pKXLZf2RLLt8wsdivIR7vJUlztjTbVx
	SeJTiFtzfwa6OGHSjx8X2FwEciAWhj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDdFaZ33ivCVSgFIvrCH2YTfOSd7wSVCMvjOyrWj3aI=;
	b=CAIj6N61HBD01Q10TBuDiZAnFicZGP9g1Kt5V4a5CWYRACTvsW+EHkRI57W8Srkk4oTEM+
	/iOB8r/sbP6XE0DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772460780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDdFaZ33ivCVSgFIvrCH2YTfOSd7wSVCMvjOyrWj3aI=;
	b=TqKJdKsryS2kvryXltCj3gTsn1zKaSMK+EYuhzjIBxqHxXJFRvkCN8TFeBIld9EFO9pZqM
	j2tjLSfNNfk0dJRyKqGqSwJKUsFCOQJXwnl3iu/pKXLZf2RLLt8wsdivIR7vJUlztjTbVx
	SeJTiFtzfwa6OGHSjx8X2FwEciAWhj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772460780;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jDdFaZ33ivCVSgFIvrCH2YTfOSd7wSVCMvjOyrWj3aI=;
	b=CAIj6N61HBD01Q10TBuDiZAnFicZGP9g1Kt5V4a5CWYRACTvsW+EHkRI57W8Srkk4oTEM+
	/iOB8r/sbP6XE0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6974F3EA69;
	Mon,  2 Mar 2026 14:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOxNGOyapWleKQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 14:13:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: gregkh@linuxfoundation.org,
	deller@gmx.de,
	sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 02/13] vt: Remove trailing whitespaces
Date: Mon,  2 Mar 2026 15:08:36 +0100
Message-ID: <20260302141255.518657-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302141255.518657-1-tzimmermann@suse.de>
References: <20260302141255.518657-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linuxfoundation.org,gmx.de,ravnborg.org];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Flag: NO

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/console_struct.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 13b35637bd5a..ebdb9750d348 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -120,7 +120,7 @@ struct vc_data {
 	unsigned short	vc_complement_mask;	/* [#] Xor mask for mouse pointer */
 	unsigned short	vc_s_complement_mask;	/* Saved mouse pointer mask */
 	unsigned long	vc_pos;			/* Cursor address */
-	/* fonts */	
+	/* fonts */
 	unsigned short	vc_hi_font_mask;	/* [#] Attribute set for upper 256 chars of font or 0 if not supported */
 	struct console_font vc_font;		/* Current VC font set */
 	unsigned short	vc_video_erase_char;	/* Background erase character */
-- 
2.53.0

