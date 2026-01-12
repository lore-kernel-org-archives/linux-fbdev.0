Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059A264609
	for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214350; cv=none; b=YyH2d5GwwVjv+KDO2Ry6oYyDGlVjRI9FO4m42+42KJutqBcRICecrzJq7zMDziIVdROmqo27IWWhQbIsj09tKsn2aFMzpc7h1ugFsob8EglUZVtGCQpYFLPVKnA4DujvbwJexbDVxcAfB/BdRDH5FHbw6zka9phROTrEn/7vXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214350; c=relaxed/simple;
	bh=6GN5OLks7CVN3xZnRAG8Elxtq2enD+onkx6FZ/seN5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qL+VK6ogqzkT8FdXzZpEWwkuFoWftUC4NwHgUlzoufnFTXvnDjNG5FlOR7st6cf0eC1duW+5ZGWse7gwv9QMq+yIjjiNdXisU85283OIE8e6HC2Ac+6dGe7BJpf9unwHDqA9csiqMTPKQPVV7P/nc4yDBR9/PirNsxPUigi1+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjM8nxti; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjM8nxti"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so4116580a12.0
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jan 2026 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768214348; x=1768819148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ui+V6GEq0tAFtoS7qG9vSLrHLiqwJZVjJzI24qFkSgk=;
        b=DjM8nxti/BdowmvYNAHbiEwCXtdDJoIP+3elHOg7aW3nD1rIPE4hjHqfZVHFp72rMV
         ELjH0W1MQr3y787gEpKEo1LHjLIdDj/hknZUWMPo00h0NN7VmMvqFfpJVVif5VRErsQJ
         t6QjAVW+2Ma8OZNByB+HUGwh6xBG92muokhxBMEHV9gbSQAEdaA2v+Gfciz2kg/IgykQ
         3P25rRGHkm6eM6+Xu0v3yds9BvOkaGscNYedZ5eUTdcQKvIVSfwz1czRn09AObywcwJm
         jACCav4KA66+mhhFNOFcfIynahezTEIKI8MEUvtq5B1aX9mRiXNW0e0jotc3MlgxOXu2
         a+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214348; x=1768819148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui+V6GEq0tAFtoS7qG9vSLrHLiqwJZVjJzI24qFkSgk=;
        b=PGzTX2apLBNRqJFUPgEge3A5mmfeb8I+wI5ZpPFN0r5k7IWpHZPzPKXVK/GlthHeTD
         AIECTGX77RTJ1klb4QFItuVzdZ2lqCqCfM64JlsyGD/3PMpiaH2J/PPybs06MtkEulgs
         7ytr/xI67KBeXi3aqhpAE6G1//CpXBnNdtDrtvnFUJsjf5u9cXF/Jbl9VZkuvQ1apXTB
         C986MhrD/sbefWtfZa5ALyZiw6gJVqUYy6IOmeqobP4pYRFlXIJiIEIrtbxbO2FDY+1V
         woRH3icDix0d2SnS17QmHkmS9oDkHdeSvL5KuXTRLFV905HE1BtXUvvxKsnuZcSpffnF
         3irw==
X-Gm-Message-State: AOJu0YxRfu8F8+sO6yZ4oinj+qIJDePHCbyNfQWBLQlJ5lYlI4MYOzoi
	+ubGNw290SSKdGzi2yVsrvyN+R6dirGiXDsVRDJn5yEl1ZX+1CsIYM7o
X-Gm-Gg: AY/fxX68+XXxiOYt3otO/LcK13r5iUNq1P8m0f9Zjbs56hpEPIvmK5J4t78MOPSvMbQ
	lQ2Omlgq61zkrxQaUj9JAlitSj0SKyxXUKUIS0qZdiUQ92jctaeInpht1GpiDQJSMq9dthW5hf/
	E3Q/r6Ae/tWJZLK/hDdSseDC7P6pb3VXheJ5VrQ6yReBWhHD8r6DiGyeM0dUtFyI/CDIfgjD8PM
	FQEgAIppk46fiCDMnjLe9OLzK0AIZ6JwK9k41Yp6ne3MxIkpHZ55LiS4OHPIembpP05TgOUGlIo
	SCgAJd2ZeinylqmfYhUxxikTlucL76ex1ccn9mqe8xOJEEOnpfG8p4A3D+7FsT4MP+zmkOqzGxH
	lc6ty/1AssMiK2s+ohJ5U5p29c8NIscvutP+u/Fn6KHLzElpbJqPN7HX/Purd5++J0G7bbR1hUD
	eQ1xMpYwxhontG4jDxKznEgBIPnnX9jA==
X-Google-Smtp-Source: AGHT+IGCEegZv9c9USe2WVt4K3BTU/fp3ltvQvAk0xMCdt6Z9AWSScfDPK+97I6LnYsi/elU1hJjHA==
X-Received: by 2002:a05:6a20:a110:b0:253:1e04:4e8 with SMTP id adf61e73a8af0-3898f9bdfc0mr14753443637.56.1768214348272;
        Mon, 12 Jan 2026 02:39:08 -0800 (PST)
Received: from localhost.localdomain ([103.215.237.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cb5352268sm16680309a12.0.2026.01.12.02.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:39:07 -0800 (PST)
From: Karthikey Kadati <karthikey3608@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Karthikey Kadati <karthikey3608@gmail.com>
Subject: [PATCH v2] staging: sm750fb: Convert sw_i2c_read_sda to return bool
Date: Mon, 12 Jan 2026 16:08:38 +0530
Message-ID: <20260112103838.22890-1-karthikey3608@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sw_i2c_read_sda function currently returns unsigned char (1 or 0).

Standardize it to return bool (true or false) to match kernel standards.

Signed-off-by: Karthikey Kadati <karthikey3608@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2..9d48673d3 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -180,7 +180,7 @@ static void sw_i2c_sda(unsigned char value)
  *  Return Value:
  *      The SDA data bit sent by the Slave
  */
-static unsigned char sw_i2c_read_sda(void)
+static bool sw_i2c_read_sda(void)
 {
 	unsigned long gpio_dir;
 	unsigned long gpio_data;
@@ -196,9 +196,9 @@ static unsigned char sw_i2c_read_sda(void)
 	/* Now read the SDA line */
 	gpio_data = peek32(sw_i2c_data_gpio_data_reg);
 	if (gpio_data & (1 << sw_i2c_data_gpio))
-		return 1;
+		return true;
 	else
-		return 0;
+		return false;
 }
 
 /*
-- 
2.43.0

