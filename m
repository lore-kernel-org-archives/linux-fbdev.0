Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC020ADEC;
	Tue, 12 Nov 2024 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443322; cv=none; b=U9SWOP0dUZgAr+2ghbCHgAw4cB211HomfPBEd8hqyW3We23V506cAlTLlB+0dEhpnwadLwSXis2/ib6C6sVHhA3yTLnsnGYNmBK9LAtyFg3HwS3ugNNfRtZv0BJwKTSe3MyYt12pqRnP3HRMF8/IjbKo3ihh362rtcv+L5Wg9r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443322; c=relaxed/simple;
	bh=hcELpbwUs79w/4JpkCJTZzZv0RDESBqBk4p/yzxsxHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f1/nXvlMhxYccV9fqiHM8i+OZhnZx7uQ45t+dX8pfQ9G+9p4hoI45CqP38DG0BD8v5grMJNVwJ458yqr4YmPCHnAg/3Yj+wQdpOSi9oVfYTf1YRbqiHuZhcKKXojjl4CZt9z+a9lz9Gb5MCYCdLqTWHLtzpd6EV043uM7k6yVxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx7ndIVW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx7ndIVW"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso20929a12.1;
        Tue, 12 Nov 2024 12:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731443320; x=1732048120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2FT/0mZJivL0ZZoqfs7CNBIJ1ZIhmKypOpf5tX8Zgw=;
        b=gx7ndIVWzXg3+01oHfPLpld+SsADmFYp90Sz2OalnGGVEtb1PeeeYYc3AkYLEnV4kI
         IqnkUt8DFdJXn0pAA2DQkRf6NACQJacmHMiSf4vK8fkCUkElJtzNboQH4/zkgGdqxAtO
         DGmyRaClYIi/7PE2R7DX5Ty3KFohoXaWjx+y6r1pQVgZ+WlRdEk1FA8UldKz88xXEW2z
         SL7iPr4vkPFIURCy8HD7l9y1EPtP8xabZ6PXpcN1PwEM8SP+jkFsdOKyo5FKzd/CchrY
         uE0sq42RbJHPRrNBiBTkCFYq1z8NaF4MfNd0qec6jTPbEuHTLMFed5UFYAnhXmS2uQu7
         J7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731443320; x=1732048120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2FT/0mZJivL0ZZoqfs7CNBIJ1ZIhmKypOpf5tX8Zgw=;
        b=cvhCyVTGs+4CV2mGRFzFn9cEyTohM3c+rJWYoxLTnkynCMJgyxlbRJzr3wudJiJpiT
         z85GakGudwVlhGuOA6+7ko05phqjJ0DWJ2tXO/NJ218OV1d9HGGFJvFNyaYo9ArHIRjO
         WQLfHhMI7Ei7aJUhi9wm98FLnN570CurUrh8d6k4/FrA9IEqmDFDc5meQMjwoa3SJubU
         PCWzgHZ+Xtseo+Y5EZBUoj/WGSWL5LTSYlltoXmMxdWOQN27yMLoojfeeTePnsek3Ks9
         Kp/paOlMENX1YfPsmuVbarxcepUctEdzuSblJ1lK3Sh7ocznKCts7LYRHEmZb44gWxrN
         LdUA==
X-Forwarded-Encrypted: i=1; AJvYcCUe1zGNbSLxFaqAVwkiMKSYJsjnKV/irQE20jFNVWtyqS82OUBG2zVgftXmOqpPW/rqqXHeWKZ+JMvsiso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0x6lbGlR12zWpdtwmh+/FOPQoIps52QF3qtqZA5GsW001Z22n
	ClFt+NrHN0MP10WPs7XBjjyVERLGPTRjV1qSy1QbNL8INtbFUDK4
X-Google-Smtp-Source: AGHT+IFZE05j4koXdnVIsrWlQDXjIzpfwdaEM8dGhyz6pcxXqnrNsq+2+3l8Q0qtJRIUELTLwv5EbA==
X-Received: by 2002:a05:6a21:3290:b0:1db:e327:dd82 with SMTP id adf61e73a8af0-1dc232d87f4mr27396788637.5.1731443320448;
        Tue, 12 Nov 2024 12:28:40 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:23d:98b3:efff:2469:dece:37c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ff9csm11767600b3a.8.2024.11.12.12.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:28:38 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] video: fbdev: metronomefb: Fix buffer overflow in load_waveform()
Date: Wed, 13 Nov 2024 01:58:25 +0530
Message-Id: <20241112202825.17322-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an error detected by the Smatch tool:

drivers/video/fbdev/metronomefb.c:220 load_waveform() error:
buffer overflow 'wfm_hdr->stuff2a' 2 <= 4
drivers/video/fbdev/metronomefb.c:220 load_waveform() error:
buffer overflow 'wfm_hdr->stuff2a' 2 <= 4

The access to wfm_hdr->stuff2a in the loop can lead to a buffer
overflow if stuff2a is not large enough. To fix this, a check was
added to ensure that stuff2a has sufficient space before accessing
it. This prevents the overflow and improves the safety of the code.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 drivers/video/fbdev/metronomefb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/metronomefb.c b/drivers/video/fbdev/metronomefb.c
index 6f0942c6e..9da55cef2 100644
--- a/drivers/video/fbdev/metronomefb.c
+++ b/drivers/video/fbdev/metronomefb.c
@@ -210,6 +210,12 @@ static int load_waveform(u8 *mem, size_t size, int m, int t,
 	}
 	wfm_hdr->mc += 1;
 	wfm_hdr->trc += 1;
+
+	if (sizeof(wfm_hdr->stuff2a) < 5) {
+		dev_err(dev, "Error: insufficient space in stuff2a\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < 5; i++) {
 		if (*(wfm_hdr->stuff2a + i) != 0) {
 			dev_err(dev, "Error: unexpected value in padding\n");
-- 
2.34.1

