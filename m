Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210EA264627
	for <linux-fbdev@vger.kernel.org>; Wed,  3 Dec 2025 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764734170; cv=none; b=Q+JikJM2PloKq8tsYxxJuxPEllVrUp7q7Cz3ODqZJcYPo1ozEHhiqEXFspkdxwR+BKGHE2U6yaD9AvdEfR5vvlbbdXft5o54EifEauKQhBInOuislhnW1qVEPJHJf69wOfhYAq6DGvRSOkYyumMWg7agPjJ9s0tw6p6zmYjrv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764734170; c=relaxed/simple;
	bh=PMlRGDGHmJC+DPTlafzIHuUYQiPFJGWZdHKXsipGnfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVLk+nu8tNgd0BHmelqfcN+VIXRewgWQzzkpr87HsuiWk9WRDOkLK36zQZdsPVMbvn69suSrB4Ra3tF5qyStkloEKpZS48xTz5J9zPu46uFXBKfXf5le6bDDXM60CXvPEC1Hf3zdIVd2dhIsZ//DUyMXEyHabD9N+PkpH/mlulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=2Ati4iUM; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="2Ati4iUM"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bd610f4425fso3676582a12.3
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Dec 2025 19:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1764734164; x=1765338964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tAaOe3I4qqbjiAbuFCLi0zuJzOlC1rPEZWLT+Z/CQgA=;
        b=2Ati4iUM42G+qfoc/qMwoWq76HddJFlAjPtI4SBEsbg1sbzrL47Ip5Nm/GrkHJ1AKm
         It/dQZzif8DJ8zfDhrBOog+o7d8Ez09iYYI+y1b9ok4w0sxZkRHArIInSetbDJxd7DD1
         CVyyho9/NpTAZ8Zo6FMY1j1Jks1UPQcAxzeWUIYvI6RyBZDcte/VIPUD1g858LWzvHof
         ITdQCfUD0UTDEocYIx3Tc/d971TCh4TR0X6jrUu0yLotbMHbERDwAPnABsQgax0dTFcb
         +NgDDqRoavWeKM0nxX5cz48O85jn/C3wmGH6RUXb2Gmf/wKNI/7pBbOoLSCXCvtjUN3H
         uBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764734164; x=1765338964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAaOe3I4qqbjiAbuFCLi0zuJzOlC1rPEZWLT+Z/CQgA=;
        b=Sf46N21Fp+lJENsqllZZX856WKif3l8SJdRltKnS5rHq/p/mzf/QOd5x/r7O/vxA44
         Lzr7bNy+lBIwl74OP+9hVxPpeWwqXNQnriJLEEWcP4m0Tvqb3ai+NV8nrZpxkopT91sH
         WnghK49uchAk0Jnd8AygYX3EhGKZuvBsDL6vbigoIaT30FPsJ1rUL232t/ntr389Tz9W
         FKqDZt5p7xqlPUifDLaFYkKcr4FlBiMjDI8VpQimTeJ2kTnUUG2zWzzKQukM91YF7115
         OSeGnM2hgkf0m8cHdRw3fISPeJ5ygPDictrf1QAwe2czwUPIgfPGz9HdWL/Be2WarWVR
         c8tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMICtMXKbhvMrMPwLKCckTyycLfs/olvgnIVgJs4FnWfjFNMlHow3QrAqRVCAnd0mJ/6lNh4hIFIK4zw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx55qSAJuwKWqJWtE6uwecArO6t3GFqba3w+rUvxbgTLaj2Oarq
	Iu0IigAFBl5X8ut7XWwi5UlV1Sb1ytnXfjoYvGa7YMrvXMNlkAJtX6O8Dvwz/jpi0i4=
X-Gm-Gg: ASbGncv6sqR2pAdHiOyJ+2rW5oZyhKEXcax0eCMvEMCfV0zLmL54crJYT/j/HycxVzY
	jYymGnRstBr6dOXbnk8Im37zFinEt7/sFELVVvJzB/dXDi89ly588ml0OSs23E7O1dhBCzPsn7j
	MEhd4Spj6sEHCXnhT5vYkvrmuXUjitlOsgsblSvPQW8oJ0BTUHt4F1lAhcyHB+gUQ8co7ejAzol
	LeZmpdb3awqnpKU88sGEYfH4ZtilShI68D+YKnjkfCiSH4EZkFA3h7RgNAd6ptGi6Ox/H7dkACb
	wBZw4KRI/8WXHcSYKlQAC6JMrPqjVSzt3s/h8Lz1CBwGQXLz7jCF59EOU/iRvpjioP6WP7HOGxD
	0yAviKkmeworaFRS9X9xneOf9wXd9Ei6fBPbarTgfn78W0OrLhmn8XIbnGhZCYFFyjLtQq8jtLH
	BHcdpfyVQlaqYp440HzF6+gHdX
X-Google-Smtp-Source: AGHT+IFef9AGSAm8GKX/qr/Br9lF5EWDpBydbgHDWnXJYMbMYZGYeYLEZP4+XBsg5LuvOZUhF/xKRg==
X-Received: by 2002:a05:7022:91e:b0:119:e56b:98c0 with SMTP id a92af1059eb24-11df0cdb884mr855726c88.39.1764734163762;
        Tue, 02 Dec 2025 19:56:03 -0800 (PST)
Received: from localhost.localdomain ([49.37.219.248])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11dcb057cb0sm96287741c88.9.2025.12.02.19.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 19:56:03 -0800 (PST)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: deller@gmx.de
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	niederp@physik.uni-kl.de,
	tomi.valkeinen@ti.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fbdev: ssd1307fb: fix potential page leak in ssd1307fb_probe()
Date: Wed,  3 Dec 2025 09:25:44 +0530
Message-ID: <20251203035546.26849-1-nihaal@cse.iitm.ac.in>
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

v1->v2:
- Fix incorrect call to __free_pages with uninitialized values as
  pointed out by Helge Deller. Now, the patch uses vmem and vmem_size
  which hold valid values at the goto site.

  Thanks for catching. I'm sorry I overlooked this in v1.

v1 link: https://lore.kernel.org/all/20251202191225.111661-1-nihaal@cse.iitm.ac.in/

 drivers/video/fbdev/ssd1307fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index aa6cc0a8151a..83dd31fa1fab 100644
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
+	__free_pages(vmem, get_order(vmem_size));
 fb_alloc_error:
 	framebuffer_release(info);
 	return ret;
-- 
2.43.0

