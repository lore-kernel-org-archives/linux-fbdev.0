Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA42F3C02
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Dec 2025 19:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766517858; cv=none; b=uqLnIgDn/MqyTl5ZuhBLk8j8gfABBmcqKIymyXZ0lJ8Fd2sxjDznurlHn+Mr4OC2mFEX/VjuxYpgaX00089r6zM368SfwcAnupen8dSlkAXJXswWL2wrCzHqZXyddiQJfYCkCq8YG0rhHzi8Qp7Na4kxCE4S+phc4h7dW7e9rOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766517858; c=relaxed/simple;
	bh=Svz13no7Ji+bCzqqG+VAYqznHhuJawGZwtywOvf/dOI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sPIuRnKmhKTXws1Jdod4lddpIKH/Zo6Op27RKxMPZLWcDGAP3keQy1xfBNXCoU8Snr6/2H7/+Zau5Xxdqd7EqUH6eW9aRYOo1Gok2QRxV6yyVRIZ3IxoST0WULLg40sKvqlsdmQQ8JIQMs3C63pIqWpoduBoHmTWODjwORMzsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLS3beHl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLS3beHl"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso7396868b3a.1
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Dec 2025 11:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766517857; x=1767122657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J355jvWq3/NjdApMIDzGb+6LceMfHS1TaMoQRJB+idQ=;
        b=LLS3beHlZ1acI7K34KQF8z4429M/wxpjd+vuL4gEhNmxy3HAVjucnSd3TxlvBVoYAJ
         qNnyJOBDg+Sll4j7TChHaTduIGEogAZ1O3jUgwb1EbjiWizPDYXl6oYg9eNFBTN5ySUZ
         O/vQb3ejw+M1FgzXZ2Sy7C1b4pBzadQ4eIYKDek6q3l6FPtLXdn1ol+BXTzPt9MNYVuP
         ZmPf2tlKvSG0eB3LRDIustOiURZz82jBzGzoKu+m52zQwuohgeS1Xbxgj0ZF2s8cgQiw
         ObSKKufTME6Jo0o34srIfpHa4G9cspqEEcNXDg4hWQhokNVg+DQuRdKpdIOF/GSG7d/B
         SXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766517857; x=1767122657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J355jvWq3/NjdApMIDzGb+6LceMfHS1TaMoQRJB+idQ=;
        b=loufmq3OY8c0DaPB0r/ohEUI7lb6PwUREFvxxLYbtbPFJKuIb4CkMpF9enB+lEnWkj
         mZTz0nbu1ueDFWfuTOClVx0pYfXJqurzUvFuzFAZYJ30l28+E4N0xvs6XW5HCJ4kHDQU
         shzz9sMyOQV1af+3AJrQCimpqt24JQsMquXA6/dofUTAiJ12peJ8SHomvmLAu3MXhNAl
         EW3JknGTRfRrGyPg208d6eonv/Dj6jbuh0lOrNDJGPWEuO4U35X+eQ2HEgyahdiVMieg
         1oA152Z4YNwqMligpv0MnjJ9Dr/jHWRFDurRJf/t01VZR3o5p0MRUEnsRm08ClXorHpe
         Ru6A==
X-Gm-Message-State: AOJu0YyWyEcGn31ZvdBJ6d9EKb4KkFdUvHqaWcKI+IBBoghMy0xn93Tg
	EyVx2LtGFglBFVEZElxn591L3kt+6ziSNAbkiNvFXEqArAHZpB3smzbjyVI9Bg==
X-Gm-Gg: AY/fxX69UTGKXXp8YcNWGxq9KCO68AG3aNAPdozDI+AgZAwZxL+Y2q2NMMqspq0/V/H
	wE3EAAnAL0oBYZcYptcekbbEQFIku9qu+n2gsETI3YgKVxCpf50qmWwygbmoe+4zZxkIFFGTDPf
	qQ+dlnB2nknL/3TkslFQWVcs5rd4jTqOO1xDJ4I45WLK5kxslqhOyYfPJI0sYgBUdfLvkWcNtSh
	j05lZICWUsaUdS5GhdiI6a/jf3SMJ8zoltGJQxHqRg5kJNWMFT3x6mx/NI4Uj7uB1UYrvazDojh
	9vGypVUPsonWdjOCUsIYer/Vw9eCysCE1ti6uI+P2Apc8lyil/4borpaODD4BhQNdqxgIzpAwxB
	ExaPQd7H9Lk/GcxKbKQvGFhgyXQ7y6DkDG3vQFrqdwYrZWM5CSWojUKzpkmMxa8MmnbSHxGSSYx
	+R0y23jD1mrswRmlm/KMo0YTk/mKpHhYQvxMAUSdNfyfhhsTc70a8U+CI=
X-Google-Smtp-Source: AGHT+IEtKTnVfpDxV0s2dltrBPrV8taJGOWI57HInnkAFZ3bEn+679+iNLgjIfqw/JI+WE5dDnlz0Q==
X-Received: by 2002:a05:6a00:6caa:b0:7e8:4433:8fb2 with SMTP id d2e1a72fcca58-7ff6667ce4bmr14247139b3a.58.1766517856743;
        Tue, 23 Dec 2025 11:24:16 -0800 (PST)
Received: from localhost.localdomain ([2409:40c2:1052:c28c:d56c:4c53:fd22:65f7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm14508437b3a.33.2025.12.23.11.24.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 11:24:16 -0800 (PST)
From: Tejas Chaudhari <tejaschaudhari038@gmail.com>
To: linux-staging@lists.linux.dev
Cc: linux-fbdev@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	Tejas Chaudhari <tejaschaudhari038@gmail.com>
Subject: [PATCH] staging: sm750fb: rename fixId to fix_id
Date: Wed, 24 Dec 2025 00:54:07 +0530
Message-Id: <20251223192407.15817-1-tejaschaudhari038@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the local fixId array to fix_id to follow
kernel naming conventions and fix a checkpatch
CamelCase warning.

No functional changes.

Signed-off-by: Tejas Chaudhari <tejaschaudhari038@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 15b5de33b..7afb58561 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -740,7 +740,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 		"kernel HELPERS prepared vesa_modes",
 	};
 
-	static const char *fixId[2] = {
+	static const char *fix_id[2] = {
 		"sm750_fb1", "sm750_fb2",
 	};
 
@@ -862,7 +862,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	fix->ywrapstep = crtc->ywrapstep;
 	fix->accel = FB_ACCEL_SMI;
 
-	strscpy(fix->id, fixId[index], sizeof(fix->id));
+	strscpy(fix->id, fix_id[index], sizeof(fix->id));
 
 	fix->smem_start = crtc->o_screen + sm750_dev->vidmem_start;
 	pr_info("fix->smem_start = %lx\n", fix->smem_start);
-- 
2.39.5 (Apple Git-154)

