Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54CD8C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Dec 2021 21:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhLAVH5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbhLAVHo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Dec 2021 16:07:44 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0779C061574
        for <linux-fbdev@vger.kernel.org>; Wed,  1 Dec 2021 13:04:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a18so55204873wrn.6
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Dec 2021 13:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=TIBFAICE4UfUtEBGXAUUrWDafroFnZVjro2iD/Ylyrk=;
        b=pfXq84vmvuUN4iyDdXGP9PHhZi8ucmNsWsx8XpD/OIMg+epA+IkU1+S5Be6J8GOi1T
         YC+mzbm9Ck324QnyMOq8CGPdvxPoNI0THwQmzhyB5m4oql8wxrN+e+7aoASLGjVpBSiy
         UoiVDJRGCuUzYoxkwSGZnJkFqDZCecsvIMvTC6v1ADiqmignNXa/KfbMmxoU2TorHoEW
         XjJJJWd4CUhcFWqNmvmghSCxnDnNDj1O8h0CKS5PYaCb59SlmsXgvUhJrli89X3fSfKZ
         MKqCaKjiVKAIOe7N2l1uYJbkjcB/Khhz29mRh9oxmNepflAb1JygLt745utBhgmwc3t1
         jq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=TIBFAICE4UfUtEBGXAUUrWDafroFnZVjro2iD/Ylyrk=;
        b=G/TOLH0YX2GGavN9EJSRp7VAHrsiTETJaH2lYU2aRftxE2KusRBOqaC2T1iwnWoMDv
         1L6lkyESvY/ye+/Lg5N8PyiYD0tbjqlEBKoAhRNYkjEe8IjbWO5JujcsKWivY8wQeWpW
         AfsHc+4pj9E5VOi4Isl12mWTMYbKD/FmurYjgcBA7L6EFcSaZiaeb0ajNnryQeuA0NjG
         OHPf4L5khc6z2kbQ/Y5wjzLLfV8M8Z6SvHuAAz2TXutm7eGI3ZleVTFu808tp3D+rzlu
         Ok1IX0gj5tLamXBf6SdZvDMOl+F+ksxGNLrPnhMgdxBU+R6tTqeEPNHBOEevrECTz8Qz
         osYg==
X-Gm-Message-State: AOAM531pqvkkBazEp4hHV8emANcN4Ob0e5SeYVIYBWmLy75VRVvwMaL2
        2HZ+GGlS3c7IZH8UgeKmDHFNxYJC2X8=
X-Google-Smtp-Source: ABdhPJxJuMYD65IqHCgJCdTPI/iBdlCx3ZAkmwvFy37VRIRmEcozw3wkfi8OhjF0doJZMkdvmd7/yQ==
X-Received: by 2002:adf:e484:: with SMTP id i4mr9765193wrm.49.1638392659610;
        Wed, 01 Dec 2021 13:04:19 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:4055:a69:db9e:1280? (p200300ea8f1a0f0040550a69db9e1280.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:4055:a69:db9e:1280])
        by smtp.googlemail.com with ESMTPSA id r8sm857062wrz.43.2021.12.01.13.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:04:19 -0800 (PST)
Message-ID: <a58b3bc9-27a2-3f16-dd92-e597666a0263@gmail.com>
Date:   Wed, 1 Dec 2021 22:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: [PATCH v2 1/2] staging: fbtft: add macro FBTFT_REGISTER_SPI_DRIVER
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

After 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
compatible") we need to add spi id_tables. Changing existing macro
FBTFT_REGISTER_DRIVER would have meant to change arguments and
therefore adjust all fbtft drivers.

This patch adds a new and simplified macro FBTFT_REGISTER_SPI_DRIVER
that includes a spi id_table, and in addition to that:
- does not define a platform driver
- uses macro module_spi_driver()

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 6869f3603..4cdec34e2 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -346,6 +346,47 @@ static void __exit fbtft_driver_module_exit(void)                          \
 module_init(fbtft_driver_module_init);                                     \
 module_exit(fbtft_driver_module_exit);
 
+#define FBTFT_REGISTER_SPI_DRIVER(_name, _comp_vend, _comp_dev, _display)	\
+										\
+static int fbtft_driver_probe_spi(struct spi_device *spi)			\
+{										\
+	return fbtft_probe_common(_display, spi, NULL);				\
+}										\
+										\
+static int fbtft_driver_remove_spi(struct spi_device *spi)			\
+{										\
+	struct fb_info *info = spi_get_drvdata(spi);				\
+										\
+	fbtft_remove_common(&spi->dev, info);					\
+	return 0;								\
+}										\
+										\
+static const struct of_device_id dt_ids[] = {					\
+	{ .compatible = _comp_vend "," _comp_dev },				\
+	{},									\
+};										\
+										\
+MODULE_DEVICE_TABLE(of, dt_ids);						\
+										\
+static const struct spi_device_id spi_ids[] = {					\
+	{ .name = _comp_dev },							\
+	{},									\
+};										\
+										\
+MODULE_DEVICE_TABLE(spi, spi_ids);						\
+										\
+static struct spi_driver fbtft_driver_spi_driver = {				\
+	.driver = {								\
+		.name  = _name,							\
+		.of_match_table = dt_ids,					\
+	},									\
+	.id_table = spi_ids,							\
+	.probe  = fbtft_driver_probe_spi,					\
+	.remove = fbtft_driver_remove_spi,					\
+};										\
+										\
+module_spi_driver(fbtft_driver_spi_driver);
+
 /* Debug macros */
 
 /* shorthand debug levels */
-- 
2.34.1


