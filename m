Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606617;
	b=OlIHeBKUZr31S0Lw4pXZrIxrmpBccuuICi4Z0xjDEfConxCz0QeLXba02wvMjGadiaxa
	 tGTjfv1L5dmZLQi8GZITcnq95peh7tpq8s3CmQwyqgTl4QraRpLam8I4DPdPXDMXEs/ib
	 GMMbEzknpWOpCMjeRAsjQU3vJXRBef00H6S/cO+jYrv2UCv3NfXmAf1x//DP2S+eBZTfT
	 GQ5hY/ggI+newWk0jLuIi0z7RmKYRtjWYLa+OP9H4uKRYDdPv+XVaXSmqOxojcAY+qMEJ
	 q6QK1C/z3Xp3y4lHBsbZgbgdF+irZe/ClzK9gM4ws49Vs4puennfNB2MpSidmEJVlyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ULB0fdcScE3pyVzoGp78pW1Fsjx9L22KYr7UY+zqZWE=;
	b=YJcf2zo23+4J7yZC4KbjZakxcO4QeBDDsFOhFnK1MLhwyw1Mpe7rtHc76ml65B1DJNEk
	 xt1s/tpHV05SqZ85YoghllGoETgNxxxwHB2ZkbtqUQ7mmDi4K4xsyh3WRRiJdGUFYJxrM
	 E23aElzeYsk58trHdgXoVKG/A858t7c7+HlahEQSyyKQfK5aWqZDM/eL9YCrM7aMyKxPB
	 8gfvBydjdTdrBy93limxRf3fm6Kacnb0zPTlcx4h5nduVFFNK+jzIo5rXYeqdbePcSlz+
	 YAzsT9u0wIk6qgokKw2yPmsgD3eocsT/SLYqW+rnq3aA/qF1AjoKLoEdINMQORfyuLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPlz9UuL;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECAA606A324
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2026 08:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECAA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dPlz9UuL
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e7e742a2c7so16991825ad.0
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2026 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793606616; x=1794211416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ULB0fdcScE3pyVzoGp78pW1Fsjx9L22KYr7UY+zqZWE=;
        b=dPlz9UuLFBnRXCoaJOT/p8CDqPb4dVxfogMypNiEqVPBs2nTkogTAKio5chRJdk6A6
         0NDHsGAj0fJs4OocteVW3HgLmNW8cMzWXo2JUatd+i/n0lpif+rdEwhF74ZHNZ2wOCh0
         5XrEfqaGqqG3ORPjCesKW3Fo5cpEI4n4srZkMt3p6sxSooboizA5J5HXDBZcLbbw/wXM
         pWiTh2r4k9K+GZH784WKhOv8UrTsI/r+KJEXAjm9rqPMAsF8qpRJce6OiCl6D7FBbJ4L
         qvVOzmrK+rjyNVTPOrsruqfNjGkfZhkaZA2Ch4Vllq7Tw3G5B1m/PkPnZR+t1Lmf0VZj
         ZB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606616; x=1794211416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ULB0fdcScE3pyVzoGp78pW1Fsjx9L22KYr7UY+zqZWE=;
        b=VOinuKgsOvNHOgsLn+hG73pS0Xvix9Q415aiUWJR2IGQkU7aeOez1Gj3xAoJvSOqYx
         u/JWwbgJheBJqVbd0e/xMAi6j9wi7hPL04APFtiQp1GAdwn5rhcKEtR3OXXXcIPsL5b+
         bizgV+o1IsywG/6Fu5KjP3Jg+XZ1AqhNpt+hljelOCAfpZ5hfPeWT8hafqqBsC/aYzYc
         F4MruWvZxuhzplqWurBSN5movJbclXvguVzaa00mf9k5ju+wJqPznhInrexz2ZNed3e1
         S5bnMqaWgE7oJbxQ5MaE/06Ee8aYg0xWMmRlW+KFG+pW/vlZ6bZul52wFehCfXL7DGD5
         XKyQ==
X-Gm-Message-State: APuU4Z+9NmB0kg+1/KWzDRd7TTbdjizkJyIzHbhhMX/6xEkqQJ9imIYg
	0vb1U0aw8yaKIMlUaOqZ2Bq/8U4HP0zTrYPqr/f2vM0z8MNmDuTrxl4H
X-Gm-Gg: AYBFou3iG8bhdMiW2MJMzuhv86u+ExyOtF21ECWO54HQ2aWz4+sT2KaU/TIYvKCCVS/
	jbFyK6ZEVFEXBmWZuMWTddhppKrKmqpdlvVwKaLJP6YqaussyfPQ2y0Bxc58uYhqkeMZryjH7za
	hS09Xa+T6CtS66XehzC84M5WF4ssaHME97L+aOYwCiD6SVCgO8qTyV9HoiI8XjSnvP6133Ux4cs
	qa2oaefa8hAq/80I5Fw+pfHgCSFveMsTCM5ITnJ0tOLJNjZAi3jpxDwryUKiJLRDOrEcteLther
	7h9/6th065fJPPHgmzhV2uZik2dpEoLc38D7nWD4ltgfkwoFy2kqXNDTMmCY6/WiVN5RM2+Yx1J
	qN0CtLGvBYWb0DxAVAFSj/0lp0SXVB2o+huatZIcU1ep5SXnV3BsQpOB9Cg3HVrlzNBAgEPuPr5
	60AmkUb9OYld8Mxr4Gfw/8CTWFqLuSFo5wt695HNf+7vwRqlxXouWtq1YSYna1O35PyIkKXNk4v
	uk8lp++S1G86QWgLg/E+hWe5h15LLp+eSr7hrcwWeSCbXjtdIuMJmTgGn8Y58EJX6SRt6YjkuYg
	HLk7MMzbXmI0xJTdMeHub2vaBMqUJX+Jvn5n8B3YB4jtg67MM52E6z6PtrB5zyY8qThm47W3KLO
	J7/nKNb1bzEAbSoHMQh0bD+mXKAiwqBtMPJLwzRRzKKBp4KDKqR/q/kat2vEOkdj5U7Z71u5Qx/
	eNCgMDniX94piW0Q==
X-Received: by 2002:a17:903:984:b0:2e5:cd0f:518f with SMTP id d9443c01a7336-2eb1a57e22bmr78324565ad.0.1793606616223;
        Mon, 02 Nov 2026 00:03:36 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392afa5asm23573655ad.72.2026.11.02.00.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 00:03:35 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] fbdev: pxafb: fix teardown and early-interrupt lifetimes
Date: Mon,  2 Nov 2026 16:03:29 +0800
Message-ID: <20261102080332.1466689-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three lifetime fixes for problems Sashiko, the AI review bot, pointed
out while reviewing a pxafb cleanup [1].  Removal leaves the cpufreq
notifier registered on freed memory and the smart-panel thread running,
and the interrupt handler can signal completions before probe has
initialised them.

v2: v1 went out before it was ready, as separate patches without my
Signed-off-by or Fixes tags, and the completion patch depended on the
others without saying so; sorry about that.  This version adds the tags,
sends the patches as a series, and says in each commit message what goes
wrong and how it is reached.  The notifier fix is now a patch of its
own, and the smart-panel patch stops the thread after the controller is
disabled and no longer changes the thread's freezer loop.  Patch 3 is
unchanged.

I have dropped "fbdev: pxafb: preserve IRQ probe errors".  On the
in-tree PXA platforms the interrupt controller is registered from
init_IRQ(), before any driver probes, so I could not find a way for
platform_get_irq() to return -EPROBE_DEFER here, and the patch changed
nothing users would see.

[1] https://lore.kernel.org/all/20260722081427.413EF1F000E9@smtp.kernel.org/

v1 of patches 1 and 2 ("stop smart-panel thread and notifier"):
https://lore.kernel.org/all/20261031033248.2491098-1-matthias.goergens@gmail.com/
v1 of patch 3:
https://lore.kernel.org/all/20261031003424.1796478-1-matthias.goergens@gmail.com/
v1 of the dropped patch:
https://lore.kernel.org/all/20261031033236.2490968-1-matthias.goergens@gmail.com/

Thanks,
Matthias

Matthias Goergens (3):
  fbdev: pxafb: unregister cpufreq notifier on removal
  fbdev: pxafb: stop the smart-panel thread
  fbdev: pxafb: initialize IRQ completions before requesting IRQ

 drivers/video/fbdev/pxafb.c | 46 +++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)


base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
-- 
2.56.0

