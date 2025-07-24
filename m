Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16B22097;
	Thu, 24 Jul 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325812; cv=none; b=gU7cR5UcaD98R+GpJuRxQ3t4kccFm8x6bOGXreABeNRybqokv9Bf4mhuReU/GTX/VCR+2pqYhFD+dD9AoDFBO7w9qfKZ/ep1LFRJZTCoxyvJ7piF+9wZt3noARZpwFBf3o4opSIyQHEZJtDmPYzYuxtvQos7ZBSkuBr88Zfd+I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325812; c=relaxed/simple;
	bh=ip9ziZYE5eZvikPAFgwXSpayvsK86shMh5uv/cgNrvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WLyq2TIBLBlT7Io52gZZno3ygmxo5aLGFvG3nGdh9eosic5jL9/aMLdjlovVU8fch/ItEA1eb8shXDGZBm09q4omeUzB8527vs9KCEBIwTY0Ge+IIJe+l4CNeEMpNhuggrjV4jMkDJqMs9l+qN8+xTGXOUaGwkzQq6OadllnToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuQDzZ8i; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuQDzZ8i"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e32cf22fdfso57225085a.0;
        Wed, 23 Jul 2025 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753325810; x=1753930610; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tya8198c6y5rCjUglNzcQUyG1Q0GYdplJmKHDjoJPmk=;
        b=VuQDzZ8iRVpuLDo6CwfGb5CCnlF0v0q3QUVAr+6torWT5CswE3VqTl7o/mvqxpN7Ys
         PX8RsoYWvidgc87UaHkITbHkqHO1Lf0Qi0AXeWQE+fJ1ZO/4Xwa7lOTovwfBwlZgEUkz
         kn0tn53hqKetpQDzpkosNj7CwGtRW7mst7/n9e40tqzemXjUJRfSZpkst8Bytq1p/uhd
         5yz3uQF38HmXYOLrrF6LAy//c11UKZfT9jQNV5lwIb5akhQMIN7rjSKhe/qOzn1thK/t
         xjg/d1/tjS3uxBoEPoctKjjPCLdRniSavzFW+ebOdFaXLek9WnJk9YYV8JuaEzUlNtZ9
         lHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753325810; x=1753930610;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tya8198c6y5rCjUglNzcQUyG1Q0GYdplJmKHDjoJPmk=;
        b=JYSYlVfZ0JS+4qPmtcmeVvUQTjG22dLWSM3gJu5GwWYAMEMB2CWJaZlIXBsIhqdHaw
         gd0PPMWYXST3988XGRPnzHZ6VPwhT7Vi3SgzwKN3vom69+g9RlVIzWu3eopdjPVswBzG
         7cHO3CdJQBynPj21GsyAwv6cHurgIgvTJiUZQ6ElCCdTmW+5fMg57RBgks3QXtC9v4wU
         O/vwp40iRW4oO07eW2gf+D6rslWIfIZS6eomb2jSWS//qZehz4nuDTvlirQaDLrSeJAd
         MFCzWdGgfIDrN9FCNQKTbMZTbMSrEO6xhFYJ8i4FCyfxvpGQ6EqMKwPFHrTf6UzetCbB
         zBdA==
X-Forwarded-Encrypted: i=1; AJvYcCUWpPItpEXVFgauXzJSwcQz4h0NWhr9Qw8sQWD0rv8AOlu5bezBv5A/0daLVEZmjC7GBLiQq9H45ueIQQ==@vger.kernel.org, AJvYcCV+u4JUDtRd0lqiLxuFozD0TH8iiBQsuOxmbtMzSHbjB1BNmFOpbSG/vqisvoCb/vu0LfixoQeN3dHm8Si+@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwO1lbIJqvBytSgQQZOgHRYeBZ0q2H4dYEyDh03/KZKSDTxqN
	52RbZBo6EtUPk7MRfz4DCNGlZzWkl19bx032QAqgafm6GJbSXJzLWu8y
X-Gm-Gg: ASbGncss7kvqC+GG6khhziXKn1J02NmVFrg2l1/Uyg4/2zYOdUMZud5pfwYLt24m0pC
	ujeVmOPSsw5e2uwwDmocieNKRP85jNYSEZ43EUf2Z9V7IMFqhyegRmBInAyygHF/bteZwtOfEOx
	5TjnO7f7z7mBfrl+5lorFG9nLKeE6MZzqt6OMi2hJh+s8XEGM0X8O4NgTgX5pADbXW6QjzzILXd
	b8Sm3dbfQ39C7aVYViG2dOZ0RTpCvGMEBEnDPGEOv3SWuthibTQ2cRdtPxkPQNUn8vm5iofb4Gt
	LF4oJB6UZnE3pSxJ3l/vLUCqOsHL9WtHQMd1IN2UvG5peEUQRANQ/vOgk2A7EbfzGjKEj25PzFU
	2f24atpHJxg==
X-Google-Smtp-Source: AGHT+IE520yI5+0BPKLPxQW3nyViV/NFLkZpgJ6MunrUBo0qqOXFxpUrTpHAPcr4S00JME2ig8XXiQ==
X-Received: by 2002:a05:620a:3bcc:b0:7d3:fb3a:675b with SMTP id af79cd13be357-7e62a1573d5mr588472885a.35.1753325809726;
        Wed, 23 Jul 2025 19:56:49 -0700 (PDT)
Received: from pc ([165.51.88.28])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e632d6413csm50641385a.29.2025.07.23.19.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 19:56:49 -0700 (PDT)
Date: Thu, 24 Jul 2025 03:56:45 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Helge Deller <deller@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] fbdev: atmel_lcdfb: Fix potential NULL dereference
Message-ID: <aIGg7erPjz1qJQ1F@pc>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

of_match_device() returns NULL in case of failure, so check its return
value before casting and accessing to data field in order to prevent NULL
dereference.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 9dfbc5310210..b1017ac9c73b 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -922,6 +922,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	struct device *dev = &sinfo->pdev->dev;
 	struct device_node *np =dev->of_node;
 	struct device_node *display_np;
+	const struct of_device_id *match;
 	struct atmel_lcdfb_power_ctrl_gpio *og;
 	bool is_gpio_power = false;
 	struct fb_videomode fb_vm;
@@ -930,8 +931,11 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	int ret;
 	int i;
 
-	sinfo->config = (struct atmel_lcdfb_config*)
-		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
+	match = of_match_device(atmel_lcdfb_dt_ids, dev);
+	if (!match)
+		return -ENODEV;
+
+	sinfo->config = (struct atmel_lcdfb_config *)match->data;
 
 	display_np = of_parse_phandle(np, "display", 0);
 	if (!display_np) {
-- 
2.43.0

