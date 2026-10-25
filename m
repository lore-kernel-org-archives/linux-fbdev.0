Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960026;
	b=ikzL8DGLASg9nX24Zj83akhBTTfQ71+TEByjZLxyQVPx4AfIqhVHxWBRMQm9b62gkyoX
	 nwatLf7R4gs5MKMqJX533i1FcarIHda10CJCluxwl3l5tMfx2qYd+KXoYkQRXAwRJ2zcw
	 c6hg1CZgVkuohw96nLXhr0F7CFEE36ylEVmYYRNujUbCoJtA0HBoFQAoZQGBiO0SjA5Zh
	 ZB9Bndl1vT0rOvvxk5wFr6hWS3eOcoLSMye7rs917DdD5DUJe63fuedD0fh+dzRnUqFuS
	 GFsPqKiIiLkVwmAaKpE9G2u9z2jvFVGf7mCAdqRhPKJs2MREifSGdej2EVzmAFnmxKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8sYUmjJXh+5g9W9rBcPWe/gvdOEiK2sbnLcw/CdbTc8=;
	b=EtdjJ6VlKVeWFC4hTil1uxH8L6lJWhoUflyW0ixRgSWUk/TNQZg08xILN44KLus0xjtz
	 jQUkVH2nHJBhhWMc9d7wAjfuu85GaRgGHb68DoDr3VH1FZ6bi5P+y/wlADaGX/etOMiNY
	 7Q6NUiob0cOibmtPi0S8fFUijec5gze8OQqsyPKjYV7f8ni0Bkv+G8NGMNP+ZCONPkNfl
	 fwjbFX3dIO67JHStgjd1F0ol8OcoDbm/t4OcRYBCNNWsauR1RaWbHAMDUEQzAZAbbpMSc
	 sxGXCNMOxFvbS7t7BzypQG8fj1q9SrNTzwgW/SxuiwGTfJoTvH7UN9jwANYYB3SzTig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b8gs2huG;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FCA606A31D
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 20:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48FCA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b8gs2huG
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so6571445e9.2
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Oct 2026 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792960025; x=1793564825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8sYUmjJXh+5g9W9rBcPWe/gvdOEiK2sbnLcw/CdbTc8=;
        b=b8gs2huGNtbu8k2ZNPL5mkgJ2Laqx983J6efsXNA4u7Vsc5PYraIv6MxdGUBeGsafc
         KQi3VS/CgX3w183o1vzlMJ+yiyuJ/zAa5RH2PQRkRI1J/LFtzKtHk64PUHane6cvBZ1W
         SRzTlSLYxIlNu0hL946XPmDWabkA9Giu+XUM+DXiAngrtpUvsCoI82nCwaEwS86nDExH
         RACXSjOqXqoI7JT7IfjLc/U9fj6tZWefxP9yPE20ErQxcfkfqTn+0hDMIn8JU+r+IBos
         LGMgRg8KcU88DGV/K67I9rAzhDuEkkW3WPBJfO8aU94hccI8ByVc3AW8mfyhip6VVcAZ
         aiWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960025; x=1793564825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8sYUmjJXh+5g9W9rBcPWe/gvdOEiK2sbnLcw/CdbTc8=;
        b=EyW1pdbBd/PIY12Lo5WfodMNrWCrL93JgWqUSga7z0w5AnRnyzlrOdPDLGzvlfgb+A
         C06j+NaCUEW1NiujsU9X7/KyHbI2mFEpFWi+Dyr9QFHZZnETiTTjhrkYPlRc03ThwqBG
         8V6u63qDIKGPTFL9V9p7GwdnmnwEDzlh2zUBdgKT4936jflQKkUYLkTTmfm3WnKHdTGL
         0L14aNKR4vlWZ2/HD6SpDldKwF0b8IQtHD1X9M2fijY3IcrKgPt9886i4NYCoxDyG13N
         jLe7sYbAp+j9RcXFelFy+Un5l8LWr1Nhhfl9vxKmIbG7rKiIRrsDDqzUqLNWRVh6WZyB
         rvuw==
X-Forwarded-Encrypted: i=1; AKwUvBxfDbba3Rde+8CIaJVUmubnL0BLgaTjhgnFnDhKTpu6y0s/vXMj6o74428r9TLkNxiIhrf5nxxch1OdzA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIGuqhlJi95XyKnbTk0HSaRcXdtILllV4n1gdwuxt/op4YK6IrH
	uLVvsybFjq2dQKsKZZMgBqQhOMWVRTDqSd0gB5pg8gG+ud/UdV+B1AZi
X-Gm-Gg: AYBFou1Y3q26c9eoqY9HOgiM1QJQI+KreQn9SxAyZ3vpSfDHYvZQ8ZVbud1yNtKf/af
	PiU+CzkFfCA98ekZyLZ0mJE7t24gluJeYIZluj29bG/c3Sb4QpXXkZQjpDXLXnds0IYUttbYQLI
	Nc/MHKKIW0trmvgBf7XehvybW6KAqC+4FvKl5bO2OsQa2jx1BN/EdH7/Q+doYbT/InoXCBpXH5j
	OEHZJox6dZg3bnWbIwr/hD6BrwXkJ5k9R4zKl/uDgxUbc9Ix/k/2MG/tz5TpdYSu4b/3AaRk/r9
	GRAbjbYYsBsFiLfKzKPcDioNkZZESXzOowCy7X8Dnp/khXbCryvhP758AuhtoW7GPmEGeN0XmEX
	BCks7z+UnPvwz+VqDRqCAsZJa9zTZD/1egViLdQts1nwtV7HQOuaNPrMBit2OoC3yI01TRR/VGH
	6nNWuY9CI1fHEfBohBD7saulCkIJXKnrcPMpXs985AX5T2S+HgziuMohVTaQkBj75BhMTBtCux1
	gwhEjpbMKgo6/ZaxhGNrZKEy5mu6ccs7p0f/JCSq0yYZr4Ow+Jn2zqPGdgzAI1D2Zq+i/MjofVc
	IjSr4lM44ZU9YteYxw==
X-Received: by 2002:a05:600c:870f:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4a35ac9d1cdmr82312895e9.17.1792960024499;
        Sun, 25 Oct 2026 13:27:04 -0700 (PDT)
Received: from Ubuntu-vm ([115.186.50.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm129197415e9.9.2026.10.25.13.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:27:03 -0700 (PDT)
From: Haasham Khan <haasham93@gmail.com>
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Haasham Khan <haasham93@gmail.com>
Subject: [PATCH] staging: sm750fb: remove unnecessary goto
Date: Sun, 25 Oct 2026 20:26:37 +0000
Message-ID: <20261025202637.9274-1-haasham93@gmail.com>
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

The goto exit statement jumps directly to the following label.
Remove the unnecessary jump and label, and simplify the conditional
block.

Signed-off-by: Haasham Khan <haasham93@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 21e310274330..66b015959963 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -815,12 +815,9 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 	var->vmode = FB_VMODE_NONINTERLACED;
 
 	ret = fb_alloc_cmap(&info->cmap, 256, 0);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(info->device, "Could not allocate memory for cmap.\n");
-		goto exit;
-	}
 
-exit:
 	lynxfb_ops_check_var(var, info);
 	return ret;
 }
-- 
2.53.0

