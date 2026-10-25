Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792945618;
	b=PC3hJh4FkYO5YSWnlU/LJO9cJ+9tmBDfjLKroaIXB/IdKNdng7o1rpQqgWGpSFIFeNF3
	 LdYg6Et/NSn9BqkztMteaW/qq4Zp1eaHOHA3uvviNrIy3YACmpzPudClCj6Txcs1bJ1LK
	 HkolsBWrXRxtPeXzLmnJOslc6GUA5YKxxAK8nxk1Qdkm00hEQWHYLmOJYEiwVS4PZw1al
	 +0Umhe+F+9dTtWz8TuA6DDPm49wQaBgp7LW0x0OtxwJt3FEnDDtQCxiNc0fWnM+0QRAEI
	 Vk3mAt1Kvk3+r7Wfhne0xMw3P1QFByKXPTMBCQLRMN1HiXfpZJxVm2eO+SYrV8WTaZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792945618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bDSSPNSQqDQ8t1tNwPdKc7jR5DatkZpoImvsQgQ5S54=;
	b=O38UM3zKelnB8JRh3sG92afdyBEZy2Zhdd3FLCT25cXqbgia7iOKLgi71IVaMELGFx5/
	 3RRsbYQjK2XfZX2Ln290WWlLzPRm3qCACXfJDqkzVRvAMmpFW6WHyo7liOSY/vVqhAMHk
	 KeHAtVY6faYfZMNI1BST8SR/OI33D50ekM/cuiObh1u6HV868Pn5HP/SZNYYjmNoRuFli
	 vGi37m/HOpRPN3vCjFG04swGekAfahKKUWMD4bjWn2gHD/MGBI6mcQ4wbVgAXYiYeT4cK
	 LFvjAclRQCAa4E/Gf3e4bXibOumuP8EcSNhaG5J6w/cY9VYbM5aIcPmhTAH7+SrHM6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hzxt2t1J;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE6E606A31B
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 16:26:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE6E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hzxt2t1J
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b042c0728so526741f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792945616; x=1793550416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bDSSPNSQqDQ8t1tNwPdKc7jR5DatkZpoImvsQgQ5S54=;
        b=hzxt2t1JJI290AWZMMbrFT04USgwJ56QM2abbAq0YUa+RLcjcF4tzeqiw7vhF2dyIJ
         7oJFjXb8KDrLsfNCTcA8BIgyIHdHmIckbEPA6o+uKVEOujr7PkanHJi61fxLDKzsNgCH
         7tLdEAef4UKvhGkfspWmSwIxleoP/ywEwaj2idsTn1KfX3G252Rx2QpJmXYtku1VtLdB
         bF2FuQZFTNLMGUlP5YFgiPpFd/JOms6AwhHSv/HjYBdNuJ+wdU7Bp6zGAImFrXzBU4F0
         6xbgSE9dgDSO2Zsa9gtjUZJq2XOCajF+3QzpVN3yE1mfkT/qOUsgV87+550PbBkAlTcC
         JCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792945616; x=1793550416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bDSSPNSQqDQ8t1tNwPdKc7jR5DatkZpoImvsQgQ5S54=;
        b=cNwGGkfJ9wES6JCh6JEvnwi5U2qZGtXGUySjtBDbZvz6U4i+aLmXpyj+IjvgOF9iZD
         XG5wXy9k27XDz+m1xZQz1XqSxjZu2DfHZWHEqqm5cOIa895c+Qsh3i77z8CRhPSIWk7k
         bWRtD/COadI+i/ucT9tSqjO0iY3Jgvaish3Rsbv5ASBhwVnaa8BKv4a0ldFXO/dJzFFZ
         sUyseJaL+1mvbL50B9eCU22GuaKtdNS1zx3de/7ZL6v7X5ve1N7CWOkCQNZpJwAyiJX1
         XXpgDI0FS8UtTD+z3xXbTTyqBxDWeh5x5OgDMBu4w+DqcnnKpj9FNVsPqZEX7k4N9Pt1
         J2vQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdEF6P6q5MzXu9jPNyuzGx20lI0MLG3y4cV0JdvTq2mxM+VmCc/CwXKItHRud9Xu6JgOqUCi6wbaG1zA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLhYXaq/ISSs/NRJBsc+MotPC4feZY48BDQECHBxHy27ODcoaEO
	mIxTxypuC08mv1LtxbOI5SxO9FiGxhqEkVtIZ+d231M7+MX0J7Sutr7R
X-Gm-Gg: AYBFou1DmVFwSK5Sio2LXz5ejzJ9oiVHQ7m0BHPY7Acx3cZw9362YWnQxXvlVJsm6QO
	GNLOoQWwNEM3QLHNjPtRYD0ydWUjIKrP2OXX86MrtZEaT+V4RIiGLbY6b9Tk3VFrFoiKfjo16XF
	f3C/kNydffqXvnPy7cFHgzza+JufMmc7VO6ZtONDR4DOpDCe/JGzjHMC8+/pQegb1/4PMCZCEGr
	izqGQweSQQtx9vYAI2CtQq7+oiNuYbkTrmZBPPenREyvtC/dHzW+JzBB3T9A6DDQ2I/jP5qUTgp
	2FAmZswC4GnfFqnbKArck11eEgl0JQU1SGjrLEjT9lT5vTglEfed3sosBs2S5qk7IYmAntcP9mu
	IB11NNP7kWfP3fxNPZ94nrcqEIWDFDs36eB3DID8Sk2en8mGaLvIZorVchY8LMP07HOhRnZ2pe8
	AEvqX6OEoT7jZ0lNyISmrIdEW4CrhD0ZUPJzxNZhVOGygV+nPwvWWMB/w+LUX5f6B1DKUcqLgaC
	uXcHzVZlQzIsbBmhQuhNYVpvDC7tl5uTLN1KqmkhP0oAIDJReoPAvfcdM5d1cV9wkyzVXyFhd1D
	1yG4L4MnSB9ZXDxKrTkEd8k=
X-Received: by 2002:adf:f0cb:0:b0:48b:e50:7159 with SMTP id ffacd0b85a97d-48e3eb931efmr6231047f8f.30.1792945616300;
        Sun, 25 Oct 2026 09:26:56 -0700 (PDT)
Received: from Ubuntu-vm ([115.186.50.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm11127395f8f.54.2026.10.25.09.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:26:55 -0700 (PDT)
From: Haasham Khan <haasham93@gmail.com>
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haasham Khan <haasham93@gmail.com>
Subject: [PATCH v2] staging: sm750fb: remove unnecessary goto
Date: Sun, 25 Oct 2026 16:26:32 +0000
Message-ID: <20261025162632.7186-1-haasham93@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025130258.10747-1-haasham93@gmail.com>
References: <20261025130258.10747-1-haasham93@gmail.com>
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

Return directly when setting the mode timing fails, rather than
jumping to a label that only returns ret. Return 0 on the successful
path.

Signed-off-by: Haasham Khan <haasham93@gmail.com>
---

Changes in v2:
- Return 0 on the successful path, as suggested by Dan Carpenter.
 drivers/staging/sm750fb/sm750_hw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index c4358d3e5091..4dfa1cb6b352 100644
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
@@ -332,8 +332,7 @@ int hw_sm750_crtc_set_mode(struct lynxfb_crtc *crtc,
 		poke32(CRT_DISPLAY_CTRL, reg);
 	}
 
-exit:
-	return ret;
+	return 0;
 }
 
 int hw_sm750_set_col_reg(struct lynxfb_crtc *crtc, ushort index, ushort red,
-- 
2.53.0

