Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4B221290
	for <linux-fbdev@vger.kernel.org>; Sun,  4 Jan 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767524815; cv=none; b=jV2HuMKYuYNi4dXYkz7dU12FpZP2nYp9ybzfY5zefxaiR09+dJiYjaKv4sd+jWW9Ya1iMTQ9wAw9PkNRdKxAogmIf1Oj81B25tS2k7h5vMy9tzea/QVMQwNYYFrKqYkUSMusuntjIacrTL7CHyy8APUuJCsDrSi1WUecFZsW2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767524815; c=relaxed/simple;
	bh=inJKKkiyV7KHWX9cyP0g6zKY4VeQfXCBaSGilxBwXCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnjCapL4z2JoRBqVRgo/uXcryUEvWAbPpVBeIQHQ5wmeXCYbDII5XRBbkP9yFBlIAYYtqFmTK0N6o/2mdH28Ahu27lmb4JwwrqA0ItYF94PmaJOCc4JhmK4388yLD/4TGvBwOCAwDvGpV/6o1E7kZ9CxMDGBozK9H971pSWkrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7z+wI7H; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7z+wI7H"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo14696359b3a.2
        for <linux-fbdev@vger.kernel.org>; Sun, 04 Jan 2026 03:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767524813; x=1768129613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmz/Xu0Pokn7o5jLUorKqspAjEWkFQmifBWWvvSJmmg=;
        b=e7z+wI7HUvCUi/7MLx4GWKO8wFki/D+IIkH3mH4AjSJB0z7y3VvbQq08NLnGNo1Brs
         l+tDx1hQG4vM79JDoV6kHvyZLuFQLjm5pip+1mqyAcGV1zs58Y1/p3fyi/jUUd+A3VK3
         lumckBbsm4cQaz7enctSo7RmgSAHnO5MI17zs0MaZJROHYVGikXJM+YUGAp0LXhJcwoe
         FmztytcWcZQ7PQs7czOi9b7lUXJc90bkjVvXeWjHPpCYOyFOGTRJFfPGOVWFBx2Sxv7X
         IODiClcyGu5hKkHwZcATpGRkWoRO4Ofi9v7MHeMXo5ZakUbXnOaaMCdm2Gp20RJP/LCC
         kTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767524813; x=1768129613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmz/Xu0Pokn7o5jLUorKqspAjEWkFQmifBWWvvSJmmg=;
        b=Ls0SByfQraA+rxkOx89I86XSkoBCDmlwXJAzd6DSiHjqjhPhTCjAa3G+z41aDH/MVs
         DHTubXZ39UtxgUK7tff8Ja4xQ7cR1iTeLh7aezgsBnMhMafwwmTmqDAQ1ocWBEAdYtdS
         QHuAWeEk6onn8FEsO3BMCirJ6xA9GRKAh30p9V6l0TOvbvu3Gqqsgk5fm9AfMjB6mh/p
         BCKwKzub5VEKRCWeoECaWlg1DTS3EnEorXESbeVFFmnxd8gU3l2IkgCWa8tWbDeKOJuG
         UFlh5pYRXEawyqkTJQNp5ZOZDTyqfj/pvOfxnqoDBHtwz31NPhNq6nlUn91IBBW5LOFd
         7jIA==
X-Forwarded-Encrypted: i=1; AJvYcCViauiNLKllPLJ59y0msr/rzkHM1NvgQl1BGzTXRMBhgVN4iJ9laMBgENMXpZf6jyfkF7QAjCpUIKzQMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZtrb8C2cN64PLO1COx7DxNEe9uTQNDlJCwqcoz7Thw6+ynzo
	gdpiNfT40A/saJa63VyYooan87zr43f875DVejGxobcZMoAlUWgGLx0/
X-Gm-Gg: AY/fxX6J4/QWmexxKOOh5aG59aHW34dAwmCbvARMN/5HGD07PST1WNWKQsYo2ZCsInv
	C0bw8LuUPAeEFq6GocxWeOC3SvBp0wD3clgCM11XXR2zinuwGhb9y4KxBFjRHcwYb0atqAHpFUi
	e1rSeCLjWHLcLTF8rDeGz73f4Kp/M2A0bVDxwQZ6kZj2DT+9ElX1PRWIvns69KG96NpuxdvkI0U
	yXGEIqJpzYZ3B0SRe6x5P2MFNvSVZ6E8n0pCoJz7rFEf8232drg7JLRJedCEIJ7v8yArjHTXI9p
	tGF5DlF9qqF/ZQIX33J/7ST6I8bgY6MQiTb332RtSguhtplZCeJzt+KhnM240khdQXe8MaxEWtG
	FGMoteQ2EtQjxkDXMpV1nKrf6HbY+ii3J9EPYxHctnYUquCidQElhkwKrrCA4RYet2t+p1Wt4n2
	qYGQVkMr+o6u166RCDM2zSiwFDoTCufUvzghmJVV82VC/4B67hAq7bLqnQv5OfWHEmCpT1BH+Es
	XTKzDda8sU=
X-Google-Smtp-Source: AGHT+IFT57sRzchwkgo2RkVk7eqybUBx+rr0/sZgZIOeGa49uoW05Lm/8gYoJDuz8K8fM2r6MbTUtA==
X-Received: by 2002:a05:7022:6886:b0:11b:1cae:a0fa with SMTP id a92af1059eb24-1217213721emr48642842c88.0.1767524813143;
        Sun, 04 Jan 2026 03:06:53 -0800 (PST)
Received: from ubuntu-linux-2404.. (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b140c42e4esm7743509eec.15.2026.01.04.03.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:06:52 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v1 1/4] staging: fbtft: core: avoid large stack usage in DT init parsing
Date: Sun,  4 Jan 2026 19:06:35 +0800
Message-ID: <20260104110638.532615-2-sun.jian.kdev@gmail.com>
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

Clang reports a large stack frame for fbtft_init_display_from_property()
(-Wframe-larger-than=1024) when the init sequence is emitted through a
fixed 64-argument write_register() call.

write_reg()/write_register() relies on NUMARGS((int[]){...}) and large
varargs which inflates stack usage. Switch the DT "init" path to send the
command byte and the payload via fbtft_write_buf_dc() instead.

No functional change intended: the same register values are sent in the
same order, only the transport is changed.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 drivers/staging/fbtft/fbtft-core.c | 32 ++++++++++++------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 8a5ccc8ae0a1..127d0de87e03 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -846,7 +846,8 @@ EXPORT_SYMBOL(fbtft_unregister_framebuffer);
 static int fbtft_init_display_from_property(struct fbtft_par *par)
 {
 	struct device *dev = par->info->device;
-	int buf[64], count, index, i, j, ret;
+	u8 buf[64];
+	int count, index, i, j, ret;
 	u32 *values;
 	u32 val;
 
@@ -881,7 +882,7 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 					ret = -EINVAL;
 					goto out_free;
 				}
-				buf[i++] = val;
+				buf[i++] = val & 0xFF;
 				val = values[++index];
 			}
 			/* make debug message */
@@ -891,23 +892,16 @@ static int fbtft_init_display_from_property(struct fbtft_par *par)
 				fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
 					      "buf[%d] = %02X\n", j, buf[j]);
 
-			par->fbtftops.write_register(par, i,
-				buf[0], buf[1], buf[2], buf[3],
-				buf[4], buf[5], buf[6], buf[7],
-				buf[8], buf[9], buf[10], buf[11],
-				buf[12], buf[13], buf[14], buf[15],
-				buf[16], buf[17], buf[18], buf[19],
-				buf[20], buf[21], buf[22], buf[23],
-				buf[24], buf[25], buf[26], buf[27],
-				buf[28], buf[29], buf[30], buf[31],
-				buf[32], buf[33], buf[34], buf[35],
-				buf[36], buf[37], buf[38], buf[39],
-				buf[40], buf[41], buf[42], buf[43],
-				buf[44], buf[45], buf[46], buf[47],
-				buf[48], buf[49], buf[50], buf[51],
-				buf[52], buf[53], buf[54], buf[55],
-				buf[56], buf[57], buf[58], buf[59],
-				buf[60], buf[61], buf[62], buf[63]);
+			/* buf[0] is command, buf[1..i-1] is data */
+			ret = fbtft_write_buf_dc(par, &buf[0], 1, 0);
+			if (ret < 0)
+				goto out_free;
+
+			if (i > 1) {
+				ret = fbtft_write_buf_dc(par, &buf[1], i - 1, 1);
+				if (ret < 0)
+					goto out_free;
+			}
 		} else if (val & FBTFT_OF_INIT_DELAY) {
 			fbtft_par_dbg(DEBUG_INIT_DISPLAY, par,
 				      "init: msleep(%u)\n", val & 0xFFFF);
-- 
2.43.0

