Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E46156962
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Apr 2024 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686170; cv=none; b=j4IsA/UWNy1ZaczQ6IFRqmef7NUHkM11kU2s0/tEWp0Mn9X5U0V23FCvc1mUnGoVsPfHw/f0iOI1Cdma5Wp9S7CEwLtBo7a2nbxxU5f+BfMDWrF+RKarm41B3uU2S3VkiXG+EgNzWWTw+CcshlN2Z7gjkXpYd0L5kosYrNloHPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686170; c=relaxed/simple;
	bh=iVHlsCCMfWKpWuWRbfli6O0Bxz4j4Vs+tlKNL1UZ+G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZstQWN7izYs5l5uiiTyPbiG58J7OltFf+zy/VTsvwkBTFR3ElgtyUVVV2glBBF4MmIbIoOF4+eENdiCLf1MF1kZdaMTLil25+/CEkdEEFl1LmLN121n8q4vXLt0YvRQETzZepxkc+lvfjCdcUC8J1NzB0TA1UaHZETiebfuna0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuF054L+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuF054L+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso2946378b3a.2
        for <linux-fbdev@vger.kernel.org>; Tue, 09 Apr 2024 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712686168; x=1713290968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NVXVzzWFiRIl6q29OSH9GKi8POQIM0rOmoVWIGbW5Rw=;
        b=KuF054L+o83eZK4VXdefYjZ6JJQmJ4Y+4ylWAuomSifq0zWRJ7F1Or/cK7b5CKnsTW
         3MUjrbgnXFVL2N9nDxfpUZYccUvXxtaczYbcXGbAcjhVs6aq/4s/BlHrDGNMhLt1D/7q
         rRqCZBUn4SN04BMNmvQl67cbKwnA6XxNWO6sENYQO5yTuEHDXgNoFeEJnHXlu7ZJfoej
         uoRo/evC9FlJu2w9ABB0EqDlEp8k6pZFbmBGfhgWMjjZyNi9dMsOpyhOoh15+vVr7Rju
         Amuasr/n5gFLiz21ZxORVzpAsO8yIdW0ux3bgOuG/OaB8miJfkm5+m8XJjby8nh/OeXq
         Y14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712686168; x=1713290968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NVXVzzWFiRIl6q29OSH9GKi8POQIM0rOmoVWIGbW5Rw=;
        b=lSl6YZR0OJ5HD040YCMbUtjkWzp7Xeq/2ZokiSREF+c4QJVWaKtmf2JVW+cKVEhQ9H
         yoTFpQCHBM8voD0cVLt0O/krcDYESKUkGnnNFNa1XlBaN91ghfqVnqpQrVUBMXVK283Q
         t5zlD1puWZNexNlohwlkq0blpU9oBMjes3EcIU+ZmmFVK+pgTxXXHEcd/sLzwHacGnAz
         aFv7TBRyYWDtuF1H6MqZyvmp2EMt4iFKNcqeemNQQG6iNZ5xVWn18/txu1KgJ3wGl/TV
         40NNVFvcBDAGAH6STGrgkYLx0N1gsvYm03K0LeOn3BAHEqgX7Y63dAvLyGbhjRs9JwLE
         asvA==
X-Forwarded-Encrypted: i=1; AJvYcCWJuSjKBskAl11ytvmCNe4wlnEhpc1uVLR4V71B6S/a+eu4/caRwDv/9/C0+s7KVZQP5wvBxIvmeafFx7wdpFxL31gZV/dj4mB93k0=
X-Gm-Message-State: AOJu0Yxw9vaPf2ckPbqquZjtgZsSU8YvMc1MqpSVPchKcL6fmBlE3QWC
	kZtdNmqKHBt2XcQwWRYlAJtnxu8z/7n2Um2PadiObs08AxCbV2u/
X-Google-Smtp-Source: AGHT+IFfFzJvldQjnVnnEpBO8iZdBO93LTpcMA44O3DKE0n7hsIP4ENWytzlu6xvr4g+hUv52FZokQ==
X-Received: by 2002:a05:6a21:6816:b0:1a7:6416:1465 with SMTP id wr22-20020a056a21681600b001a764161465mr734294pzb.32.1712686168384;
        Tue, 09 Apr 2024 11:09:28 -0700 (PDT)
Received: from localhost.localdomain ([172.93.220.120])
        by smtp.gmail.com with ESMTPSA id gr6-20020a056a004d0600b006ead007a49dsm8644901pfb.49.2024.04.09.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 11:09:28 -0700 (PDT)
From: Yuguo Pei <purofle@gmail.com>
To: gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	purofle@gmail.com
Subject: [PATCH v2] staging: fbtft: fb_st7789v: support setting offset
Date: Wed, 10 Apr 2024 02:09:01 +0800
Message-ID: <20240409180900.31347-2-purofle@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some screen sizes using st7789v chips are different from 240x320,
and offsets need to be set to display all images properly.

For those who use screens with offset, they only need to modify the values
of size and offset, and do not need to a new set_addr_win function.

Signed-off-by: Yuguo Pei <purofle@gmail.com>
---
v2: modify Signed-off-by, fix explanation of changes

 drivers/staging/fbtft/fb_st7789v.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
index 861a154144e6..d47ab4262374 100644
--- a/drivers/staging/fbtft/fb_st7789v.c
+++ b/drivers/staging/fbtft/fb_st7789v.c
@@ -30,6 +30,12 @@
 
 #define HSD20_IPS 1
 
+#define WIDTH 240
+#define HEIGHT 320
+
+#define LEFT_OFFSET 0
+#define TOP_OFFSET 0
+
 /**
  * enum st7789v_command - ST7789V display controller commands
  *
@@ -349,6 +355,21 @@ static int set_gamma(struct fbtft_par *par, u32 *curves)
 	return 0;
 }
 
+static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
+{
+	unsigned int x = xs + TOP_OFFSET, y = xe + TOP_OFFSET;
+
+	write_reg(par, MIPI_DCS_SET_COLUMN_ADDRESS, (x >> 8) & 0xFF, xs & 0xFF,
+		  (y >> 8) & 0xFF, xe & 0xFF);
+
+	x = ys + LEFT_OFFSET, y = ye + LEFT_OFFSET;
+
+	write_reg(par, MIPI_DCS_SET_PAGE_ADDRESS, (x >> 8) & 0xFF, ys & 0xFF,
+		  (y >> 8) & 0xFF, ye & 0xFF);
+
+	write_reg(par, MIPI_DCS_WRITE_MEMORY_START);
+}
+
 /**
  * blank() - blank the display
  *
@@ -379,6 +400,7 @@ static struct fbtft_display display = {
 		.set_var = set_var,
 		.set_gamma = set_gamma,
 		.blank = blank,
+		.set_addr_win = set_addr_win,
 	},
 };
 
-- 
2.44.0

