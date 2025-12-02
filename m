Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865022D3A6D
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Dec 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764702781; cv=none; b=l9X8kh0MG6vIH/qEQesQa3Ub3IC37CRqFCEykCqY9Tw81WLR4gNLsnOMMkxDFx/WglSl2P2NWVIsaK7Pd4Q2yfuealZNEq0cudVW+GPU7B8vhlPvVcP8YxLUL7HKmtzuSqWKc0GvL0tw+Un22HzWMY1JCoqa1b66e3wy0teZt2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764702781; c=relaxed/simple;
	bh=aJqxN26iyh01OpmUFHeP8iQ6CzvehWVKu4DKcNMn5U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnGTOfNo31vr4qPl2cBO4n3pxj3WLjsuhIvTpJwRhcts71VVCbyQvbqYn1lVtaU7Pcww80UbYsn0Lg7JVKYwv4TJVsCxSUbhT65rm7llSTCmiu3n6qRLLhVOdHPj2wEEy0PJeEAnQIqyVaJIydUdsDSYkkCKzsSNUelWrlSNIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=UxHsvoYZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="UxHsvoYZ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7b80fed1505so6847767b3a.3
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Dec 2025 11:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1764702778; x=1765307578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoDvJkziLciYTaasrjPuBKQQWe6VunhAtZWNX1bE3Xc=;
        b=UxHsvoYZM7IHwNIcZuKFTdo4yEFaaiXQHA47lrcPleW3aiax3+ka0q9vYPIaX0ea5r
         OvMa462myGvLMIGdXeCw4rjZTcz3Nso9kaeCK1wlWOR0+uX3xePlD2Kc3O7wIalN8chj
         rlbOMSBn+x78IZ/onzIQWBHHuDoZZ/VHHl+NioBgq+1FRTfH+/2bGMDNAgPTNrSssoen
         mi6ULZdQAF4SLM1QRNCn1zGLcVostcfoiHk9ROITSFK6TpwjKZ/xeKTvNruxAk2Pqwet
         YrIyg7XfoLErUj48MSea/xat1zV/E1uYo+xC/kGpgHnczLEJFtVhx9tmMTtwP98ibuxr
         XlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764702778; x=1765307578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoDvJkziLciYTaasrjPuBKQQWe6VunhAtZWNX1bE3Xc=;
        b=HnuLO7OSfFASAjiUethJTWvT0182fjm35lnSUHwwAQKo4JHG7rbWo4a9vHc6fw3b6+
         S3J1grqjCPZSzjonHUhait8zFkA4xbn524yTwuzPihCngYwkTgknl1t7BXR4gnDLodhV
         h907cwOEf6gvuf1oQY4ZBVDgOiYFW+/g7EGy4SqWEem7zsROnPRWfBg+7rfi6E1A3+ld
         DPu0HWr1zn3IwxsuUhcUH958ss28mQNBXgJa1+F0hcLQGZHtSPKZroHIrrh5cA9uRzvy
         5BAqvUvUXfaetTSudXN847ZR9agsZUjG8pEe3k8M/Mi1HhQCxepNuBu0RkcrS5m/kW1Y
         gbyg==
X-Forwarded-Encrypted: i=1; AJvYcCXE4vXdy3ALCoQjsduUD+nIN7sBJdNB3rgXikPn2V71G+dV88SJ+43wfDID/SKQ9jE3Xvsp9Ms4zOLXYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BYo03UpnBbNbIP9hEllq6EY8x4AtVhMtssCbQraCWnpr86Nd
	ddrBUA7hz1G4MLIXLwBCzlg2g6QPLS/BmluFRv654WwpRY0DKBowsu0szG8MnH7Qidg=
X-Gm-Gg: ASbGnctZPX/W1/Y9ckP5agZX3SW9cToHXOpVmt/0XdWck9lZR8gLkUVjPDWVMufGTn3
	mhF2HSsGs7jY6S5SdYP+05EvfHKuD8efHPFCXpxBNeo4wFpy2qTxu1Nw2WinyOcMOQuKB2yLhvf
	0L6bIr+zf83oUxs+sD4UWYnT2/52tUMlWg2FYizemyHP5EYBUHr56reEvwGg4mErubtr6FPT6uf
	dPCTz+sFKv2AFjmvixiI4UPcsJ1NInAcvPsfCcYw6BGd8OuIJUkjwidPou8ylsK6eJd1gVeksZ1
	SJBulrK0qun2OvPjEzP1KKdw5HzHsRZ3x7HcckHVOoxeUS4szTHjOkfe38tAccIAlv4GE2tnX9J
	rpGfj41tXGVNQMXUCSSxmVoTDqRkefranGuAkLsDzziB69mAqsA2GCws4HnU5uzPfJSdNT1SIaX
	HsvXe10EApc5ZhrFbCNBodvOb7
X-Google-Smtp-Source: AGHT+IGHE284hn7+9senBlcCjJEc3rGRR9ZhVxdNo/lvuyqVWFH3WIFqOw9lMAheJoHvJpVQbmA5cg==
X-Received: by 2002:a05:6a20:9389:b0:35d:8881:e6c6 with SMTP id adf61e73a8af0-3614eb0ff86mr49211981637.19.1764702777406;
        Tue, 02 Dec 2025 11:12:57 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-be4fb248be1sm16064567a12.3.2025.12.02.11.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 11:12:56 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: deller@gmx.de
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	niederp@physik.uni-kl.de,
	maxime.ripard@free-electrons.com,
	tomi.valkeinen@ti.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe()
Date: Wed,  3 Dec 2025 00:42:22 +0530
Message-ID: <20251202191225.111661-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page allocated for vmem using __get_free_pages() is not freed on the
error paths after it. Fix that by adding a corresponding __free_pages()
call to the error path.

Fixes: facd94bc458a ("fbdev: ssd1307fb: Allocate page aligned video memory.")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Not tested on hardware.

 drivers/video/fbdev/ssd1307fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index aa6cc0a8151a..66da8a1a0941 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -680,7 +680,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	if (!ssd1307fb_defio) {
 		dev_err(dev, "Couldn't allocate deferred io.\n");
 		ret = -ENOMEM;
-		goto fb_alloc_error;
+		goto fb_defio_error;
 	}
 
 	ssd1307fb_defio->delay = HZ / refreshrate;
@@ -757,6 +757,8 @@ static int ssd1307fb_probe(struct i2c_client *client)
 		regulator_disable(par->vbat_reg);
 reset_oled_error:
 	fb_deferred_io_cleanup(info);
+fb_defio_error:
+	__free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
 fb_alloc_error:
 	framebuffer_release(info);
 	return ret;
-- 
2.43.0

