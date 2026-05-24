Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748023B47E6
	for <linux-fbdev@vger.kernel.org>; Sun, 24 May 2026 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779664547; cv=none; b=GNdljwcc2uDXZ8pL85vEBs+MKXb7m3ytWGjy5kBl54c8qG1uIWSyRH0EWGnxAIgOHeQEud/D7Q/CdiUfMBu3um+5FhD1cqUZokNDDWVR4TcwpMniR/0pF4Bb9+GlsdZmw7JfJ4/UkAuW62g7efjpjg2CKpt6XrQTEGJZNVAuXg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779664547; c=relaxed/simple;
	bh=wUQkDEA+c3MoyQTiA25d33zMS/R9fXsunzUwSdEhGJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8BZZOw9IlSPXwjW+lq+BxqzBq+LFGaxiQdObogdu2l2T/WBsETdU4Nd6XX77k87QQ0FQb568KPpnXuIuAPV8BzrfjrBcYHHwwE/rZk5rrUOPk1tpmidYvdJ84ls0yVxTklT6FMOTMRRxjeo5HD4VMZN5gdejWCS6+f0F3xGSvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smS5djl7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smS5djl7"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d75312379so7568632f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 24 May 2026 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779664544; x=1780269344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCXgu7mmBV4o4fqQpXsS9NGPJ7Jt4qFYTEYzg3x74f8=;
        b=smS5djl7afTSfP1RCqifehtijDmhpZ+MZ+And28V9c/2n4j5vrskp5kDQY2AIlBduH
         qS/DvQvL/FfQ4x8I0dI4xNshPl1zGC3PYO5wTmNrmXct5myI1yq18N/tdk6sKU++M8Qj
         SxzPhwwl6ZaWMdZuhyUlo2LlcGl20Xe0or4hB50z5QXE6n/2IpW5fFhhE9eOfn6qPaDW
         tIyhKIpiH8aHuFdHHuFyvrJu+0ArziNB95BlAeqWLJSbbmqgDGp6Iq07ARX3f1+WTWuF
         Bz79uf5QDEIvWqpijwlYznZ3PQIHUaqSrKJMdzJst+l5zoi4Kzv5EQ8/sxWrvMTnZtx2
         JUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779664544; x=1780269344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCXgu7mmBV4o4fqQpXsS9NGPJ7Jt4qFYTEYzg3x74f8=;
        b=bkfKqDx/NlQuok37XDCfwgUgtu1TT2bdSFcaMOh6no0E+vCcHE5eOWZvkxQL/mjhzG
         Ek2JU45KjkyspO3FuY4CCjUW0iudO4vC59Mx51tsabgZl5hF0P+zv83nRZ+Vc3f02j1Q
         6PWjIEZplHIeivxtH473lHcGIGEiJHXyQdq2VUOSo3Z+0n1vF/qFuPBq2WMtIAS47/OP
         +pwn4QjotcQrQ+lMBr/vSIu9SOVpi7TB+ZNj7f/gCPMc+f1i65S1NPTAbs0foIWSmxce
         UGlEn54U1khy9SS1iuK+MYa9BOQh3sX6Z9vzZpmo/e01fPx7j6ZfYi2agMRAYfCDNG23
         pp8Q==
X-Gm-Message-State: AOJu0YxUHJvA+3Vi4WLucREdOeQS7pQuGnx3rgjo5PEuSTKPH3OYM1xg
	2szjyO22nZEiSQHSdKx3fwcA56jt0fjn6S+etECLZZw3wDckvyCfOYER
X-Gm-Gg: Acq92OEv6ffeDLjAuqYfRiS81JBzw1IPxQAE+4BkRg4yCpl8+G/MXRtWpTvsm9eEeRz
	IHJxe5Yxb/ZVoOUF29E5jBDqEAxbQxEPfikKf1ZPY0gLt/WHLJlnLc1y4tsz12Mn8Yc+CEo9zzN
	UvbiEg56FtT1Hjr/N0l5TZFiSn1gkLCDKyeBPH7Gb11VZf7CJZeEA9sz03os4fnpvYokTVBo3ce
	BWwG9BXYc0epFIhohnzfDgV4ohxPbfNIWhSflc9Syob/8LQ7Xsnwywga63ZTqQrR6Ul2iVt8TcF
	mZeyP9OuqODHBFqZP3IL03z/ArH7lXTCRMAOWtaT9vZxzNEYecGsaFfudbPq2MKnQ/mboHkkc3T
	D6sEaV+8BY2yEUyflMu1YGHZpA5EErvMgodVJKW5+JZc9P0C6os8+gv7zO1g26H9hnt8S3OGjyt
	65qHhrcHpSL+StU7ePQTbuulgxMtv13Ym4UdJIKmSYaE+MxAPLY8Lr3S8jGuroStyRP+nd9Q==
X-Received: by 2002:a5d:6f03:0:b0:449:cd74:7432 with SMTP id ffacd0b85a97d-45eb3131f3amr16640087f8f.15.1779664543789;
        Sun, 24 May 2026 16:15:43 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5caeesm23073063f8f.29.2026.05.24.16.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 16:15:42 -0700 (PDT)
From: Michail Tatas <michail.tatas@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michail Tatas <michail.tatas@gmail.com>
Subject: [PATCH v2 1/2] staging: sm750fb: rename setAllEngOff to set_all_eng_off
Date: Mon, 25 May 2026 02:15:37 +0300
Message-ID: <438a9a516955be8cbd7144e95f494663c8c99e23.1779661132.git.michail.tatas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779661132.git.michail.tatas@gmail.com>
References: <cover.1779661132.git.michail.tatas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable setAllEngOff to set_all_eng_off as
per the Linux coding standards

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 drivers/staging/sm750fb/sm750.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 89c811e0806c..00c293430a7d 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -848,7 +848,7 @@ static void sm750fb_setup(struct sm750_dev *sm750_dev, char *src)
 	sm750_dev->init_parm.mem_clk = 0;
 	sm750_dev->init_parm.master_clk = 0;
 	sm750_dev->init_parm.power_mode = 0;
-	sm750_dev->init_parm.setAllEngOff = 0;
+	sm750_dev->init_parm.set_all_eng_off = 0;
 	sm750_dev->init_parm.reset_memory = 1;
 
 	/* defaultly turn g_hwcursor on for both view */
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index d2c522e67f26..589ae51444f8 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -44,7 +44,7 @@ struct init_status {
 	ushort chip_clk;
 	ushort mem_clk;
 	ushort master_clk;
-	ushort setAllEngOff;
+	ushort set_all_eng_off;
 	ushort reset_memory;
 };
 
-- 
2.43.0

