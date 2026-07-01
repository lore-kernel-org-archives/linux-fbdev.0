Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A08035E1CB
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Jul 2026 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947833; cv=none; b=bpq+lIfvWei6xSi63E03V1cBx85ruwGVDufuqGe4NVYnZUZT8izilYUVrkNMZAQEmRGUsN850G/uzDigUGE7gBL6/P0sZBdc+2miCo40DSaEeo3I3deR+cw+YQ9YHt3UoAr8NIlyL6xki5Z4cXCTAnHssP7l8Nv2u1RNGv7twuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947833; c=relaxed/simple;
	bh=eZBBq1HJLKN1iFZg5sW00tht53ixilfzz3xm89z6CHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovED3IPW8dlWBFZ+WypLc3F34ejvuThlg35aCEgfCj2PYtiSB8jw5sEaBbMjQl2GQkSGCL4zxD8ychndKP/EN3Hl7zsbaWrjLwF2glOAifcsPYTxKXA9dCRiLZkjiQZjbIhk0YrZpOLw79GHsOPGEAnIaNtFT6qlEIkcqGwDEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpkH1ZIy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpkH1ZIy"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb11c7347so976692e87.0
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Jul 2026 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782947829; x=1783552629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlV+b2hyTXngEK/PbvCEICZBOhLaT4J0DD/N8TVmLnU=;
        b=UpkH1ZIy72vJadPxiB6K58Q8OOrsHMc7snhXQsogqpVIUCNWsNB2VgR0M4ITnbl9Vv
         +tNAAZzGbqSasGhCy+Lt8KwfEWIgxxzVJq+RJY67GP5lBKqHaOn/pmvX6yYBtAf3iAR+
         2E0g7Y3bXgp6h3xuvtq8mu5z3Q1NLFZxnzAiwxzkBDM4DKjYuItBm063EtMp9Bj62eT0
         ZUgYMmoNso4ChoU6xTxuATd6dSXN7fpadclQpu5DesaR8v86zwi+6o/uFY7Z0qOcN6HU
         viLZhN6GM18qAkigJbYEl62RfCODyHHGyPUsZRLaFcHDIfzLuPbtQNHVfL9KeaZ59ADp
         awSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947829; x=1783552629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BlV+b2hyTXngEK/PbvCEICZBOhLaT4J0DD/N8TVmLnU=;
        b=tVS6dyv/i2gx+urkdcTaPAXUAFRtbFFru5XuJUivEm8HK/YgSXrHb64gUInohpoyZD
         Gv2Zz3LmAZo+decVAjyjBCUovmsocoKVA+B+BROg6cDLxNJO1dE/LSh0iSO/hu020bN2
         bt4IbLiMa0PsQxvkKrbuPa28KMBHfTsTxz0jAFeTjKLHiWZOzaqkjueA5QSMnarxDm0u
         CIPIs4WWTGtQiMolb9Q3NIRIjcleB6tBRylChdP8CTbcL93dvhqx0r1D4wLOVG3vW3/y
         fUlOXNMf6tJ2IClKwz8+X0YF2S7Z2hRW5zO/siA+Vqpy1HkgYhqRa0di1an6cv7S9z2q
         sQWA==
X-Gm-Message-State: AOJu0Yzr5vTfQuVggbkLGr2G46YYcvPa0NtgUoFJTL1gfvl6e86N/+my
	brA+vbTQKpeQoxvutPlX+0mvS09u4kjvS8iYngXpi2X8FmlWGnh9jzylzHVhNADL5eI=
X-Gm-Gg: AfdE7clEDHdXEW8T5vbR8ocvpdta96BEaMzgT2Zc27AeycEZDcg2VzftkzgUdcdhWHa
	IzR1DfH0q1ye5dxGMpZSPea1+KZ+Y6UDI/w5qyxpyeHU+pXwpYrrnSVMFQGA+TiRjeJTVO7PTiV
	36XP8JZ6o0YENvSjhqwBlgylgzV7EtXt/oNC3SyBBx3ML3pPRyL83AXA6KvSaEOVHeNuUK3Xnli
	HCmLNNMhOjsLP7jnKqh7T8KFSR4LrID0swtjGevHDRpN2+rtmr+fLMRtvrcrOJvWDBMIgcwbyFX
	cMgZAYoavdUT/4SSp7xOf7Li+lf/zGIGNY0U8AtYI6zj4ys5hKXSIOWd9M+39uy7M54nLSXyJaz
	ME5nJqxoPbrZwRJOZQADo+pd+7/CxmiDTjflwoMxhSZs9mLoJ1Xl/Nj83NHWBaNwXQTHBzODfhl
	9bVbcvg0BzJtgu76+pvynZXtSy5zVaPa4=
X-Received: by 2002:a05:6512:4501:b0:5ae:b260:cf47 with SMTP id 2adb3069b0e04-5aec6795b38mr793205e87.10.1782947828852;
        Wed, 01 Jul 2026 16:17:08 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec8991974sm308950e87.4.2026.07.01.16.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:17:06 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>
Subject: [PATCH v2 0/2] fbdev: fix mode sysfs lifetime and bounds issues
Date: Thu,  2 Jul 2026 01:17:04 +0200
Message-Id: <20260701231706.234715-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701221757.231490-1-mlbnkm1@gmail.com>
References: <20260701221757.231490-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v2 addresses the remaining fbdev mode sysfs lifetime issues noted
during review.

Patch 1 bounds mode sysfs output so show_modes() cannot advance the
sysfs buffer offset past PAGE_SIZE. mode_string() is given a size
parameter and switched to scnprintf().

Patch 2 serializes mode sysfs access with lock_fb_info(), including
store_mode(), show_mode(), and show_modes(), so these paths cannot race
with store_modes() while it replaces and frees the old modelist.

Changes in v2:
- Add bounds handling for mode_string()/show_modes().
- Extend locking to store_mode() via activate_locked().
- Keep show_mode() using a stack copy after dropping lock_fb_info().
- Avoid overclaiming unprivileged impact in the commit text.


Melbin K Mathew (2):
  fbdev: bound mode sysfs output to the sysfs buffer
  fbdev: serialize mode sysfs access with lock_fb_info()

 drivers/video/fbdev/core/fbsysfs.c | 59 ++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 12 deletions(-)

-- 
2.39.5

