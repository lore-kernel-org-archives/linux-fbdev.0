Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92BB22E3FA;
	Sun, 29 Jun 2025 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751208079; cv=none; b=sd5kT3IYzDqo7KUh/6sCPBDM6NlPn6ZQ5wjwMugSL5aEYGe5OGw9CUmnREqgOTh2cN8UnRo+BOp6fhFLto177cY/iGToan97nQToANq61I0JSYS/igZb6Dj/gH2cQZMIU356vD1Gawr2ssO9upX1qdIL8QvR60XoIGQgzsVyso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751208079; c=relaxed/simple;
	bh=HOnI86sZjsx6xFz6HUkJ6Y/S0K2+grzeifCdZ0x8xRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbROaxv9QJbjbmSgLWRhcMB9dnP1ChWNJnj6KSid6+DH/eNdvwmSELlpEJjRhu1rvmdYT+ULFM4u/LKpU9LAwx8iCFY6nszfWjFWdr1mReaZKTq37vvpvBOt6wfH4vYeoG2/TsdMI5SJYHibAZNJvr2MjmsqHmc6I+wMFYqWYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPVypMaE; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPVypMaE"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7494999de5cso2895813b3a.3;
        Sun, 29 Jun 2025 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751208077; x=1751812877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZlX6oH8dce3MqKqn1FEplwlovX0z97sZ7lCxjfOmHQ=;
        b=bPVypMaEdYxWFYzuIug4ntIRjthPRVPQuvoJJlk6YOmka9ECelyHZI3EQQro8ZoPz3
         rk5elgxeCQnJtYf3n+10GlrSR+mdPVQhqyb6O9AxeJonARDeTgtUSGYcEPoXjNzoo6oD
         eok2soUdmYKm4IALmt9gu1APhffRrWj0JiQ5UqXxNGq5gfAelR7y4tYTOjHM4ZF7984P
         IZ+TecHeyviOAdDXe2fli6Jh7Zy9YnCCPcpLksEg0CRQ9i9gh0QxpeSOFO/b+LWpiTZn
         gjlRxWByLwCJiIBhDykXVkl/zge3VId+RzVFHp89kagjVf9S2B8bX/gyFeqrt0Q8EIXP
         sP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751208077; x=1751812877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZlX6oH8dce3MqKqn1FEplwlovX0z97sZ7lCxjfOmHQ=;
        b=cIJJVA4zF68Uv0xeZRpA0mTwh0hHXMPl3lPSx88NxNCwi+lbeZNJYp6NI/XS620ypt
         E15bMTgMgTG45Kxkd/iC2I/SAOJRos8BUXrZrv5UR2vMNeHOPiFPNlratCAt8fW4Zc2I
         Jq2RWnSNL9xQze2aLjFrU5l7siE2Es0igTyYhBSDX+PjJNJw+E470+6rzbltpcHDcFwY
         zsI0AreOFrS3xE7Ev8hvhpIWSNPy2RU1Feh9yyx9PBFWLJ55+tKh8GaEW/VpKc14OQbX
         +Ruy3XMP2at2fekeBhgVoM1donjHmuYvDgR11eqyM5J08D7zZ/gd5/QdIIOtqB6WLcDY
         2mhw==
X-Forwarded-Encrypted: i=1; AJvYcCUX0dRsx+rJY2wbG+KWe3fDpO/BrRs4qRv7dI754nRvwlXlDNX71gUjYK69y3jtfw+ZuNuNrU8OpcL3vg==@vger.kernel.org, AJvYcCUtF/h78aLsbylShL6xpj9pQKKgUZ4aKzEfz3+GVRtZOzKcLUg7eGtQdwspwUIB3ee9M4d7eXyTP3OlEMgQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwrKc2M3/qh6uH5LoMjnRak/prBAiQlfDYFnWsyOb8RfCC7bs2W
	wqnnagzUI2VgObHTPv/rxYChxnkZIEM6LPPevDOFaEwX5aknLqMYRt2J
X-Gm-Gg: ASbGncvjPRjzzZ+3W/fkTnZIiOpoIWX0SfPuwM8KJzwudoxKjZ97b/mBN4B/6CKBL9a
	Wi0AFI8iesihoW1PcvX+WozkRHnk8uwaRjHRAbRix4Y38fwlxkFgMMuzUXqSqqfgjcdoQM2Hh2J
	hcGYoF8FYCn+N0loFkQBMv1ohBl2K1dv6F+AFNqV9Gsixc9BBMANOABjTIfycC4EWxdy4i0koS/
	T8+H7Au9QhBInbEdTAkEyvcT7k75I3WXtLXUQp9zZpc9H4gskFSU7PjELt7hrV7Fpjb1H1Cy4VS
	UsFIDaq3tHj8NxxOqCpLPcJWp5WDVZuv14w+UT7LvT7RYqZIqblgk0aYB+HyEz2JO3rnx+q0Oci
	sMoh7qfP95RAe
X-Google-Smtp-Source: AGHT+IEdbEmJ+1xilLUoHHztIEeRjjOpIEv3s8aocZ+HWOglf6JfXuWncmoSPjHPoauzqRoD+CjaUA==
X-Received: by 2002:a05:6a00:c90:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-74af6fde138mr16238310b3a.23.1751208077090;
        Sun, 29 Jun 2025 07:41:17 -0700 (PDT)
Received: from localhost.localdomain ([49.37.221.186])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-74af55c7e89sm7039127b3a.109.2025.06.29.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 07:41:16 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: andy@kernel.org
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	dan.carpenter@linaro.org,
	gregkh@linuxfoundation.org,
	lorenzo.stoakes@oracle.com,
	tzimmermann@suse.de,
	riyandhiman14@gmail.com,
	willy@infradead.org,
	notro@tronnes.org,
	thomas.petazzoni@free-electrons.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] staging: fbtft: fix potential memory leak in fbtft_framebuffer_alloc()
Date: Sun, 29 Jun 2025 20:10:10 +0530
Message-ID: <fd2be49cfef72799f17a96d01a4c6b92770cda7d.1751207100.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1751207100.git.abdun.nihaal@gmail.com>
References: <cover.1751207100.git.abdun.nihaal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref
struct"), fb_deferred_io_init() allocates memory for info->pagerefs as
well as return an error code on failure. However the error code is
ignored here and the memory allocated could leak because of not calling
fb_deferred_io_cleanup() on the error path.

Fix them by adding the cleanup function on the error path, and handling
the error code returned by fb_deferred_io_init().

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
v2->v3: No change
v1->v2:
- Handle the error code returned by fb_deferred_io_init correctly
- Update Fixes tag to point to the commit that introduced the memory
  allocation which leads to the leak.

 drivers/staging/fbtft/fbtft-core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index da9c64152a60..8538b6bab6a5 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -612,7 +612,8 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	info->fix.line_length =    width * bpp / 8;
 	info->fix.accel =          FB_ACCEL_NONE;
 	info->fix.smem_len =       vmem_size;
-	fb_deferred_io_init(info);
+	if (fb_deferred_io_init(info))
+		goto release_framebuf;
 
 	info->var.rotate =         pdata->rotate;
 	info->var.xres =           width;
@@ -652,7 +653,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (par->gamma.curves && gamma) {
 		if (fbtft_gamma_parse_str(par, par->gamma.curves, gamma,
 					  strlen(gamma)))
-			goto release_framebuf;
+			goto cleanup_deferred;
 	}
 
 	/* Transmit buffer */
@@ -669,7 +670,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	if (txbuflen > 0) {
 		txbuf = devm_kzalloc(par->info->device, txbuflen, GFP_KERNEL);
 		if (!txbuf)
-			goto release_framebuf;
+			goto cleanup_deferred;
 		par->txbuf.buf = txbuf;
 		par->txbuf.len = txbuflen;
 	}
@@ -691,6 +692,8 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 
 	return info;
 
+cleanup_deferred:
+	fb_deferred_io_cleanup(info);
 release_framebuf:
 	framebuffer_release(info);
 
-- 
2.43.0

