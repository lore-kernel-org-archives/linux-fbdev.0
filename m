Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65803324712
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 09:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779269; cv=none; b=hwqffL3B1nToiMU++casGOqhZD11rIoPmftIQuLC6Hz5HcD374vox0QjSZY861GMewpQ8E89VvkzMqes/qzU/dMOCkqhnaKjUfbonh9RbQudrt0Fhe9jveF/ApgfsnWaIauWERCMh01GZ7drtu0UpjgFge43OlRIi4nzVHpbWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779269; c=relaxed/simple;
	bh=AmCdA5qKO5zkAOvxSnB8hr6hDGpE/OrK/33mDHhV5f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHAgH3e02EI2q8Z8PxchH8RrSzsoLFgHwrJxue+u4vu7RsVeBfSFBjHMrvidWR4FUOAmRbnugrbDzL+5eyXNiJEHB7yAbOSR894valRqe8wfE0NP5jdiE+we0VHX4sUD1j4lobzyRfdCMSqnzrdVlUZB5sNz/h2yojp8Bx+GD9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkvWX+r7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkvWX+r7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so12292635e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 01:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767779266; x=1768384066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvAbb+VvFp2MrQF4nn8HPRFViRBXMJRyP0Iy+4AX7QQ=;
        b=AkvWX+r7t9jm9aF9aTiO0KL5YS1T/h9lYL959YDUQorgVyQET+fA+fHRU/+RmHfKAz
         mh0Ql4sTgUwBL6J60+z3Nypi9HBhFK1ZIz/JzZPD97p67gLlmS99+kPmlz1yKopyUv8L
         KYwz+SeJLtB9IB2n+pJpOaxX1tV2CSgzgFdRiK+HA+bzULQTdW+WD84bXymyezHjQovZ
         OEyJAaKmOshU553sYCP8fskWLPQUinHAc+kIPEhQ0JN3ERh2VTAfO7cJIit+zZNL3mBB
         zbPU7m60xfcRKbgKm8CQlSYRD2Zdwqi3Lbk1dHAq2yoXACj3sE+n4G7ZxrpejrQxSwqi
         PVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779266; x=1768384066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HvAbb+VvFp2MrQF4nn8HPRFViRBXMJRyP0Iy+4AX7QQ=;
        b=bZrsAKhni5/tya9P65bCklOYts8+1oh34iP8JBu01MbZChZ68bWS8JXVMA+JU7zEyB
         9WJcpBoANUufJwa42nVurKIsz705yRjJmcHr+jBC7lDR+u4KbtBEbBsseF8RuszbuASJ
         4aRe59Fg2lSjHHviZtmU6eUeg7vSwl0TLBCildWnNB4QqBE5RpZvBT6U5aGYljeGPSeP
         /EdtbQivN/y/UADSxCbSZd3UWOcCMlGz8VAWIqHa83ERTQfejIk5407vqKS/YK/Hvff0
         q5f4YjpeQPG8kB9CqxdV5U+/aUQee1eKQhfLqgwc2es4yk8dcKdoGUlNVXCkcRCJuNwx
         dy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYhcOEVtGl0b7Dy1/mjLieD6Z9mp30TzHqosOiq45++WDYYXRYiE2MNmbTGaX6RKIchEjjU4OXGxZJJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKuX0VxQHl4YtfkhikpgaggNZ7Ntag4D9bpbEwkQn4/iWUTTz
	PMDSRfiqPSCkN/Gp5E6IlkY2ZJ6zbm25dDo7SQFXOIsIejpLfzEs004a
X-Gm-Gg: AY/fxX52KohcgWZyRYXBv8wgPVtRVLWEWaoxPmO3Rw2vU6Xr/lkR6rz44MRwhpndvum
	KZVivm8DVw70/WR+4FSeGfhRet0vDnrVNQQJMJzom549f+32MXFDVporPZ/+THhTVjKfZ1UMBdW
	iwol49S58bdRVPlDvLvPZGFWz/pfIjOaXieB/tFBpxSeP2kZtrt+GKyB064MXtjzy02rg8WxsdJ
	mfTTrFKNfnkz7o9uQulxi07K4UO+IQeW5bbOGqegZqUWcuFNiTMi6cKpRHruXDd4D2IWJq42orN
	NcVpRuxYl7l+vj9Mg1DAS6kdmR8ayGEbUdZ4AzroG5xO5kVtWNoPqmmtvYv8o+dqfNXo0EbpZ4X
	RcDBCSEikVm/f9YttbaZqHvsiQrRq1BOXPhKjm1Fed8I4vlHz1lP4ivan4WFO4Uc5uAqbnkqYH2
	d6eWJhy9uKrxfwPiQHE5+ebID+A8i3qW3s5uF0UfnPG0a4Dv4Z+QCZ10VVEOYX0BvGYVRX5vI77
	BFlH0/XnyqcpOPQ9XuSNvVOpGs=
X-Google-Smtp-Source: AGHT+IHafHyyzje9Vir1gaUsz/pxBeNzb6Rda3JE4pIFWYWTzEj1tTbOoJzK7knqCUS01LEsTZYGKg==
X-Received: by 2002:a05:600c:4e0e:b0:47a:7fd0:9eea with SMTP id 5b1f17b1804b1-47d84b1a31fmr21723065e9.3.1767779265668;
        Wed, 07 Jan 2026 01:47:45 -0800 (PST)
Received: from fedora.homenet.telecomitalia.it (host-95-244-124-236.retail.telecomitalia.it. [95.244.124.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871a10f7sm7423715e9.18.2026.01.07.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:47:45 -0800 (PST)
From: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
Subject: [PATCH 1/3] staging: sm750fb: fix static const char array warning
Date: Wed,  7 Jan 2026 10:47:12 +0100
Message-ID: <20260107094714.300380-2-lorenzosimonelli02@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107094714.300380-1-lorenzosimonelli02@gmail.com>
References: <20260107094714.300380-1-lorenzosimonelli02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the checkpatch.pl warning: "static const char * array should
probably be static const char * const" by adding the missing
const modifier.

Signed-off-by: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..15b5de33b 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.52.0

