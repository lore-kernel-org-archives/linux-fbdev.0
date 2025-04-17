Received: from sonic317-20.consmr.mail.gq1.yahoo.com (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0697E1FE461
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 19:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.66.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917238; cv=none; b=lvfOtj2BA8+A/ATx7WRYoyBb+OxibCP0EwrP+MWdDXuXXXXchxULDZkXuRMhjzFmjtDJ7ixXN12YO32qAlWGqb2qGc2QkIxwjVNeGkfZAIUtDjciprCq/Xuc4mAgh6oeeZCkAwIgT89HJ7Ft7LrjTrl2xX3nQKudjbv7Izx32+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917238; c=relaxed/simple;
	bh=+ec0rFb1W7AeTJVoTuMhsZFoFYiZixA+qBTOKYTMP54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWxevO0vOIPxVP5YNmkj5EdP/+M85SCRp6oFM8DuKoKnFhcoSm2BM0YdX44M06CuB918xpDNFc71kF5IfxcyRTr0wEHcwVJ8HmdFvjFBdbCNkQ3AyqHmslqaM4tjR5qrsY0jj6mmKhjG7WU+mIiOTVSCyjmd8fQBYbmvKVVlM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=iX7wL4GC; arc=none smtp.client-ip=98.137.66.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="iX7wL4GC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744917236; bh=cjitrlGIeWvZm78t1AeQAS6TcUQQ68Ruh4bXLe3iACY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=iX7wL4GC8yrPzXJW2XmONvqfexsk5RORrEfDyox6z0+grLx/XgTJAASjJCFM3y0Rt9kWyB5VPsvJBocLpTafjNU+/U2Voh9XdPcOQFxYHkJtpRmTNXX0PaBA+yoYlTdr33MUNZvcF2gaOw1zKWHtLBecBTiP/0/dov3ixK8QnNExto0bqRalruS8+byguE0FWRc4F329FxXrN12aLOdLBa3YDmDkrXaliHOLpUvAPmeHQ6a5ux3d7punWt43iJUpURolWSyqbMEOjJ5Z05mFdSVjvdDkbf35xMLTqydqx8wTqQqeVY88HPY+qmmwHBXzaVBPgg7FuESXSOJ2CBiw+Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744917236; bh=NsJmLlxYCGUYUBJCW+7cP6eD76IS5ByO+T68oiB8d5x=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VSo8qYDtjQvBgGIGoukBAMInb/gqbMocOGgblECO4nRo7nne69p8MO4AxbHzCHYEUEYw4G9B/W7AxDV4BsUPwioRUex2JKiJtZj9XwQOFL062UuSFT6QEDFlIRBAhPL9sDdCxht+052iEhv0KOFuWNbhURUOMSCkGjm+nwzTvIr+vFIpHEhKtgjBBTrXDS/Uhrm3sV9gqs8pB1ZXO7SshMaPx2NMT+un3CSCC4VgrU8voyGUlHJQ8NOBjMiWgWq0/JKyw5Poj04O+xAR4aUl+03JBEl0h/hXE4E42WeBoas6KlprktoZQ8OVlO4vr7DZI1Z/5UyO3HTCp/IkDbh6tw==
X-YMail-OSG: kIdUpAEVM1lBKTALP3RK39U5hL_VKxWNvJgxXF7vk9LBIaI.AjgsB3GQ.JEDbKO
 9YpmwAGkPuvc_oL2ArM.p4GURLlkyDZB6mYfKicjkqcht1gIne6rJGnk7DmrR9ognFSljILPoQEj
 92TXUojusPixOu0Qif5U88hgPHCNgsxcdEHSCsdbLHQOBF_._KSVrzrbvFWluDtITwGaGWRJ_KLW
 hUHOyQXYoJPkF9qGrQQNFPpx_j4lwGXN4vC5tny4nzVzUyUpW72j5XdzxvJ3x_HHsWKpgfP_wwRe
 CRcSFoFTxYYK4y1W1tp4gO0WZ1t.QIGhyo2erI05njszeUX49_2GT9hPrhUgA.6PMUH1zCIqGqBG
 hrVbhPt9YkFRFimX9VnwqHJ2kJgPkCJ8YXFyTQBbE7SJp2HiUqFe2ZfU3Ta6Mc5EOj1T5RvDX070
 3S0U_au1MmqCEV5MP.DUViaCkhwVEZ8Hfi6NDKT366motBvB75Q6lWbtHqcYzsIZ_tjZRZ5n54Hd
 Zqr7.OOGeBBtn3wiAH58DJVvxL.JLFHq0ls9g9Ogvybul2o_BPS_q_swaGieYR2m7RttctrUvlgi
 wd9ur92VZt0_wlAn5aRtoTvFi4qgkRUQ2WGAdDTE0qMp2L6Yllzz_Mznki3iG1CBqrcKofdA032e
 v4POYEFhXv3tHjrjN2RHubGENC.bVpKbeprE1ivF3rNmqJLAEc4Q0zr8ML2nfktrgaxlvNmxPjmg
 Kk0pvv5sw9MdjP0Le4cUUWFGuNHlB5jLltx1.jD2svId0h5mCMMLnzG6XZjefyB0KdUt.KN7u6yh
 nzCm..yoRk3Xr5e5_DHmaywwDn6B2hyBwhIGM968pqvZXUtlvhTv.l_DA60Ti0QC1_HK6EGhXD.C
 Nf65nFXJ99qjps3f6pZUznHuboXkFMTr1ZdT3n.gMCNNzfi5rlzQSa1gSBVjHR1HY5f3xHSwdGbT
 uthZDfEhJ_qAaOMq.zzAv2IDOr8vp3h2piYYZ5nrfx21oc5XLEVy6d66Qf3PkKiJ2dIOwABIW6k8
 GxkW03s9wY.gm1DfurPICVgIKsNhZJZ4zOZwZxeG5dpvAv0nK6yqZFW3fkke_tZ2zKENwmngEgbr
 UuzjwW4Cbo.wUfI4ImiEmPMT9mOAGuXYr2Qm53k4vzX9fXQP90s72CkGp.cYbkjGz8AoKHtZmTEv
 jVP1rxg067eTO4_6OlwAJIZo4pyTek9EumXT3DPXC7SeKuLRQ4y24jSLOo0NHRNdz8YCx0m82JjO
 6KxJHoLIpFYr14z27DXSiuln2hMm7Y2Los8.bqlVvERyHZvjYjtXSADDZqCIEAnP6qwY1OHhEgE2
 sXCAMGAa7Qq1REth5DvQ1luIyTf7fTwKF47N87TUbBvzPMBN7WdOgOm6loqaIT5PwakEC71U1N08
 SUS2bUisr1Mldg0F6YSZsPXNyRR08IwdxZZBhcuIWTLrveEoYyE0AZM5J.IPed2Gjuk5tQX7nL2X
 hi.gdwrMgMU7EedGUnq5Lv9wOmFqMqY9ust2QU2EURsqb6I_TliTbPgHiY8epBGqr6ZluIFrS2bs
 ElC8Dp7imr0E9qWSt0RpCgQPmIGNCp29cDmqMDk056Ty7dW3MYy.B2kHTI0xhDIRRaKMWWvQ2.St
 dz67uo3ByyR1RCQZ2bVtNsS9Q3hiePdVjbITmar8VFY.J2DxYEC0iYevSriK10YUigRz1d84Cq..
 hjrSDSJzLevefMNjDDkZf3zqFpyUe6HadhFagk6nBggYtI.EZ4XlgJ.2X2WUThzdMMnzexglnGNz
 uOs3SMXdIG0qTAjMfqAkr3aQSz8I.wVhhcjRAw9rNYMxJfbmgVHtSLRG7SgGnTn_qtHS7_KJ2SUO
 duuX4zZqo0et0y54fIBA.yWROyrDNcFz7GpnOggkIJe08cjtdPlqYP_I_92jBqgDop3t6JYhX8KV
 DmVVf5jBRMRtAQEgI9E4PhY0Io2LGbWCeJtOeLwvVonl8qqtJRHijFp4d2oX_aT9JKd3tjBYNBXB
 YI0hk9iOfeAUMYLgeT1ziyVdRxRJkdX1chvz25ff5t61eGJsMK2FIbSHh2GQzzbCohgLTY2pfPFe
 _zHiqZ5uv8PZhfA.IWoDlTyW_Lwf0h1bv2JTguiDA4EPnIXd1kRyPre3VI3M8yHQa7H8j6u4LMpD
 _CQU78QnY5Ttz9sOra0T1D_dOo.o._ZHmaITqNsYRHhLdRfbhG07XTYHa317CjDhPNrj3Uy85dQ1
 2aSeirX9yPiZQuqour91XE0LnKT3uTaKDrl5rLG3JZsHiXK0pkcn89RUeps42efLSv8Pf4fuagQ-
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 6fd2d702-25f3-4ce1-8338-2957403ed49a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:13:56 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:43 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] staging: sm750fb: rename hotPlugValue to hot_plug_value
Date: Thu, 17 Apr 2025 20:02:56 +0100
Message-ID: <20250417190302.13811-9-rubenru09@aol.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250417190302.13811-1-rubenru09@aol.com>
References: <20250417190302.13811-1-rubenru09@aol.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renames hotPlugValue to hot_plug_value

fixes checkpatch.pl's camel case check.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 769cbe768c49..86490c87156a 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -344,11 +344,11 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
  */
 unsigned char sii164_is_connected(void)
 {
-	unsigned char hotPlugValue;
+	unsigned char hot_plug_value;
 
-	hotPlugValue = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		       SII164_DETECT_HOT_PLUG_STATUS_MASK;
-	if (hotPlugValue == SII164_DETECT_HOT_PLUG_STATUS_ON)
+	hot_plug_value = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
+			 SII164_DETECT_HOT_PLUG_STATUS_MASK;
+	if (hot_plug_value == SII164_DETECT_HOT_PLUG_STATUS_ON)
 		return 1;
 	else
 		return 0;
-- 
2.45.2

