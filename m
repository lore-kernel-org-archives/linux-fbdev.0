Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6892E2147E6
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Apr 2026 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268874; cv=none; b=ZSdJ7+7XkqYOT+xJDSFOTXA8+nosM7qlFYTGV0mHR3FckOUFgKh9T1+nSXTOtrBPfTN+MAx8NYAiySE80FwS2aRWKRTY0TegOOec/RTgPAiCR58OT3ZKQQgWQ8K2Kjzy0Mk0rWOQ3m+RZyUhUi/vp5EPSufcVvD8OwnQ8GoSNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268874; c=relaxed/simple;
	bh=KkfNj1NQXDE3PipqYbJWPN/fNlYemAsIXaxfQeOJdaU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dsKzGTudN0Ozb3W3xMZKyRUbVxFXPO00gODDPLpXt0LpyKaeiDzsMZwveAVuqcesYbuzfq/gf1Y2XiNqtOXtLqVXFFbloKnJLdnkDMDG29Eg7XGbAFgV7XcMgR2/uSikMF9qu1m2fbUpRlvpGnZRaLsty6MXyvgSJ66DOzGStSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbkoW4UV; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbkoW4UV"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b4520f6b32so13862936eec.0
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Apr 2026 22:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777268872; x=1777873672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O1wx59qQpmYax+mg2eacWOTf08F7XgIOKeK3pBsh6NI=;
        b=kbkoW4UVh4I2ouY3p8m1RU9u5Ws2ZnIuO4+IasPfPOyxp6Ukw+zvl6HvAl9TkRfGQA
         t++Ze682CaHWmkGv6ZgGHFB3Y1lwLzggXEhtkCt3vRq3GqyX0wxhHntmNzvqMim6QmXc
         rx/Y7EZGqQUt7UAV8G7CH/k0NF1W4B6Kvlr10eTTWqntg037AQ79gNTpOkxKe5lFbxuh
         Lwkkj3no7Pg2DW/On0E9vxYuMEcSFb/WozCd7UcnA4txe/PK0aQsVuz92tcvsVHr4oxj
         xYWkMGxEBdCWvqfX3XGeBLsevMNnbGSt7jRLW0fh+bOg9oi3yfPedp3q9jcbc7qFBQ1b
         Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777268872; x=1777873672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1wx59qQpmYax+mg2eacWOTf08F7XgIOKeK3pBsh6NI=;
        b=V//HwUEGcqeFYsGTHVPp8KrmkdKjSVtWh+n8S5UhOhIf4VXxXox2xrbPC7rZ9rXlgw
         MXtT9PS1t2C8ze8xZQFIxhFMOEI+YJot/OZdhg6DFwr6Ewiq84Tw3mhGRkC17QzI40xn
         kgXKTylFnVpjWhxxnV4pBEcGz8iux2bqYmrOnZREpH25dZIz5RCGtNPRUX0zWY25Y7CQ
         DO5Bb+AuhB6dxMCsflB8XQjtNip3Nm7BPIt/oBs2dCFuNOrv2fB73+f7oO2MJB8ITl4x
         S4Hkots6kzme1XO8F+1qqtqVdpQ16wPoAovBLyZxhPPGcRkO149PKgm4wfbuRm3Y0j0Z
         VSJg==
X-Gm-Message-State: AOJu0YxeN/XV0tychDkNz4wqkqVZCUZxttk37N2DbC7z9+aiCb0MCOYc
	EMMPszdr04lJkxvdyy95gZwNl/soZc/7MKBrigJpo6HJwnbl0NPReNRa
X-Gm-Gg: AeBDiesLxLvSqv2AUFjWKxzUqqyX+iJrLAsasjiMqg+lmJsJcezH+Ldvk1XC9ZajcE2
	kh4L0vzeWW+x46zcQ5zKKv2fw1BKg1Q92hhZ9AbMnlS8kMnDWABkPABu1GkmlnDse7ytXwVVuOy
	ocYF7ZkmQlj7+MnpLGmsC0tNkb5Jr5Bc4iQVi3PokDAu+hidG6w/Cf/Pj6OJd9XsFrQqUEECPXD
	Y/TWP73RrqYNbCdRvorCC+quteJYOK+/MoRQfQZEWUJDDE9Ls4t14L6CoQHR9mSQggeBsenU+Vm
	kXJcqm0W4I58GuA4UClHOoVBGwT1teHms5ig9otqkxCnD6rWESrgqNvogCghkWGZfC+k/39IHeP
	EVh1yOe4ax8oVncMjGtIeTE7f/AficHQpZela6c/qGeS6PNvm/Rbqz95v5lqtE/8+sM35CoZwqE
	WHsmE8V8wYpciJzV1CkDVDR4nxybJEw0JAznyVvBZGBd9E31G65sLxAwDcPcG07pyW7g==
X-Received: by 2002:a05:7300:8c9f:b0:2e1:e3e6:2909 with SMTP id 5a478bee46e88-2e465487fa5mr22396778eec.9.1777268872527;
        Sun, 26 Apr 2026 22:47:52 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2cfd3esm42350209eec.21.2026.04.26.22.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 22:47:52 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v3 0/2] staging: sm750fb: fix de_wait() return handling
Date: Mon, 27 Apr 2026 05:46:55 +0000
Message-Id: <20260427054657.758-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves error handling in the sm750fb driver by returning
proper errno values and propagating them to callers.

Changes in v3:
- Remove unnecessary comment in sm750_hw.c
- Drop unrelated comment formatting change in sm750_accel.c

Hungyu Lin (2):
  staging: sm750fb: return -ETIMEDOUT on timeout in de_wait functions
  staging: sm750fb: propagate error codes from de_wait()

 drivers/staging/sm750fb/sm750_accel.c | 18 ++++++++++++------
 drivers/staging/sm750fb/sm750_hw.c    |  8 ++++----
 2 files changed, 16 insertions(+), 10 deletions(-)

-- 
2.34.1

