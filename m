Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0F20E315;
	Thu, 26 Jun 2025 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750958671; cv=none; b=tihLT0KaayAik3KPR8J5dGt96sR2z20h1ikK+djc2U/G5zu38bt+f1uTZ42iLNpOrs1craJPE9Q1GwpGEUv60hM7Q0Dse64BTzEtdwdA/xCLBgzqqMhj/KUNUlMIL0WkLSeF3VIBiKCKzkOCLMdmOVCu466R2psfbi1cahnyugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750958671; c=relaxed/simple;
	bh=KdQnwApMJiZhnf712Xc+Slm3O5Udnt89NCUlEf/erRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkzJdASTt78+HfoBuDXcYxpwyQIrfudrNodFYFRictQtkkX71/U/WfNE8k0tGASu/emnsN6RFXW6YhoEFWbh+GT3UzbMIuJ7l1XQimXzlRSYC6MijciCgn+AcFKnSMe4sNGzJfZso08U+r+PQjkjsLG7VsI+jBW9b4rtp/dquBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzaBjX7H; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzaBjX7H"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7494999de5cso932741b3a.3;
        Thu, 26 Jun 2025 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750958669; x=1751563469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GKksa35feXB36GHTT9Qp1/4Jr24P78lzzDtaWWGcnqU=;
        b=mzaBjX7H/mh7ZSWPCK7+kEZfVJG+wCkmBU+WhnrQfNfhnvygrRUsTM78fnYRHgB4D1
         +IjQ+jb3S2jXXaG43wFljzSdqIaWE09CFSY2d5zxaJjzeBcRYGS2IOAYaWhG2NTVHAuQ
         5NWHx+PRcnDjj1xJ8Pw8PLXZEV8BIk33UkehOV9VzIXQdU31fG4ZHcYajkwhZOwRlBVU
         qlk+Sf9rEXYhl95Uz22NSdCLbWmP2phXtwWtiH8o6DvGnYNIx9sS2zZQO3JoCBjrEYB2
         uQHQVLxf4mUTOodmZQUVSM6R63IIe7X8QyddZ0KeBbwh2sNB80c73L5PeQ/1P7c41TJN
         3Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750958669; x=1751563469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKksa35feXB36GHTT9Qp1/4Jr24P78lzzDtaWWGcnqU=;
        b=uhUNcxYHx0RKdjcFZ7D+M7jnfJIBzDinVVGq9s8scNJJClYt9RXpOfipycdU9c+nb7
         xZs3KM89MKEk6VURinh8DZozTP4hPcJYiR3aVYlAkwX45Tgt3QCR/LHNNRxkDRS2D/eo
         WJpLO2RIXA2auidqzgcFIRo6p5c8BjdopEvFlWbgDYZ6R+9OTzQSy1MBatv5z1xVfvK0
         YsIWZEY/pOHbx1lzXdhX2LGPtpgMeG8uUrL7A0HiK+fCPLbveE3hag0V02qzsZKuI5bE
         q3roYsEqe7nbwmbvomka9ufpWez14FBsXLxc/qlLXF9YoXGVYxrWGJ7JFfqB8XFpmVvF
         hm9g==
X-Forwarded-Encrypted: i=1; AJvYcCV1EjkzXVXoBwHvVLeZF1cAbVwVmScJ61DS2R7Ci2PvjdUPSRBlJ14UKJvawcZOi0ef3IXLk4odGxAJrg==@vger.kernel.org, AJvYcCXBBVD8Wzj6+oLRv4JFXyvkVj2qIksKaMfXCdBHlvE603qyCSOWdPh+vcgk05J08YDfxu7RTKHaU54f8Ur4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/QWPplkkA+Rt9Fmcxjy6YSWZh5MvacHJNgPx1XP9s78iqgEA
	Oe4/HV5kjWA+cEYRwR+naPqbHV5JW1AQALZWFl/Ry6DqbSUz3KB+LEQ75cqzCQ==
X-Gm-Gg: ASbGnctotifMaW9RXyhbJ++qUM8lL8c37M9Ja9C3NTOPEgbkUilM2oKW9slk28bdgeH
	wfSR/iLQ6dCIteB9FSVgHts9qnvk6vFltLz1Vy8Knbff8vz+GSKu+5LZfmBoIrHOUacpuhB7rtA
	UepnvgFdr40GB60MkbV8BnQcdFnjFYYe/7igGZm9cz7FUbSEPgCvWs0laJzNm2KJf0FLZsigDHg
	2TXhgF9gRxFCiF4BgOzE0W2aVzzXpnXIfmATUWcMB/q/cWi3/Lz4cwKPueFpd6tfRUg+oK4dnle
	b8eMiKjYZevaQDCjELefVAFEJLFcgALWzldXO/1Y6P1GV6j3Tr8teYcBWb1NIgKOviD8dvWf35n
	osA==
X-Google-Smtp-Source: AGHT+IGpNrxWVlvz9yO0sPnp3SvG03DYr98IGTzu1iXn9pp/JkN8N+6B43mNyV1Djnpa3TrKJLV9Eg==
X-Received: by 2002:a05:6a00:846:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-74af6e66354mr59436b3a.5.1750958669114;
        Thu, 26 Jun 2025 10:24:29 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af541be9fsm229670b3a.50.2025.06.26.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 10:24:28 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: andy@kernel.org
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
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
Subject: [PATCH] staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
Date: Thu, 26 Jun 2025 22:54:10 +0530
Message-ID: <20250626172412.18355-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the error paths after fb_info structure is successfully allocated,
the memory allocated in fb_deferred_io_init() for info->pagerefs is not
freed. Fix that by adding the cleanup function on the error path.

Fixes: c296d5f9957c ("staging: fbtft: core support")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
This patch is compile tested only. Not tested on real hardware.
Bug was found using our prototype static analysis tool.

 drivers/staging/fbtft/fbtft-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index da9c64152a60..39bced400065 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -692,6 +692,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	return info;
 
 release_framebuf:
+	fb_deferred_io_cleanup(info);
 	framebuffer_release(info);
 
 alloc_fail:
-- 
2.43.0

