Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE49334693
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Oct 2025 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635131; cv=none; b=m981LqaW2lxLDClRyS8t98xVdhb64+QFWIMo8FQdSEEbGui4bVS5Sr+TrQ4R6Vx3r9Ler2czahFOky78eKKhzb9tudb86hEfc8LxASA2y7XCAcE/md8ESm0+8oZFnea9WlUjZMJrkBo/VRZ/fCrDyvR7myT4fXqbYn9w4s6zByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635131; c=relaxed/simple;
	bh=u1UIA2BIHa75e19Dzixz25eBYZXZ7a8Rdt0+VX/LF+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YII7uqiIWiI2ByiCfr2+Imf0318gdglkxpT6KineSiAlaz8wBYF70nM8OIEWITkYw91WBOvrEd0Fhl4S7c53K68t2JKmwGdtOhGw7pGiae6r/qXnGq2CZH4ittxmgiQVyA4eLbDocKVKhrJZm1C/pBvsK4JsF0vXKGsqfWN7HlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+Nos+lS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Nos+lS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4256866958bso688380f8f.1
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Oct 2025 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760635128; x=1761239928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R61SKl0heteonfQWMBAG66A3jLT07W0AMS7C2zZswDI=;
        b=C+Nos+lSiGdgujFJDKUQyd+bH8qPtw7hcHWCoY16VPySRRuIxsInKJsdG78YXKeZyL
         szPUURnyfJYR9jhlawmikP1TBSDEzogdZ2HAAmKpo3YBZXGpv96c//zVhDAUZiypPGq5
         h2+ZoT2DzUTk4UIE75b2B7j2hLXeNkJNhgLSF1iXdbOXpBOx2gfMU2QMsjUh+DO5KA3p
         MS7o+uUtqqpzqTEQ1uFlmHotnMByn1/h85DKQRk15KDM3VCtcFcB6TulMloXgrIRftxE
         2m8kJ6OAoTV+JUCftD6ISOcA6dflMc+q18plkjS68cuEyl8mJJwh8dLQNmokFZDmPsOL
         Ntkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760635128; x=1761239928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R61SKl0heteonfQWMBAG66A3jLT07W0AMS7C2zZswDI=;
        b=L7y90trMFq8bhShSK93JBXrbj5BiIRwTtVTbHDf6Amr6wXCxzmSCtfdrJnkDGWVQKS
         rzVIWk9lV2eOqbRpyVUIAQjFCPi7XRtHVDd4qickjbENssJtLgNA5mBPnRz+a1jmak8F
         itlxy/qWd5H49+O/WbjomR0f4oFZvvD0V6q/+ARxOCS9rEm6lnW8ldrl5N9cOgLsECNh
         UgQdMS+Wz7sEGJrImBMUN0DQee1Avr3HagesWMMBy5mZ88fp8coypSW0b+b7UcoG8BBK
         ijXXIcAfZDdHKCKf00PlcqN6EQYWPVJIAnq9BeKQEtSYdCUsl7+f0kxKK+lYlTG3UFAm
         TpJA==
X-Gm-Message-State: AOJu0Yw5u4tZpwFOLke+8j4fOkgRtS4vBqODBGgXzFjRp98AJelcsE27
	NdIt4JMXUqguvtlOq2gBI7r68kvxm8F8MtJhwdp7Y2a9xnSmjw24JlLo
X-Gm-Gg: ASbGncs25rMgDjoyX+BmAekEG4lORwJjJPM7i82UIjGdv160flLsFKM5FrIEh5vXznA
	vVOyCILPWmoPk04VMnW9l8fzZSXVHPsZqXCzegHB2uwrkroNJmCEGa2g7pIIDajS/fjoyy9w/Up
	6dkDOjnJnbO4Qgwq0K/Ir6Lv8SvflXHwJozDZ1dC2YFmVWOr3WPJzkrLvYMR4NVn6B7sgh/w5TK
	Lhsyv+NJ/capW1CcCVYyKuI6j2cBJjQiFJrgxXNXRlKsF4jR9+E0Q91evJ2GeEHGdYf1xqztuSs
	UF2+YaVJyh/Mu78CHrb6YnlHQSfKNZCozXz1YyhKWycZWsDRyEJkcbdjT5mGBUMnOEKHXSj6s1k
	d7lk2g/F21yHC4RYvj8PDG4gGihx47ISd6KvkE9hm9ZCKPRSZDApL0dWJIKikwdCpddFDg/b6dn
	BH0NrPSLm7M8LSDeHKyrsJ+jGQHzcWiwhC
X-Google-Smtp-Source: AGHT+IGtxy9t5BEeTVIETxG2Z41hQ7E4hmY7HEIitTLwANiVPbSqfV1FzBoCuUQpqq4aGGwjVLWXHA==
X-Received: by 2002:a5d:5f82:0:b0:426:d54a:67e with SMTP id ffacd0b85a97d-42704dc9bffmr775251f8f.44.1760635127949;
        Thu, 16 Oct 2025 10:18:47 -0700 (PDT)
Received: from dell (117.red-81-33-123.dynamicip.rima-tde.net. [81.33.123.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711442dbaesm39349145e9.8.2025.10.16.10.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:18:47 -0700 (PDT)
From: Javier Garcia <rampxxxx@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	Javier Garcia <rampxxxx@gmail.com>
Subject: [PATCH] fbdev: vga16fb: Request memory region.
Date: Thu, 16 Oct 2025 19:18:45 +0200
Message-ID: <20251016171845.1397153-1-rampxxxx@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch reserve and release VGA memory region with `*_mem_region`
fn's.

This align with Documentation/drm/todo.rst
"Request memory regions in all fbdev drivers"

I've tested with kernel and qemu both 32bits.

Signed-off-by: Javier Garcia <rampxxxx@gmail.com>
---

When I've run the code always return -EBUSY which makes sense as
mem is already requested,`/proc/iomem` shows `000a0000-000bffff : Video RAM area`.

I've seen that `cirrusfb` has this kind of code wrapped up with `#if 0`, and I
wonder if it makes sense to also wrap up with `#if 0`, at least , in
that way the code gets commented about expected behavior.


 drivers/video/fbdev/vga16fb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index eedab14c7d51..f506bf144a97 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -1319,6 +1319,11 @@ static int vga16fb_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
+	if (!request_mem_region(vga16fb_fix.smem_start, vga16fb_fix.smem_len,
+				"vga16b")) {
+		dev_err(&dev->dev,"vga16b: cannot reserve video memory at 0x%lx\n",
+		       vga16fb_fix.smem_start);
+	}
 	printk(KERN_DEBUG "vga16fb: initializing\n");
 	info = framebuffer_alloc(sizeof(struct vga16fb_par), &dev->dev);
 
@@ -1398,6 +1403,8 @@ static int vga16fb_probe(struct platform_device *dev)
  err_ioremap:
 	framebuffer_release(info);
  err_fb_alloc:
+	release_mem_region(vga16fb_fix.smem_start,
+		    vga16fb_fix.smem_len);
 	return ret;
 }
 
-- 
2.50.1

