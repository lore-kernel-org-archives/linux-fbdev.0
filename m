Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07E3D7D8F
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200140; cv=none; b=YeXlYDnIv8QLqfoj9ceVcVE3npbsnS36r9KGsXth6Y5jPlsxGRqJm2i/ttp1+P0pqM8JhpwwxeLFL9s3ACe9947fgwUrF80iIBnjQ+eNOAV0IN9QO+psjeln6NqbmCcn/BdTtlUw3zhwPChDTgXIbQamlfmf3vpMBRT5OSzqEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200140; c=relaxed/simple;
	bh=dIsnl0t5FVP9ysSEsc5j1G1gdI61iy67zWOeVDaBYrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHHm/12gyHuPdhYdoSkxHcYiJITzww+8Acu5ArJgnlKyS8l7NM2phwb9jCBQHgDX3k/SAbV0dvRXOSLyG0OPWrAYxypVLyU6b9vJfgNaftEgk4G3tMSKP+weqDIQ+6v1hkfxozcihqK0VdxKLR35h8yDGOyNrAUXaW4GUFCQK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRSWpPq/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRSWpPq/"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b86ed375d37so893992166b.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 02:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770200138; x=1770804938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LV9toMtWaG2CnsQFvTzbMI2fAsoGpmrHbF+Al0cv328=;
        b=WRSWpPq/pQbDYvTKO3EukyyLO/mMLEHNqrshhmW19A0/BqNRzSbmleIZUKFaeMHKjs
         lCQvcUsWUSmGF7BRjOGCuFxVdgcNy0XD9cw6l0SfXiBO3+nFNJ/CC6FKVdXDhgML4AJW
         kq9KjqLen2X6nMz6cD5ukx3RVGokNzHhBIEvJw4PT6PlD9jsxnKimq1tQbss2kM0NaJY
         9t4Z0V/2O+cAUlhmboc6uL4N7Fan9ocihoCjbVZz+pFCfHulviHdFROfajm/qplx9W0P
         +s7swOwdyb5mc5TzSVEcjW3qj0e9PnB/dgIOfuo0GLPEl0iv5pTxqRZkXZTu5c1MJjkH
         owOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200138; x=1770804938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LV9toMtWaG2CnsQFvTzbMI2fAsoGpmrHbF+Al0cv328=;
        b=qjrzOriHGqyDf/SSQBFcRbURNHj7Sf0L7/+gQ4bzzxI+H4SRBFm9QNmBerOs2sUHft
         byLVAJIfFxdQDOmOeBHp7/T4Wr8p4DOYzuBVu4LkEjTsFajs50FL9g7dLNTp3H3CfdBw
         yob49N6Vfl3gM6vq/Svxux6k1/4XkSJN7jiPYByLxRh9a+R0j9udMs4oF+fOfG8Dhdlz
         06CuDVsZGLfoADBUWqjE3vYIG0FmBXtphs+oZp5vpQlRzCB3ggUzQs/N5hOFaKqo4i3O
         AEAAqtzY9xoFGp+REYlhv9a3b7ghVWmfV5KSyuyvW2Vslr2Zlai282ACjtCW/hlufLg2
         D/qg==
X-Gm-Message-State: AOJu0Yz8KhCCURGwHx8/Ek1RW7hpng6XDthJU63PvzpHrq3mK+O5QDdN
	92MjiouN0u6uH06L2IkP0rB5dwhXUQ671B/Eab99koBjga9Jr3s2JGOKmOq/6fKVOOopZj8y
X-Gm-Gg: AZuq6aJsGNeOCXFYU6NgtHwaHtRyPq7f9H5CRnO7OUSvraGJpPizM/vlTEOMc3yVnnS
	567rJ0c8xuW8U9EYU3k9e+WDZMnMuT/17u6lkLQO3ECg/LNTp89F5iXQzMRj3edgHluaJm3dcBE
	oMx9qniK+oMJHplkI81m75kGsOwkcO87Pu3W+W+4Ik/J94OfpB+WNNKsucAFF0NEvDm4bwMyXB4
	6HAq6WGQrHOFhEqBDuVbdRzIJIZ1Elpad+qRxjuAE/E1Ff1UZoI7rgzZJJ9c5EIc6yiXLCQpCUh
	5Fd7k5xO278cHzMxmejQ2G0lNi3GoeC9Pb7PzXuqqg0suGKvi05RuH0DW9W0xsHPs6f6EJ1tU5e
	ISarbp9lkFIuCVOAeq3K148TQmCZUPzLWqisuK9b8rFcWC2NUtu///FoX8hInvbjy+Gp2P8rqcM
	o0zmEzE7JLPd51wkn2AunwTvWf1c1Br8145upZQNgnSHsFKzbHiieceHT1MFmx5wTNhRMwWs0ph
	5lpDi+smh8zEN3fK9ou6ZntAy0UE9moz+eI8mcssxyAFlMmhU7QMlRjvF05gw==
X-Received: by 2002:a17:907:702:b0:b8a:f2de:e329 with SMTP id a640c23a62f3a-b8e9f080fdbmr169876966b.25.1770200137825;
        Wed, 04 Feb 2026 02:15:37 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-b.c.od237066db22328bb-tp.internal (181.183.90.34.bc.googleusercontent.com. [34.90.183.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fef0e17sm106440366b.33.2026.02.04.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:15:37 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH v2 1/4] staging: sm750fb: add bounds checking to option parsing in lynxfb_setup()
Date: Wed,  4 Feb 2026 10:15:33 +0000
Message-ID: <20260204101536.3311-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace strcat() with memcpy() and add explicit bounds checking on the
remaining buffer space before each copy. The original code lacked any
validation that the write position stays within the allocated buffer.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fecd7457e..0eacb522d 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -1163,8 +1163,15 @@ static int __init lynxfb_setup(char *options)
 		} else if (!strncmp(opt, "dual", strlen("dual"))) {
 			g_dualview = 1;
 		} else {
-			strcat(tmp, opt);
-			tmp += strlen(opt);
+			size_t opt_len = strlen(opt);
+			size_t remaining = len - (tmp - g_settings);
+
+			if (opt_len + 1 >= remaining) {
+				pr_warn("option string too long\n");
+				break;
+			}
+			memcpy(tmp, opt, opt_len);
+			tmp += opt_len;
 			if (options)
 				*tmp++ = ':';
 			else
-- 
2.43.0

