Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB84AC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Dec 2021 21:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240247AbhLAVH7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240431AbhLAVHq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Dec 2021 16:07:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B19CC061748
        for <linux-fbdev@vger.kernel.org>; Wed,  1 Dec 2021 13:04:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t9so38143822wrx.7
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Dec 2021 13:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=dXdZwfGWDav+4+EuXXt9amZDrLIfxTbg+r3dcr+ghrc=;
        b=bRjBq1q/t59/oprvbtWyo+sLjo83k6AHf2tN9l+TrGv6plUjnh8vWlKcIxGgGzdcRf
         QD9T2Q5PCQgaUzRX0ukZcUhKlKfm0rvUy/1VfieI2pEP1Pu3rnns+sG/rzjHT64EONSO
         Nm0ESG+jjt1fUMcAjazUdlzfjlUFy9+ZWtwrhmO35Ere/MXLZKvMtqzwSelx42QxfPho
         njClcM7khrQ1IPnQqOzigf0SU41SrxYOsvUbUQRHkWur1CPWxQwvHT3DT4P1d0PsIYTS
         rRKoRoIasLF6mBxzZ8AQ0sTiVZlt5GPz93hII22xuQSXlCuBjXa1d1++r9K1EGS3FWpB
         yfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=dXdZwfGWDav+4+EuXXt9amZDrLIfxTbg+r3dcr+ghrc=;
        b=QwpzXBSwumkNtDXT9/0mTyG5atfNXHvU1/HyEp4KCrI0cuXFYoDl8HPKdL5AUgN4/F
         JPkdovIsk9iiT7niOd656FDPkU0pAvQJiCaw5YijUN1Ds6fU5rlwI9c+AyzQRyfUGF2h
         BO6h21e8AQPzc3sG0WSZw9M6Lh1mdERDA9kYWsWSMRLpsqCuY0BSZqHMwBNNVwpnDuVh
         No9mRuIkPxZwhuuUIKPn0OlI+1HuUZVVCB3Q8jZBirD+GGHgM0qbYh89osn15wri//R0
         baOEvxH59NQmB8YUj18KeQh1PcgIJqybDhnRHr4ykNCMxbd0SLYZs0KxuPLJvNnzSVl+
         FQrw==
X-Gm-Message-State: AOAM533jQzBwZiW95DAIop2eb8n1U3TAtU9w8PXKrwmktX7oZTaQPwzc
        UtSDgaJkFpe5G1uaiEOQiBs=
X-Google-Smtp-Source: ABdhPJwtOQTmBKrSdV6HNqHEji/a4WAwj68V5PxjVwp3jDel7K0LwJlUzxHoMJ7/EjNxxLeRI3aL3g==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr9385949wrs.304.1638392663156;
        Wed, 01 Dec 2021 13:04:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:4055:a69:db9e:1280? (p200300ea8f1a0f0040550a69db9e1280.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:4055:a69:db9e:1280])
        by smtp.googlemail.com with ESMTPSA id g16sm465221wmq.20.2021.12.01.13.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:04:22 -0800 (PST)
Message-ID: <65516be1-9588-af00-cf4f-053e20af9b45@gmail.com>
Date:   Wed, 1 Dec 2021 22:04:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH v2 2/2] staging: fbtft: sh1106: use new macro
 FBTFT_REGISTER_SPI_DRIVER
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <773dc6ff-f2b4-4192-a128-c34bd3f5be01@gmail.com>
In-Reply-To: <773dc6ff-f2b4-4192-a128-c34bd3f5be01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Make fb_sh1106 the first user of new macro FBTFT_REGISTER_SPI_DRIVER.
In addition the MODULE_ALIASes can be removed. Module auto-loading
was successfully tested with a SH1106-based OLED module connected
to an Odroid C2.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/staging/fbtft/fb_sh1106.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/fb_sh1106.c b/drivers/staging/fbtft/fb_sh1106.c
index 7b9ab39e1..9685ca516 100644
--- a/drivers/staging/fbtft/fb_sh1106.c
+++ b/drivers/staging/fbtft/fb_sh1106.c
@@ -173,12 +173,7 @@ static struct fbtft_display display = {
 	},
 };
 
-FBTFT_REGISTER_DRIVER(DRVNAME, "sinowealth,sh1106", &display);
-
-MODULE_ALIAS("spi:" DRVNAME);
-MODULE_ALIAS("platform:" DRVNAME);
-MODULE_ALIAS("spi:sh1106");
-MODULE_ALIAS("platform:sh1106");
+FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "sinowealth", "sh1106", &display);
 
 MODULE_DESCRIPTION("SH1106 OLED Driver");
 MODULE_AUTHOR("Heiner Kallweit");
-- 
2.34.1


