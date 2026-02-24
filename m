Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A137037F724
	for <linux-fbdev@vger.kernel.org>; Tue, 24 Feb 2026 11:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933142; cv=none; b=GTD+vvccaN93g+2Mt9r0nL/4F6OlB1gwIF64tW2qAjcuMv73dzt8w8ITavtlPc8tmJ+wJHzv008EDoaPj+5NxE+okov0zbWXI0zlnugfCTrwRIRf5MYPo8heB7rlMysTwzVfb3boK3IwT59AAXiTKBGbg+bYB9Epeh9NiVQAfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933142; c=relaxed/simple;
	bh=Hco/dkh0BzM5oxpOLCzPRKLzfemvGFTZE8ZoJ4YPgGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mvg8M5bCp19P5cJkPXNWGAwOqYpKdZgnAQWgC3mxHMDp4Y95peuxjjen6cLBBoq6c1dpktQfOTzPXAJcgtgkEXtF/dfZ8amXbb7van4HUqUNJpg8xDnHpoj58ceBrqwOKQ1swqSSsezToV0Hf7khYibhmLt95tigtoQHuIo8Fpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZwrFF9r; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZwrFF9r"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483abed83b6so20622225e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Feb 2026 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771933140; x=1772537940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x43XPvqqlnrM3KnXK56AU57E+0X5L9bB6uY/Ah+u6rA=;
        b=YZwrFF9rx+OueA8KJpMKd4pq0wVADE56Atk4e0sO/1wWADPC0m6by1UlRlHa3Ciwsx
         HzAQB8ErYy44C/syL0zDCPm2iyzpSGdciBJkxl+UJqfRynyDK0k8MnxsNkpc7/81Y2bX
         NFiplS35pdWqwYj+1k5Hg6fo/md7YXYeJEsh4cDTWpNslakcmnlwELL9L+lonmfHwdAh
         7bf+lZny2H42mIYkqiChj7yPLjK5RcJ8PmfAmIvV+t9lWjyxEgOZfBjtjHaM0gp5rk5P
         9aAubsx61A0XE49+0G13MeAlsr0Va/0tjNIAiKe3o1JMFCCVsQQ31JWlTFys9AJe8LKR
         OWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771933140; x=1772537940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x43XPvqqlnrM3KnXK56AU57E+0X5L9bB6uY/Ah+u6rA=;
        b=cZY07Gh+n5vJJ4eCT954J6/DPBROMwJac7zUaX4ZInH/FPQeYRqROUqgoc5cbNtctB
         gQrvy/LF+CDWmbew6fTemEA1ZToQSzzNSLhxe5i0Y+cPzsiBDVDZPhmy9iRykFchNcAH
         KUk80TcI2i2eu7pDpsJ3cnA6I8XRPqmnFVxdgXnlEvOBEOEOHSETNnK7ibyYVKccTmjk
         BQL74G7OBLJ7q7DQgMsXtfy1NqoDs68hUOgp01sd82DtCzJLoYM7z2skGU9Y8QHWrcrl
         VayfZkUiyoUh30mQhYAibki5PCy4oMPZ6ppepjyCmgHq3O5QC2mRwPTBcd2/8ZmboqV0
         WgpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwbFh4WKCs9jxWwPOvGWJ3cy3XiM1gykj7qEckCCKWUG1U8fn/RQjCtZapb9r7sntBhqwDMKh6X1MbWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+BGN1q2ulNSZXc5W5IdpNxhPKDdP7gU6LhQtRJE9ugRB/8m/
	QH1h5B7jmLLOiRyQkDf6wNCtkrjpZWoKnwPJbr4CaEgiHpgRnUESraoa
X-Gm-Gg: AZuq6aJdHXjF7ZsZ+wDgr/8AP9TQAQDHPkBMKmw8tVefXf7XbdPXpuFhMAFeaV0WKiG
	b7Lg1MUE7EdumbZcA497ttZw1smWn12GG3bHu3QqXg1sITaD7bkSqpBNWqMioHnmsii2ompH59m
	7OeIzogjroR5YER7r1NShowyJY30oyC3zZJRx3/x6ay+Ni3av6GRpCt4l+xDp45E30p33hj9kL/
	2p1jhYXsrc3PfNqp6Pn50N9WHTfd5klivmhNqi7pheGsQB8ExQ5gX9108Wh6qs14u/mBecRGFGn
	Pd7sqQ7vEGQM3bGUhS31L8zzNGqfCfwiJeDkAKMKzJAOpYBUSgMXU2UogfEWpplql3uzjrkKx8c
	htGp1VnhxX5SHFGjhNl0dvFFFujLw48vEy5dLaAK/ht7tteeu2piFBgxQLWXIn+j5n0+uTgSdc1
	a1JOdG0YqyYSSLkQqYw0hLTMVHoAkE
X-Received: by 2002:a05:600c:8a16:10b0:47e:e4ff:e2ac with SMTP id 5b1f17b1804b1-483a9603c2dmr137785735e9.33.1771933139705;
        Tue, 24 Feb 2026 03:38:59 -0800 (PST)
Received: from fedora ([176.40.225.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d95sm25791902f8f.13.2026.02.24.03.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:38:59 -0800 (PST)
From: Ahmet Ramazan Capoglu <ahmetramazancapoglu@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: Ahmet Ramazan Capoglu <ahmetramazancapoglu@gmail.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Fix "varios" typo in ddk750_swi2c.c
Date: Tue, 24 Feb 2026 14:37:23 +0300
Message-ID: <20260224113806.1506361-1-ahmetramazancapoglu@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling of "varios" to "various".

Signed-off-by: Ahmet Ramazan Capoglu <ahmetramazancapoglu@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index 0ef8d4ff2ef9..e63f3b00ec4c 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -27,7 +27,7 @@
  *
  * I.e. the SCL may only be changed in section 1. and section 3. while
  * the SDA may only be changed in section 2. and section 4. The table
- * below gives the changes for these 2 lines in the varios sections.
+ * below gives the changes for these 2 lines in the various sections.
  *
  * Section changes Table:
  * ======================
-- 
2.52.0

