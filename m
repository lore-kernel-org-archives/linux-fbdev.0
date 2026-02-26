Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29433290C3
	for <linux-fbdev@vger.kernel.org>; Thu, 26 Feb 2026 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126744; cv=none; b=odJQIr/MWWUxLSoDcWRyiQ5VfpW8jK7PxlQjHaEKvOJk+GSTqE8rFKvss1Ehn3yWhOr6S5rtJ5fLOSpc7qUDKIodPb6AVqWZamoTIZ7Sz7UABF7DNTlL2yVGoco6dqw3lMl9/QF9AHrSFnNm3SMrBxWcnij7ONKSZ48AU4WDMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126744; c=relaxed/simple;
	bh=paWklGpJmpSfsuZYbC3wJR/iurGqjmM8lMz88UioawE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e83/W1j0yWoCwJYo3tGDwpGZiZLnHC+wKxg8jlWUV2UEnzJpkZuQYDlItqvlzVDyNpiSOdPed8W8F4nHWKL5nvI21SQwzAg/GrjsH40bBDxzkVltk8iGrm3EuGAz5sOk/4A5K1OuRnaATX1lOTvdjSrkQbln97ec5M9SUo2FyfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6Q0gTN9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6Q0gTN9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-358fb86de36so901054a91.1
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Feb 2026 09:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772126742; x=1772731542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNtQV6U7Rntro5/+pgriQkg2fm6u58xz5i9CJk9lKHQ=;
        b=C6Q0gTN9IgoZrxct0DUpjBe/drq27YTbpTVaAvAAVFnFO8cIwQJNmvD6apMr7wx9aF
         6u4117jz56gzHLx9RZyqxMpQQMzOKVRMSoY0VgRsAC/JrDifTEAg7LfqFZyqDNEgan50
         o4OlURVJCi2Qxo9tVYTBtCsnRObl9KvjXLWBz0lMxSi2dY32IcoZMaI1TQpxtBkZgosV
         qVLMQ49BEnOqnZF6ILDyDWB/g2Hq0oAFkZYTyo1Rkyjr7IfwMEEASGDd45f3uba6/We0
         LQe/6Sk9dMIVLmlSqxfjltvdiVNzX8l3pHjh6vh2phducnhrG0YVnxjhjPOZ+S3cl4eV
         nROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772126742; x=1772731542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNtQV6U7Rntro5/+pgriQkg2fm6u58xz5i9CJk9lKHQ=;
        b=JPngeDfu9sPov4QiEziCxPxX3en7tkL1IyrJOAKbHJqf6obC+NEDjf5fknBgSCPe0c
         hgmpyZJyhxEb0IP0yHzhwTUKPir2XHXKvXUR52JPaRTOPrTXZd1+hC+VfpoBbg6315TJ
         mOpjiZkIKU0tZCHUTVlAOVeu24yLZasokv02w29h4/fYNiFm3nK1jmU47XhpMRQLfHhJ
         gXiv8/DQ9gBr8/RKhwJifLf+Jm6S8/jg8HnPRvCjtNP+vJ9KOLNGjP74FHbXuPViPQvZ
         9QQuPCdRymv84dJaxuMYCQDYCIeYLMm8uWOVXnP2dj9lKadpIiCdQIStMjEflmPhYZGS
         Bl1g==
X-Forwarded-Encrypted: i=1; AJvYcCWoFcHR7C6Ockzby0BYwZDIxo3+1Ehs4PKG8XFYFuIMS/9vt44ZbMpJHQTf7xG7xfAoosiw9j2tWNtYGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyPUbVFaf1FIPflB0NpaAUGqsL3rG7u5GRzyBvDWbGE4ganKW
	19LTMy7REGZ4f9IKw4VxAD1Bp3KXzXXIC7EFmSYR4chOusfxZ3WNEST7
X-Gm-Gg: ATEYQzwHBG7Tn8E7iNcNv4p0bxnVgV4olZVewLpPvTFW7s7CC0EMCaer/6tr0CNDenv
	sOclkNAUyXnKM6tLYaMbxFEF1bWhsF3d1D1j5qU6mHq7HF40fmUc73nqa8HGmwtPzKSpRfFGZWK
	kXhXwGvHYb6k5NUi26wG9UszGL0B8j76+LJ+GI7MUjDgkZiO32PCI7CvWN6EulE+1AxQvszI985
	7WvhJLugiGWrxHuNrcpOkdcMJ1BMe1YqQmfxrWAm8e2uSF3cdZfMaayvZln3Fgz8clEn7pOMaS7
	o954HHjEKhSYc8oHoQ9cta4nyaBnM4I3H0iAZP2kxzWJdXnumG6GCh9q9crt+pJSvld7U18M0F3
	JKUAK7jJpiI8faIJlHopi3dKHOxsxWuZ5Ad0g4TswRZFruLgtM6QJvV0o9tD426wUD5eXwD0txA
	4WEM+M7AMh/3czywTSVSDAC1f7BQ==
X-Received: by 2002:a17:90b:33c3:b0:340:ca7d:936a with SMTP id 98e67ed59e1d1-35928b880demr4894986a91.18.1772126742205;
        Thu, 26 Feb 2026 09:25:42 -0800 (PST)
Received: from latitude ([2401:4900:aafd:b886:9ebf:3ac7:7a9f:63f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912f5f29fsm3692895a91.1.2026.02.26.09.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 09:25:41 -0800 (PST)
From: dhyan19022009@gmail.com
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Donenfeld <Jason@zx2c4.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Dhyan K Prajapati <dhyan19022009@gmail.com>
Subject: [PATCH] staging: fbtft: fix macro whitespace errors
Date: Thu, 26 Feb 2026 22:55:31 +0530
Message-ID: <20260226172531.13714-1-dhyan19022009@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dhyan K Prajapati <dhyan19022009@gmail.com>

Remove prohibited spaces before closing parentheses in macro calls in
fbtft-bus.c, reported by checkpatch.pl

Signed-off-by: Dhyan K Prajapati <dhyan19022009@gmail.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 30e436ff1..409770891 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -62,9 +62,9 @@ out:									      \
 }                                                                             \
 EXPORT_SYMBOL(func);
 
-define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
+define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
 define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
-define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
+define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
 
 void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
 {
-- 
2.53.0

