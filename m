Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DF8193402;
	Wed, 20 Nov 2024 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095032; cv=none; b=akLwhJIOGTWNAVVIG54wneU3KCC4+DF+U/rmNPuyra2/Y/H0IkNwwD29zO0lnQJlKL0hw+m6p/YjZVxRPjG1q6nD6bMUNsPSZNiX6j/Wo7DishAHLzxYMp7jILfUNHB6L9AJkTSEnaAzvorquC/SJImHkXLKzmwwBTrPmV9EKgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095032; c=relaxed/simple;
	bh=IgFAYCTChLMva9n8UxWmRt+zJOsieoB1mOUSIwTl+tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwUbT46LSoCp9HBC2OIA1YgLKoKF1zCVdX1Udo5bdbeUWpNmxsgp0ENFBV4fmY0fjehZ2uxY268wOPYYdGpe6vegLwh1Hxha0VO+h193NG+XKjNecnzYZ6OaIJ99eyRwt9yr4E9um4nePuBXYJjUix1X/gL/vp34AgtdNYcSY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dW9vgHnW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vZ1hyOHD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dW9vgHnW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vZ1hyOHD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dW9vgHnW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vZ1hyOHD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dW9vgHnW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vZ1hyOHD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B2AF0219E3;
	Wed, 20 Nov 2024 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732095027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0MKArP0kQkMOue4b9KjMcgw0/LinHsOHLfq7ftlyArQ=;
	b=dW9vgHnWiRowoCjeAH+GenAfkuNaIINR2VTaCGwxzO4tBQZqLUt41LxaohP+Wnuv6g68eb
	QiJVd3DEVdXGoCBaltcd0YjevfpgKF0a9ZSr1JINocOjn1G4WWhHEtHkzg5kQFagYAhhjo
	GPq6J4zb4759y2HJL20gkAmqMyGNsko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732095027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0MKArP0kQkMOue4b9KjMcgw0/LinHsOHLfq7ftlyArQ=;
	b=vZ1hyOHD7qcRlkQWwo2GlkF7gAoxCGx1yQVBxKwohkoLdC8fajikgaZI4cbWfIteg0EogL
	X6UGuE9l/RTFtDDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732095027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0MKArP0kQkMOue4b9KjMcgw0/LinHsOHLfq7ftlyArQ=;
	b=dW9vgHnWiRowoCjeAH+GenAfkuNaIINR2VTaCGwxzO4tBQZqLUt41LxaohP+Wnuv6g68eb
	QiJVd3DEVdXGoCBaltcd0YjevfpgKF0a9ZSr1JINocOjn1G4WWhHEtHkzg5kQFagYAhhjo
	GPq6J4zb4759y2HJL20gkAmqMyGNsko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732095027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0MKArP0kQkMOue4b9KjMcgw0/LinHsOHLfq7ftlyArQ=;
	b=vZ1hyOHD7qcRlkQWwo2GlkF7gAoxCGx1yQVBxKwohkoLdC8fajikgaZI4cbWfIteg0EogL
	X6UGuE9l/RTFtDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43F7613297;
	Wed, 20 Nov 2024 09:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3La9DjOsPWdeUgAAD6G6ig
	(envelope-from <pperego@suse.de>); Wed, 20 Nov 2024 09:30:27 +0000
From: Paolo Perego <pperego@suse.de>
To: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Paolo Perego <pperego@suse.de>,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH 0/1] Removed hard-coded string by using the str_true_false() helper
Date: Wed, 20 Nov 2024 10:30:19 +0100
Message-ID: <20241120093020.6409-1-pperego@suse.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.de,linaro.org,kernel.org,intel.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Hi everyone, this is my very first trivial contribution to the Linux kernel and
I started from a very basic task. 

As the subject suggests I removed hard-coded string by using str_true_false()
helper.

Paolo Perego (1):
  Remove hard-coded strings by using the helper functions
    str_true_false()

 drivers/staging/fbtft/fb_ssd1351.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.47.0

