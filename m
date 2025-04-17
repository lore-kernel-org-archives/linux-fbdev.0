Received: from sonic305-20.consmr.mail.gq1.yahoo.com (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A01DF733
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 19:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917224; cv=none; b=ig9+tXHRG6YIRmqLLQNYQg0uo6FoFdwttlJ7w4K9qtTnZORJH6Wbh4PxM0Gnbc14GlBMaV9MOrbB7XAWpWag5IuNmWHny/9Y0miuNx/VB/F+2nQoxB/qY1TMVkCwB2588Dz6ZNz9PPnu6F0bTlp3J4Ix8/pN9SssoxGysvBkntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917224; c=relaxed/simple;
	bh=xsG94a3CVpgEo0wqWkIm6AJqrfZQy7ImCt21WbqsL2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=Si4V4xM3w7klHsE482vR+pY96kfq4r5FeZtXmDsCLFviy+7Vc31gFfCigqQUYrF/aue18T7c0ENn9XpFgdWmFYd2YHX9HH+mfauaLEGWHfnxe7IO+5xIyafWngPW68xpbJymnLnGoVvk7qOD2vBiIcfcsB/BdoLM4AhNI1LetQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=S1lRRZWa; arc=none smtp.client-ip=98.137.64.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="S1lRRZWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744917215; bh=rPlrtz6zs5q9DINCcihvTUByo9aixRe8ODi9PYS2j5o=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=S1lRRZWaSSnMxCGhBGNTbEyrzPliXdgL2KUtm6Am8lRzCXsFkkAcS90J70i1HQOyrbwMY9qij8+N8pRhFWqGGNI4INoMwjXIgoksHajUmK533jkJLZLqndJWZVzsw9qT5NrsrwJzwcQFUxT64DUjqfh8sKFhbtclqQjAYNDaaN5v4mcjvSLPUTl/XVlXzc64i0eCo/RiY6r01TXb2XWhKPLC9Akrc1pUojM8PdAV2mWFpQScw/i4kq7kVXZ/tsWhS+NUMOfxDmDrIk80YFJMnLvJdmedsDqr2mwFp5OQBTNmi+ahZ5DO5LIjQ9en3STwXNJl+PtqLyNrO/23Y9nS0g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744917215; bh=1Ad2R3eEMQYFRQjefqknSj8KL1p3KqFNsw+mv1J8cz1=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EFryaXji81vAxZk/90V7xk/xDIBaeZYWehMyRWT4GUd8p0n3cw73shJI2+e0GzblDbsh6RUNN4XYoawqHNZbepw/n8v8399cJzcmzeGlEPYWv4CymC/0/FZ+vjELsyaRWvT9qk2dOniWEUHyDxflaLIUq7XVIS4MgV3X92dC8M/oZDuqvkQ9UmBL6yD4p5dPHwuTFutCEIuGnD91XEuWXEAaO5MBgOGzQP6RHitgKrcY/N9He1/1v8pBeD8rtmjtQuwZ4Bpoc+O9kEqiemVNTRuNIbHlFtW+ZtB9n+scdgJCNaLjgl8Ruv2GgWz6JVzyaRjZZGrO/xsyVt+NPE16kA==
X-YMail-OSG: QngtbiQVM1kDgWIYI78bovrukFjaWf.sp6N.yg8DMNai5PO7l7mGTOSbDXge0Kf
 Y.308aTcXcRKw8ST22RwkdcleWrfRiQZj9L5LkD_xtwfmO7s14b8zLB.yzaOEfOxGuFWdA8pB0ql
 F0xcUCXmAZqoUc5M1sZlDdC28yrESaIKEcPfeg7p2ecAoYW3FNwxkyZZnb6WSl33Sl.2tSqTjlys
 mgfKafxFrU7dZh2UNXg8ElZCKYISBKx8AaSYgcwLDWSPZRugH1jh.qffyKdaTpReGW.t9fZx3JdK
 neUPogv5U96BpfYrKV.0bChaAnhERMxET1qx4hVH.IOaLjre0DYjDY47OBQOSvXAxfIuSbzZShkI
 isFEj5GjuOsfJ9jLskbBgcswd0LVlSBgMGHcVM4282P.7sCOKUADMlqUtxES9KoV3cFqsohhBQFX
 Cw55mUo0.YjlCRH6FESZU_8jYIHOQUWQZNhk_Z.nR1VcoRh2z1Zaj2Ksy_PvqOWItDk9H607BtWd
 JbJRbdsxzb1vsZ8.MBS5gkOFmIAy2fY2lnMaj.xwh0QssiSCPpq1Cu8zxIDs6BNdRSrvf9FVxDJ7
 .Ul1lIyq.ZLvDttUHaRG1kb_D.tE6cujvm4QFUGUdrJ5yIjwMybwINaE7NlnrJIchzTlisZhWciQ
 uE2GVxf_HRaqqNFDC6IqsLUje.rsEalGqIpNt1236SDAbIpkBLTP_U422txXIOkbAFuz7lvH1nMC
 7zI6JjOoRXCU9gs2BqntjRSHFDbzYT7oM40_KXcqzC.TCzi75jB2k67DG6nBWBv.G8q643dHwt3c
 ott9YxAdqrDWqpwimptDnoiFl0yz8fEgGhzapKV.JU0qKKu3S8oDWZ1kBlPaaRF7b5lG9r.2QTVh
 b0uDCt77w5grQ40IY7D0WE1m5pgTZV4MMh_85sFydYy12w6qv.UqoFjmavJqcAWLfnQr8gmDfuRX
 4lPjZwTzHma7yTYW7QRwnmQ9LBd2NLZGr9PKqBjsEEVLUYJNERvj1obnrbjgT59eCz1WIQHOpsHB
 .w.OVhqpv9hAq6iCcb_L6ent3XNOxyuFZA6ml2_p7anIzjyfRTmr_QjlfRtR0tVK1Vp2lk.OfX5X
 f8uFB7ki36TNwXZl7h8A3kutwE2JwRfqdG3twloTfS_DcuMWHKFQveoJkcRl9q7yM3Lk4OVrxCM4
 x0qukTrUveBpvQCZd7LWuIp8eJG2.NGFAFuo2PsSrjd8eA6ZfpxInOVea1ezAV7lm20hcHm.DUK4
 4YwfU1WTl0DArkdveIKRt7Ux59bE1igqknRiePgT8OXQSObnqCvW2riu3cX47NrXkoQwch.zwGWP
 ld0yulk2q7vleWmmsKyTvSxe8H5NRy6r.L7zXcZlOaLrZfbZjfpikkAOFSok8PyuJHK6PTU6YaI4
 jYlKYycU91bKRY_hMB3B6pi3tKhPiYom4EqJ7aFVxaUpQQS3XZAAAXKcFolpklRg6fQfcQXv_HJl
 6pN0LM0AsI0ZG6_6f8cJjxbXTDcAdlwwX7Hw_h3yrEtlkXrijuGSvMDu_ETyi7aD2uX3uUE7wSq1
 2CjhQYd3WixVADXU0T.6OLCa0HqPZs2xLCHXuHJQ.PI7bL8sQqUDu8pOla1EuQrc4Br4NF6zMvZy
 uts1wBsfPL1ttKXFNyXdXV42.dZACeq1Std3pHW7ctDYUhMNxEmDNkAT3Cv38xr9lXtFpvFZbOy_
 dl3HelL.raN2EZW6ydxEdyEjcQUKT1.KUmQkhG.HcvZNeTcoUL.worHAfWeWEmIEr9I7kU9i7inC
 4uW2xiSJ46yqx0bcr0uEAs81Vkej3ye52amd5.cNxqenyr.FWSxX.CXmM66fvaDTNUaMnhHCfMME
 C0A_5zLAuzRriq28gqOYFerafzGGL0Ju5CtKPU3RL0m4GiNSpr3gptPME7z65g4QWEoD_0LflHRC
 .HbIALEaSBdQv3censXIZwJwPfnT4K_VnJT_A_1UZyxZIsYtvV.OxpXiMiIVsyY1G.5u9c_6UC.x
 Ib7HdTPMMFtFkddiuAqInUz2VCnz0D5VbqplN2UOiSFWdJ4TQjUxWwWLGblSi2S00cvKBI5UMl6x
 CBkZ1ad440EPrY5I_q3jzn1sxlu5isH5v72FCn9MVg_piAGK344VIYmrh1cqV1DeaSplXF2GJSXf
 BcYZUo.44nhOmCezZlq521VXGSLsjXIYn1ZfiLr27pOZ0JA9YDxZaOWUrpozhDgzj1aUgIAlR4iZ
 NY2AkjdkoIanyUQ1HD3xiblZWJJ.k4rlF9Y1N.eVr1wz8UojPq2sBE67q5nf93dM0JEJTCgZ4bvy
 GOHUJoibI_BdizY6q
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 0dc75867-1b56-429f-b2cb-686d59c06d36
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:13:35 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:24 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] staging: sm750fb: cleanup ddk750_sii164
Date: Thu, 17 Apr 2025 20:02:48 +0100
Message-ID: <20250417190302.13811-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250417190302.13811-1-rubenru09.ref@aol.com>

This patch series fixes errors shown by checkpatch.pl in
ddk750_sii164.c and .h

The changes are mostly camelCase to snake_case changes,
however include a variable rename to a clearer name
and removal of the USE_HW_I2C check.

This patch series is created from spliting an earlier
patch into smaller, more logical changes.

The patches will need to be applied in order.

I have included details of the latter within the patch
description itself.

It is also worth noting that I do not have the hardware in
question, so I am unable to test whether any functional
changes would be better served one way or another.

Thank you

Ruben

Ruben Wauters (8):
  staging: sm250fb: remove USE_HW_I2C check
  staging: sm750fb: rename gDviCtrlChipName
  staging: sm750fb: rename vendorID to vendor_id
  staging: sm750fb: rename sii164_init_chip params
  staging: sm750fb: rename sii164_set_power's param
  staging: sm750fb: rename sii164SelectHotPlugDetectionMode
  staging: sm750fb: rename detectReg to detect_reg
  staging: sm750fb: rename hotPlugValue to hot_plug_value

 drivers/staging/sm750fb/ddk750_sii164.c | 119 +++++++++++-------------
 drivers/staging/sm750fb/ddk750_sii164.h |  22 ++---
 2 files changed, 63 insertions(+), 78 deletions(-)

-- 
2.45.2

