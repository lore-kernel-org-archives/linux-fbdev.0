Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37867352C53
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342654; cv=none; b=O8A7uZKAZtwHjA696hIdRiUqd9N9Ts+OaiEGord/WO9DV3F7FE+VdF2dLaB/HKDJN5zfPhb54Ag3Zor7Sewwa/ALAi4y1EwPnnBCAZbAyuiWaXjvKDO5YXkqkxOEx9S2wZdwTLeV3hiWmwYd0vmvAGNTNS6oVkdx56EbyS9P/l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342654; c=relaxed/simple;
	bh=8wxY4lFLDlRaCZNNwjFawTBuuObSZmvd5ia+miLvcqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hJNnsgbTrS0XJK8clfK7u9163vKqPsjHiC5PBnlzv+tBjSXFMzVyyZzb9m75j04ogFMpO6TjybJEvGWFytBtKRa2PcVSjTwxDQcu8UmZMGGqJBXSH1hOwYv7DpH3bIAdTE2zCQ03+W+YFZkaWMSO5L3Y1Op54//OoZHfn9sebSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HN0B4ROu; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HN0B4ROu"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so4336331f8f.2
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 14:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768342651; x=1768947451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=adkzvRDq3qVFPYxqcikdCLTY3yBHVJYfnHghvFsSO8k=;
        b=HN0B4ROuK6J3F5CmR5GJJENKeE/9XUc6UNhzmDCPrJ29j1vL66gPU8MWq8zaQykdbv
         Ba4U6EMMoYzfl7zTBF9fG7k8Q6jVU0iVSQMO97GllR0aPNFsnWF6deXx9VQ32TRbx2TA
         w3Bckz1OIfM+MIItYYGUksOhSEG6QW7dirxN0CxKxVR4qK9o7+iP37JM/5BgvYr/hsvR
         iPOm9lbi4R2P488rlZh+ayOnXM6XJdxgiqjeeqNGXjLPm7d/HsWOzP2CHJyc4M69BZOw
         K9IL7ZnryL0Q5wAoiF3SJ7DQWu7mJ5Od2AOGvBF1Xp9h17IVhWRfHHctkXfq+6/CXAOi
         Qk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768342651; x=1768947451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adkzvRDq3qVFPYxqcikdCLTY3yBHVJYfnHghvFsSO8k=;
        b=OKrSBrfUfdDgULT/xtmQ80trAc3kDVFJUMcGBmeX8VxVsvB8+ah6L+fkQKFJ3Z5p9N
         7VX9njQ+KDp4yC42L9FrDaVx5Brx4R3xTa8Cb+WeOHRr9N5DYbsQQVRWBgqU+YgIOsT/
         pHqtgL77Q9DED7sdZP+RVUrIPvHBXt4SZtMHEiNxvhQJ8O++h84yu2u2/Gs1/vJRS3qo
         wRG3DSg3adQoHeaISjopWqur8VxnXSxBYSZCoophgjytvjyG6wsg7L4YKnzkY1I8ksmU
         +HZnN3jHTdwrpihM1y7CySgLVnoR4TSp1v6cD6t40MKR4rHUkUVyQQpQ3P0hkC7s+QFd
         SNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLpnfdSog7wJpAekdjU1vEPR9jxJuHpESUexzlbb1UmfgFqghSsbczYgHFm3x9uNauv34r/WZTveItHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ0R0z9FOmI85mMaAHUaSd05W5lr6lI/D9FW5fZBRpdBvz2mNu
	szwTqijTUCyfRlvesb2fugq93PJ5o61h0bZjPJZqgyhJWry/Dn2ga96o
X-Gm-Gg: AY/fxX4B3WSbs4/7NxSfm/nwLHyyjNxfn/w3RQ7N4n0pVjKcQ+A5FntFuRvSuMgXpbI
	yUoj7eXCQrO7E7zGkR4+HXaec9zrN+ibcH4VmB9Ced2YayelVj8SbLjsMsJ0vJ7mWXAcDwHfKDa
	3k5/hRxSaexX+N54SpR4gyvsKY3CMMa8GMR4C44fyuECsKlBTX+uEoUuWF6dUCbIqGuD7m6KZBX
	wrX4VIEnM3swAx+/hG7gWmj6hSQTk9rhR/vHBJBzCRsVo0xvcurxOefGQaeMoJaR02kvqMIbb+9
	gvKpeDkpLdWl+6Y74CjXzrlfNA9oqmvHb6qGSjS7FaRlJE8iltKI8aX0rpJY9MrQdKYafuJPcY8
	XcNT1X0BCR6Pzg1nTDmRjGMYLytWVGBReyRYLSo3nLFhHm0oFU/Bl8rJXeOIABdsBIVQS9Iu0zo
	6vNNLzPMVPVH/A3ZKxO6IxVxvOk9vMVcU4kPLFR7d3VBty3A==
X-Received: by 2002:a05:6000:3101:b0:431:abb:942f with SMTP id ffacd0b85a97d-4342c557b93mr412443f8f.54.1768342651409;
        Tue, 13 Jan 2026 14:17:31 -0800 (PST)
Received: from ubuntu.localdomain ([154.161.44.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee893sm46148930f8f.37.2026.01.13.14.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 14:17:30 -0800 (PST)
From: Gideon Adjei <gideonadjei.dev@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jianglei Nie <niejianglei2021@163.com>,
	Matthew Wilcox <willy@infradead.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gideon Adjei <gideonadjei.dev@gmail.com>
Subject: [PATCH v3] staging: fbtft: Change udelay() to fsleep()
Date: Tue, 13 Jan 2026 14:17:22 -0800
Message-Id: <20260113221722.5157-1-gideonadjei.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay() calls >= 100us with fsleep() to avoid busy-waiting.

The delays are used in init_display() callbacks. These callbacks are
invoked by fbtft_probe_common() during the driver's probe path. The
probe path runs in process context which already uses sleeping APIs.
This makes fsleep() safe to use in these situations.

Signed-off-by: Gideon Adjei <gideonadjei.dev@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c   | 2 +-
 drivers/staging/fbtft/fb_upd161704.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..3fb15df31592 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -41,7 +41,7 @@ static int init_display(struct fbtft_par *par)
 		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	udelay(250);
+	fsleep(250);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	return 0;
diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index c680160d6380..7fe2b556e17c 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,7 +32,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
-	udelay(100);
+	fsleep(100);
 
 	/* y-setting */
 	write_reg(par, 0x0024, 0x007B);	/* amplitude setting */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Power supply setting */
 	write_reg(par, 0x0019, 0x0000);	/* DC/DC output setting */
-	udelay(200);
+	fsleep(200);
 	write_reg(par, 0x001A, 0x1000);	/* DC/DC frequency setting */
 	write_reg(par, 0x001B, 0x0023);	/* DC/DC rising setting */
 	write_reg(par, 0x001C, 0x0C01);	/* Regulator voltage setting */
-- 
2.34.1

