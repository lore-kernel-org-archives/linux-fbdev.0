Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEF32309B0;
	Tue,  1 Jul 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751362871; cv=none; b=GDbnO3HSa4PaMghVsn87B/qpDcSC8n1rH9aW2pQ5ZxvZUl3kX4B8/MHJRBIC9NFJRaAkG5LPXdUIu0wDAScE/47Hok/5ltgJR8yBI+EFfPRU9nHEyuMet6ViXHky2sOC/E89HsR3hPse3CWCMQcqEuTdG5ExyS7yVFmVWFUiHm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751362871; c=relaxed/simple;
	bh=5kQ5HbATbSWIj1JFpHo9PbQOlrrjpSHqiXePkD1/QwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmY5sVCLRz28Y0mmHMr6kawd0nQbWwJ34OqbXaXpKj7KGW0uk5xyYIWpwHFnHcxedNDeOB715Kb+FNY6YR5h3KiNItpP9JYq/cA7RmDBksxiAQjbM5Vc98x6NysB4UctPOFiPRB6/BB7lH+e09oMuzWwbBcKttpOdWasRIDgbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6L/tPkV; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6L/tPkV"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748fe69a7baso5327761b3a.3;
        Tue, 01 Jul 2025 02:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751362869; x=1751967669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6VPondI9s6Ps40JI4paXgB0FQE9DZBVRKYHGloiqBo=;
        b=H6L/tPkVawvlIDEEwtTykVMbtWXej8RN++CeDoxO2Ch9EoJmv1yFjkuBx7mtV/hO9W
         484Sj83750T6+RFaX25Ana1Crq9dBi+RVQKe6s/6rCHSV3YBNC9sUctxdd91AVdEHuEf
         JT1HM5hrx1aL4nHkIjLF+85dYUp+2MPRG5UT0B5UZXCnJ5qS0Y+gye91EZLKsT4uC7+a
         q/lTuD1E+gcLFRNqAfmnH2nz2gO/FDcoUwXNN4bAfMeUE5ozWALaloHUk3V1kHnfZaE+
         tJ8qBCCe1WEOcLW/1VxdCBsNOrtGtWsWrhiN0XNSYwPrkm47cPmUcKmK5FNzpdNVqGr8
         s1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751362869; x=1751967669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6VPondI9s6Ps40JI4paXgB0FQE9DZBVRKYHGloiqBo=;
        b=XTP9/1oClFo4oZ2RumGpetjqCUEoEaSlxS1Kk55ISV0rN6+x9aRgI/w0lyhaCxtTFJ
         p/fneHsMaFt+qxD5MoR++rZyZB4viw+v1lEHUYcVK0a1RnjTfK1MMMaDz+0lhR+mJ5/Q
         oXkaWxAnWN4gGmYmXi76fkgCLgNuTVVbNyshyxzJ2oz0TQWw27xJzNvCkyWelkoFMmHp
         6Lzhk52UIWBZvcFDiWg9InfVxPeybfEz6DLpWapbjHMV19g7vPGeSMGkjpDRJ2NZZxol
         nZiIgLZaF0WmS2hMXOTswcPZj1bf7gvcpF7TZD1/YRckdCV0iJlMGcgDIi58a/j5TN6B
         /ZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIMedv+URPeaL9/bsTfCamLTcKe60WRokGsXxzZbWX0m7PBHFi8W6D9elyQugSEad0E9cSimFNxJ4vJw==@vger.kernel.org, AJvYcCWgJqJqzn8rX685cYQKWrQoxZe3+8HwqaNXCCY1/IvimWMiXXcBB1MUop7v+VrV2Ucatl7opYwwdidZfPk1@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDOPcsF/M5qxnqpvG35ErdPQAD+RnflCUpvr8yuQg+6F65tvp
	5xgmS4ZBaaYo21lx7Z8ujD5+UjCJnM+VBoZiKZTTw1FUKZa+fupm+Aav
X-Gm-Gg: ASbGncvIFLTyT25YlzVPwuMcRZoE4vIRShahP2PdaHDTpacOJtLYsh/5iqXHvyrKOaN
	U4jjzFweDMzs78Mp+23J2LlZwDJ/dDjPMG1Q+OokGy8lZGHUSONV1Lfxrj2weS9m5i2xKWf1GiW
	upGUWxILGSUUlL5QkVuowoKnssjiQvwmzya9C/4TdCNtbvGjI9eGAKTtdOHJRrBSO5x+7P83rwK
	+kDCdCupbfnmCdzBP5pjqjOiOpUO6ee63Ukjh0xW1q+ctV7jOrAHJ8F5eZbKy52MaaTaPet959G
	M0HInSRYf/IQhxaNWwr5y+wkgJatF6ML1WWurw03JAnwCCPhoQqeoA3uLMsKL/llzL/Im5pl7BF
	jIw==
X-Google-Smtp-Source: AGHT+IGCUJ6tlUrEWS8XsccIwNxw4AUXaAE5LiMgz6vheF+DRB+JBGiWDglKUzh32UvkY9tpeCODvQ==
X-Received: by 2002:a05:6a00:1302:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-74af6f40a01mr24461769b3a.12.1751362869457;
        Tue, 01 Jul 2025 02:41:09 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af57e7279sm10945766b3a.150.2025.07.01.02.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:41:08 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: andy@kernel.org
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de,
	riyandhiman14@gmail.com,
	willy@infradead.org,
	notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] Revert "staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()"
Date: Tue,  1 Jul 2025 15:10:22 +0530
Message-ID: <a689f32d6c56d6c5c6ba8e2faa0305b5e92d9897.1751361715.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751361715.git.abdun.nihaal@gmail.com>
References: <cover.1751361715.git.abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit eb2cb7dab60f ("staging: fbtft: fix potential memory
leak in fbtft_framebuffer_alloc()").

An updated patch has been added as commit 505bffe21233 ("staging:
fbtft: fix potential memory leak in fbtft_framebuffer_alloc()"),
and so reverting the old patch.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
Newly added in v4.

 drivers/staging/fbtft/fbtft-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index d920164e7710..8538b6bab6a5 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -695,7 +695,6 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 cleanup_deferred:
 	fb_deferred_io_cleanup(info);
 release_framebuf:
-	fb_deferred_io_cleanup(info);
 	framebuffer_release(info);
 
 alloc_fail:
-- 
2.43.0

