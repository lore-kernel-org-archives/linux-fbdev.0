Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014AE16938C;
	Wed, 31 Jul 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409519; cv=none; b=K6Mm9nvb4GkXDi9A4Ot8hIlo5J+kMhCj/KWek6CqInOcY1UZZQYAU2BSWXhloQSITi+QKVHEDGXz0WWkrortentsSyVIR3DQ/qNciPizRsvShvIOYcYEFD8+rjJ3Rm4sYAWReKadStsiw/54y3w96ROofWtWnEmGIdbrl2ERqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409519; c=relaxed/simple;
	bh=FonBXi+Q3MfNSZ+aBoUgss5VhQKs37vqijFK12+g2IY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=beWYpddB8um1jwV9VBikwscHcFbzQgSZQtMrJ21u8RQ8toYjG8ehq8irqq4pwoaWTeRHonXwumwfhmY3/asFw680gJA8M3/0WvZ61do6v5AX6Ld4NYCqoXSTSjmtLryfQ8AutSXErCv70SwX0plxVm1q+9iz8EdvKeZXBXuOo9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiRuR+9Z; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiRuR+9Z"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3db23a60850so2835098b6e.0;
        Wed, 31 Jul 2024 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722409517; x=1723014317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrCAXXCSMmjbL6R33sl32ct6gbQlsIym8nsT33zM3Rc=;
        b=QiRuR+9ZkthR3axb2Br7v9FCCWo4z9d3iGIXXVPzX3VUYeD1WaeKAR7It3AZvRv6Gp
         kdWIneqDbVo9uy6i3MconZZtm+s9i6yw/HyvBh141ijM3/6q0APkf/Zs/A45QK6H70oJ
         sd/xcisnVqoflNsa97Quv+C0D4Cz3wGtM0X8wAClTfNOxh1nA7xA79DnULD/b9rIlc+a
         K2cpu3G3Jdg8L8Mhfy80hIKcerUiCdbf+DNd7Rr2xcRfE+bQbHAVHhx3V/s0grLYhdFc
         hlIvvBprhtyexbGSNe2DlVxuT2M0upnrEi5eAFtcVTaOuWqfaWLe/4c6iuk+3p7d8MDA
         nm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409517; x=1723014317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrCAXXCSMmjbL6R33sl32ct6gbQlsIym8nsT33zM3Rc=;
        b=xL2Pr7hpkk5TqQkBgsQwGHsrSn5TRHP+Y+mGfKslloRyznB5ucH0gDOV/JPNJ695AG
         l12qe3AcdNmYy6hQ4e0q+DeXkyvL1D3iHt8fQ9s2IBk3yLxEMVWU9/OV92zfPFeq6JPG
         YgSBo1pLh5PLcQbE4H4pEII9+hZY7X2AkoG8jFScJiY0s56kloPwVQXPDhFDg9MoYLBI
         NJV2lo1/zEA3+QqjmtFEoQcDIot2V7HRnjC2wwfaUYezmoZjz6nQIwQNyPtWgUaBcLIm
         7RGtCY+viYXBFO3DYDd9JUQzujf76Ps+NVOz/VtIa+02dwXvBqCI+LJ8W1HftwsRUnRw
         UpBA==
X-Forwarded-Encrypted: i=1; AJvYcCXGJdgQVeNEHyiv3DMyoXxxr+S1z3w2UUeFS0DndVW/x9symTVyZpvyUPS3uhL3sFUCfptdBeF6U2O2UBk1V5Ieatkl+2b4X4OzalHS87Jgoy62rLqTRf07oPTp1W1J45etS0Z3f4pyznA=
X-Gm-Message-State: AOJu0YykMwytUqlL9+CjY4DtN9rAYb8O3SqX0vL5oceokOHrWKRd1Pf4
	Bc84svrCB7RMYNBK6Y64y4HhfgEZDiOC/YdKvGaFUgiT0SE7o0ck
X-Google-Smtp-Source: AGHT+IGr572fiibvBQPX2H/P2UU6sDQCN8guL81ZBr4lGrTb8rxtV2x6+RVC46jqxQD7x55AYK4KPA==
X-Received: by 2002:a05:6870:2d4:b0:261:198f:13cd with SMTP id 586e51a60fabf-267d4ef04e5mr16428624fac.32.1722409516886;
        Wed, 31 Jul 2024 00:05:16 -0700 (PDT)
Received: from Riyan.inspiron ([122.176.203.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead7120f6sm9447234b3a.50.2024.07.31.00.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:05:16 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: vme.h: alignment of closing parenthesis should match open parenthesis in function declaration
Date: Wed, 31 Jul 2024 12:35:07 +0530
Message-Id: <20240731070507.6290-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/vme_user/vme.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
index 26aa40f78a74..7753e736f9fd 100644
--- a/drivers/staging/vme_user/vme.h
+++ b/drivers/staging/vme_user/vme.h
@@ -129,8 +129,7 @@ struct vme_driver {
 };
 
 void *vme_alloc_consistent(struct vme_resource *, size_t, dma_addr_t *);
-void vme_free_consistent(struct vme_resource *, size_t,  void *,
-	dma_addr_t);
+void vme_free_consistent(struct vme_resource *, size_t,  void *, dma_addr_t);
 
 size_t vme_get_size(struct vme_resource *);
 int vme_check_window(struct vme_bridge *bridge, u32 aspace,
@@ -138,20 +137,20 @@ int vme_check_window(struct vme_bridge *bridge, u32 aspace,
 
 struct vme_resource *vme_slave_request(struct vme_dev *, u32, u32);
 int vme_slave_set(struct vme_resource *, int, unsigned long long,
-	unsigned long long, dma_addr_t, u32, u32);
+		  unsigned long long, dma_addr_t, u32, u32);
 int vme_slave_get(struct vme_resource *, int *, unsigned long long *,
-	unsigned long long *, dma_addr_t *, u32 *, u32 *);
+		  unsigned long long *, dma_addr_t *, u32 *, u32 *);
 void vme_slave_free(struct vme_resource *);
 
 struct vme_resource *vme_master_request(struct vme_dev *, u32, u32, u32);
 int vme_master_set(struct vme_resource *, int, unsigned long long,
-	unsigned long long, u32, u32, u32);
+		   unsigned long long, u32, u32, u32);
 int vme_master_get(struct vme_resource *, int *, unsigned long long *,
-	unsigned long long *, u32 *, u32 *, u32 *);
+		   unsigned long long *, u32 *, u32 *, u32 *);
 ssize_t vme_master_read(struct vme_resource *, void *, size_t, loff_t);
 ssize_t vme_master_write(struct vme_resource *, void *, size_t, loff_t);
 unsigned int vme_master_rmw(struct vme_resource *, unsigned int, unsigned int,
-	unsigned int, loff_t);
+			    unsigned int, loff_t);
 int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct *vma);
 void vme_master_free(struct vme_resource *);
 
@@ -162,13 +161,13 @@ struct vme_dma_attr *vme_dma_pci_attribute(dma_addr_t);
 struct vme_dma_attr *vme_dma_vme_attribute(unsigned long long, u32, u32, u32);
 void vme_dma_free_attribute(struct vme_dma_attr *);
 int vme_dma_list_add(struct vme_dma_list *, struct vme_dma_attr *,
-	struct vme_dma_attr *, size_t);
+		     struct vme_dma_attr *, size_t);
 int vme_dma_list_exec(struct vme_dma_list *);
 int vme_dma_list_free(struct vme_dma_list *);
 int vme_dma_free(struct vme_resource *);
 
 int vme_irq_request(struct vme_dev *, int, int,
-	void (*callback)(int, int, void *), void *);
+		    void (*callback)(int, int, void *), void *);
 void vme_irq_free(struct vme_dev *, int, int);
 int vme_irq_generate(struct vme_dev *, int, int);
 
-- 
2.39.2

