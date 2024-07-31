Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87E1A76CA;
	Wed, 31 Jul 2024 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411380; cv=none; b=KFeCazuqX2Sv0o3DhuOAp5gPhEZ5wHhne61fiBUsVzUgHMGEDbA4DJf3gAgST3J5wV8szlLD23Jf/1tOAo9pbB39b6l2Ckw0+bkmHq9Uwr1sCStiGybKsYv+t9o4pSVpy/fEzBxeMiz1MLT+RxyRp/ZyyE0ANnicAsxi3NqObi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411380; c=relaxed/simple;
	bh=Z0quf++gqajFpVICB5Q3/3pf9XLfHXdzDDlmECaMS0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pz5QBg2g56yKeuPisw4/1vopYjDuw8/ywShcjeC8kAq3cAQkgsrMcYtfFe1TpH92RaeXJ1LmlF/RRtMmjytAmBpBE639IsA9Prrcd2HUPpBGgekRsEBWQdJxorYVxrKGm3J2FBjU10yO8ByKqBr2JPU9t20WaHmc0c26IKsY3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuYFFgEn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuYFFgEn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc692abba4so38060325ad.2;
        Wed, 31 Jul 2024 00:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722411378; x=1723016178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lRH4DV0DJDUFsL+oAneJ1eExEHHJriff1ENVzKjdwVA=;
        b=NuYFFgEn/t8eNXRhtUrMCRBI6NsPBNvfJKJ2ImKIf28VqVpynGXO0/X0YxR9j7uYC3
         40bWoPAx07NHUsZjiPkxu7EH77B5HTUB+NGmqEM4aRxnXTuBaM4+JxVTKI7mYWDC5LHS
         +4UXo0Mkubc9qIM9Ts8W8QQReTbPX9DpOE58gyWiX1UptWQcwFdoglc3TnPsaLtNdv/U
         o7Q4GKNYPHQALTX6yDp0qYDyc8vB9bQz1c+V+/B5pApHWIf2PLTUgIE7sM6UwizhlUme
         vTZr3YPt+VK/4HXyiVEmpbWdj+TzrstX+PTnQpuJT1w50TmiYYBXG5TTGhitVtYQpwxS
         jzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411378; x=1723016178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRH4DV0DJDUFsL+oAneJ1eExEHHJriff1ENVzKjdwVA=;
        b=Oy4EnUNKz5zqikNl7ZwSGXFmEwyyCoQyHEC33vyfQ7yPKYN8mjAo362r2+sqYrbj/K
         HXNrc+l0qUExAp6nuhckYxcDDUJZCpDsQV9qZM1mr/3E7K6mQkBKUPDmSsHJuSC2JY2o
         9Z7HucorGqJs2qa9OhUgTm8HTzfZJvVjpy6pgh7R0elE0jYjP2bkcf7jIse5ELmWazBt
         OqxVPkiGsIG2wmpoyYYyc6khVzCkdOk39bUxz9l8SEzN2CgqntMZYn8Uyuzxi9ZBxvst
         +VwFvenijI8Q1ATu4hCtmoeI+0j0manl5tkd3ILYr68b8L4F3S34Y9NVCZr+/KhbU1GE
         jXaw==
X-Forwarded-Encrypted: i=1; AJvYcCWv0FnLbhGy7C1BmciDP5k14R9hTplZDwjoB12dpS7zRPIgm5QBFWxTQ9+xCXj5DpejTCLL+GhQnIDD5F7fAaBBgt95WgXZzMG28IxNWiKi9VInNAFEu1RigScPpN2hlAxnuwvJ5sCaObU=
X-Gm-Message-State: AOJu0Yyo7HzJy5j6FlL9OVwWANm4gI5Dq8MWRc152LRXMbA2f6tlFNHb
	zNqvcR4MXgOdANO/GWv1iGqUuNyWyFIRnDjJ9thhAKlQd+QsCRv0
X-Google-Smtp-Source: AGHT+IEceKTtYYEsOkXyN0s0CRHubuzO4J5r0XPfOvSvOHmtwtPrADzOS1FSoHURcWoeZWH3v5Mn1w==
X-Received: by 2002:a17:902:cec3:b0:1fb:779e:4fca with SMTP id d9443c01a7336-1ff047a5335mr138685625ad.14.1722411378005;
        Wed, 31 Jul 2024 00:36:18 -0700 (PDT)
Received: from Riyan.inspiron ([2409:40d0:1028:df3:da0:ae29:34f8:4b4d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1b7dfsm113401935ad.189.2024.07.31.00.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:36:17 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: vme_bridge.h: Fix mutex without comment warning
Date: Wed, 31 Jul 2024 13:06:05 +0530
Message-Id: <20240731073605.9857-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style

Reported by checkpatch:

CHECK: mutex definition without comment

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/vme_user/vme_bridge.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 9bdc41bb6602..0b1f05944f0d 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -28,6 +28,7 @@ struct vme_master_resource {
 struct vme_slave_resource {
 	struct list_head list;
 	struct vme_bridge *parent;
+	/* Locking for VME slave resources */
 	struct mutex mtx;
 	int locked;
 	int number;
@@ -55,12 +56,14 @@ struct vme_dma_list {
 	struct list_head list;
 	struct vme_dma_resource *parent;
 	struct list_head entries;
+	/* Mutex to protect access to DMA list's entries */
 	struct mutex mtx;
 };
 
 struct vme_dma_resource {
 	struct list_head list;
 	struct vme_bridge *parent;
+	/* Mutex to protect DMA controller resources and ensure thread-safe operations */
 	struct mutex mtx;
 	int locked;
 	int number;
@@ -72,6 +75,7 @@ struct vme_dma_resource {
 struct vme_lm_resource {
 	struct list_head list;
 	struct vme_bridge *parent;
+	/* Mutex to protect LM Monitor resources and ensure thread-safe operations */
 	struct mutex mtx;
 	int locked;
 	int number;
-- 
2.39.2

