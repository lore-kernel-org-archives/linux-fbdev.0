Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1D393DCA
	for <linux-fbdev@vger.kernel.org>; Mon, 29 Jun 2026 06:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713260; cv=none; b=C9fPF9wdKS4oE4L3kIfBW+83qXz5hom4f/7u680pXVugndaEh/QfHuu1g9upzotxyx10z0Q6RNwcW+h+HuAlSohWIAhaEkfZ12jMoPMYh60Z/gZPo1CSn3/Wrhr0hVtwYlTTxOSEA1vtMnWqM1ualAw0J+Fp0Atj19mLklnfYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713260; c=relaxed/simple;
	bh=qyhxZTPlkmyRRs4zjuV71BMSt6BbiQgEFPHOh+oAPbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqglelKcRW7X1xzYEGCIMvVjG7j1ExeppFxI07I2qLuA/11OTlvM+mp+3pAc3c3ZAJZCp7rW8hPsLHBtQtbAml5+ifVwhxiR2Q/x2HUbq6h/BcA911SRtz1RGhJqHVZM4XYZAJjUyRgTnZ5xRGm5lN9uFZjmRjeAAtsY1R5cOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FTeGT+zv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FTeGT+zv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FTeGT+zv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FTeGT+zv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13ACE7599A;
	Mon, 29 Jun 2026 06:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oN77kguiT/5cFV778mh4/n6Vz6wKLrPbFPNiIfWFD4s=;
	b=FTeGT+zvzBOLobk42UlPaRFyk+TvnJ+3Nm98OFGMDn5UlewIQZ+OjiCSAw0qta0lqIme2X
	fmhXd8TbtSsaVEq/0kqhEU9QIDir7slO3AYURm42Iz3iNC7nP4biZ02P5efFJ065EWiGMw
	OXYizz0n2oP9W6JZPeSJToP66mgUxZo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oN77kguiT/5cFV778mh4/n6Vz6wKLrPbFPNiIfWFD4s=;
	b=FTeGT+zvzBOLobk42UlPaRFyk+TvnJ+3Nm98OFGMDn5UlewIQZ+OjiCSAw0qta0lqIme2X
	fmhXd8TbtSsaVEq/0kqhEU9QIDir7slO3AYURm42Iz3iNC7nP4biZ02P5efFJ065EWiGMw
	OXYizz0n2oP9W6JZPeSJToP66mgUxZo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0F31779A8;
	Mon, 29 Jun 2026 06:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qj6MMagLQmpUEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:07:36 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Juergen Gross <jgross@suse.com>,
	Helge Deller <deller@gmx.de>,
	linux-geode@lists.infradead.org
Subject: [PATCH 22/32] fbdev/geode: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:05:13 +0200
Message-ID: <20260629060526.3638272-23-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmx.de,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Level: 
X-Spam-Score: -6.80

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
removed. Use the related 64-bit variants instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/video/fbdev/geode/display_gx.c |  8 +++---
 drivers/video/fbdev/geode/lxfb_ops.c   | 38 +++++++++++++-------------
 drivers/video/fbdev/geode/suspend_gx.c | 20 ++++++++------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/geode/display_gx.c b/drivers/video/fbdev/geode/display_gx.c
index 099322cefce0..b93aa21a1d2b 100644
--- a/drivers/video/fbdev/geode/display_gx.c
+++ b/drivers/video/fbdev/geode/display_gx.c
@@ -23,15 +23,15 @@ unsigned int gx_frame_buffer_size(void)
 	unsigned int val;
 
 	if (!cs5535_has_vsa2()) {
-		uint32_t hi, lo;
+		struct msr msr;
 
 		/* The number of pages is (PMAX - PMIN)+1 */
-		rdmsr(MSR_GLIU_P2D_RO0, lo, hi);
+		rdmsrq(MSR_GLIU_P2D_RO0, msr.q);
 
 		/* PMAX */
-		val = ((hi & 0xff) << 12) | ((lo & 0xfff00000) >> 20);
+		val = ((msr.h & 0xff) << 12) | ((msr.l & 0xfff00000) >> 20);
 		/* PMIN */
-		val -= (lo & 0x000fffff);
+		val -= (msr.l & 0x000fffff);
 		val += 1;
 
 		/* The page size is 4k */
diff --git a/drivers/video/fbdev/geode/lxfb_ops.c b/drivers/video/fbdev/geode/lxfb_ops.c
index 2e33da9849b0..f5f1134cae9a 100644
--- a/drivers/video/fbdev/geode/lxfb_ops.c
+++ b/drivers/video/fbdev/geode/lxfb_ops.c
@@ -124,19 +124,19 @@ static const struct {
 
 static void lx_set_dotpll(u32 pllval)
 {
-	u32 dotpll_lo, dotpll_hi;
+	struct msr dotpll;
 	int i;
 
-	rdmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	rdmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 
-	if ((dotpll_lo & MSR_GLCP_DOTPLL_LOCK) && (dotpll_hi == pllval))
+	if ((dotpll.l & MSR_GLCP_DOTPLL_LOCK) && (dotpll.h == pllval))
 		return;
 
-	dotpll_hi = pllval;
-	dotpll_lo &= ~(MSR_GLCP_DOTPLL_BYPASS | MSR_GLCP_DOTPLL_HALFPIX);
-	dotpll_lo |= MSR_GLCP_DOTPLL_DOTRESET;
+	dotpll.h = pllval;
+	dotpll.l &= ~(MSR_GLCP_DOTPLL_BYPASS | MSR_GLCP_DOTPLL_HALFPIX);
+	dotpll.l |= MSR_GLCP_DOTPLL_DOTRESET;
 
-	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 
 	/* Wait 100us for the PLL to lock */
 
@@ -145,15 +145,15 @@ static void lx_set_dotpll(u32 pllval)
 	/* Now, loop for the lock bit */
 
 	for (i = 0; i < 1000; i++) {
-		rdmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
-		if (dotpll_lo & MSR_GLCP_DOTPLL_LOCK)
+		rdmsrq(MSR_GLCP_DOTPLL, dotpll.q);
+		if (dotpll.l & MSR_GLCP_DOTPLL_LOCK)
 			break;
 	}
 
 	/* Clear the reset bit */
 
-	dotpll_lo &= ~MSR_GLCP_DOTPLL_DOTRESET;
-	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	dotpll.l &= ~MSR_GLCP_DOTPLL_DOTRESET;
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 }
 
 /* Set the clock based on the frequency specified by the current mode */
@@ -268,7 +268,7 @@ static void lx_graphics_enable(struct fb_info *info)
 		config |= VP_DCFG_CRT_VSYNC_POL;
 
 	if (par->output & OUTPUT_PANEL) {
-		u32 msrlo, msrhi;
+		struct msr val;
 
 		write_fp(par, FP_PT1, 0);
 		temp = FP_PT2_SCRC;
@@ -282,10 +282,10 @@ static void lx_graphics_enable(struct fb_info *info)
 		write_fp(par, FP_PT2, temp);
 		write_fp(par, FP_DFC, FP_DFC_BC);
 
-		msrlo = MSR_LX_MSR_PADSEL_TFT_SEL_LOW;
-		msrhi = MSR_LX_MSR_PADSEL_TFT_SEL_HIGH;
+		val.l = MSR_LX_MSR_PADSEL_TFT_SEL_LOW;
+		val.h = MSR_LX_MSR_PADSEL_TFT_SEL_HIGH;
 
-		wrmsr(MSR_LX_MSR_PADSEL, msrlo, msrhi);
+		wrmsrq(MSR_LX_MSR_PADSEL, val.q);
 	}
 
 	if (par->output & OUTPUT_CRT) {
@@ -313,15 +313,15 @@ unsigned int lx_framebuffer_size(void)
 	unsigned int val;
 
 	if (!cs5535_has_vsa2()) {
-		uint32_t hi, lo;
+		struct msr msr;
 
 		/* The number of pages is (PMAX - PMIN)+1 */
-		rdmsr(MSR_GLIU_P2D_RO0, lo, hi);
+		rdmsrq(MSR_GLIU_P2D_RO0, msr.q);
 
 		/* PMAX */
-		val = ((hi & 0xff) << 12) | ((lo & 0xfff00000) >> 20);
+		val = ((msr.h & 0xff) << 12) | ((msr.l & 0xfff00000) >> 20);
 		/* PMIN */
-		val -= (lo & 0x000fffff);
+		val -= (msr.l & 0x000fffff);
 		val += 1;
 
 		/* The page size is 4k */
diff --git a/drivers/video/fbdev/geode/suspend_gx.c b/drivers/video/fbdev/geode/suspend_gx.c
index 73307f42e343..6c0a526ee8a2 100644
--- a/drivers/video/fbdev/geode/suspend_gx.c
+++ b/drivers/video/fbdev/geode/suspend_gx.c
@@ -40,25 +40,27 @@ static void gx_save_regs(struct gxfb_par *par)
 
 static void gx_set_dotpll(uint32_t dotpll_hi)
 {
-	uint32_t dotpll_lo;
+	struct msr dotpll;
 	int i;
 
-	rdmsrq(MSR_GLCP_DOTPLL, dotpll_lo);
-	dotpll_lo |= MSR_GLCP_DOTPLL_DOTRESET;
-	dotpll_lo &= ~MSR_GLCP_DOTPLL_BYPASS;
-	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	rdmsrq(MSR_GLCP_DOTPLL, dotpll.q);
+	dotpll.l |= MSR_GLCP_DOTPLL_DOTRESET;
+	dotpll.l &= ~MSR_GLCP_DOTPLL_BYPASS;
+	dotpll.h = dotpll_hi;
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 
 	/* wait for the PLL to lock */
 	for (i = 0; i < 200; i++) {
-		rdmsrq(MSR_GLCP_DOTPLL, dotpll_lo);
-		if (dotpll_lo & MSR_GLCP_DOTPLL_LOCK)
+		rdmsrq(MSR_GLCP_DOTPLL, dotpll.q);
+		if (dotpll.l & MSR_GLCP_DOTPLL_LOCK)
 			break;
 		udelay(1);
 	}
 
 	/* PLL set, unlock */
-	dotpll_lo &= ~MSR_GLCP_DOTPLL_DOTRESET;
-	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	dotpll.l &= ~MSR_GLCP_DOTPLL_DOTRESET;
+	dotpll.h = dotpll_hi;
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 }
 
 static void gx_restore_gfx_proc(struct gxfb_par *par)
-- 
2.54.0

