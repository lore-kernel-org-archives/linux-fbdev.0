Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792933397;
	b=whuyKq2HH/2Nnba6XLB/nz0xAKPgcoeM2m4N1x24iRVvor4jjuSrEwa/B/r0K9WxYyOu
	 QPjCU7xnyX8SvyLc25YwMFOmnz8AlZyU78i/PoQ92wYRweJZqEYRK3wGzHOfm100ap1K3
	 3ipXpbRpXUULNWMw8ONe4Jv0AVaVFQgRW4Zh+W5EoSGlDj+dtTCbsIUvmLxNTp+5W7jso
	 bknASGqXi0aPvpF/OkUOJefikQJMmHhiQLWvMu25pdBK25mtPgH0LAm+B5uCICYWqtPw/
	 ChuptsJQCa8/B17ZD5jwJchn2FmZV3jB96ZzIj5QAGgF/uugJTAd81mmw2qH8YoEtYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792933397;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pw+VQzikrvNhFcsLNLiHCOdnZ30fvzuuTNfRPpO+bNk=;
	b=AGDaT5B472e3q7SsFQ+8zMUKvJQbYykobIQZKePGg0gCENqGYw/V+m9TIAaRJE0l60g6
	 T6kd1DIx67BoNqcgLqgD/skaj1EvdiPOf3lQk7hQAHo8v3DpTj2yOGozuehTm/DNEwWyI
	 qqU+6MTq2UmPddJqedY5UAv0vpV5tNMyqnmy28SJgDM/fizefzRnvY8qlIo5YlMZLxT0i
	 ayu1/QVNibrdVLVQSgL7mYjUpCsxZaZ1JD8oCNZjCZYrdUKuKKB9Rh0h6wi/xQBYh79xA
	 ixaXn9p7P41LYJ9qnuI18Q35AsCLa1G96rRqLjq18qxtE8O4S2QgxVqftyQzcpbWRSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Arc/I2nN";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDB606A31D
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 13:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76CDB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Arc/I2nN
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so20736565e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 06:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792933396; x=1793538196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pw+VQzikrvNhFcsLNLiHCOdnZ30fvzuuTNfRPpO+bNk=;
        b=Arc/I2nNT7rH/CtpyJYfHvjMnenGPvEByGpIu9xigsqKL3Jh73UlOuO8gwX+BjKbco
         R+0qhcYclzCSXoJX7XFUt2+Ahtf8QNYf+5pAD8u73XsAcRK6cQPHrQC3+UESBvg/Kskr
         y7lMBEF99Z7mVBn7ya3bOY6vYryXyh+LXZfEot69HgEAN5VeB0QK/uJIKXaTXhJ5wmZr
         uswbF679IdSMOgv2SoMXHXXps8HheNpsOr4vI1Oa2urkItnX8q8rc87LDvXBaRK4glP5
         vZbdDkLsU/E2M+RSbvfDaePpWs4KAU1JL9mg0z8jO0NmYBoPzND1bzjQv128ENB2+0mx
         KVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792933396; x=1793538196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pw+VQzikrvNhFcsLNLiHCOdnZ30fvzuuTNfRPpO+bNk=;
        b=D7dpZiLTn+BeaHM9M2znuDLhgvb+5C2VjrDNz77+IvN2noObSAOZHmZ0YuXs3stgV0
         DmpDheSCczVNzjKCzFutIWjBOyVl+CDOeFE4rRvvsVqIlBty5+siO+wsUQSpqaqcBHJp
         LYOWYLv0wr2Tuo9TWk8VSfh5LGsF+9rBlGeC+MwVGtAgdD7OMhV4AOXzJR27AIjo+aK0
         6i97vXxBmYoxLS/5d/p2jE5bSAqj2ZdN+TbsmETUEeaw2bCDpzcrxu6LK4MmWOQpgXQ0
         LVRdTwEgPtCXo+OiZxnKJcqQe+nVWuxQbKoN+GEEy28/Ptgsk70izhveFBttAzbjJL9P
         CZBA==
X-Forwarded-Encrypted: i=1; AKwUvByH8bWFSgIsg83Q1x4oWAfv0ADv/2aDotzvY913DjNriUtit9p2ox9IHB9ZR8I5oG/7HLOQvhaK0oVimg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJJMlw93d0lXX60nVawvb+RbInxkzCs4tIXWG5MNAw5r/wRvvyh
	YitTB9LmwPrS/IF1rh7K9NXY76w2+q0vNtVkmrgf4h+YN19epZSEa6KW
X-Gm-Gg: AYBFou28s1xseIzvY8kc+68cD8yPD/Q1w80n2RXPEKDAy2jPIXEqpJu6U1P/6u3eZnj
	rzLsm9t19N/ZFc50jJUhjnsjIvAktshLrz6oWHxCA3rbmBbcJ1ncWjmhZ5AlhDVNUlJZcvZLwVs
	mAdW2O3JGRnY6CJP1tFrCHEkBl6JM5Sdu9jBGy7kwMvhj2/cbBFDPbMYMPChaofXcT8Oa0b4x73
	u0KAe2tmATZjp6Di2FTfEwuM5C7/q8PkWah0niTawhhvXHCAkap3QXQ/C0DBz7HJrIGC9OrMHt/
	CJfiLvPNX5YJVODIZntNLPyZaMzDr8aoWo7rlfQmM240kVlPA6dI/fHHUqDI8ArKNDFAQnw080g
	dq98Zb0193V1CXnIXaGx9JvwKLabkkwKo3RVNkdaGAlBgIeIgvaXosLYG5Cf8GVjl7JC9vggN4O
	Ug64zihFO8nTehNs/Eibhq1sZQS1yhpBD5XHPE42J7wNimCOH3py7gwaCpIFOfOGRHBWrIrbbcA
	lrVblwgqaYr75jQll3yrI0/rXT2doqVLA3SdCd8wfnpXvbR0ugj2o4uHQU8oH+GvdAhAZzqeLX+
	vIG3Rk6a6HUhaebPSA==
X-Received: by 2002:a05:600c:6749:b0:4a2:e0c:2b10 with SMTP id 5b1f17b1804b1-4a35aca32e1mr66130535e9.19.1792933395658;
        Sun, 25 Oct 2026 06:03:15 -0700 (PDT)
Received: from Ubuntu-vm ([115.186.50.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a029332sm108000685e9.4.2026.10.25.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:03:15 -0700 (PDT)
From: Haasham Khan <haasham93@gmail.com>
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haasham Khan <haasham93@gmail.com>
Subject: [PATCH] staging: sm750fb: remove unnecessary goto
Date: Sun, 25 Oct 2026 13:02:58 +0000
Message-ID: <20261025130258.10747-1-haasham93@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path in hw_sm750_crtc_set_mode() jumps to a label that
immediately returns ret. Return directly and remove the unnecessary
label.

Signed-off-by: Haasham Khan <haasham93@gmail.com>
---
 drivers/staging/sm750fb/sm750_hw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index c4358d3e5091..22f93277e91b 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -272,7 +272,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 	ret = ddk750_set_mode_timing(&modparm, clock);
 	if (ret) {
 		dev_err(&sm750_dev->pdev->dev, "Set mode timing failed\n");
-		goto exit;
+		return ret;
 	}
 
 	if (crtc->channel != sm750_secondary) {
@@ -332,7 +332,6 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 		poke32(CRT_DISPLAY_CTRL, reg);
 	}
 
-exit:
 	return ret;
 }
 
-- 
2.53.0

