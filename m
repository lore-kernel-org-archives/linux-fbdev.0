Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336E333B6D9
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 23:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772580357; cv=none; b=ZrctnOvhNXjPosW9DXF5lZrqOyHEBXK8Hr831ZDBO4pPz8vTNp66ypbwLYkQacxJkooCg/Cem1nn4dUziKGdKVCPoY+rl8jhs9z0T/Ql1VNpbDaHgwMLYnxJbUL1yLzjICApS5jU9K9Qx3tN7QG4mYmLr8beTZmZo2Jez2Y4FPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772580357; c=relaxed/simple;
	bh=juTqYkup/by3DgOkN6qLT4McKLHDc5uf8jqpeji0c8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ/msgRzlSTCZbOvcGNp7Cxp2DXTovE1eiDLWxKMJfcX60es0nd4yNgZGotBS6/sDTlzRrjCXbbhAXS6dLDigSBiI7oVw1po5dzfpyGR5Foz+zgGJ7udHEHQfVfOR6ArbQNhgBx0h2VRjAQB9WA69DSOG37kn4NicG+AACG1ayA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DP5gFLiK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DP5gFLiK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso42424545e9.0
        for <linux-fbdev@vger.kernel.org>; Tue, 03 Mar 2026 15:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772580355; x=1773185155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0VDTq5+YnLJ0nZqtFumq/na1fPGtAhpN+2pmOfdQ2I=;
        b=DP5gFLiK9moR80geGraIO36WmmvxBYZXOem4UsiIVId2aOwNdicYo3zMovY55NTPLn
         RFrli+0LDMTHSs2AzM49JU6d1Cm6e9oLDek18Q7LO7Gxz0cbAbZct95IyGjUGjBvDFga
         y5vubYKX1d+AUnhQVX415bl9KVm0gW0I2ZW130U9Hzvbp25kIEidIsKa5sjiI3wmmW6v
         ck/aulYGDEwOCdk0qAPGBRCZC9opI1gVwH/+My3SslZrKqiWBA2A2PBhz+IgPDnQSaHE
         iIdCNLIlK1c0i+GHSd5tlKryrUuaoY8qmtCwbvNcyMBoB+Xksuooe1vwUKwkhnOlpszC
         b0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772580355; x=1773185155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f0VDTq5+YnLJ0nZqtFumq/na1fPGtAhpN+2pmOfdQ2I=;
        b=Kcw5+gJZz/ovE5e/DPqmqnzmHGMWr4NJlJ+sn89eh/5BfcB6oMIAXfBS6pyb1+yw8J
         X6Llgpw5aSIYtPkuNjHbSjCGt9IsdTWApYLQpa7C9EIxMGI3r9FIR4GHqRPjIyxri2sI
         B3Jo/jKySIOEfZ+N/08lfnxXkfKmZEXhLWSyXbPL6ONWXn1xyI04cZ/F+Rk0yL7G0vGu
         OMI4Xd+rGbCj4gathuON7TP9oTn5C0GipHHUMnRqlye9svlxn0QWaaD45rqRTPO9uljH
         Y4KFGsxr7qFAtl7YXOwJofC4PjoBNJnt4QuBjJCABM/vMGFqrlVDIQ1UhxiXTrZ+oEZk
         eBwg==
X-Forwarded-Encrypted: i=1; AJvYcCU3gaiShnjCI38yw2QofGBgdLZjoYiinxGE/1unNG6wjshzyeXv5iXPsfR/C11wuOscvSwnvuAbmUjH6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2197bPj+rFMi7iVVgFgyle7q7M1C5QzJxD/ZFyBHzK9YruO8z
	cv/gn5BOvaRcDj8ZgAfwTZMdfVagEL7lgBOdhGNpRgI8HUTX5kOwtGJ4
X-Gm-Gg: ATEYQzzXO3j+dcmLNQuXvIzt5Xqj46xCo7vuyvollZOLck5scACtRJ/JNkod+LGUuTh
	B3G2IQNXc/nUDQDbQ2Q4GVT3HaidbSu330RHdazdnFHKX8CkWLEU5i71wkd9cLOOHpHiYa3bf2T
	fRWvT/87Nrf3Eaq7UFFdayA0eT224IgVSlAQ810g1+xz4C87TFnzlO+KuHxJ8n2SWCQkRX7McJb
	GG1xX4OyMyD6E5EPnqQKthgkHyZWIqYQYd6ut+0hpdRmC/0XF/6VtRKAoepsX0Os1znubbDR3m0
	54wn1aOlnebxQEc0fxQ2hagR4jAnUz3tELLqymwzRTkRGPeyrqa5DBVKN/WdKalukeu1Z7BLSlN
	v78N9+Fvh2ZXdJEu+IhhVrzf1AGXoerzLKKKwdMgEnO8okzwvULjTr1Yd27LfCOGJwNcRNYgZoJ
	dDw9aHkG4HXB1Y39bSe/xpE7ltfI1o9CJB2K1yXhHxIBCYRCjoOw==
X-Received: by 2002:a05:600c:3542:b0:47e:e2b8:66e6 with SMTP id 5b1f17b1804b1-485198ee3admr278035e9.14.1772580354568;
        Tue, 03 Mar 2026 15:25:54 -0800 (PST)
Received: from arch ([2a02:1210:2e28:2800:36a5:7f85:ccb8:1176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851335648esm68036615e9.5.2026.03.03.15.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 15:25:54 -0800 (PST)
From: Gabriel Windlin <gawindlin@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Gabriel Windlin <gawindlin@gmail.com>
Subject: [PATCH 2/8] staging: sm750fb: remove unused CSC register definitions
Date: Wed,  4 Mar 2026 00:24:23 +0100
Message-ID: <20260303232434.1850583-2-gawindlin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303232434.1850583-1-gawindlin@gmail.com>
References: <20260303232434.1850583-1-gawindlin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Color Space Conversion (CSC) register macros defined in ddk750_reg.h
are not referenced anywhere in the driver. Remove them to reduce dead
code as noted in the TODO file.

Signed-off-by: Gabriel Windlin <gawindlin@gmail.com>
---
 drivers/staging/sm750fb/ddk750_reg.h | 79 ----------------------------
 1 file changed, 79 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_reg.h b/drivers/staging/sm750fb/ddk750_reg.h
index 59ecbc0d48f7..13b04870ad9b 100644
--- a/drivers/staging/sm750fb/ddk750_reg.h
+++ b/drivers/staging/sm750fb/ddk750_reg.h
@@ -1126,85 +1126,6 @@
 /* Panel Palette register starts at 0x080C00 ~ 0x080FFC */
 #define CRT_PALETTE_RAM                               0x080C00
 
-/* Color Space Conversion registers. */
-
-#define CSC_Y_SOURCE_BASE                               0x1000C8
-#define CSC_Y_SOURCE_BASE_EXT                           BIT(27)
-#define CSC_Y_SOURCE_BASE_CS                            BIT(26)
-#define CSC_Y_SOURCE_BASE_ADDRESS_MASK                  0x3ffffff
-
-#define CSC_CONSTANTS                                   0x1000CC
-#define CSC_CONSTANTS_Y_MASK                            (0xff << 24)
-#define CSC_CONSTANTS_R_MASK                            (0xff << 16)
-#define CSC_CONSTANTS_G_MASK                            (0xff << 8)
-#define CSC_CONSTANTS_B_MASK                            0xff
-
-#define CSC_Y_SOURCE_X                                  0x1000D0
-#define CSC_Y_SOURCE_X_INTEGER_MASK                     (0x7ff << 16)
-#define CSC_Y_SOURCE_X_FRACTION_MASK                    (0x1fff << 3)
-
-#define CSC_Y_SOURCE_Y                                  0x1000D4
-#define CSC_Y_SOURCE_Y_INTEGER_MASK                     (0xfff << 16)
-#define CSC_Y_SOURCE_Y_FRACTION_MASK                    (0x1fff << 3)
-
-#define CSC_U_SOURCE_BASE                               0x1000D8
-#define CSC_U_SOURCE_BASE_EXT                           BIT(27)
-#define CSC_U_SOURCE_BASE_CS                            BIT(26)
-#define CSC_U_SOURCE_BASE_ADDRESS_MASK                  0x3ffffff
-
-#define CSC_V_SOURCE_BASE                               0x1000DC
-#define CSC_V_SOURCE_BASE_EXT                           BIT(27)
-#define CSC_V_SOURCE_BASE_CS                            BIT(26)
-#define CSC_V_SOURCE_BASE_ADDRESS_MASK                  0x3ffffff
-
-#define CSC_SOURCE_DIMENSION                            0x1000E0
-#define CSC_SOURCE_DIMENSION_X_MASK                     (0xffff << 16)
-#define CSC_SOURCE_DIMENSION_Y_MASK                     0xffff
-
-#define CSC_SOURCE_PITCH                                0x1000E4
-#define CSC_SOURCE_PITCH_Y_MASK                         (0xffff << 16)
-#define CSC_SOURCE_PITCH_UV_MASK                        0xffff
-
-#define CSC_DESTINATION                                 0x1000E8
-#define CSC_DESTINATION_WRAP                            BIT(31)
-#define CSC_DESTINATION_X_MASK                          (0xfff << 16)
-#define CSC_DESTINATION_Y_MASK                          0xfff
-
-#define CSC_DESTINATION_DIMENSION                       0x1000EC
-#define CSC_DESTINATION_DIMENSION_X_MASK                (0xffff << 16)
-#define CSC_DESTINATION_DIMENSION_Y_MASK                0xffff
-
-#define CSC_DESTINATION_PITCH                           0x1000F0
-#define CSC_DESTINATION_PITCH_X_MASK                    (0xffff << 16)
-#define CSC_DESTINATION_PITCH_Y_MASK                    0xffff
-
-#define CSC_SCALE_FACTOR                                0x1000F4
-#define CSC_SCALE_FACTOR_HORIZONTAL_MASK                (0xffff << 16)
-#define CSC_SCALE_FACTOR_VERTICAL_MASK                  0xffff
-
-#define CSC_DESTINATION_BASE                            0x1000F8
-#define CSC_DESTINATION_BASE_EXT                        BIT(27)
-#define CSC_DESTINATION_BASE_CS                         BIT(26)
-#define CSC_DESTINATION_BASE_ADDRESS_MASK               0x3ffffff
-
-#define CSC_CONTROL                                     0x1000FC
-#define CSC_CONTROL_STATUS                              BIT(31)
-#define CSC_CONTROL_SOURCE_FORMAT_MASK                  (0x7 << 28)
-#define CSC_CONTROL_SOURCE_FORMAT_YUV422                (0x0 << 28)
-#define CSC_CONTROL_SOURCE_FORMAT_YUV420I               (0x1 << 28)
-#define CSC_CONTROL_SOURCE_FORMAT_YUV420                (0x2 << 28)
-#define CSC_CONTROL_SOURCE_FORMAT_YVU9                  (0x3 << 28)
-#define CSC_CONTROL_SOURCE_FORMAT_IYU1                  (0x4 << 28)
-#define CSC_CONTROL_SOURCE_FORMAT_IYU2                  (0x5 << 28)
-#define CSC_CONTROL_SOURCE_FORMAT_RGB565                (0x6 << 28)
-#define CSC_CONTROL_SOURCE_FORMAT_RGB8888               (0x7 << 28)
-#define CSC_CONTROL_DESTINATION_FORMAT_MASK             (0x3 << 26)
-#define CSC_CONTROL_DESTINATION_FORMAT_RGB565           (0x0 << 26)
-#define CSC_CONTROL_DESTINATION_FORMAT_RGB8888          (0x1 << 26)
-#define CSC_CONTROL_HORIZONTAL_FILTER                   BIT(25)
-#define CSC_CONTROL_VERTICAL_FILTER                     BIT(24)
-#define CSC_CONTROL_BYTE_ORDER                          BIT(23)
-
 #define DE_DATA_PORT                                    0x110000
 
 #define I2C_BYTE_COUNT                                  0x010040
-- 
2.53.0

