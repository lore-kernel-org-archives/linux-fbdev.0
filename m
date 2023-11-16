Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N8TnHSuH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D38D4D
	for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 10:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700158078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W54lS/jbyFmKQJpxN3dQRiCf/ft7R1Q+OyFPgBZkh2k=;
	b=N8TnHSuHpwtjPH68TEur4HiEn8RBJdj+RRGWGlgV+SG6Y528DsSF/Bnx1Era+qDFTMpzdj
	fhk5FQWlnzsyUORJEe2xwKkwWERlSOHxXodOzZTsWTaUWAH7d4unWEraYFm5/8TLmQfTzF
	4tIVnGAyhDPzY5+osA4gWIm+K/J0zZs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-lXODFWjYNvSK7hsmrVOL-A-1; Thu, 16 Nov 2023 13:07:57 -0500
X-MC-Unique: lXODFWjYNvSK7hsmrVOL-A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32f7cf9c33bso539969f8f.3
        for <linux-fbdev@vger.kernel.org>; Thu, 16 Nov 2023 10:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158076; x=1700762876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W54lS/jbyFmKQJpxN3dQRiCf/ft7R1Q+OyFPgBZkh2k=;
        b=GZmRs5WraUUS5JavB7KX8f10Lbyq7Ut+XZrcKorKm7Y/xKSVLgEULCpOxxrgh+lIeV
         SYKEriczCJ/3M7w+q4X+yj+poEA/HkmVCZfKXWsaWehC8NHnZpinbSdQ2GbLTsm6wcfP
         tvgV/6TQYjYYvSOH8NgIdb9ov90DqzYPYqWi6ZKUlW4vX6dtf/m8WcEoKihsatK+pAqh
         gZiKYAQ3w9+LRd1GYWkvdWnAEqL7phUa6yoZ8tllD8CgtrKUPWJwoZZN0XqbYBZJuFF+
         OlLnbSM2ETkTdw4KbTSwvXJ/P/zB0hkHLR/pMD8Ty21a+SdWX/HeIgUFlfU67C4it0uN
         RbWQ==
X-Gm-Message-State: AOJu0YwCSkve7i/owmOE8/GSOlMKlyuLv+ANIzn0cdRyxG61a3nzQhnZ
	qI5N5O3vaogLnRCIeuCX41RMXODmW4k5RWwukL8983fy/XbtedolSrCbB9YdohexR/CX8Ep3pZt
	ya8zCAtkHE4QMZ7XUjSR94Hk=
X-Received: by 2002:a5d:4441:0:b0:32d:a688:8813 with SMTP id x1-20020a5d4441000000b0032da6888813mr11709936wrr.32.1700158076059;
        Thu, 16 Nov 2023 10:07:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr2Uo2/zKtm0kyeqWnh34kZmrEKiHbZLy5vndsH3tPLeRv2OqMJqf+niFFID1bDqbG3zONhA==
X-Received: by 2002:a5d:4441:0:b0:32d:a688:8813 with SMTP id x1-20020a5d4441000000b0032da6888813mr11709913wrr.32.1700158075741;
        Thu, 16 Nov 2023 10:07:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b0032db8cccd3asm32812wrs.114.2023.11.16.10.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:07:54 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Sahaj Sarup <sahaj.sarup@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Helge Deller <deller@gmx.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 2/3] fbdev: ssd1307fb: Change "solomon,page-offset" property default value
Date: Thu, 16 Nov 2023 19:07:38 +0100
Message-ID: <20231116180743.2763021-2-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116180743.2763021-1-javierm@redhat.com>
References: <20231116180743.2763021-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is used to specify the page start address offset of the display RAM.

The value is used as offset when setting the page start address with the
SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
1 if the property is not present in the Device Tree.

But the datasheet mentions that the value on reset for the page start is a
0, so it makes more sense to also have 0 as the default value for the page
offset if the property is not present.

In fact, using a default value of 1 leads to the display not working when
the fbdev is attached to the framebuffer console.

Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 5ae48e36fccb..34f014bf4994 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -637,7 +637,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 		par->height = 16;
 
 	if (device_property_read_u32(dev, "solomon,page-offset", &par->page_offset))
-		par->page_offset = 1;
+		par->page_offset = 0;
 
 	if (device_property_read_u32(dev, "solomon,col-offset", &par->col_offset))
 		par->col_offset = 0;
-- 
2.41.0

