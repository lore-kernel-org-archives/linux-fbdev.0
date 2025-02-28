Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E5274264;
	Fri, 28 Feb 2025 16:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759847; cv=none; b=mzkCjgITk5TtSbI1mKZvPfDsM0u4G90PPMZZ33Z15bvraghtk74TbX1KLKbm55zECwsfOMlnxu+BjFrcDeggugUkQ3BjxqQIP5tzHDih6tX+b6d6uacTnnnLDVAtdg/r2XPMJaRlV3TO8Q9XbtOcj/qDRdNN+ifzUyzoFKiq8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759847; c=relaxed/simple;
	bh=vw7uvbl/KnjEf50NZ9ggW2ca9g1yuG4sjfLATHQRM0I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=H7Uk/jfll1FffFFsU3iM9VH/BMVUw4nk6oG0kZmQflMuFW8MzRiP9WG5y68GKieu2emoNaz+DpyxKg/oXeFRUHDvZUKfDknS820NaksfX4i4KtVEery/kL9GGYoezz7JEEVd6zwMBe5m3aX2jYlmvHrdRaVAKsTsNoni6ST5GlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7A9axOa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7A9axOa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2211cd4463cso47442765ad.2;
        Fri, 28 Feb 2025 08:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740759845; x=1741364645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZpdt6SfKLnffkI9zi8NmCtVZiMpf5sWSLXSEwyV0aY=;
        b=G7A9axOaYwHF6k071yEniZyuO/5tp+ZF7v51xFrmqGCJrzQSPEIaRm7PcIU6gz9iSl
         BJ2YOs6kOWW1NiKoXjLuufNiKIi/O/+r69Rb2wlUwbHTrZCUCXU+8yF5J0EyeTgX6CUS
         v+B7x5q6EsPF6qtJaRnFrlQukjJplinLuXJ3L2SDNiozP6EjnbOdRitEWR5LPXGmS/O+
         poxvx+1Y3mTBR5685Rh1OFe/UI6vBLty7355Txw3jEzseWduAhvU4ws8Udv0UwmZqUhj
         Zz7D7c+xYVktWmsisnwA+2b7p5a5AKL7BupF1Q9PxJfblk/YPFC31w1Blt+USqsYFyz2
         nWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740759845; x=1741364645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZpdt6SfKLnffkI9zi8NmCtVZiMpf5sWSLXSEwyV0aY=;
        b=KBwEZPRbLV6wgz3e2A0cdylFyLC1rE0n0Kcxp4RO+PuWeLj5Sp65lni89SI5FKVDGa
         Xk1t/MFZU1tj6bDvIbI7qWiHQNh5HiCQ/VLHpNiVXl8emLhQm3UJ8F2y1qVfXImkVqRx
         4Cgys++mjm2rs9myqoEh0lC37t2MkZvIIvGdmTHWg7u34QoscHureq4LyvXwOtF9Th7L
         jgjHnccaiB8eQa/FpsVitgl0t5zs+uYnmVFfU/5TUvlAvQ8Z4wW9wRLu86erZQ8aH5X5
         sfeqbTv7+0+Tzf4SgfHycpTrby9kCL5lWQ1Ahw6Bdrr0DDcHWW86YAii3SDCBdFdCCx7
         QLtg==
X-Forwarded-Encrypted: i=1; AJvYcCUAqBOKBSRwAhTTkbngyDY/WHXhQrPwSxeQ1EyaIaFuwJf7GOiGlmqdK+BmCXL6X/PrtdbwoPl2pVcR6lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSh3n0RoY+p2VKmq7IpZa7KwN4bgomLf8OcgOvrXPy65PBClX
	aWGZP0U3IywrhcAOvSuCLzBjNodDAOYs9KHq0M/aJ1FpRjFws2T2hmJd4gEA
X-Gm-Gg: ASbGnctvIl2vGbLOtf8kxn9WInuW9O8oqYuh/jXQQLI7K0pHnfAW3NGUS8Xoce73jB2
	edmtr0IAx5tHpGymHsMnVcSWmtfCZL4NjYZid9XZjkRrtgdz/DiXdDgQpjyiBSefaCpl7cjpY5h
	PLbUm8+Kh5A/Aux1ATq9/nLe0bYnadtDLNKq/eg/b/43HltxCzKqvmxx9g6RXOO85aRynefd6wo
	j3KFfO8brwu8SaFNeA926Fa8t664x2V+DzyBMloA7vNoaFbyo2qdbbvBozZe4ygmMN1Ub3LygDz
	zrkWADMfkbX6VJbe239Ss5mNVuF8V/6O
X-Google-Smtp-Source: AGHT+IHrtOlJgkuMI5Re9PzG8aqsWYDH3G9O4iLan31cBeWX+IS4/S5MnY7luo+6Iswn9cjuJoEaTg==
X-Received: by 2002:a17:903:98f:b0:215:9894:5679 with SMTP id d9443c01a7336-22368ac4102mr65842995ad.0.1740759845165;
        Fri, 28 Feb 2025 08:24:05 -0800 (PST)
Received: from Grommit.. ([2804:7f0:3f4:eda3:51e0:e6f3:28de:c05a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0024d1fsm4084725b3a.103.2025.02.28.08.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 08:24:04 -0800 (PST)
From: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: sm750fb: Fix CamelCase variable naming
Date: Fri, 28 Feb 2025 13:23:54 -0300
Message-ID: <20250228162359.14029-1-lima.gabriel.luz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Avoid CamelCase

Signed-off-by: Gabriel Lima Luz <lima.gabriel.luz@gmail.com>
---
 drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 63c9e8b6ffb3..33e852fe6949 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -3,10 +3,10 @@
 #define DDK750_POWER_H__
 
 enum dpms {
-	crtDPMS_ON = 0x0,
-	crtDPMS_STANDBY = 0x1,
-	crtDPMS_SUSPEND = 0x2,
-	crtDPMS_OFF = 0x3,
+	crt_DPMS_ON = 0x0,
+	crt_DPMS_STANDBY = 0x1,
+	crt_DPMS_SUSPEND = 0x2,
+	crt_DPMS_OFF = 0x3,
 };
 
 #define set_DAC(off) {							\
-- 
2.43.0

