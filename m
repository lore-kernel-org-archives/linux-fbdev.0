Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127A3FD4;
	Sat,  3 Aug 2024 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722644304; cv=none; b=ulsrLEpvkTG7wJfVTrGgnc9UoWqBxS+G0R04rbbKLvqklCMcLq5XjBgXU7L30TOewAj+rus8DRBM4usxbpWEwculKrkf56DCBi7QRto5g+8ReXBbSD26XRv9Q5U86R9pWmpPfSPCQMT57tDjserpMKwfgEbI89wr7MivrJmdMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722644304; c=relaxed/simple;
	bh=pAQgIkSRZwjkpI5gO2BydLYmo5HlIqcCrZ9VS8V12yM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n73DPjaTPsoPmQpvJwwcrlKHTLBMFyWa81wBAE0Xn+vX2hArDSvU1GdqLySBz8GJ+BXg2Vs/C4g7z+I0wJrkIeS3ERlKPwcuDmrXfGN6yMOZ2jAyq6kBgSNXJ7tDd1AWyJ5ydMBEEVJOb09Z+xUVgCZ6T2KwoTYK/+ecsVgTS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+/wgM1s; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+/wgM1s"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc66fc35f2so27582905ad.0;
        Fri, 02 Aug 2024 17:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722644303; x=1723249103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAWRuSmJKjlpvA4QhYPB4hwoTefNcdDnXSOAB90DYYc=;
        b=c+/wgM1sxmjXEZ5qcgsS9l6J/lpyXEBdNqLF+s+jLb53n51zKEuFg1ni+61VhCK0EP
         b0nNLRRupAt7X64rbqVylftET53QDkYuJHE0w2fUQhxyAJYzyHnvkPH8tsgew9KWRj6b
         ffjrl1RpN7POG2OT1eWT3f6S8AVtu1yEDeBNwWuAb5PVaImXwuOvvhiIa9nL/v4eXyFn
         jGoRaFscyV9lxaFPQw3Gqq3f2S6maIvIFtIu14+BbwdrwuYVYuzsWMTKeSdxJos1mHid
         bLZrJnlV61lR5pvnZWXjgWaROJO0It0sA6fF0VvyWZS0LLOSCuOZYUdnDf3BpUvxa8Vs
         OZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722644303; x=1723249103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAWRuSmJKjlpvA4QhYPB4hwoTefNcdDnXSOAB90DYYc=;
        b=rsHTzLCHVUFRMq8pF9FwABimeDvg4+TxLh91et68o0RbbtkBykK4SgMdqSjV83dTG3
         zfg6P8h8MaAdUNbed3eVoQSz2wTqgftANNf0uslEdb9NYOnaaNF13m4xkgQ0TeLYm2eT
         QEeqjNe2v70oOY1tF3IJnogkD0r0MZWkdT41/13EUN7P+NF4uB4ir7udFvjQQUOcPLoL
         CJu9ZPDqKOu5mv/AljRvUXTnL6WGnntHC1px34emuNJ9t3Rk8q3d0C8w/FEPF1AIbO36
         0fvubDHFae6hHyKXCqPSMJULQRFB1FKf7kYxqcZx3OpNB4C0pVd6OCA1Xnk/MwWhOVM0
         uUQg==
X-Forwarded-Encrypted: i=1; AJvYcCUDlba2vptHYenWWoiipI0UOquGeQVLIWizTolw801CRaG+Slo2z2CpbyfA9WO/nduVBXfKZQmo8rYCJtF2luqsjnzzNNF1I0OW0FkUQMQufV1w2Ac9+fO2rU8bSxG3sVGrXPNYgFq8s7s=
X-Gm-Message-State: AOJu0Yy+VQOjsEaSJg9o6ot5UJ1kG3AyoVE3Rti7F1lQAiZkjNPAx/uP
	9Zw0+yMIM2pVcXGGE6P+PTvnUE+oDIR26DJsiFNJC6WmZGQeVa0m
X-Google-Smtp-Source: AGHT+IEXMJ/xDGW0/TPd6BplXEHx1lumggDv01n9rtt4EZzLr+h7VIsu0WAr2fg3YtCCKSnHroS3ZA==
X-Received: by 2002:a17:903:41c8:b0:1fd:6ca4:f987 with SMTP id d9443c01a7336-1ff57bc504emr73575585ad.15.1722644302627;
        Fri, 02 Aug 2024 17:18:22 -0700 (PDT)
Received: from Riyan.inspiron ([122.176.204.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178248sm23542255ad.202.2024.08.02.17.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:18:22 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: vme_bridge.h: Document mutex in vme_dma_resource structure
Date: Sat,  3 Aug 2024 05:48:14 +0530
Message-Id: <20240803001814.7752-1-riyandhiman14@gmail.com>
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

Proof for comment:

1. The mutex is used to protect access to the 'running' list
(line 1798 tsi148_dma_list_exec function)
	mutex_lock(&ctrlrl->mtx);
	if (!list_empty(&ctrlr->running)) {
		mutex_unlock(&ctrlr->mtx);
		return -EBUSY;
	}
  This prevents race conditions when multiple threads attempt to start DMA
  operations simultaneously.

2. It's also used when removing DMA list from running list:
(line 1862 tsi148_dma_list_exec function)
	mutex_lock(&ctrlr->mtx);
	list_del(&list->list);
	mutex_unlock(&ctrlr->mtx);
  Ensuring thread-safe modification of the controller's state.

Without this mutex, concurrent access to the DMA controller's state could
lead to data corruption or inconsistant state.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/vme_user/vme_bridge.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 9bdc41bb6602..bb3750b40eb1 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -61,6 +61,7 @@ struct vme_dma_list {
 struct vme_dma_resource {
 	struct list_head list;
 	struct vme_bridge *parent;
+	/* Mutex to protect DMA controller resources and ensure thread-safe operations */
 	struct mutex mtx;
 	int locked;
 	int number;
-- 
2.39.2

