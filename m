Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5295D2FAC05
	for <linux-fbdev@vger.kernel.org>; Mon, 27 Oct 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554639; cv=none; b=C/X3YlYAOiDlj7l+h3Vy/vLLIWIrSzwrksa2r284KH6iDgmbWHNyJBYqIpjwrr1l8zswEc8tgExqWlsDQAFTnzeTeiTS4Po0GZt1qMXxDp9cr/1QNmvC10UC1RAuhgCmq5aQEjxkpHwe3Zu+dmUY3KWS8ef/7WphcXExMnED7xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554639; c=relaxed/simple;
	bh=6GhP5nzTlCJfW037vP9XgllmDGxPVLYMDiLoDoeZNf4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DqADf00f8Qbv17pDV8T1Gk+Hw3SHAoN31KIrCISq2mcPpwAOs2ZcHIyP91gId96brfp6IF7g8JPFmfmKejx90SXE8Ya2PvW6tn9d6rd0zcu54qxMtgrdXqS16LYbgkhD5PWq9e2KnZc8aqNEur+J4CngC5P8+gOGPccm7Eucq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etBaUrra; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etBaUrra"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2698d47e776so34841505ad.1
        for <linux-fbdev@vger.kernel.org>; Mon, 27 Oct 2025 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554636; x=1762159436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XdBHtrgp03ghVnsbwdnfe2LK03D2az8OLXtLHgvnDs=;
        b=etBaUrral7HiRlkJR5xaCp3MNIXyZm0xW2f6n99fj0EjBEICuBayIANI1njiuZgH3J
         MIkNOYCgvHo8FqzquFQ8dMygzlTiohEzoGRM/64fb+dj2XdVyKj5d16NKCWpWHOw0n7O
         lNI8DOrgVGAQjMP1JPDB5qQ7S6uMo1GQEYC7MYrFVe0YM5TCuCPhEzTjuR6n+Klle5tB
         Wib4R7WXeJRiPtw0Mc32FYsEputC4mB/WT8GzIFvzMNdgxCXKPPrOA4bqy/csF1vScOf
         c1stI8wv//WN0snEiNTTguzLBmvkor+9Vh7a/H1xfkXZrNNOaaPSp2lRzziPH2/1ctgQ
         QIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554636; x=1762159436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XdBHtrgp03ghVnsbwdnfe2LK03D2az8OLXtLHgvnDs=;
        b=oJlOPvn2susD4O16YghHUywFzN85u6efqJqq5HSEQbr2f8DH0akk4Ldu5TUchM8hMJ
         V2362+1UB/D1KAMa7Hy5Tw+70k2Cf2b8FR7BNkUYRXtfI/002gsfO17tCX8Arm/FxuOR
         hhxcnNiVKtM9DS7vyQWWqoTaK51oCHhs+xm9QRb7G0wIxJlb3lwfsgn5PUSF3uywoYnl
         J8+uzyndG5vOOCXjQ/3zA3Igr7nGCy2ywRVJQ340efsOoOBo/pdS9FZjZwbCDAUhwA80
         whlbuYWuHyVoYWdzROCKvNXqwq3L65a3t0UwubGhOGzHch3WiLUi1LhoxmrDMU1V8fui
         gBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfiSraSxjB1KVFGKKAIPxcgjz4NgaYZV5Cg2H97hJmfdO6xYtB120whVfb3BxKB6igtJNQki0Gd6p2vg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NCF91YrfWHqpW3nH4h23IpWcPt75KVo4pJLBhysbi/mXgUX0
	VEDuKdialwuqg2Q10xSCUInWD7WFa+rmQp80mXJfodWgoHpdy5W0GzHY
X-Gm-Gg: ASbGnctRX508wQRQPHCi6A15+YI52NFoGzpsdGFqj+sApbaWlGxBrUW1gKcvyydeytu
	ggTu3XGL6k3Qing2SFNBGEvN+NQjx5+lui/2CmQHAtaH6ffsHKGUq71XEfKub795NGNVxfoXumG
	ne4G42zUVCCvtv08hdj6F+ETTAia2sQhscLxhwp20IqzA7AR+KWIa3ZnMCfBSmMSZGvMlRH8niR
	O7niZ5Io7BwCnMlBoXZBDCh01w3SFG/saedHRiNwX7jqzyHDkvne5hpG60RHFNLWic+U00CEcD/
	ZVCMF+hZB08irAq4xmMps097SiwcYf7o9Y+lDvSUxfp+EsHPO8bJv7Ti8GdOSEhe4IFPsk6xnzJ
	zzfax0Mg7OQXd++6oIU6y6erf0kJrKhlssWvEcpeGK4bvx0hnvNOh5awv2ZvWXprMg+QLgD1wcx
	SDD0UZAHbxX/y2spyYGBXYiS5y4rtSlnMD
X-Google-Smtp-Source: AGHT+IHJsL6+kpoPk8x1PWb0mqg3iHOZS6wR/zv/DBqOZ8GMqq9D0VqdZrEygNgekK2sc9hwLF1zkA==
X-Received: by 2002:a17:902:c952:b0:290:a3ba:1a8b with SMTP id d9443c01a7336-29465525229mr183633555ad.24.1761554636181;
        Mon, 27 Oct 2025 01:43:56 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e4349fsm73037945ad.107.2025.10.27.01.43.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 01:43:55 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Paul Mackerras <paulus@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] video: valkyriefb: Fix reference count leak in valkyriefb_init
Date: Mon, 27 Oct 2025 16:43:37 +0800
Message-Id: <20251027084340.79419-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The of_find_node_by_name() function returns a device tree node with its
reference count incremented. The caller is responsible for calling
of_node_put() to release this reference when done.

Found via static analysis.

Fixes: cc5d0189b9ba ("[PATCH] powerpc: Remove device_node addrs/n_addr")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/video/fbdev/valkyriefb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/valkyriefb.c b/drivers/video/fbdev/valkyriefb.c
index 91d070ef6989..6ff059ee1694 100644
--- a/drivers/video/fbdev/valkyriefb.c
+++ b/drivers/video/fbdev/valkyriefb.c
@@ -329,11 +329,13 @@ static int __init valkyriefb_init(void)
 
 		if (of_address_to_resource(dp, 0, &r)) {
 			printk(KERN_ERR "can't find address for valkyrie\n");
+			of_node_put(dp);
 			return 0;
 		}
 
 		frame_buffer_phys = r.start;
 		cmap_regs_phys = r.start + 0x304000;
+		of_node_put(dp);
 	}
 #endif /* ppc (!CONFIG_MAC) */
 
-- 
2.39.5 (Apple Git-154)

