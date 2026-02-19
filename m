Received: from sonic312-25.consmr.mail.ir2.yahoo.com (sonic312-25.consmr.mail.ir2.yahoo.com [77.238.178.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF68733DEC0
	for <linux-fbdev@vger.kernel.org>; Thu, 19 Feb 2026 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771499817; cv=none; b=OvPJb4bOwVn/vArbZ+jerw+7Ylv54g76ZYSidV6buHmS1Tu4EHYZToFracaFtbuGk3bG/7LMUDR9kjBTKTvWCY6Rh50Dgwydrm2ezEx+zQZBrxq70Pbv2sI5zF3YDC0lIEqEsfZCgHz/uajTQOGYD7OBziU+/aJToBDY/3sAJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771499817; c=relaxed/simple;
	bh=xNmmdblDxkwNTum5PgTKCfrAGw7aJwB/1saxfGaNuvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=lqcIG24A6qB3FjNN+aqNmkS7XUBniyIusRNiNaT+Y/T3Vpyx6ca8NtS8liX7gAErexayH2TxASmEEx6HP8VMrR1nn3eJUwU8of5Ym+BS3NQGw9Wl4EtFTV4NzDpYJsxPLcWMJfBKxRW0SpCZvTUgfje4DoIvZczCq/nkNqnp8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl; spf=pass smtp.mailfrom=yahoo.pl; dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b=a4uOlyDC; arc=none smtp.client-ip=77.238.178.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.pl header.i=@yahoo.pl header.b="a4uOlyDC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.pl; s=s2048; t=1771499814; bh=rrbTrXlCINoMBfNNXDHwgZw9HDa91yRcD3bSDG+yogE=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=a4uOlyDCTNR+wh+WQAeW542x8GORS55+XZgxf+J3enA9Uuq2d9OuZmfsAV6DLVrinx06nH2OAaq4ExcXfBQCmrX3pwiExo8LVHS0kdGwol/Tes/8Ci6n5hEZC5OgepM6ccJKKkVAn7XnfIE1wbFXpmBC7gBoeplVFWzR/LtdwUGUJ8nyTuxPO+bPLSDt9zIwQO9ENTxtQJV+/vry/iifENB9/443pPTzV0wWXGB5KUycuOKGkVEQC/SAoBzYZXlylRfxOnO30nUuX5IU6j61dgD3C6FbL7wvbhWJYZ7GQCxwDVFbNLIKdc5nwNovk9CGbHahsz+vZrVxu+0Gqau3sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771499814; bh=PZMh6mkakLkLbM0yN7xGA3kpnPmHFcASbpa1kV3wDzm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Q/NvGN64hWcG66WFf8sgCHFNi5gbke+SEJPgNc8uxpGgj0zJEBoKYrbZj/IQXneuLa+CGyxgC/Q0wCFSeSoFN9e+3V6w6XOLyM2t9/g/bCl0JchePkWZFvJ9SounGrXMDfZ/DRa89AtdsWsjICwwVcJty2OEJhxUIkUZ7Czr6Mq5cl4QfdlcrLtBmkXA3D+zGfzAAh0rJrdm8BjyyKIXzpsFy9bCw5TfjSc6Z5fNKsAIDywVn9K6Z0EMp5kOMIVUaVv3wQEXmJT+3pra8YFBFi/fUv4a+r7c5v8ry21PTA3vpAzgKdpsWiVZobyN1qDWY04Q8to1pOtjk5wB0PTwsw==
X-YMail-OSG: S.ibOWQVM1ko1M8s5z7YGB3Ub6TR9TMSEfj7u3LdG4mopcHKVXBKbKeq7YFvINL
 nyFNRiSfRznd_UEtXRjHm2YkQUqeg5YMyQ_3TTpe2y6FF9WeCFaEv25su9KcdCXcEKVLCr60wbic
 FFWqeqUy9GI.IuYkFzTqd1UBnAFFO64AvqD1Vc7KlTpRkTkifYaGeUJBtn8b.gscvInhGwcizpr6
 arETspksI9bItG4jbe_KvOuyOUt7R8HCFXo7YE7rK2wAqf29bW_y1kec1il5X9FCdRg0BJbonSyA
 dc1QbUjXYpo236.hP7GgWM68eS6DSvhsxy4tnfIkllnadCdDLRhTx39iJyR9msO9OuoFXghtnU1W
 NDSt_d_xkPZygecT0yC0kF5NHaT5QLxducuaf4U23ohoUajJ4ID_.sg2uc.Nvh.narcJYoPVLtX_
 vcIlt9Ob2_NV8FHyPCH0.ER7kPLIio8GBy1I63EXsiPiABS_INl6khZVMVS_fDelXFdtCFuy.KHl
 5oynLgkIp2IAOWPYZKnIc_etdzvxGav.QmkUSO_XAMrCR30Cxlky2n.AhRL_lnPDbkCoq_T4u7gO
 1q.lsjdcIMdBV.aRqTF_fgqVsEq5anX3XNB961KOhJDJDUt2X3vtczDSH2lfP_3ThHLSP.6OscD4
 tCe9dbqQqI.73W1EzuyZof3ZP6b71cMwWPUhtI_mwQGT7Lz905ufUhR8iTazZjunlDsD.c7PXSc8
 a52kAjvfuOhp6Nlzu0OH3Wq8XAG9w2xrwdZoWkxGILRHSf05c.eIfbm_W9j7RTYPxAh1MEbQ5UPt
 D3zSaPr5mdvuEhhqugxTkoFK6WD_iT.n3uzsU2aRX7eR_PLLv7hKECygIvl2M.FN1eEEM4KlJSNV
 wtVPjs8D.SSJEHyPKCv1sNInRwigJCCao15_0QVvBEQVAOOiWUe4m9ld.z0cBJmE0tQp6V8LkU.f
 MVqt5mnp1JzUdPzQeg7QRoMjh8RtaWhZR0NGVhaDvd06qC98RogIyoiXsSMK5MJk0_GyyqcR0k3B
 gbCReARBS.5ZNoaJ3GcdCYCZZo4Njwn7pJokBLGS_7u5sNmwNXBPzFcL305lR1YwzeKplhn7g0k7
 EkGWeE3mEJy2TTCUAETnPFGMnhTXu3QUbzMRJCrS.N8i.eLmTKqll9AdZ6_Xv.QfHk1ULVEVVo3s
 iMCrjky8o99HoFUVVKRDX7.6D5D7uMF27cZi4sFFOXqq3bo.IE9uyPXyrHzl3uXx0afgE0EBgtsw
 QoJuN6ZW6B_zTwSEYksMnZt0HXE9c9.aYDOXlaKkZTMzHd0L8Fm06Ya87rXHHxKGKLa6VsvQsP4m
 mbN8z8txDnL5ugOkwsfEfVWmBy06k0GtIMTXnAZ3vDjt5kwj4gTktF290cMH9BWXFqwW71GmWUpU
 yd2NmHpqRs9g2YZ7Kcopf.yWDRPPhDry9ZrPQF.uH735Ai.H0gzxGtRVVRubhaTehTGFWdQQ6510
 jJB7ZFlD0roTyzQgKuUmzS4U4fkatvMN3aCXZlfbZyfCrhq.wkke9LzqAAqBNgBZE.m47Uhb1IjQ
 jnJiPVp7Q4.f3mbGighSY6QKqgtxPFZxE7qP4ZWSjhvtQnRqrrF8xljTVtP8Xk._blXGzRJNvKvV
 R0zTIEypnTsoYGJU7uVxEv9V9JsjGkGDUnqOvCVxOfbYo8LX6OOE_VYggij3x6KPTYV0ToalIDio
 GIjVd._rrLviAYj5o2wzmULh45Y2.07VhIxVhQCtaCZg2KAPiK_8l6Kz27gG0ErILuc950ABZia5
 MqjVw0QFT7nnRET7j8BO5RGIbqekpsE2pXB1x.tMOfoUC9R6Xcfytt2ch7pbGKJtNlE29EaQ4PHg
 _3_4DSCGAKJVUw1DyXTuXSCiAT2MMmWQ6lyitZPaLIkn0wH8qkduPc1rV2Rj.XVbJIkXsTjg6_NV
 wPlZx5.INQ7DIXSZ5sAFo4MLj4KbCI.LVbsdGCdtOkWAhitqvWuifSl5ts57vS4wcoZocEfUJKnF
 BHFEdYPYFDTW_mAqmR1s9H9sFCTnoINy4kwPugbYDrsYc.Ov6vGvKiaWnZkwDcbPoV16_y8z4bvt
 _Na76vQPuFMS1TVoA5LshXgRQGeGQQv5z7osP5cwQuYvoO4JwXdLie1deJLsGfDEqzh1kJg_nvov
 b9wLEmf68n4RH.gbeqQfDhJNaiOgZpIop1DCvbzk6Msaa1K6K1g2LPUQkcPIxlSNafcdcoK.dfm.
 qSBwy.YLY14xDopqksw8uxB7dJRanfjwfc0O_tkGvuMegMvLuVhNJ.ZRfhedPzrb3pVSNkuC6Upz
 wj3DONzhX_Tt2
X-Sonic-MF: <tomasz.unger@yahoo.pl>
X-Sonic-ID: 6fcd8d4c-b3d2-49b9-8aa9-98c6bf85263e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Thu, 19 Feb 2026 11:16:54 +0000
Received: by hermes--production-ir2-bbcfb4457-g4h2c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d16b53fd9273610de93e18c09654bfdb;
          Thu, 19 Feb 2026 10:56:33 +0000 (UTC)
From: tomasz.unger@yahoo.pl
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tomasz Unger <tomasz.unger@yahoo.pl>
Subject: [PATCH] staging: fbtft: fb_tinylcd: replace udelay() with fsleep()
Date: Thu, 19 Feb 2026 11:56:28 +0100
Message-ID: <20260219105628.43534-1-tomasz.unger@yahoo.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260219105628.43534-1-tomasz.unger.ref@yahoo.pl>

From: Tomasz Unger <tomasz.unger@yahoo.pl>

fsleep() is the preferred modern API for flexible sleeping as it
automatically selects the best sleep mechanism based on the duration.
Replace udelay() with fsleep() to improve power efficiency.

Signed-off-by: Tomasz Unger <tomasz.unger@yahoo.pl>
---
 drivers/staging/fbtft/fb_tinylcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..3fb15df31592 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -41,7 +41,7 @@ static int init_display(struct fbtft_par *par)
 		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	udelay(250);
+	fsleep(250);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	return 0;
-- 
2.53.0

