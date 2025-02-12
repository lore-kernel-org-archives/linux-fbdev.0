Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68624204682;
	Wed, 12 Feb 2025 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346198; cv=none; b=HQWBr6eYn3aj2npXoOsJNI+me8KObosUytqKuxMx6WGoA2LXg7seI0wk2pvZcgQ/fcq8s7tXQNMDQldYbNB8zn42RFNr/7SW5eAHobA2gCFG3lnF2qhUgZgNY2CN3CREToDqaASP+reL62fzNfqfAQtz+dxtrE+AVtfsYbzndcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346198; c=relaxed/simple;
	bh=uYeXJyn5UeUw6qcDYRDrfV4PFQBbTfNbcG3JQxPQTfc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VM0PshiYb5VNAv9yhYI9ORCfV3X3V/TF42v8pNSzMcR8zNFoKq+0rxi0jCkBex68aZq35xGrbNXVgC9D48VuQwGXkHVOGOFfCO4adXGduPmw0W2OOLSUZUofqtC/RmmhNa0E1glabfeIrHqh7FJvK9mABLDijw+hgbogsI9+CDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4IPSicf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4IPSicf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43944c51e41so31537785e9.0;
        Tue, 11 Feb 2025 23:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739346195; x=1739950995; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faKuoffM1gAZWq51vkqkknQzyRKywd6R7upna9jS1Us=;
        b=L4IPSicfRpclfoUch/v+ScJ5YMy7MzfNQ7WWHhArZRMXHvffmWfPQmacbBiHYyIxFQ
         I+6/FNxANkt+pjydcyVGItxJ+sBfpUh7VrLP27bw8X9jCpyEylglVaJAhLpua3LaQ65P
         FB/W6MpVCdkZ4OTb7CQHw2Bekp0bSVkhpklz9MEom0Xmuz7Ptb9pJsNXUOV538tgSCTM
         CF8/O9eQbbDnaFQklAj1+pSUi1YQHd4N+9/T0hanSXBnUvCxg49naiCyLEPrxPSB9I/6
         Hns7nf3dc49Vlqh5BEVlHJV0eXNDnke8Ad4to9ty/F/be+ifnGXWbId2lL7t4kvLIF/2
         LRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739346195; x=1739950995;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=faKuoffM1gAZWq51vkqkknQzyRKywd6R7upna9jS1Us=;
        b=QeVKR91NzroWotR+IxTCJsgesNfYSY/pCp4rzu4W+jCHQaV17BH0U8Ejfc4sQYVsgE
         HeUSgX4ZSNNyrJ6N2x2nhs3he1aoZ+JSQIPjc6S7Z7NV432PcRBRJ6lSImcwZ7W/OOIr
         pAWZhmOrnCelM0LXznetQIlK2nEH078AEvXbh8JcECUpxcIfi/Q9OxcinOQtPWatmBsb
         BQ+HGKFm4FN/vbQ8/CVu1RFBsNCwLCHCtxS03atYj2A8sae3359QU0XlMy0sp2uJkTE7
         HuMNWA3qcfLe05c9ZqoG+ZIXFJZeTnNCv7DNGb9q5lKmU2sDK19B/rdBQ59tkcpQ+Nlj
         lWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0olTflW3u6B3XVg89SiW+nNyroTQNjUB4Hxn0JvUn/ZmA4SYDdBshgPRb9EEQ6C0MXvfw0D/5cavMIw==@vger.kernel.org, AJvYcCWJzMht2hwMF/x5u1amxgRGxBRD9lQexUFccFQXGtbxLnnpQdKA7ZGBVZUUvko7SA9SJhEMayLytI53qP2D@vger.kernel.org
X-Gm-Message-State: AOJu0YzIC1CUU/hNRwZEBivVdLPawFWIwrXgnkqGPgSUJoOP395zusp6
	U6546C6+k3u4fPR1b76DykHKAcYj6BTLKunTj1DlUtAHcIy4TpP9hdzUzPf9fp4=
X-Gm-Gg: ASbGncvZkCkygdLOdB1Snl+gyWIXJ/j7DcRdiyzh5ZzCwp0XQUdMjpKWdTS3kh2zviE
	RCHQW3xP98oyHlpFd1LRxgtht3Cb8+ECKHpo4cgqHyI9WTcX3jEPglCcvOSX+bJgVmb6CwkohTQ
	hXRRt+u85sufInGc8hmlYW53tF9WpWIYw9tdG/P3Ieo1qlBMk9hCBNNYFa49EFTJ66YcxW0A/8h
	c2JAfrNMhQ7pEzbim/f4lzSAJmNcDWot8bqDVicEhJLsi4a+pSobQ0jwGSCf6o7tnp7HiqYHkBG
	N18h2ortBVn43P/Djc5uf9TUgFHv6RAIFf98YeUDS8/kphir3zPLn2iOs7X9U4Ip0tjMull9LCm
	ZZnFc0GN8
X-Google-Smtp-Source: AGHT+IFLnB8Ymq1rlUTsAloZXjXNuyEHGglxk1LiY+nVnHMEX5ZdXYat3hHkscmmVysqmC10clk5kQ==
X-Received: by 2002:a05:600c:510c:b0:439:45ce:15c0 with SMTP id 5b1f17b1804b1-439581bed06mr15039995e9.25.1739346194504;
        Tue, 11 Feb 2025 23:43:14 -0800 (PST)
Received: from michael-devbox (ec2-52-59-234-77.eu-central-1.compute.amazonaws.com. [52.59.234.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d22csm11458725e9.22.2025.02.11.23.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:43:14 -0800 (PST)
Date: Wed, 12 Feb 2025 07:43:13 +0000
From: Michael Anckaert <michael.anckaert@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] staging: sm750fb: fix checkpatch warning architecture
 specific defines should be avoided
Message-ID: <Z6xREbLLtexX4_uh@michael-devbox>
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

Signed-off-by: Michael Anckaert <michael.anckaert@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index 02860d3ec365..67a2f60440ca 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -229,7 +229,7 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
 		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
 		poke32(VGA_CONFIGURATION, reg);
 	} else {
-#if defined(__i386__) || defined(__x86_64__)
+#ifdef CONFIG_X86
 		/* set graphic mode via IO method */
 		outb_p(0x88, 0x3d4);
 		outb_p(0x06, 0x3d5);
-- 
2.39.5

