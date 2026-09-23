Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2E35E1D9
	for <linux-fbdev@vger.kernel.org>; Wed, 23 Sep 2026 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127366; cv=none; b=oBccCZGUFr52VNHJi/P25CEP4Pl9jp03anop4DAaT+56SaZzXa+r7XRrlfIdIuNF76t1Bn1EY22Eul+5vOU4cw8+xBKzq2yJ/35smXZYs4D0mXVtPl0dw3/+GLNpSyPt5P6bT0JEiWBwxq0a7A1L/c1V9iM8LbCFaEEOT/K1kvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127366; c=relaxed/simple;
	bh=cdAjBeMlNMT+7+wm8ZCCKENLpx7+MxggMRqCiLWJKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u/Dlt719loqmvAJ85tfqSNKVThGNKHl6EtD4fPKCRhpZrRX/PggBNgKnY6iqiBLAzkEN5ETXa/Wb67he7GzJccr9A3qkyhuiAysS10y/afx6p9bF3NJujUBnOgXLqn7hHqCqnY8aS0S9U86jfTOL2ugnBtU2Oru18Gw/MoFGr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdMzC1PS; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdMzC1PS"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so387144a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Sep 2026 18:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790127364; x=1790732164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=00Mu3E316L50R7aKcX+ERjAkcdHIZ0M1oyJeJ9Yl1So=;
        b=jdMzC1PS8B9faMukF4d1EIO9LIVfNA4cBScjtkkGpgN7urht8wR/okxwMVzfY8M8BT
         pT3JBaVZR1bZHzBJPZrNqFuyp4OGWgCQ7R0GWwjH/7BcgBfLeoiCegW3KrlcZcV4gaD0
         wo8hifytA5P7wSKIy8YPpqYCLkequ/6UkEcrEDEmTqdfcLaR4d5zfpZ5NU7KYe9xJEkr
         VEqU7vkTk9U1AP1hneV+lEQs/dsq/anwPI47CDKJGURbtOeEY7IQ2Q/z7pNwN5AYZxLZ
         eOLPNXZSip54T/ANMlJ0x08p0tU3tbxpqHg2ZdL3umr2CyGVm6k8+CLR37pxcIsIMN2H
         zKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790127364; x=1790732164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=00Mu3E316L50R7aKcX+ERjAkcdHIZ0M1oyJeJ9Yl1So=;
        b=HSY/D72eTQTnAMS7JjJexeJFSAllFNTjAu+HViAVMwMI6O+FKGKFVk4NP5UqzAyeTs
         FIHUOWCOaXmM8tboKBUGoj1H1CF5SyFZq7ATgL3PESaSVD67f1QW/pX4fEpQed7g/+9W
         XISmX9WVuZw1OldCYgC9kIWogyuyLbIYEXDlH+H74GBY0cwGcwd/28UtQbTy2vNbYHKH
         2eDAo1ZOisHFRl3RW2WhqjIc5vNrmeJN1vo2dgKLJo0LBI0uIrmLjMsfEBYkytSzXMH2
         vQTuq1HyEKXiFwiSKs88eWqzYTnjcw92bDzKR6jauCGjaubykYyaG0eoJHNvpyg/Uqr4
         i7Nw==
X-Forwarded-Encrypted: i=1; AKwUvBw5pT9xZzEvbAmlhVFF/uKGqhUDFTZs4mZ1kMZQ20FK64SVkgyIoNdoZw/RZZZ3lljsIssSeQIsIwb6Xw==@vger.kernel.org
X-Gm-Message-State: AFuF++muEDVBUYehCnzNPRw8cOJ9VXfTPmg58MLYcSlKfeN2qWceGHO7
	yagWrw0MbFbrno0HPQT3eNIvOvAtKbAKDEMeUG/vn+T2hPVgcSYugFdj
X-Gm-Gg: AYBFou3o6A4pNlt+9T39Wh7N1U3AwmsnSFM4FeHHr3xFGlvA6Frxxzc/xB1/IhF941r
	EA4DRUo8/ibATZ3KzY7R/ubP6VMJliDWZUpRn/OkYApfXCa554gj9V66jaNTOM3j7oXd5FtVCMZ
	eLpLU1YDsojfHkKT6k/CJ3P8NpvY+/oNhsezSA1Y7hHjEPzZilPMdPTWzfoTuwQ4tx2odrH8Kp9
	t+Gy7IgeSvHBkOblzm0D8ix6sEzmfdc+Kh6WakemGvhRuLO6/1ww8oYaR4ixN+JqqsS1KTRemmv
	gSx9gwYZmJ4uEGHAgdtqg/EUGNycjOJji4TBUomOk0g8a3j6UHb7hUP930sgVJMHjK1WvQ72IKA
	4yYwjd9fSb62rAMKb2CF7On6LtZ8APxopDtnzkoKz+eyjAUXCnsuWt1xTsf2F5HN2QPQJtd6t5/
	rw7kBTrUuQbmdRi8LOEMaHbsyrDyk8++QWR1p6kSVvxSzu5qOddk3CAxWEy7DLeWkT
X-Received: by 2002:a05:6a20:7faa:b0:3da:e1b5:2baa with SMTP id adf61e73a8af0-3ddf7e93850mr1125740637.2.1790127363814;
        Tue, 22 Sep 2026 18:36:03 -0700 (PDT)
Received: from linux ([205.237.104.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1afb99f0sm487569b3a.6.2026.09.22.18.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 18:36:03 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zateev <hackerowskiy@gmail.com>
Subject: [PATCH] staging: sm750fb: remove unused variable 'tmp' in sw_i2c_wait
Date: Wed, 23 Sep 2026 03:35:26 +0200
Message-ID: <20260923013526.12225-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'tmp' in sw_i2c_wait() is written but never read outside
the loop, triggering a set-but-not-used warning with W=1. The loop
itself is a fixed-count busy-wait with no side effects; remove the
unused variable and keep the empty loop body.

Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index e63f3b00ec4c..55623ad35be2 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -92,12 +92,10 @@ static void sw_i2c_wait(void)
      * it's more reliable than counter loop ..
      * write 0x61 to 0x3ce and read from 0x3cf
      */
-	int i, tmp;
+	int i;
 
-	for (i = 0; i < 600; i++) {
-		tmp = i;
-		tmp += i;
-	}
+	for (i = 0; i < 600; i++)
+		;
 }
 
 /*
-- 
2.55.0

