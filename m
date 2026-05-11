Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9843CED5
	for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519013; cv=none; b=CLhfAbJ1KqJrr2YzwO9HaAF4ls7OHwhV/j+me4pOg47aF8/ot+i4E+NypoZVFEjTm0n8yeCwiV/QQWHSTz5JTJ3owPjxOFnjgIcBQ0ovo3VfWmZIAHbO8TfBmoGLdqLlgKKSdLAyKpBxUnn5TPR1Qxxgm0KpnXpl0TDFI2kbFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519013; c=relaxed/simple;
	bh=YCyAaTy3tNRlW3vQ1sWSmBjYYEpXBHbHt7z7xrLpx5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBj6g7eVbuMcpTQCgMd3ngRW52Sp6ZWbe/DZZ6sHRYrKXYvIeOPDRYr0hSmmx4gIuVuti2bYbGuzM4B/DO/1SMommWPUB4FdZs1DAratpKXBEtAKx0KIVmv/Xryl/JAouhpB2sbIvOznMJUswcQgCX/5ROnKQQGShIijrp1mh1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/O5zzt8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/O5zzt8"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so3217206b3a.1
        for <linux-fbdev@vger.kernel.org>; Mon, 11 May 2026 10:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778519012; x=1779123812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ2UzcN4bjFQ+iX2aiODShSxAP3mdh0bB9CnSJKiQ9o=;
        b=j/O5zzt8KoSPZSQEk2pW2TbVsjbGxdD/1K4PDBqqtHQGU/i7qx8JPUev+SgKVWJwub
         5BK2qVYFPp9xMT6lXU6zm03rtTVS7iwZnIhHWR613hmeZ2qiv9+YVzfL6ejwi4gNFvdd
         110zrO8ut5r6iGfWoJn59NnveD00yCMJRdtkOF6p8q56JLneLFIPp64yrhm0N2IL+ibf
         zpNj3Dk15BOaIDL/eSzc8OXFJazoR6L5/PSvelInZ/IBNnzL8rB4yQyx3J6MXoJcaZsy
         PeiXlvuWmGm/1NGmbMGIawQrC2bLW3fM5O4BUjvIRgKrxfjmur2IJ6KUsX0q1iFkKmB9
         WoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519012; x=1779123812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQ2UzcN4bjFQ+iX2aiODShSxAP3mdh0bB9CnSJKiQ9o=;
        b=rti1s0R5UZBiq3uEDXHH0VDIn9gpWxTnQxoOIm1XeqHwW68w3xbV44/yHR+7lWjIHW
         uAs0XvKJiHJLF9TO0x63DY6JHXRYqVmdW46Hww7Z09ufc1k97ycqevaqtJTEUiGaHFFA
         UKfQZk+VqNecuI4g/2YW+DycagAHmHqsxUJq0S94phEWpmn2UGxPMOtFPdZPy4j0ucsr
         nxrrifAAK/bD8czpFaPl09RXu/4fzaTCOz7CA8PyBEvwgwEWiizuSLxIGFhINc227b6v
         3N2tUmMUKPkmwt4Synb2jBWDC76IV5UHE+AIyRayaIqt4HLStGfNkJYu1I/LaQetWnWr
         Q5CA==
X-Gm-Message-State: AOJu0Yz9TCYoPc2no7a6ITLeGJKbyD5G7lJX5S8lNuaraHVFTW3k7j2x
	Oe4So2JVxL0FZPON5pPoRAsx9ZgHKwo0yILtZmjZlfcE4g3LTVG2JxrU
X-Gm-Gg: Acq92OGdnfWlhZwtCn+v4bjDQeAKvjHrBRJYUHbpHqdAraUj4F4aD9J18TUYhQG+PkE
	q9HCU81L7avfA9z9mRoFsR2z6zIHtZPwOT7cved79qt4+x6EP2geqSWfNCoAiDqaEEKrR3Bkjmz
	YlZ/G2BV9QEVXAuDErblJ8WtK8RC8ikekkoOSG9+aUMyWZps2uuhSmlRyP6dsEyUJlCW3vfDz8x
	GQaUxxxaA7XbQIp+tw+YyswoKQsB4haUoFjb/rstURj0W6+RFgmr8E44HUpHpkqWNgGzrmxLVOc
	EX4s0t5paEeLvLa4gX1QXu6+PtLRHLemHe+ojxhSwUH+SOZz9tbTxkkrL+OW1AOU9tIoKcjOy12
	K9wYspdTs/S65D/xi3H2XqwBKPCE9Ea0tg5/coi1SpdMsPKDMiZ4fL0mBpTTXCulU1VyUFiWCg8
	JMeyhAffU2e1cSQiNFjR7m0yxQ1Twmo3uPnX2N52XPaHv4H/51UkXpNmtiPh8rkYEjTPV5BwGDn
	Ibl
X-Received: by 2002:a05:6a00:420e:b0:837:80a:5aaa with SMTP id d2e1a72fcca58-83a5ea3c118mr24296078b3a.45.1778519011764;
        Mon, 11 May 2026 10:03:31 -0700 (PDT)
Received: from localhost.localdomain ([2404:7c00:52:d485:aae2:91ff:fe57:5e15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839685a3187sm21245900b3a.60.2026.05.11.10.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:03:31 -0700 (PDT)
From: Chhabilal Dangal <yogeshdangal66@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chhabilal Dangal <yogeshdangal66@gmail.com>
Subject: [PATCH v3] staging: sm750fb: Keep g_fbmode array non-const
Date: Mon, 11 May 2026 22:47:45 +0545
Message-ID: <20260511170245.53556-1-yogeshdangal66@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The g_fbmode array is modified at runtime, so it must remain
non-const. Added clarifying comment.

Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 9f3e3d37e82a..a553099f42f3 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,6 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
+/* intentionally non-const since array is modified at runtime */
 static const char *g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
-- 
2.54.0

