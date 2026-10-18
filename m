Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68C3A168B
	for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 12:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326921; cv=none; b=QjwJbIuOKXXQ8w1bc3ayj34Pj0MDW6CfxwUW1xQhd6CQsuTV0kwWU9G4Xu7u4dtNpD2NTRKRpCtD9pPDRa/ZlEwoWir7EyiKhPIS/MQmBz29bBb0P0DgMzWrnT45oSIanLmwbADXzzHgdtkDFAF0mCWtfSekfJb5bWB3i//+f8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326921; c=relaxed/simple;
	bh=cg0uRSb4UEPzp01kbIS5zd8ide7ZgMWxvA/IgBjUUJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TVXQBRu0IinhFrAcZLAyodQtIPHcnbrTTr+innwRLxODwr4p65AwEbBy1F8fU1MyeQTVROQovtQ1DPqfCIQLpfzQKWtCeC5yymhS5SiS7L55+yOUxKSBoB1/gVl93gcxyP/yooFw4uUkTdJjpKYaTnHFc80i/N+GzoJ+nRWlC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r2w+hDuX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2w+hDuX"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e10a70540so187154f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 18 Oct 2026 05:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792326918; x=1792931718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yZRC1saK2lzqhpBjjhBU/Y8Q9XNxMDtAH2y6pyCBfUk=;
        b=r2w+hDuXOxye2hwlTMyfcXAEmc29kQJjLW02/95c5UvXszVGQ2Wppn4tZTRclf3Vj/
         I9/+s5f7abtOyNTVLuLIk+nL80AXaxD8KR/DRIogqotx7P119XLFvG7mHLIecnvOgSdO
         fI24dE8pdvWMOTQFHxXa9zXUIaDoww3FRDetKLkF8kwygnwP09IZGI4zm/MjGXs3AlQl
         yterV/bL2H8GYp1ELbWN962djGbvhgSKLKQ4aDTFJwuVqpDi3P4BEfSxWgDygqGPLsvO
         +vOS7X9K53RlPaYc91vhVRidkYgiG4DziLO9HR52hdMz40/H3mONN/7GCwsWUM1CVCMk
         iF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792326918; x=1792931718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yZRC1saK2lzqhpBjjhBU/Y8Q9XNxMDtAH2y6pyCBfUk=;
        b=BZdKPArcmQc8/D/0vJM66gWAiouAn8CjgpulvUToPT/Ov6RlJV8jbI5lkCR4W3Eoej
         dejy6XZqOCeNM4eoz15LQM64xPygeruKkqiB+o6tKGOdnA+BibusJY/zgzkyJ2QViN7x
         YoddJLgjTvrtfAJ0HRcX/1aPTjR3yLBcF07/W0ozrnnTWwhzJh8HwdkA8f8WM9+WUcVh
         1CgNosz78uJcToiEepxyLlQTVFQ8cbe58/jHPBYZEX/nqA7FmNjQwWnkY1njImNxEIAe
         nXuD2AC3/vWXs+xT8lPDlMJu9o0s8ZAnSiDITMM56izHia9pyjx4l/Q99QhI6pNi6cTO
         bHXg==
X-Forwarded-Encrypted: i=1; AKwUvBzDUDnuwZU2vAZ2qOYxFpXXzP/hNvM7GoYNbS+sv6idX6qy0vHrcGx1tgy+eclzyZY8qXueROQP5lvrYA==@vger.kernel.org
X-Gm-Message-State: AFq9FYL/D8RORJsWXOeMkj6cxzbJUfX62nI1fUmKuVU+BLkWw+bzm1q/
	FokSLQ9Egsg5PXLeEMwxnvhNMqsoByGxO4xlC5ykebxJWz0Uja2nrxrU
X-Gm-Gg: AYBFou1SaDn2OUbDZ9WGNCT9eLX+3eHe8VZiP0hUgK1h2R7F07vVWbInP3keZ0Qwyhv
	9hk5IoiaPLndQgHDvM0jFMkiz//k8ofOX6DYYr77m3ySnNSFcV1CBbvinbEEcbv/xsFOHOA3bvl
	3cfBHgG0GeNmyR0vP/42v6XyEvtyG/s9hqL9MjG7Y6PHkeEw8bkZDp1owVZNjRv2kRf9d47G7uK
	42zuh8qUZS8Rx6xHQJxt+HTRVWX1yl+RWqBU87vvuDnEbqjeh1t/wyIi/Bb3dEf17j2uIHS3ueP
	tZJmq1rdKutHWLXdNUedudw7oKOAveikuVqDI67MBgHackjL95K1DVFi3+wgk/J/48cn79pF99w
	s8HS7QxC3sM8/3KCH58ZVR+AidWaMDfxzf0cxtQ+99eKlkiGm1pO+9NmzmXrFVDKcALnlvu5suz
	j8wjH8VmRL+eExBwkoRnLZhOvK4s60NT4Akbni2VCpjAuvUUHb5dn3T1NyjBsZnkkviMMywZZVw
	YOurW0/Zw==
X-Received: by 2002:a5d:584b:0:b0:48d:f831:2688 with SMTP id ffacd0b85a97d-48e079767e7mr10390179f8f.3.1792326917977;
        Sun, 18 Oct 2026 05:35:17 -0700 (PDT)
Received: from kali ([102.89.22.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd503a0dsm17000429f8f.47.2026.10.18.05.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:35:17 -0700 (PDT)
From: Bashirah Lawal <bashirahlawal017@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	outreachy@lists.linux.dev,
	Bashirah Lawal <bashirahlawal017@gmail.com>
Subject: [PATCH] staging: fbtft: Fix continuation line alignment
Date: Sun, 18 Oct 2026 08:34:30 -0400
Message-ID: <20261018123430.148379-1-bashirahlawal017@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Bashirah Lawal <bashirahlawal017@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c740c5..d58b1247262b 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);
-- 
2.53.0

