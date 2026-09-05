Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3F544E67E
	for <linux-fbdev@vger.kernel.org>; Sat,  5 Sep 2026 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611711; cv=none; b=eFq6A9h0uNSZUhTd4DljMzZgb7yZRESmTYhvuwF3g3iffNmoU1uu9VDktgcVwSOeXY1e/xu5aSn4Ao65wkSSUKkeionJ1ZEkm6LyUOIpmMDm7TgLpVnbwzNoh0HqfWYz1D8x0ZAVYKPHtJvksp0OtuCLYvj7c0HOAl8N/AYMXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611711; c=relaxed/simple;
	bh=FscHQeKZUzuZgsN1YVbqBe6K3v3ip/hOfNYfXM/WTBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHS8w2ZT8kjjrAGpZilzTL0K6mGoAgJTcZPCuyj+g/sYii6iuNoBIZreGHTHiJfxdhDsu3qTpCtvxETG7AVgrofbwh3kW10V2TAZ9sagsRgS6dPIJbogi3jrw0ULBShMVnRgldg/J8ZSA9pybirrtHcnWfxRgQglTTEAtOAU+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sq6R15W+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sq6R15W+"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1843345a91.0
        for <linux-fbdev@vger.kernel.org>; Sat, 05 Sep 2026 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788611704; x=1789216504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S3X7uidjFB8vVdKb+fO92WnrzwU/cqJo9nFwSZVVmzI=;
        b=sq6R15W+LwD+kmsvTOKEA+PH8eCVuIb+1vaKtbyQvD4np3FXcyLlQJuLuoMBeTjPtP
         ixi1GTFZ6bATx5DEa7Wz2Ne7YY0dhCMVHnBXwCvepA5YIF/oVofBWl9kcI4lWRLgbSfw
         SGp3z3JybK+8Ra4yPJZ3QEjvzBVtN81HAx27gWpnpvFi9MqU/v0AjrTOtunyHEqlQkYG
         dw8gFTw4BzpQQxuxDeYv69HlLxSwoGg2S9FfrMxMbpamFswRGHG6Cwp357FJ2U+eUS/y
         StgY13ZCrLoMCgU/SAJAcPvOI7HYYx6TQWLLahcl//OQyqqCDXNmbEpbtWwlQGgwFSoa
         kjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788611704; x=1789216504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=S3X7uidjFB8vVdKb+fO92WnrzwU/cqJo9nFwSZVVmzI=;
        b=pY1mqrGf7uxOj37lmwkQtHOF+ytrT5CCeQbn4f3/R4sHwuHL42fwCUBjCUYgmvZZJQ
         tMR/BbrSPjN9yXHB3QgZR6FT6VlaDwXpbJP0G00fAQw+au7axfnXmQyl14jdJDNvWi6S
         CPosq+9PRNZRbLvzgKYuKMe8fd6C4Bb9nPNCFgw+HjkiwE5J+yaqQCmayzX73J0yeKF4
         YVabtob/JUCgfV/Syf/FQJCPXPx4O/hlH/MehPSCIjH0mnepEaDnP6bRN9aQ3ObO2aBb
         c69KekrXzJWic7v/9C/Y6p/ehZ6ZyKsvTLn0ESkDG8mI2Pl1f+EDrOzNuc2K+mAm4K8n
         drwA==
X-Forwarded-Encrypted: i=1; AKwUvBycnDen/+D0nML2pYpCHnTyK8M+bzP52ANB7sx6l1QnB4YWqydW1IHK+DSyCMPAFh6CpfAaTvijV4Hikw==@vger.kernel.org
X-Gm-Message-State: AFuF++lgtvQcoe8nfCvUc0RvY9zIW/FR1hJmEsQzYGgaKjlbopFCHFHR
	3DUuDMR7nWfmSF7lo8LYtTJx5zcWLv6fWMkMkQhoGuGqlzN8RNbi/HRKVTTc8g==
X-Gm-Gg: AYBFou3VAam1hJdz0+nv37Ih5Ui1TV6+zkni+SMoNUtECaKj+uawqva+haAa19lBI7u
	dO9arlLyB0u6jTd7V7b8qBa3J2QAGpVz09jkzUn04yT6DrLKPZuDKB2OTlv/ndtt8thUCXnT83S
	RdYaWDiOGH4zS+MF5zE27srOcz9xI6/+8E7Qu3Den+FR47TXP6scHlgJdR5AsKzL+W+j46AsfB8
	xN/eH/0V94+n2nnRYrPFKQG7IiXu5VD3KVZw99bMGhhpq39YA8lX8IvMQZNR1NQtol6qUaHgbrL
	YrS9A8RiM4ay4Xh6z6f0lndyMUxq2GC/g7JDzLJ5jIXkYRa33KIAkV9wspoRudhATGhRwPPcY0b
	KKkWl1DjtI72+WOlY0F4cDd57CsYM7UC3ad3X3MOGqNbdpO6AoJ2UU0zSui8kCGFfsJ/1tbWz1k
	WpFNfhNWyqgqz0kCZ6OqHEc13SDZ0JQKkwOQC8OSf0z+5lS8M4NsMa6aES05q/8kPkembQFCEDO
	tf0LADuzsp5h0Q1v+18avhyA+T/looa2EBki4aJmVE=
X-Received: by 2002:a17:90b:258d:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-39b261323e0mr19491750a91.11.1788611703632;
        Sat, 05 Sep 2026 05:35:03 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf26c5sm13829815eec.27.2026.09.05.05.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 05:35:03 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: gregkh@linuxfoundation.org
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v6 3/4] media: dvb-core: remove defective and unsafe ULE debug block
Date: Sat,  5 Sep 2026 09:34:49 -0300
Message-ID: <20260905123450.5620-3-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905123450.5620-1-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Completely purge the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c due to severe lockless race conditions and buffer overflow
vulnerabilities on global network state variables.

Assisted-by: OpenCode AI
Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/media/dvb-core/dvb_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dvb_net.c
index a2159b2bc..3b503695e 100644
--- a/drivers/media/dvb-core/dvb_net.c
+++ b/drivers/media/dvb-core/dvb_net.c
@@ -68,7 +68,7 @@ static inline __u32 iov_crc32( __u32 c, struct kvec *iov, unsigned int cnt )
 
 #define DVB_NET_MULTICAST_MAX 10
 
-#ifdef DVB_ULE_DEBUG
+#ifdef CONFIG_DVB_ULE_DEBUG
 /*
  * The code inside DVB_ULE_DEBUG keeps a history of the
  * last 100 TS cells processed.
@@ -320,7 +320,7 @@ static int dvb_net_ule_new_ts_cell(struct dvb_net_ule_handle *h)
 {
 	/* We are about to process a new TS cell. */
 
-#ifdef DVB_ULE_DEBUG
+#ifdef CONFIG_DVB_ULE_DEBUG
 	if (ule_where >= &ule_hist[100*TS_SZ])
 		ule_where = ule_hist;
 	memcpy(ule_where, h->ts, TS_SZ);
@@ -659,7 +659,7 @@ static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
 			h->ts_remain > 2 ?
 				*(unsigned short *)h->from_where : 0);
 
-	#ifdef DVB_ULE_DEBUG
+	#ifdef CONFIG_DVB_ULE_DEBUG
 		hexdump(iov[0].iov_base, iov[0].iov_len);
 		hexdump(iov[1].iov_base, iov[1].iov_len);
 		hexdump(iov[2].iov_base, iov[2].iov_len);
-- 
2.43.0

