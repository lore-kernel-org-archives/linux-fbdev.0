Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AF2512FB;
	Fri, 18 Apr 2025 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744948368; cv=none; b=j9VbXIU0YPUozpeW+fNWuFIwmc3ZkaKKbAwJpD0yU8MXv9RrL97uUJcjzQV1EAmlR3v7YJ7+3GrAqmZTgJMZIG0ISHHJyTvef4cJ41p8+st+DPaoU83wXfLqNXzKWJIKAtoGPqyfrcg5XvvcRAuYNOtHOjYJKJMFXlyEP9UcW8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744948368; c=relaxed/simple;
	bh=1HKTn2EglAYTCuaBXWT35oX2outJLa/J/ifrSlkV4kA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HFaNscULyB3ZAXGLLKjmzcOkclsAQkJwgWG2khKpUOKwdxED8NBtIXjnPvJZl6I6T8K5DcL/kJZ3qZf8/w4HYv0wicsONV4Dm/bz2FoQvNJoJihwZ75rGQ7LbXiz9rgVDluq2j22XcRGuFwfS+JNrkbx/Swk9i+SK+8p9Gs0g8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAjkxiLA; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAjkxiLA"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-af5499ca131so167940a12.3;
        Thu, 17 Apr 2025 20:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744948365; x=1745553165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2J5dQ2/PrvjaVhqlG1x9qQJqPr5ZU/HRgzC2aAsxKHs=;
        b=KAjkxiLAcGSKb/81HeDa6MOHE/OgitveliloU+Yz4nNBeSbvsXE21NibejIcYN3wBx
         m0OrKsVZcfgn1xD+9pNvEI/QS+jUvNWL7aK610rfJHbF7A9fAidLYPtWvaj4IHCHk1Xb
         dDwTv4onck+TiBSDHPXuGVYtyfD0E0kFYMTAHA+euWgZ3ijwRCz1QbLF9oUadD4KLsws
         +e0Gd6bHwXcSP02gKPS/55JfEvSXceAn+27Pw2wU02P7v17sVpk9KO6PWLRLvrpUQhda
         DTtfiH7URud4X5V1QD38r1A7K4ptP6jToruW+5ARmfLqXuxffYqIAhJe6D+2fz3dAWX/
         JySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744948365; x=1745553165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2J5dQ2/PrvjaVhqlG1x9qQJqPr5ZU/HRgzC2aAsxKHs=;
        b=GAORtn+1dVOYk8GrtknDjjeJAZ1kcSibCE/2aIja/6IZzQdxhXhybTtOpkkgV4MlqY
         lcRtKnk8snl9K9t37OYiGGaWxMJvAsF5mj56ui8tYFA5lBBHHiiudSudcQe+QXA6NEJk
         pJvIKXmfp9KDheWrPDf1PlVPRo/d4wlv63iWjjrczmYV5lMpR7cvTVimtKaEdOmw23r8
         fgKQUzOPYjGm/rLPybMXArhazBU6BDwAm946f6SQH8k0CGrJdrdibyRyiNZvkxaJRDK6
         xpZwIRtGtje+wMI1aUnknFeaWRl0bf5juJUNpZK1PJ+5aqBBEdTUgdNcvgupf3u0tfZG
         9Acg==
X-Forwarded-Encrypted: i=1; AJvYcCUJXUCxLJF8NwnfiSBWHBzRdzGjmjZVRHtTUtgsWmr9O81olCraBT9UHAl7rS3+Vs8T9KLYCMr+0VBLyPKx@vger.kernel.org, AJvYcCUbW0pQitx7ihXXjpMQfEHTI+sjmJxwexbbAGYcZ8NZKzFFWH7+hjJ4/zK0TosOFbd+pzi7HRa97D/+4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXOI6KFEOXHou5dLrOXTo3OOypWNBGhXiK3uU40/E1BqaAdIE
	+9kjvKlVmk4jeffws3jC+tAyNM8zQQTIo6FTe7K7O86jPv7xn7fu
X-Gm-Gg: ASbGncvLDxmxqo3RMHXC9DeTskiCCw2FZhi3N+u68nhaUiTup1eEYaFEKl8RO0XW2J5
	dXOFQGpTdHwJQVuOu/VbX3IVRpw8+JQiiFIu3fpOaF1fAcTYFrH17sdnugVrvpc3BZ/C0EMcBf4
	AORGmuSIJIVCA87njE+7DrSly29jd5p4xrsyRdMBtEcw1eOEm8r0eIPvKhS15pqYG0E40MWnwt/
	O8O9qQFPFsnoTgw0Th4YEEg8xriZ18iq/CRssvXeowgaAoOFTI0tfYq1htarNK+EdBZY4YUmbW0
	vKRqTvLOckJQeei949KTLQozDcxHmz516hyiQxQx4xFr1tEo8uFqFMNh7lVu41O55uu/iBf/3O/
	mJWHzNgf0AnwIuOcH3oMU5mo1nJeFzE2igeVKVZ7U7xwSX6UD6rIfQsM=
X-Google-Smtp-Source: AGHT+IEf8BcieBW0lj/bJ4dLQDQM3ev773NtVTtH+NHVZsyy1jn4grCRfDQO9hb2GITMPvEINmdVpg==
X-Received: by 2002:a17:90b:4a02:b0:305:5f20:b28c with SMTP id 98e67ed59e1d1-3087bcd3fedmr717176a91.5.1744948365397;
        Thu, 17 Apr 2025 20:52:45 -0700 (PDT)
Received: from kerneldev.localdomain (162-225-124-171.lightspeed.sntcca.sbcglobal.net. [162.225.124.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087dee889csm273853a91.2.2025.04.17.20.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 20:52:45 -0700 (PDT)
From: Eric Florin <ericflorin.kernel@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Eric Florin <ericflorin.kernel@gmail.com>
Subject: [PATCH] staging: sm750fb: clean-up `else`-blocks
Date: Thu, 17 Apr 2025 20:50:23 -0700
Message-Id: <20250418035023.27067-1-ericflorin.kernel@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean-up `else`-blocks in `hw_sm750_map` that occur after `if`-blocks that
terminate function execution.

Signed-off-by: Eric Florin <ericflorin.kernel@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 4bc89218c11c..64b199061d14 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -55,9 +55,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		pr_err("mmio failed\n");
 		ret = -EFAULT;
 		goto exit;
-	} else {
-		pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
 	}
+	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
 
 	sm750_dev->accel.dprBase = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
 	sm750_dev->accel.dpPortBase = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
@@ -84,9 +83,8 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 		pr_err("Map video memory failed\n");
 		ret = -EFAULT;
 		goto exit;
-	} else {
-		pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
 	}
+	pr_info("video memory vaddr = %p\n", sm750_dev->pvMem);
 exit:
 	return ret;
 }
-- 
2.39.5

