Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C33FC03
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Nov 2023 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lq+rlQy9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YXJK0+sO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874D18A
	for <linux-fbdev@vger.kernel.org>; Wed, 15 Nov 2023 02:30:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDD0522918;
	Wed, 15 Nov 2023 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700044200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NB2YWYmaip/EtelfbOHaFwB1e4ocGe1fcwuNSNti1Vo=;
	b=Lq+rlQy94ntH7BwmUhLf8pNvjchxBFlp3HTx3n/JSNwtC7/A+fq8/58Xsn6Fh61IGWZaJK
	Qxe5XOA7EzkU9bLTRXf7JNLCjfPCQZnR6Mt3l44L8l+DlvEKf75HYTxTOzH/xi436MO+MK
	VtH+tD8TtnPrEYf7gtGRsUoZIs8pUTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700044200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NB2YWYmaip/EtelfbOHaFwB1e4ocGe1fcwuNSNti1Vo=;
	b=YXJK0+sOMnE/YwTNuYGhcZsJmMbOGrjzc3fVrMjrRVcJ4C1HNlgktOhYZee48JnVmwpgd/
	QNqSi2thszrKtfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EBD5139B7;
	Wed, 15 Nov 2023 10:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YD8MIqidVGV+UAAAMHmgww
	(envelope-from <tzimmermann@suse.de>); Wed, 15 Nov 2023 10:30:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	javierm@redhat.com
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: [PATCH 25/32] staging/sm750fb: Declare fb_ops as constant
Date: Wed, 15 Nov 2023 11:19:30 +0100
Message-ID: <20231115102954.7102-26-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115102954.7102-1-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.60
X-Spamd-Result: default: False [-1.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,suse.de,gmail.com,siliconmotion.com,linuxfoundation.org,lists.linux.dev];
	 RCVD_COUNT_TWO(0.00)[2];
	 SUSPICIOUS_RECIPS(1.50)[]

Split up lynxfb_ops and declare each as constant. The fb_ops
instance used to be modified while initializing the driver. It is
now constant and the driver picks the correct instance, depending
on the settings for acceleration and cursor support.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
---
 drivers/staging/sm750fb/sm750.c | 59 +++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 79bcd5bd49380..35098516f53c9 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -663,16 +663,53 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	return ret;
 }
 
-static struct fb_ops lynxfb_ops = {
+static const struct fb_ops lynxfb_ops = {
 	.owner = THIS_MODULE,
 	.fb_check_var =  lynxfb_ops_check_var,
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
 	.fb_blank = lynxfb_ops_blank,
+	.fb_pan_display = lynxfb_ops_pan_display,
 	.fb_fillrect = cfb_fillrect,
 	.fb_imageblit = cfb_imageblit,
 	.fb_copyarea = cfb_copyarea,
-	/* cursor */
+};
+
+static const struct fb_ops lynxfb_ops_with_cursor = {
+	.owner = THIS_MODULE,
+	.fb_check_var =  lynxfb_ops_check_var,
+	.fb_set_par = lynxfb_ops_set_par,
+	.fb_setcolreg = lynxfb_ops_setcolreg,
+	.fb_blank = lynxfb_ops_blank,
+	.fb_pan_display = lynxfb_ops_pan_display,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_cursor = lynxfb_ops_cursor,
+};
+
+static const struct fb_ops lynxfb_ops_accel = {
+	.owner = THIS_MODULE,
+	.fb_check_var =  lynxfb_ops_check_var,
+	.fb_set_par = lynxfb_ops_set_par,
+	.fb_setcolreg = lynxfb_ops_setcolreg,
+	.fb_blank = lynxfb_ops_blank,
+	.fb_pan_display = lynxfb_ops_pan_display,
+	.fb_fillrect = lynxfb_ops_fillrect,
+	.fb_copyarea = lynxfb_ops_copyarea,
+	.fb_imageblit = lynxfb_ops_imageblit,
+};
+
+static const struct fb_ops lynxfb_ops_accel_with_cursor = {
+	.owner = THIS_MODULE,
+	.fb_check_var =  lynxfb_ops_check_var,
+	.fb_set_par = lynxfb_ops_set_par,
+	.fb_setcolreg = lynxfb_ops_setcolreg,
+	.fb_blank = lynxfb_ops_blank,
+	.fb_pan_display = lynxfb_ops_pan_display,
+	.fb_fillrect = lynxfb_ops_fillrect,
+	.fb_copyarea = lynxfb_ops_copyarea,
+	.fb_imageblit = lynxfb_ops_imageblit,
 	.fb_cursor = lynxfb_ops_cursor,
 };
 
@@ -714,7 +751,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	par->index = index;
 	output->channel = &crtc->channel;
 	sm750fb_set_drv(par);
-	lynxfb_ops.fb_pan_display = lynxfb_ops_pan_display;
 
 	/*
 	 * set current cursor variable and proc pointer,
@@ -731,19 +767,22 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	crtc->cursor.vstart = sm750_dev->pvMem + crtc->cursor.offset;
 
 	memset_io(crtc->cursor.vstart, 0, crtc->cursor.size);
-	if (!g_hwcursor) {
-		lynxfb_ops.fb_cursor = NULL;
+	if (!g_hwcursor)
 		sm750_hw_cursor_disable(&crtc->cursor);
-	}
 
 	/* set info->fbops, must be set before fb_find_mode */
 	if (!sm750_dev->accel_off) {
 		/* use 2d acceleration */
-		lynxfb_ops.fb_fillrect = lynxfb_ops_fillrect;
-		lynxfb_ops.fb_copyarea = lynxfb_ops_copyarea;
-		lynxfb_ops.fb_imageblit = lynxfb_ops_imageblit;
+		if (!g_hwcursor)
+			info->fbops = &lynxfb_ops_accel;
+		else
+			info->fbops = &lynxfb_ops_accel_with_cursor;
+	} else {
+		if (!g_hwcursor)
+			info->fbops = &lynxfb_ops;
+		else
+			info->fbops = &lynxfb_ops_with_cursor;
 	}
-	info->fbops = &lynxfb_ops;
 
 	if (!g_fbmode[index]) {
 		g_fbmode[index] = g_def_fbmode;
-- 
2.42.0

