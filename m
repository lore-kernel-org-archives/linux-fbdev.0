Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793928500;
	b=UJy/WcNYn0K7aY5gPKvZ+XVFHiR4fQyVeLqT26MxH9CLVJkOXuTDt4m73hvbuEkVtIAF
	 wanba1iVnv97JgMbpf5KUv/In7Yp2lOLC/yZYVo/onidS2zx4btU6pQ7B1xA8RBYTgmJh
	 eW1+r6M7KkflvhzsdNZ1Ohkw9R3Mnp35gQoASkvQYFTOfu1Jl8A0/ZIA7k0Cen7bJbPtf
	 w5VH2XG9tbJW9+wbtLZ2Of4ibImJ8x0ct3vuW0J3lDIv8R31xkaWlobfrh3oUy7Ec/oT6
	 /c14hUvcqgJLM5/SjOFwFFDIeTMMa77OoHogP7XgES/qH+puwA7oecGevzLBWBrYfJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928500;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OzmeLVnOJ/ClYIo+ngL8aNFa/8nEmpmvX7t0mnKpTNc=;
	b=z5RV9Tv6Zf/Ll4mBgpyrRPJNifNrieAdhQPV2w7iA9ESsD5S4VeZ+9Au3gINSOmVihM4
	 kw2xUU761voIMIzIRRwuVJZMEnhhhM+cpyMgDcXDoMdM4Ezw+DE1VDelSq5NCcnayd1fA
	 40FoUpR4OoyZRUVj3nDmWQbr2oBQ0zXi0sQ2aLX3g2xEAzUbHqTk56Ef36GH+WWv/3F35
	 pu0Jv5dYyjk78roazFcEsE3WBC70Q7urrB7G+GQu6m3ubRvrZk+Ahu2iohw3dbQuuSNyR
	 xY3Kqbc9sRy6KgUmzYYc9dUgErJm0FQRy6h5tRraUbmfWUBSB0a9tVqD7nzLn9w3VQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SwQktOmM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MD9aG4fx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02D606A31B
	for <linux-fbdev@vger.kernel.org>; Fri,  6 Nov 2026 01:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB02D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SwQktOmM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MD9aG4fx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793928498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OzmeLVnOJ/ClYIo+ngL8aNFa/8nEmpmvX7t0mnKpTNc=;
	b=SwQktOmMK+OOPotnjTMjhszEs+5+twyPTDGjrEicxXDrRN1biVnWIFS88HuxlH1O4AwJpV
	44e/caS7LThZkgBcQPnv64BR4vKEisG//a8qiBqMdxMiOB0a7CCiNJg7bdh2DjCXUYJcYh
	kTPQOycxSUL7S3Xc+9bCKkCILwqSiI4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-hf1AGTupNSiwp9JBFURw9Q-1; Thu, 05 Nov 2026 20:28:16 -0500
X-MC-Unique: hf1AGTupNSiwp9JBFURw9Q-1
X-Mimecast-MFC-AGG-ID: hf1AGTupNSiwp9JBFURw9Q_1793928496
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-54af6c38092so1111941cf.0
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 17:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793928496; x=1794533296; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OzmeLVnOJ/ClYIo+ngL8aNFa/8nEmpmvX7t0mnKpTNc=;
        b=MD9aG4fx4mCWQAH03sTcLmygk+gD03T71HtAdTGykHbhtNlM13XdY93yBRtatBMjBH
         SBuMfuYXWLITwi55eZQC5wMX8vz7kGMGQWCdBqe7UCFaXQfpyAIMEo3Av12Pazmh5bpz
         dfrctM/36k/GTpECGxzojsSITzKqSG/7fCTDL8fNH3NcpWkWEhBdsIYPW2cnHDrz+H/k
         UJS+zKHMZkokav39o8H+f2GlzjxPRMocuduFjqMGQd09ohM+9jGZgspOhNwKRACPse4C
         YQk6TphBxcOTZ+NNXIwtqFRbp9HMpfZEG00Fy0jNQO+DIbUQ/wYyc4WclOYDEbRz+h8u
         BwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793928496; x=1794533296;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OzmeLVnOJ/ClYIo+ngL8aNFa/8nEmpmvX7t0mnKpTNc=;
        b=UVFJ6qcrlWHYUCVFbZrSBTKWDbxGqtq62cxT+49dom/lulRI+FFA5Yv+L95nJmrjug
         OuKc614otoFIwo3ZwH+QGvwIaQ9BA9JE1cDilPqJdjZ5Bf/5fIpcvaTB2A4PRpzxK+YW
         sFwLfw/k2ygR3P+ZKi2El7eDosKDbPZffc1lobof+Q0gaCcVCczco2n2twmlakWzth9H
         siGrsG4mnf7nTmwecmit0OMbma0n9hltNVM9vw00ppMG0WXgAedSim0ZSMvgkRCRcD0m
         H3dmAlOxy4uAuw/zS97/A2Hpil8OTgRU/Ztsl0Llr5ZGr1GXL9xLFCmqr2+Gl8JvN/7C
         hASQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1bVVaNYBOWXnk2XfcGVV8OOUt768FV49Lgd8uRCf82gjlAzzrHxNJKzhuBJJSS2Vk1t3ziVIZs7tigA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/tFrOUV12/ZgRfRYeMt2NEM32okOHrKfV7lUZdvH4wrPWnseYU
	PS477Pc+4MTId5VFGXl17IqnCGlIsyC9qPoUizG8pAtIdUERJ2O7rxUACOdNOOzVZ2OZeBltNxW
	dxjTtCN7md9WSyj1JhT78N96etThcYjuMfzZhv3YCxNbmMqIu6PzuLCktBbLlKObS
X-Gm-Gg: AYBFou0ompRTGDbS/RCQDU+EeNZ6OTLAFBDxvJzfmoo19CespiqWvuLtsxw5ZI64aPX
	FwHnoJX7zK4CthuflIvMVV3VmyRi5OYfVTq2uOFoWoVXIZbgFKu/9oNCiZ0nWNKtnYE+bEGl2bL
	rt/INanWYo9tGF+yXmBvr4qT0AAehjxOiXvqzqJNUocZx5zJYjkjui4/54LU3BEXxBia58AYOff
	yrEETOIDk1YxuHVNddakdtZws4oYcjlVmhsRFqAdnHWBX5AEEmw3NV8utOy16Td9IiDxrooxA6X
	H5J3XwVBxKetZ0xZdpDoKHyDH0OpGUb0pNPrsGUSCIy1X3HpZ3Q5nu1UV3jHjdOYCWxFZ7ZtXaz
	4RpSp6Q9mf/g7JHrFt/2i1HpY8Fox4L8HEuEqfxws0UKOBghFJ6eCvLAMTOzk85oXhJMvbjqHQD
	xsJmyGFG3cKXoxvno+
X-Received: by 2002:a05:622a:4c0a:b0:532:9b14:96c5 with SMTP id d75a77b69052e-54e15762f20mr17086181cf.60.1793928495967;
        Thu, 05 Nov 2026 17:28:15 -0800 (PST)
X-Received: by 2002:a05:622a:4c0a:b0:532:9b14:96c5 with SMTP id d75a77b69052e-54e15762f20mr17085971cf.60.1793928495520;
        Thu, 05 Nov 2026 17:28:15 -0800 (PST)
Received: from bmasney-x1.rmtuswv.csb ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea68fc43asm8983646d6.3.2026.11.05.17.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 17:28:14 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 05 Nov 2026 20:28:02 -0500
Subject: [PATCH] backlight: aat2870-backlight: convert to
 subsys_platform_driver()
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-backlight-subsys-v1-1-ee9e4cbc8cdf@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBCF4VeRWWvSSlxfRSzaGgyCdBAi3l2x/
 JJz/gsYHSFDEVzgcCemefJQYQC201OLgmpviGSUKCVjYbQdRmq7VfBm+GShUp3rpDaZNAj+tjh
 s6PiSZfXbL3u069uB+34AqBad+XQAAAA=
X-Change-ID: 20261105-backlight-subsys-17a9a6db80be
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.17-dev-d96cb
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=H2Ld4en7JsjVIIhCDl57TIyk/SGKDX29aUAga9OP9iU=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLLe6mrezL7W5KgvfvdaGM+czQYGWYu0H1t0fz7VHWW0V
 sRNWPBPRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABM5uoGRYbax8+fouQ21RXqP
 jl3hvcV7cPWUkxfcj1dK2OQsbuvKzGf4X7BCjlXHm4cve/05l0Mie3cdcmLyn/WO+yPXMt0lmm+
 LeAA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

Reduce boilerplate code in this driver and convert it over to use
the macro subsys_platform_driver().

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/video/backlight/aat2870_bl.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 8b790df1e842..2428427e11aa 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -189,17 +189,7 @@ static struct platform_driver aat2870_bl_driver = {
 	.remove		= aat2870_bl_remove,
 };
 
-static int __init aat2870_bl_init(void)
-{
-	return platform_driver_register(&aat2870_bl_driver);
-}
-subsys_initcall(aat2870_bl_init);
-
-static void __exit aat2870_bl_exit(void)
-{
-	platform_driver_unregister(&aat2870_bl_driver);
-}
-module_exit(aat2870_bl_exit);
+subsys_platform_driver(aat2870_bl_driver);
 
 MODULE_DESCRIPTION("AnalogicTech AAT2870 Backlight");
 MODULE_LICENSE("GPL");

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261105-backlight-subsys-17a9a6db80be

Best regards,
--  
Brian Masney <bmasney@redhat.com>

