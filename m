Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GuRLhXgI"
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA9C1707
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Nov 2023 01:52:27 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so2312115a12.1
        for <linux-fbdev@vger.kernel.org>; Fri, 24 Nov 2023 01:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1700819546; x=1701424346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lPiBn2j7nRC2ohY93oZwJpQOBSGsTTZbyG2+TlPFQiA=;
        b=GuRLhXgIIoNoHiXXElj/Uz50alI1JdzaFBgz6HNm0jkMA8K2Bb0bcsJbbw+Jfdf+B2
         cuGzMW/kI0M8GKmj3emS/8uoHTYV+/tD8CEHXZA3I+XmO8Dxho0k4v2g8k5dIGE62/K6
         zU/qZDypAnI+Mlqiz7q/BiPH3Tkdl7BZ9L14M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819546; x=1701424346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPiBn2j7nRC2ohY93oZwJpQOBSGsTTZbyG2+TlPFQiA=;
        b=VVHKpPTnz2ohbvuXBHiHzix1YOgJrwx4A3hIuVi7IATD4mDUOfe7ZmPir8oDfJKPQq
         XIJo5/SrMlQAszsjUR6dXlHwBXF8bfGvN+scnjctzS/3uKeavyiszOre5vB5CLi3n7LV
         j+nf1px86Nhj1E3wr8RdR/WpsBnjqAJkTK661LWPBTl5ZYwq1Gp5phzd/c7s3orY3hR2
         fNuz/bM27PeohgOnhv0hYQKSdG/BafMfQYjRN5f1sS9jdvUujscRHwVm8MGh4Kltx9UF
         0BteNKUNAukQDy+ukX9aDf2MKOnVhBjSS0z4CGHkuNi6Y33e0lHwI0o3pjq/UIPhN8r3
         X7QA==
X-Gm-Message-State: AOJu0YxGLeuOqQzKuWmHURgWg702cquOpZNiwFw3cqHiYMzgpBX0uucX
	qz5Kr6XApFp7CkyXcHcowuoQbg==
X-Google-Smtp-Source: AGHT+IEBfhEmsD5EKPJl+/lEhxi4nG9SttIahQn1yPMeWAXJB+1krEHdfcyXCHFNF8KJVIk8quJgcQ==
X-Received: by 2002:a50:d745:0:b0:543:5741:c9cd with SMTP id i5-20020a50d745000000b005435741c9cdmr1359620edj.34.1700819546366;
        Fri, 24 Nov 2023 01:52:26 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:7c18:b9c9:f303:f6bb])
        by smtp.gmail.com with ESMTPSA id i7-20020aa7c9c7000000b0054855988fedsm1588384edt.37.2023.11.24.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:52:26 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Zhou Zhu <zzhu3@marvell.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH] video: fbdev: mmp: Fix typo in code comment
Date: Fri, 24 Nov 2023 10:52:11 +0100
Message-ID: <20231124095221.659445-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/singals/signals/

Fixes: 641b4b1b6a7c ("video: mmpdisp: add spi port in display controller")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/video/fbdev/mmp/hw/mmp_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_spi.c b/drivers/video/fbdev/mmp/hw/mmp_spi.c
index 16401eb95c6c..64e34b7e739e 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
@@ -91,7 +91,7 @@ static int lcd_spi_setup(struct spi_device *spi)
 	writel(tmp, reg_base + LCD_SPU_SPI_CTRL);
 
 	/*
-	 * After set mode it need a time to pull up the spi singals,
+	 * After set mode it need a time to pull up the spi signals,
 	 * or it would cause the wrong waveform when send spi command,
 	 * especially on pxa910h
 	 */
-- 
2.42.0

