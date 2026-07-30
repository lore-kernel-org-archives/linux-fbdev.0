Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9C44C67B
	for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 18:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785436034; cv=none; b=Q3Z9yHPU0dv18WEBZQC9dxCwIFN8I3v28J41IQF3FYmdvuWxZSNh4Ajiz/ViOuPkvy65EDOKPT2bvBMVIdyYeWc71S4Vk6pSSUPvvUXA0Vq9rcMH8Vg4W1fI5NvJUUDzXMKnjyAmepEIuwpWEVMphvi5ssnEnIccXYhoo1RrImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785436034; c=relaxed/simple;
	bh=yVpcirTfEpf2H96K4E6NdKgRE9Q5aIeQxaEN6w0gwyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hplWbhjaQkIra4pKniQFKRbCJZyFjAgARVIL4obA5ZYObscXrwQ8oON8pKg7F8bvMtjBhg+J880Es9JjnKXAJ0Ha8azvkb9yGCThmEqvPp9qRG/onRwwHUFRgkwn41SknXJQchjyK6uYr6whjdUqGivMhC9mrRUBBl3Lyu0tlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=mDoOsYVH; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="mDoOsYVH"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso236185b3a.2
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jul 2026 11:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1785436032; x=1786040832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XFQ1vlo/U5kPhUKDIkSFcUBW9GP6124E7pQ5VM7OJ4I=;
        b=mDoOsYVHh5LqOmzMB4RUDlaUH9Kn3Ga9rMHHmMq9PgL30NcJa229KMrSu4wY2vUpaO
         Dv3//fcJvC6jh+IZEjSGicxeGVPxBILr9mftrXIXsHe2dH9Nx7Qq678eGp+OobHMmG2R
         FjY73m+JSgoJWPTPOCRfaLaFdBlKt4DPirHMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785436032; x=1786040832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XFQ1vlo/U5kPhUKDIkSFcUBW9GP6124E7pQ5VM7OJ4I=;
        b=Mz4gj+WTcIOpnIfqHIi4OKkRSU8wMK8DODqGnenux8Pca1kh+eatl69ccczeeDBJvJ
         YdXFxyZ/ZaSaEbWpxoOHRnR5QTcGxe9SzsHmczD9ZPI2hYntnjC5YGAejlBcLXW1vfYJ
         V5b/gY2KB9qUyt/XN2olZXkFbVzchOPVceGAcAbnhQdCpyh2yYYAFRsQYv0UsjzzN56+
         m3a7oPO8kb9lE7lgOd404wXpBtofrVCHmWa121lHE8S0oaFXMmnTr1kQD1liJOWmuzCz
         IjdQ/Q0jGesgAg4/uFPslyfWUS3FWnbnAdUSAm19g8rPXkZCgutcfhVvpHap3HqYBsf4
         sBcQ==
X-Gm-Message-State: AOJu0Yy5Myl7kD7yQOMgI8sQ4oeGvbbobF6a2hDRsSAE5kCw4JnCKRyB
	3vcA77pJQ3BbTvF17ah14qMDag5+1frI+4Eb4pReM640AS1TnNMzfGRGsyK9DLa+m5c=
X-Gm-Gg: AR+sD13TUZDjCCDiF2ldlU4SzvBV/RuXyzc9z4EnUr51B8d2C0mOhdr6UnumTIxNFES
	ex6qymIwloE1PxX9HWZctTXkK9Bvkb9sEM5OV3cepM6Orr/S11pIBU5dZGJ9v/30n3HEmfEsmsF
	CPHZUeOP2otJH1OolIZlYrRSGYRkB7jtRBmb+g6ZRZ7AJfMP6gAWnrtHAPBjz+XTeDYUMBXsT7l
	KXXtMkdTr6wmAuYItKSr5fPLZ1ofgWLWJj9QDM7xKHqxCfPZJyJ04P0/2xABEi+yIE6tbWe7YWu
	Yfnyn4Fb4W1nFQKLIiTxTfvQkh8tk8s9hUiNB8vZJXZWUymrO6L3gFfH2R6pd1oGtnc7ttik3wT
	AzihjZlJLTZOWZWS0ALErskggZD3EGdywlfQ4UF2R8yYBKxFJdNg3puEoULv/RPovfjJw7pkR+9
	7XwrbaIvE9DVJCJKWpREPK2eDPwDC7OV3zcJ/XMgbm9DvLXrejW2I=
X-Received: by 2002:a05:6a00:1391:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84ebc1f5bb4mr3620610b3a.3.1785436031780;
        Thu, 30 Jul 2026 11:27:11 -0700 (PDT)
Received: from shiro ([2400:4162:2428:2ffe:f84d:1f36:28ac:c15e])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-84ea0378b18sm3428806b3a.48.2026.07.30.11.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 11:27:10 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 5/5] fbdev: tdfxfb: Program the initial video mode
Date: Fri, 31 Jul 2026 03:26:40 +0900
Message-ID: <20260730182640.2808572-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730182640.2808572-1-daniel@0x0f.com>
References: <20260730182640.2808572-1-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the card does not get bound to by fbcon set_par() never happens
and the initial video mode is not setup and the display detects
no signal.

Program the video mode and also clear the framebuffer memory so
random garbage isn't displayed.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/video/fbdev/tdfxfb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 9d55efd2c934..d03cb47b34a5 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1692,6 +1692,13 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * Our driver data
 	 */
 	pci_set_drvdata(pdev, info);
+
+	/* Program a video mode so the display detects a signal */
+	tdfxfb_set_par(info);
+
+	/* Don't scare the user with random garbage on their display */
+	memset_io(info->screen_base, 0, info->fix.smem_len);
+
 	return 0;
 
 out_err_iobase:
-- 
2.53.0

