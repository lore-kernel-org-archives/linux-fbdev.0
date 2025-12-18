Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867932475CF
	for <linux-fbdev@vger.kernel.org>; Thu, 18 Dec 2025 06:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766038483; cv=none; b=Q1x2Ezm+bVIwS2Dw8HncTU+gVOSK1IiwRT+82nSBqxJ1979x6mfsDjohIsSE6uCJbApPBsuPqoUdQOq9fF8s2xTSdOZHp8VPT6ZLWksTcZpIt4QoM0L8Fz7WOLzVW786QgRkwfOYLYa9RFlvArGRz7UEHTvh7Igu1wpKGQlfid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766038483; c=relaxed/simple;
	bh=Ggx3K3AWheIt4L0mh+WwSssxKcKkJcMLFPNyg1GrfRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSmz66idn+98OY7IO3e2FQOd7Sz8wk2wi1EmxY5UrNprx1MlAahq/OzPLBDbdDhVkWk8UfBQLIW/21X+x8A8TZpXTLMKBD3o2lTPMi11dYGO0RxLlsblqt5yS+GIHZPuEozFR/PurcLrtOrQEHjgU0XEeJKyoIAXOLaH7JQfB1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkq+TA/E; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkq+TA/E"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aab7623f42so377197b3a.2
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Dec 2025 22:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766038482; x=1766643282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ByPqHkzjH6Q1Om9pizog4Avqkf2U2qg2PTvWNAENUs=;
        b=jkq+TA/EQ2oB/T0HDSBiTLokpLXIOkNKr5glxRQdU7V13mJg7mAyzTLk/D2LYPS0Mg
         Hoy1I+scpKlqml5ELsXV5TToVXNAvSF841r8VyzaxmMQbQiYanlTylsRJzbeVXw9it95
         1B29JGjZXAcCZnu9Loc3+JETL3y0ZUTCt7aS37PEhJAOytGQVz1FhO5MvDdJatOi+qOb
         w3pwu+Z02IoreoxeDXIEJ8mTa4V+AOcbwQdnPpDtw5u9+4OPP+juvXj8GybhdyaiHz39
         JhY0dcUkdJL6eVpg/LCepuH0M+bsN3vnDMCHnsMq32ywa5tV2G9pKmhqY1pqLexZD8jc
         uDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766038482; x=1766643282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ByPqHkzjH6Q1Om9pizog4Avqkf2U2qg2PTvWNAENUs=;
        b=YFHu/1BpNwAEp7VR8hnXO00Y7FgnkgsB3a9fieFb0kIbnxFvkci/18EhJVh3g8ruBq
         sn/Wq3ZR0/IzFhcvLmw8QmjFGHyK2jgVLjxFGfcqeGYLhc1cVyX0BFQn9dtmJQ29spuo
         kS1RS/V/mOsR3AX1t364bimEcSJ4DLccz6C04JJt333LkD/pf9omngCuhjc87WJqUlN4
         LFhhgSATFJG5w7I9cMBU+QQvBSfjSk37huotoksMERZrROt0FH8BGMoVpOlJcThjn7a5
         a6Ui/BSTjLrU3yv+8jhV6Axs7zFuFxCOhkO4HFNJANZ3m+Bi16bCCMigXAzsHeZLOzum
         XU8g==
X-Forwarded-Encrypted: i=1; AJvYcCVcUREF72fb+7RZGuesuFmnxEYH1wYlg2V1ZR+onBiRWigERBR++RWlOYdcsj+fjvP4j/96AMoeQComFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLCxbWEcLx6FwBst0aKLzo0UJhJD9T1fnRQ8YduHyDY6HVMNv
	QjIDltUXM8CL4fFDtyMhmnsfFP/Opf1ze/br/M6ElBhhXMr9xlhKNyH9
X-Gm-Gg: AY/fxX4krohy7cdp8C+eaNUVhmQJkxrppowzI4g/lq8PE24lEUKOY3MaEQ2KpVJ61ya
	IwjxDUOwdvXmosvhKV4R5OStwT2KO975kipdXQ4YTDtTteWl9Sn38I8hPotnDYmimbxrXJwlWI4
	GcGTd9KIbE2aX2T3A+gPSrOeLBcXG98VwY0eD92q1XbTh5haik2QEMuq9pItlXFCQ6THFr+tQDj
	am8P+6kmxUVPJVkxSBdNH2UNjur560NouZISkYrz5q06A5HWG5T8KWyr8/L+6XSKAWvx3OxeOTK
	YokL5SHgeUr753ce9fHA2HOnMoPUVZOl9Bxn4Eo9a7B9CCaAOVmnglB59LvbyCwzuhZuAlRgv1I
	RGF6Y/Bz59/6NixjNPthKKcU0w0MWK8DA/XjfXIWS+apKhbQfV8F0Xq2PYIGbYwBTyoytAVMyks
	I1c0qXGrc86rKwd/5J/HlFxS33Sp7f
X-Google-Smtp-Source: AGHT+IE/9wFIIieTQNvwxm86+AsvmVZQ7ekju2YVJBrytFbrdfTJ3zUvKtJoZsiHz7qoBXsSg5DZNg==
X-Received: by 2002:a05:6a00:6ca4:b0:7b7:828b:f569 with SMTP id d2e1a72fcca58-7f667d20d99mr17684559b3a.25.1766038481793;
        Wed, 17 Dec 2025 22:14:41 -0800 (PST)
Received: from SIQOL-WIN-8.localdomain ([49.36.67.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1456d417sm1347795b3a.58.2025.12.17.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 22:14:41 -0800 (PST)
From: Arjun Changla <arjunchangla7@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arjun Changla <arjunchangla7@gmail.com>
Subject: [PATCH] staging: fbtft: fix spacing before close parenthesis
Date: Thu, 18 Dec 2025 06:14:06 +0000
Message-ID: <20251218061406.8043-1-arjunchangla7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch error "space prohibited before that close parenthesis"
on line 65 by removing the extra space.

Signed-off-by: Arjun Changla <arjunchangla7@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff19e4..2f7c891177fb 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,7 +62,7 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
 define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
 
-- 
2.43.0

