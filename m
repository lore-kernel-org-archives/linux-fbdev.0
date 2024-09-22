Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643913B58A;
	Sun, 22 Sep 2024 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727007141; cv=none; b=VKXNrorDGov566yBD6azspVYoVdwyCCb7wrXBdB0BZziW9NYsKim4y8HO9Sp450C5p2HLTL5Rd9C6D4+fVi1N0CBQccIDyp51Vr/w9xazeu06VqE96cQuUGsxVxZTzmvUTazzpknyUh/OIQf2VOA0YUn+oB6ibnjUhDu5iMXA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727007141; c=relaxed/simple;
	bh=H2T+n0imBLVe0xkWRGKTHNdpmIUZcw9mPrNVLfTeqZs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FI4aVMT3cmsXJOPoUmJZJBT5NOVkI5TjKlmqUQwtsFtygNxdw1oCfHwgNJM41KJGDkuoXyD4FDy+IfIvXDDiCoeGlbFsFZV/ATORW2ryLbhz8VduInIlZzxv4KROtfPG5mW2URE1vyNqDbdiRO4IFrMJqZ5ycyL/yA7PL9TBPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB7aYv8/; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB7aYv8/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a9ae8fc076so385952185a.2;
        Sun, 22 Sep 2024 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727007139; x=1727611939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VS1hIkkrLN57v3P9cwhdNl/6iwD4+WEDwLLcb3wVylw=;
        b=fB7aYv8/Xf5a9K97iqI6Be/6WANil85pmg9MuN72peZkv/iUWvdmNR0xNsDVjZOlQS
         jt9PQLjND0xyFSnLJ9SDst4jp+5qkdLhh1lFaPZEvR8qftnb3VPDJUpvsittDv7d/BcU
         0IRJsND3RBb32So0UteFAh0rp69P0oH79jhkiEwT+E2l2bhuFl9V+yAVzuwSqSlNwdA5
         ahFWHi/s0PUPReZi8znbaA/y6/bard5bEC6V2M0AL3eHzQZFtiNKDlWiR+vIfxqj3wyY
         IqucPeKFZWnzLCBBX8iWfl2tgcSZdAj3VlCK+uT6H3HxIvCoHqK+g/q67zumKJMsasBh
         PAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727007139; x=1727611939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VS1hIkkrLN57v3P9cwhdNl/6iwD4+WEDwLLcb3wVylw=;
        b=o5WIn4AmW8b5HTTkasfFlYn3wNQpMIONQlmmLyxrAzfl4Xlq4e1aXVoZw5wevQXRKc
         6Fr1C8vJYdAg1LYHN1iM8u0jwRyshAn2L6QtbEHC+n9KnSlDVEF88NJdooP7mqZbOldr
         PYqe7DU0BF5ov6C3tjrkNqG8y9MxLUoI/fIMNYDjp9Ay3yuB+S9FmdjaSW688//8XPEz
         8dIeKG74SywQ8H/xTT6R7+crP/QQCQkkIDPT45ZC/wNBjwOWd7r2vBQmtklqCyHC4yW9
         G9SURJqN/4Mtbnu/cFUrPqTtuuIqykoMpP71NHoJOke0YnPNYtbHd7Pe8p3+phFHely0
         3TyA==
X-Forwarded-Encrypted: i=1; AJvYcCVRXb8NRVPgD0TGsT9RPx/eCh3SrnIHNs4tavswr9l7qhVMN2Tn6jA2TZDme8GsFeqEEywIYkZp3NeCbg==@vger.kernel.org, AJvYcCWl3bruZhysuGuP9si9nHosK7Yh6vC5PNo3323ov+c0glDB7MvHqbmUgx0+FhSdxggp/bw5zmE8KegF9b5E@vger.kernel.org
X-Gm-Message-State: AOJu0YwmtaT4PjZSPt+l1CKB3SEC9YhqvGeuOtnSP0Va30rIYroVp0IX
	6i+idcRED/ieA3pop2fjbu9jKhE1Jq4vZLLDp//XA0QPQkmFPqnUVbugLNmL
X-Google-Smtp-Source: AGHT+IHh67MorNuxN6aG8qz3DGbqWTu7y0US26POxQ3cxkCURnlAu9OcRt9UFB3mno1C1NTNDRjQBw==
X-Received: by 2002:a05:620a:178b:b0:7ac:a0e6:70c with SMTP id af79cd13be357-7acb8e0fbedmr1357396685a.60.1727007139164;
        Sun, 22 Sep 2024 05:12:19 -0700 (PDT)
Received: from fabio-Inspiron-3583.. (201-43-119-188.dsl.telesp.net.br. [201.43.119.188])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08d9098sm376545085a.111.2024.09.22.05.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 05:12:18 -0700 (PDT)
From: Fabio <joakobar2000@gmail.com>
To: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH] staging: fbtft: Changed calls to udelays() functions for usleep_range()
Date: Sun, 22 Sep 2024 09:12:13 -0300
Message-Id: <20240922121213.4260-1-joakobar2000@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced two lines of calling  udelays by usleep_range() functions, adding
more efficiency due to the need of long-lasting delays of more than 10us.

Signed-off-by: Fabio Bareiro <joakobar2000@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..edd467c6bf1a 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 150);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 150);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.34.1

