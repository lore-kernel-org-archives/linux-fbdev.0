Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81721348;
	Sat, 14 Jun 2025 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861896; cv=none; b=Ze5TfYe2ksb5+4LnYFTaTGWK+Cl+6/EakTpFcT/ng3DIzktx3QUAVZozFLIV2U6iS2hjlxqeQUgr+oSLFb/l3MztmUWg4hJ/tfnftgm+4nq+aJHrTElwJDDRvfxToZId1FTnrkcCFEhBKD9n13/Z3e6Ygk1p25zBUV2JXfted4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861896; c=relaxed/simple;
	bh=QjxExhgrl9lF8XR8OVzaUuJbjCmCwGrqDlGqJiLGARQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjhMBeqMHy8+h6XqmsW1QAN0I73o3L/DC/+vBJormOfCgwSRxLzdqI1f1Xyvb2NV9dhGhVL7wmGBz0fATV8+jlSALJ3C+RMlVrMvyvDiRdz4vRaUNbPjBJCer0p8zsOMezaylCAcr0kArFSgmkI9aEAs5k7b9zaOVTFVSBuSiOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuDwH3bC; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuDwH3bC"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e2b601a6bso28262647b3.0;
        Fri, 13 Jun 2025 17:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749861894; x=1750466694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4BvcwXUpYpF53aglFHdWaMYuKTVfMzFy1gAx/zcHH8=;
        b=TuDwH3bCPeXEKvs7AIbigTWOggHd9N6iWElg2TA02oRY3M6tq0bmulspS5x2nL4Q+f
         ld84JW923Dv3bEmL+7TlrUb6aTJ0dGptDvxxXJM0R5UnlBB2MG9zps83A76VTYSM7GjS
         lPOlTwfmEhKLQIhzMsSqZK4Y+cIl21u7tH2TSAIGONZ/JbOHQApWZgjZpCBOMwDFlYoq
         0BKrqh8B+XI5iGnkZoeCPcqN+PSn8RSpGl+kem9MN4X1pPXBWIczVT/GfwZK22CACjYi
         4MvvKckwZwAr5VcZPbVz60P9H1ZZTiDBHtBqoKD1lzx8xMgBtj4YmxL64OQYgXydvI9J
         s/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749861894; x=1750466694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q4BvcwXUpYpF53aglFHdWaMYuKTVfMzFy1gAx/zcHH8=;
        b=vLad17RvFEM8niWmvGRUQW/F37yuzqtibzH71SyYffLuwwyTSu5AMzZrj1ryjPPHCL
         0slWX638XSAokXyPL1DFjNmOntooUCE3efKBB7agNVsVb3kw62YGUkdO83mQay0DocVr
         8mwmM3afyVhB1TwJfiy9c+jpzggBvFkx7VywNqQiw00vh8iXSuSujVMUp18593bZ1+dy
         /7B9Jj63M9JzwuprFuflu2biV+BiMmRwJXOs+4qhfK10dMXOojubydw3coBsTE3SrqGQ
         DqWyVNoc2gYLrOBWYmbQYqFPnmmPFgSSVte6pRsVLPB8RHhRKMN5Mg62CzOfZpGdKEGU
         +WgA==
X-Forwarded-Encrypted: i=1; AJvYcCWrg3xPD00rCvknnHD42WyItnAUgGY92k7swrkQlh1R8wiIcxdv76Zo2Ef4EwT4iZfQcFnzZxCjm6uVhw==@vger.kernel.org, AJvYcCXRghmuJhamHgYSRqqF7aA78k/ZCQDZeDq+isgpedbeIsYQiZMr4X9blO5MWhgyFU4dJrGfyjFjW+7aQMFT@vger.kernel.org
X-Gm-Message-State: AOJu0YwO5WPfAdeZB/2V63TVFixU0FjV1eS0glFUWUOwZe8evBMcV85O
	L8k+dmtC/Ucn0R7jguspUJAqSiC50cEWwVgE0sr3nyeGRJSDxuHrTLs9
X-Gm-Gg: ASbGncu3JM3bbrB4Xisgkq2t2hsz1A8EaSkjOB9W+OaE/7gg6ZIaNDkf+1ru0N2smHz
	yct9lnOa8Z3FlIaOfjV0GrL4HSxY7Q+M70G5qjI2yI+BXhuJ351DEIXx0Vv2a5yWmn+FFrSzFPz
	LRVv6q8XdY/wqBFkSmWB9K5F2tqz24Sj/wcqB4oCbuKGygyIVnn7ciqKprOKzO2X15MPVA7vJrE
	lVhEkEmQpvUxfEoswUkkxgaFpn7I7zD1aZsxUOGVIfDYg5//IsNml2GxHwDCqgy/RxbBSbpvQOg
	wEcM6pGk9OlZ/SFGWNrYaVAKk0m1YDwNTKgF/C3WArIJtggOb3tQmgK36ndXRbvkVsG9hJdN1fU
	E
X-Google-Smtp-Source: AGHT+IGjLtwBG/qb8tTfi+EFfpRRiPz60v6QAyBpoxShxESQKaqfAUJV/kdfD3XI+ycQZ6HE2YHScw==
X-Received: by 2002:a05:690c:6c8d:b0:70c:c013:f2f with SMTP id 00721157ae682-71175492805mr22391947b3.35.1749861893645;
        Fri, 13 Jun 2025 17:44:53 -0700 (PDT)
Received: from trojai4.cs.purdue.edu ([128.210.0.165])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71152793dfcsm8421807b3.67.2025.06.13.17.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 17:44:53 -0700 (PDT)
From: Alex Guo <alexguo1023@gmail.com>
To: deller@gmx.de
Cc: tzimmermann@suse.de,
	alexguo1023@gmail.com,
	gonzalo.silvalde@gmail.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: sstfb: Fix potential divide by zero
Date: Fri, 13 Jun 2025 20:44:50 -0400
Message-Id: <20250614004450.3096366-1-alexguo1023@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable var->pixclock can be set by user. In case it equals to
 zero, divide by zero would occur in sstfb_check_var. Similar
crashes have happened in other fbdev drivers. We fix this by
checking whether 'pixclock' is zero.

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
 drivers/video/fbdev/sstfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 2ea947f57efb..fd387ca8401b 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -359,7 +359,7 @@ static int sstfb_check_var(struct fb_var_screeninfo *var,
 	int tiles_in_X, real_length;
 	unsigned int freq;
 
-	if (sst_calc_pll(PICOS2KHZ(var->pixclock), &freq, &par->pll)) {
+	if (var->pixclock && sst_calc_pll(PICOS2KHZ(var->pixclock), &freq, &par->pll)) {
 		printk(KERN_ERR "sstfb: Pixclock at %ld KHZ out of range\n",
 				PICOS2KHZ(var->pixclock));
 		return -EINVAL;
-- 
2.34.1

