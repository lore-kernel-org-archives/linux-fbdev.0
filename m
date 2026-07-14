Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F344C9567
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 19:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056291; cv=none; b=Pj10SzLSxni4wpzRwP5B+yfP2N8ckwG7slYG6Ndsej8FL3VXdG24IA0YUvfPL/brokADR/r5T/aDiJHSnFVF7BOCb9zo4AOgSAAwxBKkNWPO3mOi3ZjhBQv2iAgLfV8NrmYolZ1G1E6klzJd8+ib9TbiPCGWI4F2X1NtiQRea+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056291; c=relaxed/simple;
	bh=LAYO4eoXWCrre271g744oTgjBTY5ZzqOUJH42pVwkbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTIOQw5b2fxPsuucmDhaK8LcRfEYg8RXxB4jKcjS2sRt+wRi0A5xzUOMKI85iBDKj+F6FejHMkKbueA0jIfxM68+j8XVak/jW5tUXNLg77FKahEoxMT7c3LzM7f7rXfUzljHGs4RHp8SkQJFPDKu11sIem16QXS0QzAcnEgQItk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVcqi8zl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVcqi8zl"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493ce08a75bso18505275e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056285; x=1784661085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bOMU8cZKzzQg02swhcvJoLmSoAF1bo7hqLkWzLq/6T8=;
        b=lVcqi8zl6gRLdcIBxqnizLU192QZ9PnaffF+0LXNyDiTh/fTmYNKt0aWh8zGeqKp+j
         8ZpKrI485YDpuCayIAPBMsrtcwKZA2un9VMPdCOvlx1ELxJTjKsuUDx5Wv9pblQhuL/t
         tOt043LogOrNn3FJk9cpb/KjBH4H7v0JK4Kw3sdGDxVu27fhxYL4SkSioiu1jp0kepzO
         Bg4A8dGbKUlLyXsAhol0LrJb2tWBl/5+BILHTKaJEKCXTc2s3iNoFm/JqbND/qvBoQdc
         bR4MHQN2UE9g3M+FBoZjhNCSE3PsmfgD4lrsLRftwOwL9LRgtwdG++89SGuSMA10LfXV
         ro+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056285; x=1784661085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bOMU8cZKzzQg02swhcvJoLmSoAF1bo7hqLkWzLq/6T8=;
        b=ckd0tc9sRzwTkR2HqnaNEWcaDUJo1aYRTDpPFilBCMcQGuzyKt4a3vEDPmdz3g0Cma
         /F5mymiuKnG/bzvavDldh5YxO6Jwi84khjwzXDNyCaK5lZMmzqtSXdM5SQc9dPbOPiap
         hETr6PgCwSosKGaRW9LJ5mcQG7J/vzSBvNBOk1uvFaSRZ7RyGyUpnAwNHR/R6+vby/ue
         zSNsGyg/wkt/mvWcoO2Xxr1ZLXrJ8BoZMmUebb0p2MvcJut6q/etrrLmP2w52QbkPwUx
         QKEVBLQOKzW2fNezHwWIWTMoBllCzZLB7joTQXYXSQvIaoaA30inARBvBPYYr0sZbr4C
         lupg==
X-Forwarded-Encrypted: i=1; AHgh+RorGW4VDxNVKzmZli3dO0ydlNtIhoDb0TQjr4cYw2kR6vdNoXpyWxWtYh2cS7LKESS8AlschTsJ2E6Jlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzK+3SI2/o2q8jAywc6qJVqvWDRxsPa65ZLZNVkB1NWsGSS4qtD
	+sUasbxrl6uvLY7Rub8pi8PlDeBLqISb+LmiWgCcs8Tcgo+eChvmWCJP
X-Gm-Gg: AfdE7ckAjZZF2gK6/LpAFP7fBwAva5+2MItHFIutzXGypESxHFk36RfNqfX95WpOzNI
	M4727tdhCB0TS0ynVQ07YX0p6XUXKaE1qg6KejOC+2VggOTebPhRgbGzfyd5v6JlWQSU1PH+cA5
	rxjSUNCQjhmaP0ymCLARQ8mmQlVj0/0HjQ/P05blxvOW+buDSYgS3+uNljCPRPJCJklZah8IbwF
	HOLqGpDx9g0FI9FzeZ8mcrx2a1YcIBZWXREW2wXKKbUFQlh5Fv7LokW+uGjAV3qscOgDKyO3G7H
	8tQDogsjyVYg59wRFWls6i933Vk1LsxzpbvsGHo2tv9zs0NiOXteKpMSPHqJEEw55YrQow7adZn
	0FssMKUCItvpC3MjYj+tXNvAYMb5STcINdAeR+oBy6KGhjuivXrHDpE87gWxAtbssSdvF2BTfk5
	00oyzEgvik0wyIou1j+3yFeiVqj05Pna3164ElfrkBI4mtpa/96/QFtNU31hYp6bI7SY4ILiIf2
	7fET8Tb0zSINFonqAuMRA==
X-Received: by 2002:a05:600c:468f:b0:493:cbdc:7cd6 with SMTP id 5b1f17b1804b1-495158c6a71mr56346085e9.7.1784056285501;
        Tue, 14 Jul 2026 12:11:25 -0700 (PDT)
Received: from evil-archie.tail5479a9.ts.net ([2a02:1388:23c0:16c0:aa41:f4ff:fec6:26e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f951asm100677815e9.14.2026.07.14.12.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:11:25 -0700 (PDT)
From: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: namcao@linutronix.de,
	tomasz.unger@yahoo.pl,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Subject: [PATCH 2/3] staging/fbtft: Align arguments to match open parenthesis
Date: Tue, 14 Jul 2026 22:09:41 +0300
Message-ID: <20260714190958.219437-5-graviaspanagiotis1@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch warning for alignment in write_reg() call to match
the open parenthesis, improving code readability.

Signed-off-by: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index afa8f1c740c5..d58b1247262b 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -38,7 +38,7 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, 0xE5, 0x00);
 	write_reg(par, 0xF0, 0x36, 0xA5, 0x53);
 	write_reg(par, 0xE0, 0x00, 0x35, 0x33, 0x00, 0x00, 0x00,
-		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
+		  0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
 	fsleep(250);
-- 
2.55.0

