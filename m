Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC5E230BEC
	for <linux-fbdev@vger.kernel.org>; Mon, 16 Feb 2026 00:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771202395; cv=none; b=u3UNJfYIvLFbgSaY7XuLe0Ngtr+opT2+RQJ8uXtOSc2ndGLstWBUsOqggtqRl4Y7Yzyq02Zqi1R4cUaX7AI9FNxcYqxAKIV83GY2hceF9dqjeS7HqS6qGKbgnHDo1/anVVQa14YSmZ56QwNKQaHVCTNTNiK+uTko5e2q5UhD318=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771202395; c=relaxed/simple;
	bh=4tm1ZqobNRN9gXqS89aMjJcqkkBC7kWiXLvsGVQ5ByM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=snj1X77iA+MSi/gWEyoltiRsYfMGHV0IwZGQaktQouhOH4r4MJ/Jmd+pRztAe/zEIzWOK5Lj0JjGlvxfne//n3Di3b4RXSxlyB6pd8QypUmELYZX4QDDCnQBWaSy86+Fg2slZ8TUiEpAtWNrf83JDmSJhFs5Zu/hKZmrv7ihPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dr+BK54L; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dr+BK54L"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48375f1defeso19379785e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Feb 2026 16:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771202391; x=1771807191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vig4vuedFM1p5E9RWA9Ad6X94bVgmk9hfEgfxEl4qRQ=;
        b=dr+BK54LR80YcHCrOu888H9qHrUCQppU5ZxRwYOcChFXtgOuxcxV8O1fPyLuxMvNGz
         myReQeDfXiqUAVtJ/mtVl52qJufeeGEACMMm1iTgfyQFd6OfvTt/ay0ZqNnOS9r34zuZ
         /f1I9WGcTHHGa6RDAi22dk6CHYZ7BriApuAQvUXpsXo6ZfQ2amD1AQNqLsscxtqscJq/
         L7V2D6ckzWTrTb+e3jR8kEfQBCHlqFRWx5Qf7rJ+HuZD60eSWGSzxqfcKuIAX7cALtPQ
         1QEEVsj82GGIMXhU5V7TRrMt6l7Lf4dUIFxns/h3ydFJV3GHMt6N6ddmTmn2we8wVAxj
         H6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771202391; x=1771807191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vig4vuedFM1p5E9RWA9Ad6X94bVgmk9hfEgfxEl4qRQ=;
        b=xTDDBBBzf9K14PTzTT6Hw/8Epww2KPpcglRAM1YeOVVG6XrZq0L3Mw5VDhO9BG1uhu
         wFDm+I0TyvwgvyBuPG8eS/NldNaSBZIHvVaxoCdLRHuuk4siY9GdjSIzZkKMhbnr0s/V
         QIP435tw8hqZWVWJEJqePAXIUgkIekx0SY+e7SvBQPqswgFzkNvaPYB3xRncyfuF6YZi
         YVqrR1tiYMAHkGxWlgn1ljbbSLtuDkcZ1rMkbPAYvWS0Ap4WCAaPha3QoM6DIiYLXlHC
         /zkmaAK5U2Gv1USm1G75NEYndyS2DF6m6DQBGEv4ojfnfxjPnXWrd6ptNyTH9ly3Ym16
         JaHg==
X-Forwarded-Encrypted: i=1; AJvYcCUEEOknCPoQVZ7eiV7jWkS+RBDrfryTkyyetbD5ne3AKPXoc41sxYFi30kdzWRR1l26M4J6RwzWpI/wFg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9vuajPiVkW8VjxDvFEfxok6mr0D/rUYQcGqgSRL5aAqWa8ILN
	phJJEQkU08GxGVbFEMtXWj1P0Gmvnuo3zNbCPkmhcCOUrkmfVhGQvRW7
X-Gm-Gg: AZuq6aKklJd9qZUR9ebdWz5yZsZfm4IH8tmGoR8+jpbDCtVd/UYcgqo9pQrP8kjSr9I
	XAozDWP8FREJaYCOTB5u6WjVP7Tson3H+j5o5phRWx9t+28+yfnSkmVfhBxqs54bjcOn0zJjhAH
	fZHUY4AXmurcPg1NPVi9pBct1YWrWIty9Fn/cNx71sJZ98MqdzbKRj3pRytBm6k7pIHg21kzOjQ
	ZixUlX63ar3PE4/wQhRp4u4+d7fwj6BuPnQPp3vCUbhcMJdCwGzk2+6NK4coF5qIPSrGGMz5aPg
	vUmclrdDUMCPTR5zIBlDuXiC+p7laqWkzgGUc6/HucbkJbqqOzJI3ZVou7+wlE14QQ8c2a7CPH2
	7sYRSmMfG9KqQkHBK0yQ+lQk1MASv3B0eUHEi1jXUY2qh0li31UZB1jzGNJ1ea3ViRMNj8xwYhc
	+W7OUneU8xjNLf5rwcpp805/YNmGysVpapsw==
X-Received: by 2002:a05:600c:5299:b0:480:19ed:7efa with SMTP id 5b1f17b1804b1-48373a7a0dfmr118045645e9.36.1771202391232;
        Sun, 15 Feb 2026 16:39:51 -0800 (PST)
Received: from eyup.ktu.edu.tr ([193.140.169.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835d92267bsm573656885e9.0.2026.02.15.16.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 16:39:50 -0800 (PST)
From: =?UTF-8?q?Ey=C3=BCp=20Kerem=20Ba=C5=9F?= <baseyupkerem@gmail.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ey=C3=BCp=20Kerem=20Ba=C5=9F?= <baseyupkerem@gmail.com>
Subject: [PATCH v2] staging: sm750fb: add missing const to g_fbmode array
Date: Mon, 16 Feb 2026 03:39:39 +0300
Message-ID: <20260216003939.206758-1-baseyupkerem@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Checkpatch reported a warning that the static const char * array should
probably be static const char * const. This patch adds the missing const
keyword to g_fbmode array, moving it to read-only memory.

Signed-off-by: Eyüp Kerem Baş <baseyupkerem@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e615..15b5de33b8d9 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -33,7 +33,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel;
 static int g_nomtrr;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview;
-- 
2.43.0

