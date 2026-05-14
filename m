Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E453AEF34
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778747184; cv=none; b=oO6Y40X+C806zoMNK7g+EGqVudLDe2jKFzCPoTIFSharMGX4RzyzWXNPZCivf6nf1eWXm8gfbZ3gptSS4R028c0qssdH23P8oSoVhnBRAMkYE4M5umyuyetrBNWMcBgYHE4XXfU4UPmbLpg7ByCNNcS5drSRCw4Uj6FOHA1luXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778747184; c=relaxed/simple;
	bh=IYxpemUzApEKYrRLdtgG2hm2hB0JVowGXr41xfSQwNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZlyyDDpZVFF+QaSNxJOb30RVhNTwPgxtcRD7rFnAi2WFfLwPpiKhYtjyjRNqCQmuYoUOIBBQH91P84zyIwdNmH0/cbdruTocBlkQFK9r67R2pPOf7fAIrQ84WKdpj5JMlf5uPdWfhcwZ9hkjD91ed101dhoYF8ru2YfEgHNSK0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=N4djrP1e; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="N4djrP1e"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c828daf83e2so2232671a12.2
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1778747179; x=1779351979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bcm+FEfphE7RWlNG6KH2TrNjmFAxIKcw/vHzKLgiSIA=;
        b=N4djrP1e2EnGfPPSSWpRwc2m+ldSTOCQCL1Ub+kM78RtnJUjpiWxERDjGJGP9iS1G2
         fGsO8xXuYbbTU3xjzMprNuTfOXJOfm83B+tP5x+8jMnED+xQSQdzAS1lRq5Kc0CuCs7q
         h3VEkcrldyXHjgL0uSI6PFIwYLsoyODK6s0vc5yS2lGzwSWc4IZ1qc+azLXMyj2TWnb3
         EI+zcL/WigcJub6646lqlZgHkUXkH5PrGEYgCr9HxmbC80XOvGmD6R0fjcMYj2ZZ1bkn
         U1YNfcgmVwKUGP4oKHsrv/IVAUfdSvfj72ZR7PaXypXO6Kfv7DxDoPfnVwhtHYklDMfW
         JgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778747179; x=1779351979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bcm+FEfphE7RWlNG6KH2TrNjmFAxIKcw/vHzKLgiSIA=;
        b=rOL5ScB2IkVgTNg36XQfvE1aTg3jkhw9fAslC9HZHnhNgfAgR/qkuZpnWr0hDzOX5V
         NsmMuQwjbgCQY4g5q+uqGcs91MuCy5AyomCbuKYmWrfDMihhZK9rxf0yOPAqQKfLtnjg
         bqY6tamHxDpzZ2X4Yy6L/TT2vZEFPuCF3MR/MwJPy7Wn7zmYi0kdjKXLX6vfRjCCrL8U
         OtOX2K05wiCkum3X+aejg547FeasXCLxKSbNL/P93fOjD5Ie19i7jNK5bcZc6sSNLd1O
         COQBJTINkk461uMHfhfYcxIGjyxsXxyiHAGBxqsSvhHe9FopA1vDyn05gZXNg2xaZrsd
         R5og==
X-Gm-Message-State: AOJu0YzEtOLy6VtuVs80DXgwaqlw68eWe0CAJ63aBk400opV0WQjtMlv
	o+CmAfefnQ/QJcC4ZEzYHR3v4VClIwtZHwZX+hETeqqVLPsy4AqgcD8976rT2UWKd/c=
X-Gm-Gg: Acq92OESt95unen3R+qUvdp65dPVK2qaofTGqQVyPExV0uuabPOYah04Qp92qZ7pr9F
	scjzQUq0GV8VkOVnlWDOfQsNDw9f+TyqbNf/cNpZseNYPoPXSr05CsxYV8vl/jRBTWFPmB7k0qg
	l2rIcdgx+mOuyXyqodmyuA6bv7tyW2TdBAt+5TYnw0pQfykJvEMGUroS/2Asw65DA7QeYcEpHM+
	OuzScg2HQRHh5V3P+poW2vCNnvrTpCqHWcjcaxduzurfy0GhtWz3ZpV8dsLeXgBG0/yZTsYFibB
	jGhNmFbkDJZNRa2R1R+Vg2KLPwYPEYFfSgj4MONT13EBPd5cR5lK09212vW4ZVYzANQhl8ihAzI
	kIyrPgkGdwp+LuyH/OBDnrlym4olwHKx77kmp83xPL+i0+upOdbMYFwO1e4K5ici1C7+xcVzo8Q
	z6kUqJk87xBFb4BQxbngfRKdcwWNsk7p567di1rXTyM67oS4N9KplLZrwS3xJnLma/tTOXPPevl
	Qeec0Mqf0dVN+pQ9bxt5d5VQnAlo2HeyaXFhFTGOqq1
X-Received: by 2002:a05:6a21:998e:b0:3ab:13f4:c721 with SMTP id adf61e73a8af0-3afaf522ea5mr6800186637.18.1778747178988;
        Thu, 14 May 2026 01:26:18 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c82bb06875bsm1589102a12.3.2026.05.14.01.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:26:18 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 14 May 2026 13:54:41 +0530
Subject: [PATCH 12/14] fbdev: efifb: fix memory leak in efifb_probe()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-fbdev-v1-12-b3a2474fa720@cse.iitm.ac.in>
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

Since commit 73ce73c30ba9 ("fbdev: Transfer video= option strings to
caller; clarify ownership") the string returned from fb_get_options()
is expected to be freed by the caller, but the string is not freed in
efifb_probe(). Fix that by freeing the option string after setup.

Fixes: 73ce73c30ba9 ("fbdev: Transfer video= option strings to caller; clarify ownership")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/video/fbdev/efifb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 47ebc0107209..ad8dec7807c3 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -377,6 +377,7 @@ static int efifb_probe(struct platform_device *dev)
 	if (fb_get_options("efifb", &option))
 		return -ENODEV;
 	efifb_setup(si, option);
+	kfree(option);
 
 	/* We don't get linelength from UGA Draw Protocol, only from
 	 * EFI Graphics Protocol.  So if it's not in DMI, and it's not

-- 
2.43.0

