Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D41CEADB
	for <linux-fbdev@vger.kernel.org>; Sun, 18 May 2025 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747606214; cv=none; b=MRRLML/a+LuIJ0ot0iQ2ALXL56gu/1nErx7mdgPTmhgRRYhfUSsCH2q/VRXLlXrAttjVjh9Wh8hWSgViSeUJoXiSTF8bUFudyU6KjeMAdJNssHxQXZcUbTM9BJSFw3ryQG7oQRG9j5uEyUC6RtXIEfXHfd5CqtDpY2je8PK+LwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747606214; c=relaxed/simple;
	bh=RlfQ7Sl9w5x6XC3rRVXrwDjFJLRI5opWfOuqy5T9x0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UJcgDufWjZ2oLJ7duARGnvJSGQrEad8GagF2tz4heK15N2wjfbE47LFuU6WLmi8jg4eZak1kv1GsvD0MEVe6FlkulFAaOn79ZvENpdxr5tag8Xz+U6S2kCE2gpOd1eeve1P7TaosVHghjHxNCSif/bqYJiWnaW4D7R3mjQfyzoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NK7nCVtV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericflorin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NK7nCVtV"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73e0094706bso5060476b3a.3
        for <linux-fbdev@vger.kernel.org>; Sun, 18 May 2025 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747606212; x=1748211012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYWWA92r/lnE6mLiwOw7SOEtSivOca0z811KglLj8l4=;
        b=NK7nCVtVMjqrY0OZU395EqIixcQxTT0tAHqChv4BCAHF9LPo7I9yTE148pQsCQS7RS
         Jhm6iMoBlaGdmEZgSMIh6MDPKQZDPlML84QnhrMsdbk/3pJBTIo/mLP0T75luqwR+uie
         vY+75OGxTH9C6ThlfXJfNeZ+rdBZpsUquuu+jouTKcORfP38+Livf2EPq6VYFRbQBHtG
         mNjH7k3vlViMvLDeRabCYwz/WBI2KCstkKjTDILz+/KoZC3xs8XBa71SkolodjBQEqkl
         MpPErt5D16x54Up75DM5FEYWgkYEIkEwuAUN9MPyFwi3kmHnkp48XUkebDl9cLefbq2q
         Yn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747606212; x=1748211012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYWWA92r/lnE6mLiwOw7SOEtSivOca0z811KglLj8l4=;
        b=UqlzV9WeQmcpuDBFyoXtFBDPiqMCo3KovNmt0i6p7W+1qoDgYwOf801Xarxp+P43je
         IlfquzI42GLXA/dreofTLzIl26hJqayfX/rlRG5SyaYA52gkfy0ujhVOrCreK8JBQgdS
         se03Qr4iRxAuy1xKS3nCpOOpFgdIleNa2CYmZ93CdEX+7oxWXHGFlKshQv8BSu4cjU7A
         qh/T3c9tJmgg0eE3LUyRFq1E84Knz9b5dZ+RLw3sdXbUuKg51+vZ1nfMPtLwSetvqSNm
         7xpKmapigz9oxSX5MTKwsAC5KWgnTpwbPsIBVaGflHnZQUSNKPuSi7b5Xb0E6TXY6zii
         Geqg==
X-Forwarded-Encrypted: i=1; AJvYcCW+OV22Z1dwAmtLqQELaZ59ZNjMmTMYfWES8Vmq2g1RLFLcKxpmbfRWT4g8WvYrEv843/hOLHB8G8o5SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxbgFYvc2EowHpOGvUj9EHaPTlb4gFXlAnlG4NL0Q7V+beyYxB
	ZrHfC1m+1Ws5yMjgyvaf7lXCRP0nicVIUmN03uUC1jUK1nt/xJ9aAJx5pZIW5BxQgT8egeA6XtU
	PrZFbtA5C+Wg8TyNAgUDvfQ==
X-Google-Smtp-Source: AGHT+IFDEIjm3DAQ9auq4uM8uVG5ZGZ5EZoujr8el53HHhvTwmDVNTZeyCi31Dnb2f99N5E4a/jdjzSSCSIJNaWq
X-Received: from pfqg8.prod.google.com ([2002:aa7:9dc8:0:b0:742:9f9a:bb76])
 (user=ericflorin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1790:b0:73e:970:731 with SMTP id d2e1a72fcca58-742a98b2242mr15775081b3a.16.1747606212313;
 Sun, 18 May 2025 15:10:12 -0700 (PDT)
Date: Sun, 18 May 2025 15:09:46 -0700
In-Reply-To: <cover.1747605658.git.ericflorin@google.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747605658.git.ericflorin@google.com>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <d4b30e00ca64a233efc2a7dac4bc568186dafc71.1747605658.git.ericflorin@google.com>
Subject: [PATCH 1/2] staging: sm750fb: rename dprBase to dpr_base
From: Eric Florin <ericflorin@google.com>
To: teddy.wang@siliconmotion.com
Cc: sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Eric Florin <ericflorin@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename `dprBase` to `dpr_base` to conform with kernel style guidelines
as reported by checkpatch.pl

CHECK: Avoid CamelCase: <dprBase>

Signed-off-by: Eric Florin <ericflorin@google.com>
---
 drivers/staging/sm750fb/sm750.h       | 2 +-
 drivers/staging/sm750fb/sm750_accel.c | 4 ++--
 drivers/staging/sm750fb/sm750_hw.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index aff69661c8e6..a2342c69a65a 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -50,7 +50,7 @@ struct init_status {
 
 struct lynx_accel {
 	/* base virtual address of DPR registers */
-	volatile unsigned char __iomem *dprBase;
+	volatile unsigned char __iomem *dpr_base;
 	/* base virtual address of de data port */
 	volatile unsigned char __iomem *dpPortBase;
 
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 44b9e3fe3a41..97791f1b0123 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -19,12 +19,12 @@
 #include "sm750_accel.h"
 static inline void write_dpr(struct lynx_accel *accel, int offset, u32 regValue)
 {
-	writel(regValue, accel->dprBase + offset);
+	writel(regValue, accel->dpr_base + offset);
 }
 
 static inline u32 read_dpr(struct lynx_accel *accel, int offset)
 {
-	return readl(accel->dprBase + offset);
+	return readl(accel->dpr_base + offset);
 }
 
 static inline void write_dpPort(struct lynx_accel *accel, u32 data)
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 64b199061d14..159a5ad621f2 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -58,7 +58,7 @@ int hw_sm750_map(struct sm750_dev *sm750_dev, struct pci_dev *pdev)
 	}
 	pr_info("mmio virtual addr = %p\n", sm750_dev->pvReg);
 
-	sm750_dev->accel.dprBase = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
+	sm750_dev->accel.dpr_base = sm750_dev->pvReg + DE_BASE_ADDR_TYPE1;
 	sm750_dev->accel.dpPortBase = sm750_dev->pvReg + DE_PORT_ADDR_TYPE1;
 
 	mmio750 = sm750_dev->pvReg;
-- 
2.49.0.1112.g889b7c5bd8-goog

