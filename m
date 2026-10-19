Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441286;
	b=Jb+5tsT1G+4YjV4LTvtOlQJ4+A7bBPszuT2DHpOiuzF1bKi/O9Ou3qUzt38IVt/ROWIK
	 yArdqkxFsLiuSd0n3vkLzZ1IRMl1XU09RDzHkKuFA+pNlJurd8injLixoQtnM45sDd6F3
	 gLK5yTnNT2nkycFh3HJcmFYHJg1o8w589wKSWTHWXeJMCalYwzAVgTBmEWateY/fwvMLv
	 rmiU+np7xAmqJovg92n7szFW6Gci52qeUcqf8L85uYo+EkclQGZ91fHHm4Qy7PoQSchCb
	 4bXDYmb07hxVSoVkT1Az6tuMxLN4OgXvY0xEpb6OO+CBv7W3Xf3UzJZuIUnRoVpqxAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5SGe5k/sxuefMjqMn88o6FMTCheBSXX/pG7tZNOtng0=;
	b=FscU7Zuugtm2Ub6kI64uaeyHdfcGenH689RNvmcR23OUr2rRXx8uqYjUhPUm+eQBpw1G
	 bhPJsCwEoGNTCsDwtEZq/WfxXkLgyYncF7RxWKciMpCkNKKdakd9AHLRbZyIfxXVlIqui
	 lodTfihXEvMqJcECGbqpZbBixrQck8+OG5o36R2NWVbwZI+RlCriR8cZ/Xfu8Rpo41WCO
	 Zgyznp3rHm3VYqztY95OdXR3tOn9BloZpu6V4Sz0yyMZJlpCpVGaKRP8iSMw2EbwG1o9N
	 DunPUAN/I3w/QrSrrwARUOxsPHT/WNIHsder8vbc0TZjkPI3JdxBDJA7o0P7PuZ7v+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N4F39o8h;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C0606A31E
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 20:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB5C0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N4F39o8h
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso28527975e9.2
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792441284; x=1793046084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SGe5k/sxuefMjqMn88o6FMTCheBSXX/pG7tZNOtng0=;
        b=N4F39o8h2bRYjS/nBSs4Wut7jXe6vQDCJezCfqTuYfaQu05wkEFpcElLDnPgy7E/aq
         FZMZMaV1NpnBXOQ2Op3ITzaZ521eVpNf/a1ffNEGKSEYQbxNLVhg9Ax0P5VBM5zqvXAy
         j7nwulX6ct8uzCRXsJcLfRFcohmZwnmMHqRaRBkyAxHhVc3q8DQGras8KtOWEFQdP9zD
         YaRK5EOqha5tjyBpEAV6PHtMH6GkxVTBWiQzX08AIcktgQJ3Z4+X3qSpW9hokVb1MSQw
         0HvmvddD+EGwhitr6PZqmtIeSxmsJzv879Pd9kaxE3xTBWYGppR96++2Dj4YIy5bmQVj
         f44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441284; x=1793046084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SGe5k/sxuefMjqMn88o6FMTCheBSXX/pG7tZNOtng0=;
        b=iYZKnIOwapbjX56ceRZ3RpdqeEwqafe0WnIXM1vvxGTgZVlbi+67W5zTvhP6LmL9bk
         6hBYXl+KT3AUW3hCwBrzWegorgPD0BE0aLqDJ09mVJEOuZkC5pB2O4vPAgD4S8zEkEWK
         nyCKGvaZIQeriUqmMn7OGUbOsObXa8vKrMHJD1OGaxyi859ur3prNtqDhcGE0Qgnzbw4
         7CZZSIKimyCeevR5hYMm1vU8jMiV++saaAEtRHNVtU3PRJKwOKLUKoVujeOv1STzTjtE
         dpZKoLsEV3fZAsAZulqZsTJVbm3UcCfnymJ0GRT+eIvnMZiAE4xcyJcKAfdgfzzpwzX0
         sQ0Q==
X-Gm-Message-State: AFq9FYLTrOBHM9sJpL6ZqlGmS7ODHexJ1gGPz2TP3h6kMrZa8fSePSSw
	HzLxn7APjCMYasKHPcge+SgHV+yg6lO0xcOdwoajmiXjHXMlLEV7ehO/
X-Gm-Gg: AYBFou0tRWVf+V6afw9MfYiampBbpLq2en8Mf0AGxDfyhJgbcAvjwT1cY/vbFBsl42m
	sUlui+Ebm+4ZR2CkipTOPIHQTEm/u3mnFXBU6Zs148x92mNeZuTUuicNauFhwawUGB+4wLpx9rw
	hKLIKJwdSdKWSwkAzcjBMwtFHpzpwR/dg1VrnOFoEsfFxBs4uPOU61JbeFvMW/D4CiinnFT+kiK
	oMFbyF/e6NaXRRSoIhIkg2c2u1senqmUZryG8bbWhqLKPP2UMDpgOrB9zsSS1w6wepb3/GIiqVe
	4RkvbapZ1eQEXO45PLwYAUXXSbsfp9ZJG1T5oHf5SK665lvPLbDjt1WrrWieDIFRGHYfthzc9eZ
	p/6TDLdxt1M8Iw0ZvbhMptlfwWOF6dLBBKVa6CD+PbOoM4D3EuHce+vnUVM2ynKb3yd5XnJBoPB
	P9TnIG9Hs+YqN2a+tj1bLX/Q54Q6EpejiPBF5T4XrRUuHInvu3A74jk4ORH/uLE+AJiSbNUGFS6
	LboX5HMYivUzlQHrZNhLHB4fYg=
X-Received: by 2002:a05:600c:4f06:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4a1e69d931cmr119638455e9.22.1792441284070;
        Mon, 19 Oct 2026 13:21:24 -0700 (PDT)
Received: from DESKTOP-0KSTGNI.localdomain ([156.213.131.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d817d8bsm943142f8f.24.2026.10.19.13.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:21:23 -0700 (PDT)
From: Temitope obabi <obabitemitope765@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev,
	julia.lawall@inria.fr,
	Temitope obabi <obabitemitope765@gmail.com>
Subject: [PATCH v2] staging: sm750fb: Remove redundant NULL and zero assignments in probe
Date: Mon, 19 Oct 2026 23:20:15 +0300
Message-ID: <20261019202015.1724-1-obabitemitope765@gmail.com>
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

The sm750_dev structure is allocated with devm_kzalloc() just above,
so its memory is already zeroed. Remove the explicit NULL assignments
to fbinfo[0] and fbinfo[1] and the zero assignment to mtrr.vram, which
only set fields that are already zero.

Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>

---
Changes in v2:
- Remove an accidental duplicate of the note at the end of the patch.
  No code changes.

Note: Greg replied to my earlier sm750fb patch that keeping the
explicit zero assignments is good because it is clear what is
happening. In that patch the allocation was in a different function.
Here the assignments are in lynxfb_pci_probe(), just after the
devm_kzalloc() call and its NULL check, so I think removing them may
still be useful.


 drivers/staging/sm750fb/sm750.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8b93bfeb217b..8702f6313f78 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -969,13 +969,10 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 	if (!sm750_dev)
 		return err;
 
-	sm750_dev->fbinfo[0] = NULL;
-	sm750_dev->fbinfo[1] = NULL;
 	sm750_dev->devid = pdev->device;
 	sm750_dev->revid = pdev->revision;
 	sm750_dev->pdev = pdev;
 	sm750_dev->mtrr_off = g_nomtrr;
-	sm750_dev->mtrr.vram = 0;
 	sm750_dev->accel_off = g_noaccel;
 	spin_lock_init(&sm750_dev->slock);
 
-- 
2.53.0

