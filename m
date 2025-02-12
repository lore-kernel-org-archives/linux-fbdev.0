Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE8D1FF1DD;
	Wed, 12 Feb 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739355164; cv=none; b=O0HWh0tlgKXDC0HSVRMBi3fa4rTeneNVNPbSlmB8B0yJIyj2MhG7A/Odf0WePHR84b2jJSCJU6LsFPiZLZRkz3aGzStDnnBadnO7Y3mvIOSfViR9sLyXfkzXTzCwSL7UF/zgUehTHRbB/1lbr0kuWOxNnQGUZKUmuTB2VaRF0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739355164; c=relaxed/simple;
	bh=Ipdw+HzMVUc1a2SsAq+NMqJ+fJDERecKuobxFYR7C5g=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AZ8EBA79Sf4fHZp4XiEYL8q4UUECGqiMpZwqAg1m5bseP9qLWgoShkEvlNm/3xxMgQ0oAXTCGcKWUdp5le9xmTl4tWI+IprMfjKgksyWwabcjFazhgGtdjbkaR45fc1VkF+Hd38fh5cc3bpIYy4KBrJO/7hwf+/vpdDl5XewD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4Mrbg3L; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4Mrbg3L"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4394820123dso18934025e9.2;
        Wed, 12 Feb 2025 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739355161; x=1739959961; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mNNKBtbX7Tvug8Fw4Lq02BaT1unD/9lLJspUhFklJfQ=;
        b=d4Mrbg3LXDbyd+cQv2ce51ykOQH6k8sDYC/pMMZsG3yokoTXn2189W8q7S/YBNacXp
         4NcIJinZg39tom3bt6jaY8VSucpUEgxHAJM8FeemQ56+MlpZ5/X2DYHaNXhCdV59yqKz
         MgvM8K4WoSvZAQuRIrd69On/0vjt5KwUBpiGbRgumT0Q3jifwC2aZR7xLa5yySXFOerV
         sXfd5zyFQfX78xUxkjmxHyWjWO3Y2Rbxbpn29CUDeSWXA1wQhdICiw2ot8F+RC1iVj1c
         B089ODqTmqOZLrp1A5OLyAVXWnz5Z6aSP5e2czlKU/7c+admAi8POA4ikqItQInNoGC2
         4dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739355161; x=1739959961;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mNNKBtbX7Tvug8Fw4Lq02BaT1unD/9lLJspUhFklJfQ=;
        b=IgRUgIct7ozsE1LgVDM0HQW68BAF0scsQV9uVqPUw38B4z3osHYKGXgq/t7owgoMD3
         ygTyWPE3FlHiC2vTddccjGjU44j5DJXTIstTgjaeKSQmk3Sv6IPjtjWyBs7IqTDQ9XNP
         4weqiRZu6ns1xoqkH5C5FKrBr4lHRw3dVB52z0N63Aizx9SBJ4PSLzs2b/lWH3HoyJdC
         +0a8Mxnm1q5Wj+eys5g0OKhCgaF7NaBoP5DHM9rDVbaU4TAoUlqe3JJ7MAytji3C6QGE
         +M4Zr5vijXoBgfkj5eROUeP1LTwdGBIiQ53/hEpUD7BWGJJOmq3dninuOhVquW73Q6sE
         h/1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCpvkIzh6SmU7MmwYMsN1ER7ePBV7nhjdpbaCL7iu5GA6npr++Q4WR3rCuj6Jl+bfdt75OsJx6/2MyYQ==@vger.kernel.org, AJvYcCXEliLu4AHve7MmKtt1OLMDfzlY5e0jTfFq5k7AlC1aaGcFDR/9b2MOwmBp84MRzxx8Ny//B8o8BvOx0iw/@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCQno+sjGJ8gfjXetVuiX9tMR3Qig1Hk0wJao9bkxstMRUfad
	vYhmmXecgv8JA4LNsbGth/iGMDKCCHWLhGe9w6EM34LgI/7KL+6deDBQwKj1MY8=
X-Gm-Gg: ASbGncu0Es05y6+3gf3GZZZYvckHpk+EaDtZORoNJljQgRr8xurhqmdU+pCsMECISq/
	E3uRjZJWmIVCL6J6I5Vp54N+iIMKZMna0nECBtXkfz9LWlK9P9Jn9Fh2872zH9rKsfBKyXtkI4m
	98W4b3I90RsFjwbXQMc9m6l867azPGmSsHtisxE7r13MDuTPUPSVJthKbjaisk+aM696mmw6j8h
	Q/1HMIMimZJzFoBoi/ogL1LwgDS7gfUEgdCIyxdsx0LKi9ipwG/y7cjM6pFKwISLaoy71j7sMjN
	7KxB9JywmqI1g3/V04pwlTdw50ik+zf/kMPw7lW6eZGifNbsVHoMX/RZlEnTigcG2mu8urqwbS/
	XFx50aro+
X-Google-Smtp-Source: AGHT+IHhRK8nxFM1MkvP02b1tIRnIroxS4UXE3wB4NUmuptZfBzKer8oXq6j4K8FtetcxrRrEyBHDQ==
X-Received: by 2002:a05:600c:5487:b0:439:3dc0:29b6 with SMTP id 5b1f17b1804b1-4395815fcc5mr23241965e9.2.1739355161186;
        Wed, 12 Feb 2025 02:12:41 -0800 (PST)
Received: from michael-devbox (ec2-52-59-234-77.eu-central-1.compute.amazonaws.com. [52.59.234.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b83a3sm14845085e9.33.2025.02.12.02.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 02:12:40 -0800 (PST)
Date: Wed, 12 Feb 2025 10:12:40 +0000
From: Michael Anckaert <michael.anckaert@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: sm750fb: fix checkpatch warning architecture
 specific defines should be avoided
Message-ID: <Z6x0GEM5sxcruYlS@michael-devbox>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace architecture-specific defines with CONFIG_X86 checks to improve
portability and adhere to kernel coding standards.

Fixes checkpatch warning:
- CHECK: architecture specific defines should be avoided.

Changes made:
- Using CONFIG_X86 instead of i386 and x86.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Michael Anckaert <michael.anckaert@gmail.com>
---
Changes in v2:
 - Moved the '} else {' into the ifdef to avoid the possibly empty
else branch

 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 02860d3ec365..025dae3756aa 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -228,8 +228,8 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
 		reg = peek32(VGA_CONFIGURATION);
 		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
 		poke32(VGA_CONFIGURATION, reg);
+#ifdef CONFIG_X86
 	} else {
-#if defined(__i386__) || defined(__x86_64__)
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
-- 
2.39.5

