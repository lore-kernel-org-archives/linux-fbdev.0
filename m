Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C42AE6A;
	Sat, 14 Jun 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749878988; cv=none; b=P18+19DBFZGxG0A1lMMePa7Ep+c4Uq1kaW30Oj3kGqxJLGD1egKhh3opgEomMydO2vmAkFMoWSVaSJTDUhLfkEfFSyRuzkGmPbueYcwSbFPqNZoighPllPIrdmPK1hcPrdGDwp9Hsouz3yyiJ0qNof/a0yHBraLvBPkagMyN9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749878988; c=relaxed/simple;
	bh=4m+F9CS8Kox6Z71IUBMAHYeOdZ2DV+ck3U5f1CMPmDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofEGIX1IR2IFEZCjqFXuf89mkXMA6lKlO5BW4jk5VUEVT8uaasOMV0JjfGl22m2Q/jXMyVhVt1V8Qd9ndzmKBNujUsMaJwKNw8DKfarW1Cw+BIHDyYxvRKrFf6OQT/NZSD/hfU6mlpOsbXSMbRz/DgA3aiul0JgvvEu1Jw936S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUCfTC1S; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUCfTC1S"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-710e344bbf9so25365777b3.2;
        Fri, 13 Jun 2025 22:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749878985; x=1750483785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KRKrDObQhMPQFf9PTLf1A+HaIc9XWYs9GuKdkW/pSkY=;
        b=aUCfTC1S04r/MClq0JjIVsjrmIY5vUdFHrn/NrtapuoFDsJOF8itstP9antglcFQIU
         Ciole0uIK/+AKM1Zv/5mr42vHPSAgRPdGBSQ1y9Mf0xXOYWLV4ywmLF0KPLaDkt9eJUF
         r4cRHzzyOy/aMaS4ukU01K3TjwWYY1fR8bEq85IWG3wIauS/vh+93U44p3hiztTgv+1B
         T9Xp7ZbJ+//KNLK6dIukuY1NH2KCmPBeC4eBXrfFP1OJayht3D2Zrlj7n5wcSgwevu7I
         0c6DdGHr3irBQfqvNO5UXG+DadvZF/3+MxC6nfXw2AKwPoTQCHmfeTKOjkyrfFQyL7Zu
         fkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749878985; x=1750483785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRKrDObQhMPQFf9PTLf1A+HaIc9XWYs9GuKdkW/pSkY=;
        b=bf6gdb/Fob1f79VYimqxu9Wz0HTBwxL45aZ/rM7NW6fS3nrxSQS77GhbAJlaaRWVHD
         8Tin0dEF7kF4F3t0RTzM9SzWAl7rh2MJJgPJ48mh+z2y+/2E4SCXQMMkSNphnI6GMnTJ
         nckZgmkCkxuMn/Y52dD1fB0p6HzolSuYIfAHXdXodme2V9gmFDlvTb88bJxdWwE54uFc
         2ji1UOTQvp5QY+Xxy8D7vObPqwAOt2rOh/x3ff0w5NdPgpCstsyYPqKaYu4sBTr7jUKX
         nlRQqSt9cApwBEUZOIpEj4MCgN9yVOfpgHmudWo5v1oLer8lfyYvbCRo73BudgyFeoQJ
         9YSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt+PrZPf0fiz8YDa2hbxuHNwkOA4crnn9e967BC+DVruVFWXgt2sOB0lzPjeRqHG0Tel7LtBtYrAioFhgf@vger.kernel.org, AJvYcCXFy5rC8v4oW1/bGAdisvx92xbsBmE6pg6PD6AQgOkdw5TEh+qVcVZYpgLkygd/OmVfzrANv347FAkNTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwavUmzYlGZ+vgyBnD5JtgkZ56Iz/0xrRYPMMAw8eJ5ewA6f1
	Og/AsMM77E//7GGkQskUQr8RAWCP2UoEnfoLblKKr39Np7Quy/oqfUWK
X-Gm-Gg: ASbGncuwSw4tFtTaHvL+Sl9fyMAhjEo8a3gM+eETW7xAbAVYkLeyBA6HPYtHCtm7xw3
	1LMgmHDb8/X9Is3Px1hOvxJAINUgA3XFHq8v9XlbNPy2wUt5aDaeGgyVjuRlxnaNkCJvbUxBExI
	8eL8TB4eBsJ862PIURwQ9Ta5DUr+UjWPc7RyAsda8+V8+MsYqzkaYTTKXBf3iMQKvEU7/GRN10n
	09kTVRD4xAICNj23zFwyQsZL7mhbkdWPaQGu2iTyq8j3X8q3670dQnRa32MjM+j2efymWpvmXjI
	DXeFPUaTCaOeuXfRE/1rAdSCVZwQ/1HVm3GIVNZc41G/tkf5wH6+gxd8SaNBXPKVPy+56ISyOAE
	a
X-Google-Smtp-Source: AGHT+IFP4qmmzvwCoLSm0orXL9x/zDHgGPO3E4RSSJPSZGS4TypQ6nZnCTxfPpGHPX4C8NHliBZi/g==
X-Received: by 2002:a05:690c:7083:b0:6fb:9280:5bf4 with SMTP id 00721157ae682-7117544d5cfmr28014767b3.30.1749878985301;
        Fri, 13 Jun 2025 22:29:45 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7115208b1efsm9080217b3.38.2025.06.13.22.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 22:29:45 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: alexguo1023@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: Fix potential divide by zero
Date: Sat, 14 Jun 2025 01:29:42 -0400
Message-Id: <20250614052942.3551870-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
zero, divide by zero would occur in acornfb_validate_timing.
Similar crashes have happened in other fbdev drivers. We fix this
by checking whether 'pixclock' is zero.

Similar commit: commit 16844e58704 ("video: fbdev: tridentfb:
Error out if 'pixclock' equals zero")

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/acornfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
index f0600f6ca254..2dc0e64137e5 100644
--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -421,6 +421,8 @@ acornfb_validate_timing(struct fb_var_screeninfo *var,
 	 * No need to do long long divisions or anything
 	 * like that if you factor it correctly
 	 */
+	if (!var->pixclock)
+		return -EINVAL;
 	hs = 1953125000 / var->pixclock;
 	hs = hs * 512 /
 	     (var->xres + var->left_margin + var->right_margin + var->hsync_len);
-- 
2.34.1

