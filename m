Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2837C90A
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 08:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613957; cv=none; b=AvJqFZBHJwehyH1mjop8dgrNAWpOmsr3+8mnmkML+jf3uKQbgzpTBhNMbXG4Pm3G+OiWuuYF+0FA2koHLeYjd3APT/246rQAqjDvnwJCS6D/131BDeD+wyFcR76Pjl58P5RxhBwFBNGYtU5TVgF0a92MVHQyo9EQsxWzSDbCWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613957; c=relaxed/simple;
	bh=THfLGrQRHE61+kilKBL8NidbBAzC6FOlwjMO3nb9rL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/o37G/THST1q2pIeUQk3mfRSu0WjW7sgCVg1aGDp9R4dawAhqhn+t4v09zLVbmmNyPvl3rjG8U6mbxcGIRJO27rQmuTtYbNUDTzxnKm15xroGpPS+R8syiIskQh68MTNJ100oC9VRXNFEHZIInHCRKrmKbAplTYTde4FXf/U5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQ+4PgAL; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQ+4PgAL"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c7382963b67so25648a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 00:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772613954; x=1773218754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THfLGrQRHE61+kilKBL8NidbBAzC6FOlwjMO3nb9rL4=;
        b=TQ+4PgALY7nBbF+m6RdcIgrjUrQG4V/wAFx0uyu2XhKVlw/UmMKTMGAwPkb8jjWjP3
         fM7sFZXPRxnP1GOoBu6u6LYykoO/jHk20cpXwUTAiUjtNYuYFwcrTMRK8Tn8WC/gzOJw
         L5R+VjshglABJj5NyETvKYX9/TriXQ9+Y+as1CHIqGA0dtibB4mNumIK/N8m7oPVDE5O
         Lc5UfW7G9w0/T5W/TzAwWoNp2sd3VgCgnrRmXEk3eNE7e4X09LPQBfwL1ro7qJ986xdq
         KIShCA0tF0x+dMGJKoz2fqHAIIUulFVK6F8KrFpu2NjnVoc/gEfnlnZ3LVKfs1Wi91pE
         Z5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772613954; x=1773218754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THfLGrQRHE61+kilKBL8NidbBAzC6FOlwjMO3nb9rL4=;
        b=Ds+Yyve4UzvMltENzLCddhRsvPIKXasqJIGEdj0mMt18uf0d/HQFi4+Q940IuZf6vB
         ecOlKI1eVN+RAP7E2M3kcDmc4v5o7Jn8eibFShgLGiL7cJBsg70j/xL4p4zfnAxCK8mJ
         viec4F2X1DH4YOzV+cfCbVK9x0n9wRYwpBp/4DeQE1deGauQpuk9Kk90cklL82bA7Dr1
         jlMqD7Xbik+NVAJKrhwSg9ky5fMGf03WQksRrLO+pvVUdppOOx4bOJVAMIe3NAceMFqY
         tesKy6PmIpyvdb/OUdWuvTmI9bT+JWvDgXen48XQksxi2ueTX6O9kUmJyrYPx1LIlkGG
         tz2w==
X-Forwarded-Encrypted: i=1; AJvYcCV+EJhykCgJe55F5g6KluUuR6oA4wAf8FgCgnBzKXtjLZ6xwCJzRFCi6pvJJrErMmhb30vAyU9wupF/qA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqUF9k0twXlc3HcF8xoGds5X5X8EHgncfELdIJEivOn3NnMjL
	rB9gvvQ0qKO1c5EwelXkIlUVO2xM7smnAScI88zVVBwIZZ+vhl0dJNlc
X-Gm-Gg: ATEYQzzOaT+BzzNI7uzPtx+Qycr356B8Z+4c9ErztabZjMesMgvDXqr/tRMKOFm9L45
	6oRTp+op8w1aW8X5QJKV4pFg1BPUxV2JKFboycRoeqUFQgDRUOcJ39pUyBnPgpC4l6MpWCee6eI
	zEOjbUidt9wk63RVf86g1e/W7QpVlthWKTM4bWrzCblTm+FyF4/Mh60XWPMp/Rq3XFALWr82Dut
	BeJw8dMCUwWPed58zC14MHj8fdkW1d13hurl1VDsTBYgWsbSJWu4CvS70UjSTl6JPFesO6C3MYg
	CPBolr983LfVkS8pwMHyp1ofMcvIjYWVgnjdyCMZmSZtsdig1xjS2HKMBEHw1B6tfkIqO9ffFr+
	VKamfPIr4dYFXatYX41Wxv7qhM7l325b5t8WXuAYGxHKIrVN5e7Sk5byfxLorZfRUZFFd+JZ5z4
	gsccGEZM3JKoP6MwGS6mBPmWNsyAip8iuSltfwykv+pELDY5tD2GB0qoyPuKT1LhhdwWtmW1ZLU
	x3kg6nE5j+Amww=
X-Received: by 2002:a17:902:d50f:b0:2ae:59e0:5127 with SMTP id d9443c01a7336-2ae6ab51eeamr11137435ad.3.1772613953992;
        Wed, 04 Mar 2026 00:45:53 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c5esm122010285ad.6.2026.03.04.00.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:45:53 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH v2 0/6] staging: sm750fb: fix error return values
Date: Wed,  4 Mar 2026 14:15:39 +0530
Message-Id: <20260304084545.156170-1-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aaVT1mSeKrSSlrha@stanley.mountain>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the sm750fb error code fixes, split into one patch
per function as requested by Dan Carpenter.

Changes in v2:
- Split into one patch per function
- Propagate de_wait() error instead of hardcoding -EBUSY
- Each commit message describes caller behavior

Soham Kute (6):
11ca38f0ec63 staging: sm750fb: hw_sm750le_de_wait: return -ETIMEDOUT on timeout
28df828cc89b staging: sm750fb: sm750_hw_fillrect: propagate de_wait() error
2378ece78154 staging: sm750fb: sm750_hw_copyarea: propagate de_wait() error
85139ac8c7fe staging: sm750fb: sm750_hw_imageblit: propagate de_wait() error
9c2430311e23 staging: sm750fb: sw_i2c_write_byte: return -ETIMEDOUT on timeout
915599b01e9b staging: sm750fb: sm750_sw_i2c_init: return -EINVAL for invalid GPIO
