Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63BDFC433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 17 Jun 2022 13:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380506AbiFQNix (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 17 Jun 2022 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiFQNix (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 17 Jun 2022 09:38:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA26B480
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Jun 2022 06:38:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id h23so8814073ejj.12
        for <linux-fbdev@vger.kernel.org>; Fri, 17 Jun 2022 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject
         :content-language:to:cc:content-transfer-encoding;
        bh=9+5JSfR5emIIXIQSkqObw0oPOeBn2kv6o6GBkTBXMVU=;
        b=cZaQ9dbLocF/ekU7EzslSnuavirg8HxSEt1aH7adBb8EKkz8xMfyvD3qkNGN4NUO43
         JD/0XQ4ghbyi/nh0t37j3RX5DYxtgAENVaKJYXyul6KmJtXkiDNBjoUuBkJFugpqlF19
         ltvo1Odyl1CiVwP9sS+m0lifv9tBVXuoP8gdGhMw/OUh+XeztFWaCFS8pgoo6MTItSXu
         4ARQHhDk4Ww4RhZX6knotm2tCuY5iPz06Xz5mT9U3QoIHc0fldPWdsVC95ZSfHQCWNmg
         LJWzQkSwxOb0bOsea+i3tc8geiYiedwwhLL6VRbU+6qZUSbikIXbhLSjLpz61HDgkhgU
         MnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:content-transfer-encoding;
        bh=9+5JSfR5emIIXIQSkqObw0oPOeBn2kv6o6GBkTBXMVU=;
        b=kEF9cExkj4g3Oq5a2LFNWRJyPtYW8hIVXB8QoZI/KGrRNFgm65FpYvmC4NQ0CoQeft
         QAxUb/YmsEMj5QkukRorIMY+RqWDlarSYFmQ22LZNGb1OLdKTo5+Yw2xpKdLxQRAWXos
         fme1HlnWDWU8nfIz6mwklwPsi8pyM4Upui1Ubz1bkXbTT8pdq6gTlqOKBbfwpq1yan0O
         Uxg0hhIlVXQ7mWKbpYSBl5scHd9dGoZ6F4m9LtEqWJva/wnnclwzrAOSCqKuhuE96axG
         kf/pNQQL2xxLiF5tt499q+e6T9AblTE4iKkir3J+f1BVyBIAndljlSC+0sZVchzHrx4b
         1wnQ==
X-Gm-Message-State: AJIora84ExoNg87dvWu6HY2TgZN/adjUxOTtCQFtEmmKp90gNC7D6c1O
        UyWgUx2GHE6iTJAG/rbIa8CZv/d+JFxd6A==
X-Google-Smtp-Source: AGRyM1u82aGIFGlhexIqLi4cNYiXgipnw/L536RFQzHfU5ZaOOusmJJbcELQwNbjlArMdEvJwfUBvQ==
X-Received: by 2002:a17:907:7f1d:b0:71d:ea75:e533 with SMTP id qf29-20020a1709077f1d00b0071dea75e533mr1872187ejc.78.1655473130745;
        Fri, 17 Jun 2022 06:38:50 -0700 (PDT)
Received: from ?IPV6:2001:1ae9:1e8:b200:ae52:b385:81fe:eeab? (2001-1ae9-1e8-b200-ae52-b385-81fe-eeab.ip6.tmcz.cz. [2001:1ae9:1e8:b200:ae52:b385:81fe:eeab])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906539100b0070587f81bcfsm2242995ejo.19.2022.06.17.06.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 06:38:49 -0700 (PDT)
Message-ID: <2a722588-e41d-75f7-dad6-944b2b1daa4a@gmail.com>
Date:   Fri, 17 Jun 2022 15:38:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Petr Cvek <petrcvekcz@gmail.com>
Subject: [PATCH 1/2] video: fbdev: intelfb: Use aperture size from
 pci_resource_len
Content-Language: en-US
To:     mbroemme@libmpq.org
Cc:     linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Aperture size for i9x5 variants is determined from PCI base address.

	if (pci_resource_start(pdev, 2) & 0x08000000)
		*aperture_size = MB(128);
	...

This condition is incorrect as 128 MiB address can have the address
set as 0x?8000000 or 0x?0000000. Also the code can be simplified to just
use pci_resource_len().

The true settings of the aperture size is in the MSAC register, which
could be used instead. However the value is used only as an info message,
so it doesn't matter.

Signed-off-by: Petr Cvek <petrcvekcz@gmail.com>
---
 drivers/video/fbdev/intelfb/intelfbhw.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfbhw.c b/drivers/video/fbdev/intelfb/intelfbhw.c
index 57aff7450bce..2086e06532ee 100644
--- a/drivers/video/fbdev/intelfb/intelfbhw.c
+++ b/drivers/video/fbdev/intelfb/intelfbhw.c
@@ -201,13 +201,11 @@ int intelfbhw_get_memory(struct pci_dev *pdev, int *aperture_size,
 	case PCI_DEVICE_ID_INTEL_945GME:
 	case PCI_DEVICE_ID_INTEL_965G:
 	case PCI_DEVICE_ID_INTEL_965GM:
-		/* 915, 945 and 965 chipsets support a 256MB aperture.
-		   Aperture size is determined by inspected the
-		   base address of the aperture. */
-		if (pci_resource_start(pdev, 2) & 0x08000000)
-			*aperture_size = MB(128);
-		else
-			*aperture_size = MB(256);
+		/*
+		 * 915, 945 and 965 chipsets support 64MB, 128MB or 256MB
+		 * aperture. Determine size from PCI resource length.
+		 */
+		*aperture_size = pci_resource_len(pdev, 2);
 		break;
 	default:
 		if ((tmp & INTEL_GMCH_MEM_MASK) == INTEL_GMCH_MEM_64M)
-- 
2.36.1
