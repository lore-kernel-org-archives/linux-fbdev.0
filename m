Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792827464;
	b=ATz5qeJDQcaAtfid3djXr9w4jrtzwbPaT9UMJSapsXKkgO98Kwx4Zh1aclJ3w3qfQWNL
	 5CX7e4+MCH04R40461ugD7TYR1G6I2Qxyjcg3wxHWL5j4yuA9oJF/EPutSKnYt/56uggp
	 s57NW9CFMxHIKtCdGXuqqVyOwaSGyQZw4MR6/H3qryOtzlMk/Wpa6rUDe1roQ5xaGFwE8
	 pR1oe0++VE3MiXGUq1zfxXbpYuJ2f1CpOdiczdytjE1GtZCcMdQoOCpbVGro0Ipi+1U4B
	 MvK4AF0WSibXDVJr0Lmbq/mfyhVq3kDSFKi2UZ6krH2ZWsAf/tz3o+MHzfHZX5zB/GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792827464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tc1XY534B8TE5CFUGmLcAlz66NS2raVPHqc7qDFoaz8=;
	b=quuMwwoJelHETBZB0fb7HDHhNhOf+YEtmVixOObHcFSBaMIRLQKr/PfzeEboc8zsKN/I
	 UQ76odJaORsZqDdgVTHEO+vl0OkXfkJ6Pw9yNwKzr4mg/HWbu6XJ5L3jXyv1W2MyKZLZr
	 8k4Rk/N5+PDDq/aoUJqDSWXyHa6sE7HYZp11pyQ3SjrXOjUl989vswELD7Aewc8hNn63A
	 hOHr7SEqav0NBe5lcifbyTBJ/E7Nu9MhR7+PwOlugtj8uW4DN+RDlb/jFNivjqjdBuLl+
	 Yk1hONPR8ZMYHruYclJuk7k3i3e3GeRUgJNFUK+6kTVfFesi5hSbwl2hJNJbtRssaHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qbtIkNoc;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163F606A31D
	for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 07:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E163F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qbtIkNoc
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35c76e9614aso2399547eec.0
        for <linux-fbdev@vger.kernel.org>; Sat, 24 Oct 2026 00:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792827463; x=1793432263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tc1XY534B8TE5CFUGmLcAlz66NS2raVPHqc7qDFoaz8=;
        b=qbtIkNocUInzBbe1NJ0k2D2r6wGOBKFmnv9Dk7rD1iV1uktCGw//EErLXowyFxAibE
         6jDdJDp4WFaNf/bZtprPb88/jUYgkUbGwHYfEYdTJsPNrGwqhDvEdA0ZjJdtbslt85ev
         0dK11bWPJ6+GHnEjXe/Uc2co4foPmKmRcF6wSIY5r+wYwap6QF8gIa92EgzeS08Rp2yT
         nBCM/wknbNGriOk0IT6zcojAbnGZ3YqLcCUUgpTVI3/4kmSGdDfwFuF/9v6OYng5ATKe
         E86AXzwOoaAH8X1QiNv6YIGQY9tHtfA41XAPVIZXyLs/L1LGF97YG2QA+HC9fPH/jHJO
         GGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792827463; x=1793432263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tc1XY534B8TE5CFUGmLcAlz66NS2raVPHqc7qDFoaz8=;
        b=bEIIKrDJq7Fwe79UhzfZzj2MMWMwO3LkmLNWvVPVLkVPvp0nZGofB/1TjFaD4SKbMd
         sNzhxBYtoaZKRoUgBbv7ZCoExT8e6BVIEmTrykLSu044epp+1J1Yf/FyRYB0xyoXStTU
         w6ojf6C5cE8aVoLMEhmVC5vc/cCR6QQ4//rSCwNw8xUY06RCT0ERHpdHahOSIEq94Ycs
         t7bJytMqasIaLs55/Zg1G/jo9mKHqBfYSSCrNkDWWpKe1H/WX8MDLI4UBdyrS/V7coC3
         /L5Lx04GoknNrwREBeX7635+pq4ow+KjMrdnC8s92yv2/r7jIFSvebsQKK7Z+bTiYl+A
         EM7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy9eL3ie9t8wPuAqGbxEFc82lCoqR3BTr0qp+3pXuBeHKDiarORB2ZNgLDaCnmf/HnAj6IHqZs+Sk9CLA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJWmClOY4AbiCJmYWnvVNOQMYs8PBDyYXa9pf0P4ExwJ2haIEtP
	Sw7yj88r4eYyngP6NA92oysPEQSqTwoC27ai9zNgHEqCze80v0+guOrZQj++E31y
X-Gm-Gg: AYBFou1pEL2BkE2LYEpJgpm9jgN7xSFvmKgGeFAA+8QwCraRgd32OrpcoHbbdTqNL5+
	Q/gv5SIa7S+YrOsf9QeBjSz2D6ZzGcXst9gN6iIwq+I/lm9osg4qo6PtorudgMSrspI4cgy79uc
	RHlXxUG+ckR/Pm3IZsyK0kK1LY1YfjQgHW89/rRiLES6du/G0y4nGotYpKPpldlrZGC7G8G5MFY
	EcygBpJy2z9qg7rKqRsvDIdhGw5eQEH083brrEw7Vsl2TSccXR3qAz8ZLse+r7o53AsiSNU78E9
	J0sr0v3IL7kHAkqrKX6Zdb0tHOvzB3m9D4iSogGS2HrZUQcFqDJjzueqhgiR4EpF8bEjWM1K0mT
	y43utOSucopJX/C/FmvWz8eMKPIimUPqLt2iV4NlOj3udyLuxmvs3qAKI7B3GbM8BrGL8DyQjbm
	pW/se1Ua+MsFtbw1gG9KfRjtIf4+zyn5ymY6AQB7aoZKEwy80+LYq2DdWlB5o2dsWilWXZ3cGCK
	ZG0o4ogrFzNWQeIpfr/9kWUxdg0PVJ/vZZR2vwoAQyMBgM5swqXnwoq9bR7dEYQU+s7G+t1Rqx7
	yYnPViXrMvEG/+T93a7F
X-Received: by 2002:a05:7301:1694:b0:368:da6c:4fb6 with SMTP id 5a478bee46e88-369e84ba936mr2974905eec.18.1792827462776;
        Sat, 24 Oct 2026 00:37:42 -0700 (PDT)
Received: from himanshubakshi ([2401:4900:1c9b:1c1b:d646:355d:1105:8655])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm5294951eec.13.2026.10.24.00.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 00:37:42 -0700 (PDT)
From: himanshu bakshi <himanshu.bakshi478@gmail.com>
To: sudipm.mukherjee@gmail.com
Cc: teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Subject: [PATCH] staging: sm750fb: clean up PLL calculation code
Date: Sat, 24 Oct 2026 13:05:49 +0530
Message-ID: <20261024073549.29531-1-himanshu.bakshi478@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>

Improve the PLL calculation function's documentation and
readability.

Simplify candidate selection by skipping candidates that do
not improve the frequency error, and defer updating the PLL
parameters until the best candidate has been selected.

Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
---
 drivers/staging/sm750fb/ddk750_chip.c | 84 +++++++++++++++++----------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
index aa78d0bc1..74ce320b6 100644
--- a/drivers/staging/sm750fb/ddk750_chip.c
+++ b/drivers/staging/sm750fb/ddk750_chip.c
@@ -269,21 +269,18 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
 }
 
 /*
- * monk liu @ 4/6/2011:
- *	re-write the calculatePLL function of ddk750.
- *	the original version function does not use
- *	some mathematics tricks and shortcut
- *	when it doing the calculation of the best N,M,D combination
- *	I think this version gives a little upgrade in speed
+ * Calculate the PLL parameters that produce the clock frequency
+ * closest to the requested frequency.
  *
- * 750 pll clock formular:
- * Request Clock = (Input Clock * M )/(N * X)
+ * The SM750 PLL uses the following formula:
  *
- * Input Clock = 14318181 hz
- * X = 2 power D
- * D ={0,1,2,3,4,5,6}
- * M = {1,...,255}
- * N = {2,...,15}
+ *     request_clock = (input_clock * M) / (N * 2^D)
+ *
+ * M ranges from 1 to 255, N from 2 to 15, and D from 0 to 6.
+ * The selected parameters minimize the difference between the
+ * resulting clock frequency and the requested frequency.
+ *
+ * Original implementation by Monk Liu @ 4/6/2011.
  */
 unsigned int sm750_calc_pll_value(unsigned int request_orig,
 				  struct pll_value *pll)
@@ -293,12 +290,15 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig,
 	 * N located in 2,15 and M located in 1,255
 	 */
 	int N, M, X, d;
+	unsigned long N_best, M_best, POD_best, OD_best;
+	unsigned int diff;
 	int mini_diff;
 	unsigned int RN, quo, rem, fl_quo;
 	unsigned int input, request;
 	unsigned int tmp_clock, ret;
 	const int max_OD = 3;
 	int max_d = 6;
+	bool found_best = false;
 
 	if (sm750_get_chip_type() == SM750LE) {
 		/*
@@ -335,26 +335,50 @@ unsigned int sm750_calc_pll_value(unsigned int request_orig,
 			X = BIT(d);
 			M = quo * X;
 			M += fl_quo * X / 10000;
+
 			/* round step */
-			M += (fl_quo * X % 10000) > 5000 ? 1 : 0;
-			if (M < 256 && M > 0) {
-				unsigned int diff;
-
-				tmp_clock = pll->input_freq * M / N / X;
-				diff = abs(tmp_clock - request_orig);
-				if (diff < mini_diff) {
-					pll->M = M;
-					pll->N = N;
-					pll->POD = 0;
-					if (d > max_OD)
-						pll->POD = d - max_OD;
-					pll->OD = d - pll->POD;
-					mini_diff = diff;
-					ret = tmp_clock;
-				}
-			}
+			if ((fl_quo * X % 10000) > 5000)
+				M++;
+
+			/* Reject M values outside the supported range. */
+			if (M >= 256 || M <= 0)
+				continue;
+
+			/* Calculate the resulting clock frequency. */
+			tmp_clock = pll->input_freq * M / N / X;
+			diff = abs(tmp_clock - request_orig);
+
+			/*
+			 * Skip candidates that do not
+			 * improve the frequency error.
+			 */
+			if (diff >= mini_diff)
+				continue;
+
+			/* Update the best PLL parameters. */
+			M_best = M;
+			N_best = N;
+			POD_best = 0;
+
+			if (d > max_OD)
+				POD_best = d - max_OD;
+
+			OD_best = d - POD_best;
+			mini_diff = diff;
+			ret = tmp_clock;
+
+			found_best = true;
 		}
 	}
+
+	/* Apply the best PLL parameters if a valid candidate was found. */
+	if (found_best) {
+		pll->M = M_best;
+		pll->N = N_best;
+		pll->POD = POD_best;
+		pll->OD = OD_best;
+	}
+
 	return ret;
 }
 
-- 
2.56.0

