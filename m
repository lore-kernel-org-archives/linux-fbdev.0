Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CC6324B3A
	for <linux-fbdev@vger.kernel.org>; Wed,  7 Jan 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779270; cv=none; b=JOi7p+K1VDrlSbScdMuczm8vL3m+hezhYyEJwxOIDcXO6HtppVAMygoKKH3wa5BtMqfjTOE+5Qymjo2tjC1kyCJQPvb5r6pv5bGa7KLPkobAPi3nQ8U/OedwLvt7YPNTSB9VXzF59R92TpDHegDJ6RskQMa5QrT7Ud1Zs7eoBlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779270; c=relaxed/simple;
	bh=yTLerNvdtDEosypGJSu4ed3NpQtcBSWTy1A86LSNvhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQGN/rjpP3ajsCiqrqFqZhBxWpVpAtiYONX27mYrC6jq83On6JmXd6Lsuqme8ch+d9Lc7/+cJHbCTonRF1cd1G9vrJOrpLBnLvc5zHIe08PCv0mvzkIrwfqI0vOeLeHZu5twQgcvYDsff3Y+65XgezK1gusVdviRUUntgvBbPig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN/4w7g1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN/4w7g1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so11111425e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jan 2026 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767779267; x=1768384067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6G1SZVdPaFU6JbEowRplwTM+Q+oRKFBn2SFhoJyO7E=;
        b=nN/4w7g1G+DfzZCNn0Z/qf2kuPR6ulvxsNu3rf9Slpq4ZtQb6NbSjxAgI8cdIcP9W9
         imPViYl8LCF/BVGc7LqFuDvB7LyLczyf+YftEKkNoL1DWGT59HvQe6lzYKAFs3PtPxFk
         XMT98zaFjTDjQVK9y5NhaUYo5KaALk65zSDCa343GG8wBO0kQHhScnRrcrBuGwa9jwtw
         k5PXJnMEdazm92m+5rA0tokfrE0Y/PjbH6zSs7OCydSZKJ7NMGarN3IGEq36JUvKT/XJ
         rhu6e9P9cclV4R9k+DyPXanR3dChZxNQSMpasDACeBAobGHUT238QndLWHsnWcFd79VJ
         ZzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779267; x=1768384067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6G1SZVdPaFU6JbEowRplwTM+Q+oRKFBn2SFhoJyO7E=;
        b=ROd0SkQZ3t15Q3hJdIxRMXizUMQmwBn32CFRU1CUzrAuaBBLMOmnb5tf79A6DnTJil
         BfxpftrSiW0hM1eKSivTVrOwx9jhccN0E5+RyxsPIlOXSfk99nogQfcCPla/j8xqjJJo
         KaUbtek5k3oX/tdHTiLmN3fzKsCvtT6nEUD+gLbVkWCUf0KO+hO2+kCHgO1iaJ54O5ku
         WL4vvxDFHp4xCHGNQmDhpPs7jm+Z+a2blaU4RTDX0NPL0By2YkIn/GN5WHhWSUMo1HnF
         YS2JyZjkSY/hs2BbfUpH6SB2BaF7/WqLJR7hx4o65B3iGFLF7Fmei0lKCW200uIhLC+A
         JeTA==
X-Forwarded-Encrypted: i=1; AJvYcCWiEUSFwxUmmSAu84cvjnzd9Hpm/cEYDuvMkZJV9Ci17c3OufTnXw8armOInLa2KZrjGoyphPM8M5Shzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrXoi6AEHAtu4SXaaEhtO9/QMnqjkkpq87gAVme/foO2r4aAPf
	VT3ET+emDvHEhDFvneJXMWjUCk3bvVbOF4mg5YCSgVcJ/NwaqHsKRcxN
X-Gm-Gg: AY/fxX67Wlz8VnC5F0ZHGMh7MHtblJaFarhl6BaB2hw4PNkFj67v65TwgOOWHxx/XxP
	qhfxsFR4AWgP47yfL8tSM1rDXuPH9/fFym1hatQ4iAcSV31rF1xomzmDBkuXVEOQgRPOv7PDEBP
	TmOA7/6xarhkH0Z07lAfKuzFfEvWLF4lcBhuNQMO9NBPYNp36PR+k79CHP8sS/ycRWAvzBeQmHV
	qJfMTQSynJk/CObVYLkoJbGa14QtBtjLVLCWIQKo9eUS3U/es8kGy49qME0plmXs7PWfgM4HGJV
	TTIaWG6u7uxFFMak2E6LMH9O0IwBDpNP+Byg3OyRF6iT5Hmn4TBG7pREpcFDQVHyFwxzyaxbXBf
	VyxNNmarmkSzUdmbNR5XW9IqMOGPMj7xoJpX83NDoRoyjZ9zimMw03hT0a6VaoAzLKI5YM07bJt
	Ru/kydeybYQ09eE3VjBHynwkdBdsmZHBGHWwBu0ICjLG408lh2rfPhiFkCzbCRF7qyD1i7ufiHq
	FEjAjpbXLriozrYmdlol8XBh10=
X-Google-Smtp-Source: AGHT+IFjtVVwNmv5YdtnIJKg56YN1n4bSBn1kp4ZsuWAEVIQbEnKsmF/1xSwtDW8jtu/09wGzBV8hQ==
X-Received: by 2002:a05:600c:4fc6:b0:477:b734:8c41 with SMTP id 5b1f17b1804b1-47d84b0b320mr18135405e9.1.1767779266984;
        Wed, 07 Jan 2026 01:47:46 -0800 (PST)
Received: from fedora.homenet.telecomitalia.it (host-95-244-124-236.retail.telecomitalia.it. [95.244.124.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d871a10f7sm7423715e9.18.2026.01.07.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 01:47:46 -0800 (PST)
From: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
To: gregkh@linuxfoundation.org
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
Subject: [PATCH 2/3] staging: rtl8723bs: remove trailing whitespace
Date: Wed,  7 Jan 2026 10:47:13 +0100
Message-ID: <20260107094714.300380-3-lorenzosimonelli02@gmail.com>
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

Remove a trailing whitespace found by checkpatch.pl in rtw_mlme.c
at line 2021.

Signed-off-by: Lorenzo Simonelli <lorenzosimonelli02@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 98704179a..ff4e668f1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2018,7 +2018,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	return ielength;
 }
 
-/* Ported from 8185: IsInPreAuthKeyList(). 
+/* Ported from 8185: IsInPreAuthKeyList().
  * (Renamed from SecIsInPreAuthKeyList(), 2006-10-13.)
  * Added by Annie, 2006-05-07.
  *
-- 
2.52.0

