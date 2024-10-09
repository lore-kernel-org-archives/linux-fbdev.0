Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A151E3780;
	Wed,  9 Oct 2024 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488923; cv=none; b=enzViyR6HA+8eTBQF4BGhRODauj2yI2M1UbNePFptVOnF8BGmo+JNVOg2x6BqKCzM56pOqXaNIoiqOCT+sbDRMBF9TKlC3B5QawZX+5+P42nUVp+WkMEl8sFgDVYLoFe63KsZdD2ShCzwmUn1kA+e0e+bnnxqXr0oqkKH5sGivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488923; c=relaxed/simple;
	bh=BvhB3fFal6qIRjoErM+X0ss56drVoTZm5GFWQ3iOHXs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rAEg1sXTqshIqZuD/bE5EpBURouujJLyPu7o3hBu2oIiDGlpglgagJ2iemVReBAOcGz6cGIPE0Ep2kahf2ByamRNU3jWMOmbCMVG9zIZo7YrLlZqzHXU849Wao2w5j096X2z9FtDqwfrpreAChrPe54NXvsX1NQLa1Rcdovibp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8sfelsA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8sfelsA"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99415adecaso189796766b.0;
        Wed, 09 Oct 2024 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488920; x=1729093720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpoA7U68G9HQgUGPUrZ+1IXl+YXLZClnFOv3Pi/HKVw=;
        b=C8sfelsAF+4JMZ8guudARms2CDIU5ITZ4WbfXiUcCEX5qbzENLDHiy9cRd+Yhqof7m
         qERZGuDLcWxQLoA2P58cK2b7NNwqUpBqmJo34gTWMdKFHmmDTnWZf2coMnyLocWv7r7s
         cRbpgQEhdDvXzJJSWRxWz2xLerqJK52xDRsV4JQkG9svrh1Smvpq18BNpvwuNnZy+waX
         MJJMfpx3i/BsJa3u9vFEXUbGFxf97dO/FQMlb8TVyzMN7CrOkTPBrPVEoXPAqnipwoLP
         s4L9EccR6H3yhA5iI/jERw07LSZOaIuAtNpW0RFom8E1EJcKaXbC2ub7ZNQZS7UtO9+a
         00mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488920; x=1729093720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpoA7U68G9HQgUGPUrZ+1IXl+YXLZClnFOv3Pi/HKVw=;
        b=AT6V8xS1rzqUPhGEo/Ob0VQ0DrgVpKgNctO7IN01WsIKTKwwePas3kS3UU8ru5XBsG
         lZ4ie9mISNP4T237ADsyONpgtwwh6v4bu+nDKufYOipSzGsPEBxdlwI7U4qCqZpH+3JP
         In3MpwPQJg0wrJ8yUeHTqAvYwVhXftX3QEhaPELl+jpQp6GZDBDSzXCESeVAJk5wz5qf
         fxaK9xfWJti4YT4/R9QeI1ct84yb5kvZZNvuETdvTmJhW1n5o1uY4GzKsrUxyyeHqJ+p
         SonTYaYZKEQ9K3h/FybG6PomKPx/ov8zzMhkPnPiY1r6IuGaYtC9ln9X5+JW1m/Tiobo
         mDMw==
X-Forwarded-Encrypted: i=1; AJvYcCUSeDyqy5nW2IZSnqxxzbQkrfCJsEYUVR/xZOdnqucDtplrUncjXGTBF+SXBClS8iYfWzcdMTszP7m7ew==@vger.kernel.org, AJvYcCXGDtbGZu5e/LsFCiu9Zay4sGGQMXd8wo89BmkeEtK5RItoU+ap1y/MSlNe9zl1kQPuzCPmOvHrnz5Bifk0@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTXkjPb4juGP1/0ixi5utsUSL3/uuwYLn7ZenHuTbx0IAJxC5
	2jGySh+JR8jcrY1J7f0EvDv4uVAyY0mxM4JDk8Jk9Nz+NJ85rRL7
X-Google-Smtp-Source: AGHT+IHWOO9nOZunGvkay9i7X+SSjj74oEgJnI0FqGywprSGNAjDKmfmkGDdTyOfIJpukNiscRSlgA==
X-Received: by 2002:a17:907:8f16:b0:a99:4e74:52aa with SMTP id a640c23a62f3a-a99a113b8f5mr5893266b.33.1728488919530;
        Wed, 09 Oct 2024 08:48:39 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a0b33ffsm623897366b.69.2024.10.09.08.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 08:48:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fbdev: clps711x-fb: remove redundant call to unregister_framebuffer
Date: Wed,  9 Oct 2024 16:48:37 +0100
Message-Id: <20241009154837.371757-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently the call to unregister_framebuffer is unreachable code because
the previous statement returns from the function. The call is redundant
and can be removed.

Fixes: 36462ac19308 ("fbdev: clps711x-fb: Replace check_fb in favor of struct fb_info.lcd_dev")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/clps711x-fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 5e61a349a4ab..c350340fb7b9 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -332,8 +332,6 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 
 	return 0;
 
-	unregister_framebuffer(info);
-
 out_fb_dealloc_cmap:
 	regmap_update_bits(cfb->syscon, SYSCON_OFFSET, SYSCON1_LCDEN, 0);
 	fb_dealloc_cmap(&info->cmap);
-- 
2.39.5

