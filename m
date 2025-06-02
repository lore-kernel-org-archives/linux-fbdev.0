Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F119CC36
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Jun 2025 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851149; cv=none; b=Kq6SQ/GcG/nnOH/7omf3rDwsa8UznaYtXGl0H60Fl5zLI5AnL2RCJHuhQvser0+ZAjdp4ociyudMnaWGmwf9H/56fYcXC/yBzZbGQQjqoxRXkFOpnGs3Dc0MYEWPiiUeaokyxkgrWPpMsx+cP8t9DO3U/A3PbcPrPVY63W19R1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851149; c=relaxed/simple;
	bh=aVbz3da5wSEgl0thMoHsbU6Q99ASpwOuEngYAZg8BGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyaSyAdYpXJlxp+LdgUhQu6GC/IXuYm8142pI5Am5CQHZeva01b28ZIED7RW5pXg4tzCMq6QSsVpHMm7RTt9tM/QrG23iehGgzIh8Tht82FuQpjJu7LzDFD3PaPDK1a+6z0UJDfT7zf/ye+OSg6QuyOLbZjHXrr1yVArSnPhoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vsqb1XU9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sos2EEun; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vsqb1XU9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Sos2EEun; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vsqb1XU9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sos2EEun";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vsqb1XU9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Sos2EEun"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B7E621257;
	Mon,  2 Jun 2025 07:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748851146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eYgOuhLOmrS8XPFfIn1moRKm4FdkzK24f56NqUjcbDc=;
	b=vsqb1XU94sXY43AdLx5xRWRkAgag5KKKU5tjOqWUhgqNg0tGYJ6gLIIcfActHJGayQ7pEP
	EIWTZFC2/qBRqB49QLUrYJEBQxzw11+/IQvMSILw4lVsBDakkGSJJ10irSd49qFeQmaYHw
	ytTqBvqn4Zu2lkRsiLJr6kxcsG57+s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748851146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eYgOuhLOmrS8XPFfIn1moRKm4FdkzK24f56NqUjcbDc=;
	b=Sos2EEunwMsqjjQMSNJJohi5MmJaNdYQcsCTwQpuunL+vc4FiBiKELau0dVfqUXnQS0pq4
	urG4lFq+7nOzWtDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748851146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eYgOuhLOmrS8XPFfIn1moRKm4FdkzK24f56NqUjcbDc=;
	b=vsqb1XU94sXY43AdLx5xRWRkAgag5KKKU5tjOqWUhgqNg0tGYJ6gLIIcfActHJGayQ7pEP
	EIWTZFC2/qBRqB49QLUrYJEBQxzw11+/IQvMSILw4lVsBDakkGSJJ10irSd49qFeQmaYHw
	ytTqBvqn4Zu2lkRsiLJr6kxcsG57+s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748851146;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eYgOuhLOmrS8XPFfIn1moRKm4FdkzK24f56NqUjcbDc=;
	b=Sos2EEunwMsqjjQMSNJJohi5MmJaNdYQcsCTwQpuunL+vc4FiBiKELau0dVfqUXnQS0pq4
	urG4lFq+7nOzWtDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DA99136C7;
	Mon,  2 Jun 2025 07:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id olvrBcpZPWhuYQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Jun 2025 07:59:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	javierm@redhat.com,
	deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] video: Make edid_info generally available in x86
Date: Mon,  2 Jun 2025 09:51:42 +0200
Message-ID: <20250602075537.137759-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
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
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[arndb.de,redhat.com,gmx.de];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The global variable edid_info provides the system framebuffer's EDID
information, if any. Make it available on x86 without dependencies on
fbdev. DRM drivers for system framebuffers export the information to
userspace.

Besides cleaning up, this series prepares support for firmware EDID on
EFI-based systems.

Thomas Zimmermann (2):
  video: Make CONFIG_FIRMWARE_EDID generally available
  video: Make global edid_info depend on CONFIG_FIRMWARE_EDID

 arch/x86/kernel/setup.c          |  4 ++++
 drivers/gpu/drm/sysfb/efidrm.c   |  2 +-
 drivers/gpu/drm/sysfb/vesadrm.c  |  2 +-
 drivers/video/Kconfig            | 18 +++++++++++++++++-
 drivers/video/fbdev/core/Kconfig | 15 ---------------
 drivers/video/fbdev/core/fbmon.c |  3 +--
 include/video/edid.h             |  3 ++-
 7 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.49.0

