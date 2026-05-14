Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593F3D812B
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747119; cv=none; b=unUwhDUxW3MF8kCiIiVP0kcyzliSzNhwJ1Nj91SFl6SpT+oTccCfN8RPI2dMxKZdDWbmeIE+ahV2zbTuVJ+v3AbJQcMMQ0/sQskGxJUlJSyExP9O7NHQBN158+YH+P5TnsBnBA01b3YcaaTBpQEkZ1adh1iUCDFkq8xazBNRqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747119; c=relaxed/simple;
	bh=s7vOJa8zQULdRpt82vMyDCCkIAR3Vt7Pe6/FpWy2FrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMaJ72eyzy9+VDl84sU+IJIB5i17BXqVMC4u3ESF8Eg5l19ubGi7jCT5i7/TNMhrS869uD/vKFGGoSUXaVMFU9U/wV78dDx9eyE+GwcV/nj3hOugoLADuE/QzRGXgkVjGRPE1FYmCOYX3oOUtcd9S3GmGxJ3mfP+h0+eXrBiwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=tcuT8auE; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="tcuT8auE"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso3208316a12.0
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747117; x=1779351917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJh4Y1vJpYq92CQsC3/GcBHFFxqYLe8usjdVpu9K90E=;
        b=tcuT8auEbn6gOYZ72sU9YTaYv0dH8GExcpdHV4HPr82hDl83wGoqCpq43XY8XTrpQb
         3wRlqXczsJDiswRLRSVMa3vIH6EgaL/j96QJT6fWcswSUlAZc2h3M8J+fS2fnd4qhnRx
         KGm8ZcH86jrR3d1hwrW7KU5W68xrECBHMU+GkQgFDMMXBboLVa4jT45FQl7otf4IEUM4
         +bdYLwZGsNy6KUPiAkZ9SaJ3k0NpThHzLoiKoFarbFIGXb3Y9EAcTUenHT6ZVFJspBus
         7U6KkLYf5Y0LfPsTBo2ncYJMbmtctcuhbhtH3DWUcMyFyVQmZ/tGe6T9fXggBNHe8sWZ
         0EJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747117; x=1779351917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fJh4Y1vJpYq92CQsC3/GcBHFFxqYLe8usjdVpu9K90E=;
        b=a+icVVJZ+llrPXieSC5MJPDrgSInFigaz2mst28Mn9XqbQ1ta/SPIU2gSJMdjL+2Po
         Kxtwm0TiunGsFGAEWI5sl9cY1Ea2ZXUFMP6i6OEcYXf+2NT/kB7SGxv+JTd+cRvcun8u
         YonfpJlvEhwSbvytz3cklK7nQ5fHJM+YOIXH9Wqf87+HC3XaOU9rW3lRZ0EnHzgDDZ2Q
         W2d3yI8b/D/FmT6BzcKaR3vebKPQt+x+Dn7eH8Huozxl8f+YGy33HHnOiOD5LyuMPSRL
         5VvAuUTFhWesvsGXWWZjPASDWc8Zsn8XLmGdKNiIxAXCQSkQ6PWsfzebM15F+geSR7+U
         LBLQ==
X-Gm-Message-State: AOJu0YxVLXzzkMfYLJutcownqOzk+eR92EhOHPrLk943myqmyESiC/TW
	pyinhwdzmAWB+m8p4g5f3fjx0Hf3j5D4ku+ny8+Juo+1UfrZlS+WsgQC/Qhai6u1GAM=
X-Gm-Gg: Acq92OHHA5i6Wn36O6CDVkRPS8BO9rTUx3UE8njxSL6d0D/iTBqkoQ6JwReYXCTqur6
	PUOle3e66uIpF50zfnB/PfSsgoxHDR/WghIx23bRVFOOxGNYQjhLKvamOqwyOtavnvUzqhX0sUL
	Sg7PMzsRlvH9f90WlFhLOswtF0zq5atgcJNejvxEN+/x5rMFOU85dEvbMOrcIylmc5M3SjzWXVl
	jaw7B7PMmsTMrDLcYs6OhbnqPxPfzneIN8xi4uZW6DuQlqDGU1kR7eOjtL2BpLc6uyvRA7nPSrx
	FxHE3374XY+bD3tdKFJZEb1pNb6rc3BJH142roqR8NkgWD0KLhwdQfxpTE6gipdTT0nW4c8viEF
	VGlNDPAWZDlnLaABVPWKJ0EhIM8YwEwelXipAsL+30cjWpgAv9QNA3cu0d/slD9nDgt8AuF4/Ib
	LWF1h9CIJSdxHM7DALtVfj7K+ebbqA8ilplnXcmCVGJBTd4a71dLzrSLd2eDlzK6v8b6x7A0qVq
	KCYoyiiJqt04xaiH9J7RZGfV8pwISEx9ozCpMEE7BxrAGs//IjtUN8=
X-Received: by 2002:a05:6a20:939e:b0:3aa:c99b:5c63 with SMTP id adf61e73a8af0-3af7f25ba7fmr7209249637.18.1778747117417;
        Thu, 14 May 2026 01:25:17 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:25:16 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:33 +0530
Subject: [PATCH 04/14] fbdev: radeon: fix potential memory leak in
 radeonfb_pci_register()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-4-b3a2474fa720@cse.iitm.ac.in>
References: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
In-Reply-To: <20260514-fbdev-v1-0-b3a2474fa720@cse.iitm.ac.in>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sebastian Siewior <bigeasy@linutronix.de>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
 Ondrej Zary <linux@rainbow-software.org>, 
 Antonino Daplas <adaplas@gmail.com>, Paul Mundt <lethal@linux-sh.org>, 
 Krzysztof Helt <krzysztof.h1@wp.pl>, Tomi Valkeinen <tomi.valkeinen@ti.com>, 
 Michal Januszewski <spock@gentoo.org>, Heiko Schocher <hs@denx.de>, 
 Peter Jones <pjones@redhat.com>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0

The function radeonfb_pci_register() allocates memory for modelist
(by calling radeon_check_modes() which calls fb_add_videomode()).
The memory is appended to info->modelist, but is not freed in subsequent
error paths. Fix this by calling fb_destroy_modelist().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/aty/radeon_base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index adb03489bedf..b6b058cee751 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2476,6 +2476,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	return 0;
 err_unmap_fb:
 	iounmap(rinfo->fb_base);
+	fb_destroy_modelist(&info->modelist);
 err_unmap_rom:
 	kfree(rinfo->mon1_EDID);
 	kfree(rinfo->mon2_EDID);

-- 
2.43.0

