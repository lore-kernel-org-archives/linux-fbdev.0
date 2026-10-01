Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B74FECE1;
	Thu,  1 Oct 2026 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790861876; cv=none; b=KAK8BgWHQkgHmt9CkY2cz+PpyyVsFU+aDLeOjDU5B7nfinKtPJKfHlYBM1fTdkWzDsb0ZvI3jCu8sQuSB5oTCLNWs6JaPnqZvLeaqAhEK+Dra+TYyHp5Ic4hGAVMy0r6nJGEKksJprMsxEfSiRpK5zEgwZfqRoQMxnvkIpaJA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790861876; c=relaxed/simple;
	bh=mdifJNIKmJ4zz9n8tPE0KexD4szXV/9tNl0OEFSsJOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeD1tNQtJZ0Bis5o6IAJcqXS/rFvMwSp6QLoRWj3+Q+yKzEmPIEYif815b+RFmS/3GlI+k/0lg8Rer1qIajwO+HNx+zEaY9+sQ+FjRRRMk9hg/YF8w3M4JVB+wfojsnoiw1+d5sUdGRpiuhy5h0graJ4QSLewDNq7WEOwpTAGxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QWxlbl74; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ap8fwlFG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CCeMtSll; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bmsg7QoY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QWxlbl74";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ap8fwlFG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CCeMtSll";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bmsg7QoY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77E9321A57;
	Thu,  1 Oct 2026 13:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IU1IGmz/Zs2YU5nNzdx+yfrU4S/GWs8tkSN0HFIgvQA=;
	b=QWxlbl74nZob55th1gnSBrQbb8CplZI3g5L9m4hR+ul77/GKK/at4fKca5XIUF6VBF6cY3
	ZvIosav1FS0FQ9iPiqQJD6r4jsL0WaveVm3+WW5kMHkEfIqAHXiSXl5uZBZtQ1725RGLLw
	7i9PuJbyCG7e+9GFIGCi/xClL8s9SSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IU1IGmz/Zs2YU5nNzdx+yfrU4S/GWs8tkSN0HFIgvQA=;
	b=Ap8fwlFGto4xSx0T60nOsxplZP/eSdEd0aOqsqroKxCE56r08efafICDd3W3VUSO/ILRcH
	MEjUFsViyHk6JZAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790861861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IU1IGmz/Zs2YU5nNzdx+yfrU4S/GWs8tkSN0HFIgvQA=;
	b=CCeMtSllTJMEbtnRGU2QklQ+QQhsF8KPR+WirgUABqpijGmk8fuPwwN4WhyK0D7HACjcVW
	1qyboegFeWkSsSfgL4C3dflgNAQlgx16Y6YE5Yd+Zj1uOfUUev07Dmov4VSxur11xfUnFg
	LIW10hNi5xSuaBLhTMmgOr5TrOF9wRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790861861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IU1IGmz/Zs2YU5nNzdx+yfrU4S/GWs8tkSN0HFIgvQA=;
	b=bmsg7QoYSihzmHoyL4bDCC2tON2waM7EwYJnOLk8iE1YFV6UcDMi6IbZqzIEG09Mshonvf
	PMzH9cdIxqSfYBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF302134B3;
	Thu,  1 Oct 2026 13:37:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ih09KyRivmrGOQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 01 Oct 2026 13:37:40 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	decui@microsoft.com,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] drm: Remove simple-display pipe
Date: Thu,  1 Oct 2026 15:35:36 +0200
Message-ID: <20261001133736.802604-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

There are no drivers using struct drm_simple_display_pipe left. Remove
the related helpers from DRM and clear any TODO items. Hyperv-drm needs
a minor fix to include some additonal headers.

Thomas Zimmermann (2):
  drm/hyperv: Add missing include statements
  drm/kms-helper: Remove struct drm_simple_display_pipe and helpers

 Documentation/gpu/todo.rst              |  17 --
 drivers/gpu/drm/drm_gem_atomic_helper.c |  92 -------
 drivers/gpu/drm/drm_simple_kms_helper.c | 328 ------------------------
 drivers/gpu/drm/hyperv/hyperv_drm.h     |   5 +
 drivers/staging/fbtft/TODO              |   6 +-
 include/drm/drm_gem_atomic_helper.h     |  28 --
 include/drm/drm_simple_kms_helper.h     |  56 +---
 7 files changed, 10 insertions(+), 522 deletions(-)


base-commit: 9ecc25f4cc83ac280099d6c39e044d911774018d
-- 
2.55.0

