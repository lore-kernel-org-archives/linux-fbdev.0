Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A45221290
	for <linux-fbdev@vger.kernel.org>; Sun,  4 Jan 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524810; cv=none; b=rUesBLn/toI+rb9HJQrhHmxqeRGQjYkcpaUjDr1IGbrSzyNdx+1SSVwxCEOQw7vBeltfnv/jTRNDICZDV3kq8J0NsNzcdeunZ4VIbMBIAerpcEHKD7jofCneMzHjZQz1BSm9DQxcy1IM9ogpOHk3nqqICW71nvKwZLXFlD5rwcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524810; c=relaxed/simple;
	bh=eDHeyoZczKr3AyHj3CQ3Ty67UKiPmoUz2PAKeg50fG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ag8fTpMnlFSW1cY0NkAD87DWPgjiNOeiC9cGQTKLV7LG38Lw7JZLfGVp1pBbc/KkYfSZUsRvQk7p3uY/Hy3A7ZqBlEeRe+Q23G3ehZs5d6e87nS6cBpF83LB41J5i8Bry7jWJaCDemakHklya2+XZS4zxN8n3vyiHlhWqHOgYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNADy/9j; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNADy/9j"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c3e921afad1so1584204a12.1
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Jan 2026 03:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524808; x=1768129608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUCt/I1JDgpKPWl0wJY+VdRCfc9g+GhZhdDVLk6Y6Gw=;
        b=dNADy/9jucsyc3RpzgNvYCiFGj3SLfkA8hYCzubnb+Mvp1xm+H1ozypetB8WbEX92O
         RYIGIzC5Gw7+oGmxwqctjcuFIol5k+Rj1cvf19JUkiHToUtWsRHun7/sexxjrpfEwI/j
         c8mrH5VgaLEFKfwX2Teue2vW89CBAHlxyOd2nK1hGZ5XSI8cDEDb/ppQpxpDtE/h0H8N
         ZyqZc+KcDbwbPk3W+SiWSYMiiTefB76hNG0qXEy/4U9lO36mOSxmTnGTPHDXPDdxdnWV
         DVS0PeOCajRziKN78EQy3ghBXYBUj5dLaUfkVbPQC9JEQ5xE8SR32z+xntArVVsNeCIk
         jenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524808; x=1768129608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUCt/I1JDgpKPWl0wJY+VdRCfc9g+GhZhdDVLk6Y6Gw=;
        b=TOY2/cK3Ao59E8jNSTHCK0MkD2kryt/I1b7HIn/vnfvx+M1o3q8BXoHPzontjnrTkI
         mi1cCzNfglKWGusQgSmtts8GvpkDV7pdcw6Ommpah59hyPgUA9EWG85E4ap7nAxN+KF6
         lFa+wGl2o0BZuVnJd0/YXMzTPQsNC6tLfLWrMNAX70Hnih9fuQ61MsDtpbivnij3Sg29
         SFMP2SIbGUgZPQFaYonkygexOlXxVXcw+9yPCoyNI1pfqa4TXZWJ9iPoDgeEZp5Cto3o
         r/EAz4EDwGVnbZbqdnF7zGnHpmBGT9zdGNUvuZEBtSQz/btyhT7NXoxINSBNOUzNt1Yk
         BNDg==
X-Forwarded-Encrypted: i=1; AJvYcCVBN0ZEuAfRIREFA+3pkQryvFn879fURNTcMG1EpgH9BQvO70b+4UDFgOunau6Tjt0qBgdoiC4rTawOXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7Vt0B8bpYILvZtRwlevFe9UjgYEaGbtw+Rs/EGfrJQtO1rtR
	auFT3BfG8JkHzN9CO9c7xozHTOewuxBGI6PZGmxs62BKdHXWrk8ZF4uy
X-Gm-Gg: AY/fxX7rGa3q3vzR82l03FwpF4/gk37bMoHipDINizk9J0GcSQhhd4nwyKkGOwk8fjM
	6gdAXqAKn4CO1RACLvm46LR4wt5Bd1IqaanvVxdjpPqKr1fHavL0KqXPomfzjczk2ZAoEXsfqhG
	keUrBQw8PevAN/bnyqFPN0B/mQqloVkBVLKlyafJX0lXyvYWr55qV1OrFR5Tf4rLcRJAjyUgKtA
	cgGUYzWECFKAls4HMRTFLLUZcfJC/gHbFcAzGW/3mGw2Tk46pnbLhbUdSGOK/M887MROVMyeyhr
	kEqPi4gTgmmKzUkk2gZkaup0cUBpiY3LbMRPrUM2GUUC/dHACvHaYjhWc3ED6eQPLut/QQI5ikj
	pYP6ZSe7hloI5nds3vZnfrsm0YmNdjbvLphO6foC7VX3r/yU9+mnF6jE4AFExRIjy1P2nQpd/hE
	dujpxgCgslETbK/OI/mhyxdGv5UHt90atrnTkpjML0zQyKjfek2zSLWd9UkYewNPMwmq94cNIBt
	1S8fhi32Jg=
X-Google-Smtp-Source: AGHT+IEJJ1hrsUL+EWG+/LYHmGIsftevAAvshlZviJRsmXOHXp8IxBwsGTPWSTtldkfSDqfO6NUI7A==
X-Received: by 2002:a05:693c:4146:10b0:2b0:738e:287e with SMTP id 5a478bee46e88-2b073904fd7mr23927432eec.30.1767524807784;
        Sun, 04 Jan 2026 03:06:47 -0800 (PST)
Received: from ubuntu-linux-2404.. (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e4esm7743509eec.15.2026.01.04.03.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:06:47 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v1 0/4] staging: fbtft: reduce stack usage by avoiding large write_reg() varargs
Date: Sun,  4 Jan 2026 19:06:34 +0800
Message-ID: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes clang `-Wframe-larger-than=1024` warnings in the fbtft
staging drivers.

The warnings are triggered by very large `write_reg()`/`write_register()`
varargs calls, which result in excessive stack usage.

Switch the affected paths to send a u8 command byte followed by the u8
payload using `fbtft_write_buf_dc()`. The register values and ordering are
kept unchanged; only the transfer method is updated.

Patches:
  1/4 staging: fbtft: core: avoid large stack usage in DT init parsing
  2/4 staging: fbtft: ssd1351: send gamma table via fbtft_write_buf_dc()
  3/4 staging: fbtft: ssd1331: send gamma table via fbtft_write_buf_dc()
  4/4 staging: fbtft: hx8353d: send LUT via buffer to reduce stack usage

Thanks,
Sun Jian

--
Sun Jian (4):
  staging: fbtft: core: avoid large stack usage in DT init parsing
  staging: fbtft: ssd1351: send gamma table via fbtft_write_buf_dc()
  staging: fbtft: ssd1331: send gamma table via fbtft_write_buf_dc()
  staging: fbtft: hx8353d: send LUT via buffer to reduce stack usage

 drivers/staging/fbtft/fb_hx8353d.c | 38 ++++++++++++++++++++++--------
 drivers/staging/fbtft/fb_ssd1331.c | 29 ++++++++++++-----------
 drivers/staging/fbtft/fb_ssd1351.c | 35 ++++++++++++---------------
 drivers/staging/fbtft/fbtft-core.c | 32 ++++++++++---------------
 4 files changed, 71 insertions(+), 63 deletions(-)

-- 
2.43.0

