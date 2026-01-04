Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28186221290
	for <linux-fbdev@vger.kernel.org>; Sun,  4 Jan 2026 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524837; cv=none; b=CXebCSKIe1k25XfKkGYzHWaGUA0JZXBgcjfHUKShTbMUDexBP45znm4CQxo1t0EuTpXg6iYnEj6n6nUElLgZLMAhW76JyWgKBbJ8ffdlynPSxV2/PL/XltQEBHxgz+9hsMo3TkIWu68NumHOuoQ/3tUa2i4XsMkPedCYoOwgXqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524837; c=relaxed/simple;
	bh=LNGpIRI2sIUQy1BYTdxD8bMV4uIyoUozjz5hsBz2r2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTVpW3JxtZtW2CZ99GUQkFXwi5ZO4LZeDktozRfgRghUb+SlrU0C9Er1WaKBBzAtvQQaVFtCJQqFFr56sI1dnNiwj+RHzs184PSs/4NettlLgpo+YpovP2tqKh9QZC3K+sQ/sS3OpWSSogqpxrRE/WiGIieBVBFE+eWSGStmU0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRutbf9m; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRutbf9m"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c0c24d0f4ceso7682825a12.1
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Jan 2026 03:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524836; x=1768129636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCTGHTVVHMA6vyGR0yyFOy75tys/0KRwLLM6G8GarUU=;
        b=GRutbf9msvE2tQOxtvv/8VvtTJMQ0GIrIQOtVvYyBQC3aUllxIxkgqZ/SMUZKIPSug
         YEIA69fhnAcdZDYeRxXX/L6DqE1NctpBeL+Baxp3fwftMjbNTSFpl3q3/inmc1AyDvZG
         qNSewdKe/1PfN6AzkS7edoGdNjwuJulnRwbIZDNzK2Q9OIUxmERZwhyxeHF4Xb0O0eqL
         N9XNk8eB9wzD33OcQdwrd3N4eUekecqm0yiFaVPWx2LYbsPCWa1C0hBJe9vMjb1WONHO
         mqNX6X0S3tQJyxDHbMA7VHINaWW5kbRt5X/pH2rX84+OgHAp2/JwsvsaLoVfw3vCtaz6
         6hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524836; x=1768129636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCTGHTVVHMA6vyGR0yyFOy75tys/0KRwLLM6G8GarUU=;
        b=vUjaRRl4qaD99LRp8mXeekEs89lizobA9C8GAytRP8FQIfkSxQHd4OGuPZ/hCmoNDR
         PgGSXmE7ZxAlfIYEfByzuM7OT4p6c8Ntp7c/BgHxq4Z96TDpMfjfAApTpRiEqRJ5/CE0
         UHXqeKHLO5rl8h427LP+tx3Mrp9maetOX+DNBNyLCpWuMe6LjgNOM7DK7tILnJirtsAV
         Dfu0HyHgNF3c2lfZ20nmVUC1xNNOKK/Y5y+BQ3zfjhZi4ajcilAgOB1Qdo4i9DPEPTPZ
         OHbUh/X0asehenIvg7EBHvLmrc2PkOzPEMQ0dAGw8/IX2MqLRGxHZZkpFlSJqStQmoU8
         2l6w==
X-Forwarded-Encrypted: i=1; AJvYcCXBYoFXoVDVpKFWgMcsIQkkQUYLx/qyff1Hr4tnJ4qTpmFl92v4M4SuqTNi1DzTFqIG7eVzbKXfHSKDjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlW6A9jhqDKvpOKAMlX8dCt+qxfGP4TsX1KS8XF5VqUHTxsLB9
	HQMPFJ7q7pihS1ezApdNBV4BFJb3pJJsNO6tRx8cYNojZQceM2HuJrAI
X-Gm-Gg: AY/fxX7znxG0nqE4dPunMAQRH639OvSshlh2ngq7mIZwUbpd2boETJ1KiltsNMvnmbu
	g2sDX+AHMSlcOJdwi3pYUT7Ehw2yMbzq8s+GVCoqeNeK/ACIBvkEBhbngiVBxWIL0coJrjpTXzp
	Zmx3W/0b3ut6SpR9tA7SMVvHGlNx0uikXoupmxjBRtJeHB4ZaH5yqxAegb6X/CTeJ+4jzLo5Rem
	LfqGQT8wfglmLpokAJNUqFZIUZINAFtkcRJc/A0C+c0Ig7LImJiIX0shaE/f5nxKw1k8okMWLci
	f3nJnnqIIuCvnyvoUsuCxlLp7fnMBEv+TKgbwo+5flPEVFhMFazldY8DJNl7bEtU0/zcWGuFC60
	Dw1cVKojF6q8+1zHLu+Ui4BjZZA+TaOePpMlZqEHRKk02YCeFcFJPBsbrOr44gqMF+3TnL9h9D+
	lfiqRff3WNtSSSDiuq1ItUkoly+N/rHJQx2X2z5nYW+1xjtjxr1ExdWlt2vczlofrJPZHV4BG/h
	mOqkwyeU8KfPcLclsGGrg==
X-Google-Smtp-Source: AGHT+IEBlQin3DED6U3ZrS/y7L3/YC7dD4Soy4OYJVCu+hhgs+CK06RDqttmL3s2kWznHZII3HLCUw==
X-Received: by 2002:a05:7300:4fa7:b0:2b0:507d:c2e4 with SMTP id 5a478bee46e88-2b05ec85832mr28474488eec.39.1767524835534;
        Sun, 04 Jan 2026 03:07:15 -0800 (PST)
Received: from ubuntu-linux-2404.. (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e4esm7743509eec.15.2026.01.04.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:07:15 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v1 4/4] staging: fbtft: hx8353d: send LUT via buffer to reduce stack usage
Date: Sun,  4 Jan 2026 19:06:38 +0800
Message-ID: <20260104110638.532615-5-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
References: <20260104110638.532615-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang reports a large stack frame in init_display()
 (-Wframe-larger-than=1024) due to the very large
 write_reg(MIPI_DCS_WRITE_LUT, ...) call.

Send MIPI_DCS_WRITE_LUT followed by the LUT payload using
fbtft_write_buf_dc() to avoid the varargs/NUMARGS stack blow-up.

No functional change intended.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 drivers/staging/fbtft/fb_hx8353d.c | 38 ++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/fbtft/fb_hx8353d.c b/drivers/staging/fbtft/fb_hx8353d.c
index 3e73b69b6a27..7e667d60792f 100644
--- a/drivers/staging/fbtft/fb_hx8353d.c
+++ b/drivers/staging/fbtft/fb_hx8353d.c
@@ -17,6 +17,21 @@
 #define DRVNAME "fb_hx8353d"
 #define DEFAULT_GAMMA "50 77 40 08 BF 00 03 0F 00 01 73 00 72 03 B0 0F 08 00 0F"
 
+static const u8 lut[] = {
+			  0,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
+			 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62,
+			  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+			 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+			 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
+			 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
+			  0,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
+			 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62,
+			  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
+			 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
+			 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
+			 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
+		};
+
 static int init_display(struct fbtft_par *par)
 {
 	par->fbtftops.reset(par);
@@ -48,18 +63,21 @@ static int init_display(struct fbtft_par *par)
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	/* RGBSET */
-	write_reg(par, MIPI_DCS_WRITE_LUT,
-		  0,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
-		32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62,
-		 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,
-		16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31,
-		32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47,
-		48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63,
-		 0,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
-		32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62);
+	{
+		u8 cmd = MIPI_DCS_WRITE_LUT;
+		int ret;
+
+		ret = fbtft_write_buf_dc(par, &cmd, 1, 0);
+		if (ret < 0)
+			return ret;
+
+		ret = fbtft_write_buf_dc(par, (void *)lut, sizeof(lut), 1);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
-};
+}
 
 static void set_addr_win(struct fbtft_par *par, int xs, int ys, int xe, int ye)
 {
-- 
2.43.0

