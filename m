Received: from sonic313-20.consmr.mail.gq1.yahoo.com (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEE1FE444
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916621; cv=none; b=ACFC3AmBXKXYAU4UIXfHS1G3hHPEg88xUuckOEKnC5vsnuovR+KF4YCWnOLb4huw4tA1MQVvk2ktkzEHlKrIZrzVlhKoxR086c4DhOS0yvWr5rfjNnQj9LfPbN2qeOH0/2ScFb2lNSFnia4io0QvJ/4Nx0tuH+1GUcap58NVgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916621; c=relaxed/simple;
	bh=d6TXpPw9uD/T0xtW1qjab8px9bE7kkSDAEaEMHNKvKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfacldczvHB4cwawJa/MmvGdiqB0IU7xKhGVn7CqIU2u30mcdPjse6izvt+xvjPwK1fiIOlvb5L0ji9j3QCM6GjpfMGpw7RoyjzbqqxRS6+FWb51HmJhp30hKOk6t4RV5T2hNfZ+iZwdEqE1f+UtsQ39ie/uxzQw5fx7plL1l5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=kGAXVPAt; arc=none smtp.client-ip=98.137.65.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="kGAXVPAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744916619; bh=ud1w3HfMPHz9i+REhP5oVrV34MnkpVn0N7CAQVP3iGI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kGAXVPAtok4qk6YWIvFZFCr+8pkR8nu+3JqHECTTEwBR1UIplcedw0fqVHJATq2F/Al+21gPwNUwQmTbr3Y83SV8JcIKlLPhK6pcwmUbQhzINJF78X4Du4tuaxN5T45EEAdmRNHvj1YsxdBc13x4AXuPFRo7f8hnwhSdCQGG6C5ps2HW8OF0Ur/LJTDwIm4lfypaP8qVCvhsffFXMggQ0FuxLmqJK9lXYfUOfL+SiB0F+lv/HeAC1EG8jQI6wZuR/k5LBzXRO7GR8SxnBit4yMflpSVLSkh/PjpHXoTKfYmhkFGJaPlN3VY5dygoF5n2se9+HTtYmx0oEJR/NkhD7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744916619; bh=vjsDYOrz4z1LtH3/07pNwWuauWKRxCwJ/qk77a3Au7j=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=rwOr38TLlb3nJvchBNwVIMpq7RrWPYqTdsJc0Ko5iqZCwBW6kadaDYeVFMwx26mfvgzNmkQ1KoHEqUdbrfxbjcooV9gru+VxDQ5cnEFvmlAxOSAnEMXfma1tLr3FxAJW0ssHecux+BTSGhATtDHTBbXj78Xdx4GeBXo+EsJgsmGdM5tLZ68949GQPkMJuoQq5XsRPQc6KkyhUddsanV3+m1GQmionnAYisZuaPqeR7haXBpwv3yU6r8Vy7Dxq0JgarROKavMy9jd3njsquOboiFu9/ZGdY4iVobTJyuKApv4rouKtb+alvwko2HKWr3ElywitqOIXYG/ss7eMrSCnA==
X-YMail-OSG: LQkbBBsVM1nOPi2YidBu_FFnD1rUZWGmV8xlN6RzFb.684AioQVlsOKYMZCbrnR
 lIrbPl6.qH6VIREZjLPdE7rbm5jRu39IFBmGaNI0V5zYX.zAChiPptQoDLfflAUME_y2yNARE9vK
 BWw8wAi1R.lsE7AByb0dp3zEwPEQrQ4eVyzlIO98bw2eXevM6xTOdsKoKozSoVuX4KLihgeSMqMH
 3m1PDyUEHjeQXWh_qitBcSWixLKEvagr1GXi7dUlvAf.in5Sw9pfCLbfKU2mkrmIC13owDia_1ef
 ampmbFaOAzI0xmwQcrY8qC88MOyVxjDgCuvFqvPPursR7UuXISo.ZmGjwAb0Gv1emCfoE8a2WKpD
 b_g08QuT_sXhW6lYWAtMDqlazXZVZnsdw.ZM5xEQmc8_vWzSSpJ.fbSiuoEra5UbmU80oPPonN7o
 6D.B6DIlLmCgd_RzP6aTzDSUdZla5gvE8mldGIC0R3G1he2VGYtLbrGCCkn7phqLCLwqWhEUXRtO
 VBaVCefKFMrFUiWXEuF_95lYAeXSHw7sf0NiCO5WPpUOkc44_PctU8mbub.5L396W_DZu.Z9XSsX
 i_R2eZnev4Gd13Od47.7RIrj5LIhezO25tt2EETk5DmMNxAKmaDnGsIjY4QL2Gm_HRRsq1np2Pue
 B5b6c95UVrx7YJllk4I_OBeMYEfspdpVcHIYlWFDozwO44anDH3H9fPiwwt3ncN.xKlFRMHeGKbt
 IaOJ6Cm3CbN1fRlAWJt0GyqW.s.EXJegrWx4IzZXUPsFBqHSL15gY7LveFFCSkjNTGqwbzog.fYx
 fNMpLE8rrg0T2nQKRrx9YlPM0mo8emfcI.0Z.igdAVataHCAdE1b5kjATo2dn_YUfMfxpGhtNE2s
 GkuOxLFONF4dHRXatEzKDlXqaRJAdUQmFh7Cd_mlFUOi5mDpxJNXFeOmImoo.FNdOo6KL1yKCEGI
 VxEEPfQhneDVfTeKicyvG56OBtz3tzFqcWAXz3OSTZKZwp.QiMU6sgzUtjGXOmFaWP1br79nDz7i
 CThl3P2bwyr3CrsXkf7gx517v90kReOuyITCAlXLErZV3voL5NKudHXx3aI4wJ0QaZxiR2hrwj5o
 bK.4lh2kku2yV.bdxnC9XLQmVJqrF..ZDOm_ZdCfgReRlXtopZX9lsAK1tiG18QCZIr63rs4Cosm
 zftGiqsIFiQ4H3Lp_KF8ZFtjQcgvnX5hhgMriiLM_b9qHpj8iqcXDYT70v0YwMouSYgVet90xCBR
 Sr0_Wn7cdUV5W12tHrXVnlOAT34qGs9ESFk7srBSsfsChI5D.1YoI1yugTdWWkU12agkSd0Zw3Z5
 8eZQvVOOXbKsLaKsaacmd5hKGLnxwP393DJtW8bVw4W6EVL0hbOXbTkLKwUFToJjzFhYd1zjurf2
 1rlwI3N676yz0XlNVoXEFficP.UpX_SqsWHUkZugyX3u.lrjPb0JwG1ewSZVcGcRYl5Iy0JX5hDi
 QiBoHol5CFvIaXwQMskqtZaJt6as8e7H4KYnmCCPiQIkbBvhRscHjBYb9QEL_nFyFs6WS7RiFWPm
 eMOLJtMufjNj0jEF.y9JiH9ugoIz_uFeiV7Y9l6xAqSV5KHlLmLum7djgPY5wmLQFax4dJTj9YXY
 WNLL.Hw2r3ytHNTcbFi9Jh9IjcTv0WuzaqRfPdYTlzVta1UvwvzwYEasBspGCExEq.18F8s4YroG
 7tgU2qIHkLWPlLS8nhZA5xf9GZrTOOt0GkrkGC72ugvWTio1F7NucNAnYx225aZ7ec8e60l_hkQX
 KnzMOAflzcmhwcp0OlM9caxBSgHjaIda5Mj5zyVlPK2b443dpJohsj1W928JR5754DT2it8ZnssQ
 FCRLC.lWjOa1rNHwTQgGl5Hdfvotic7shZo8smy_2o3d7toP_BRewUxOCk7fDj5F1wpcG64f13Sz
 jMN.BDnbTZz.vlpk41hrF4wRDdbaD3uk2NueorBSlREGRoWtetUuN0X58nE_2_z3Tnd2UyeTjjXT
 AD461536Cwmza7itqUo2djQaRqsrJoU0BaQtLxSjt4gAgC7.DfcMGhOeXdjjS7MnHgVz9bmi3eVe
 xnJm8aSlLNJdzdo8TwoaRmi.38bpnRCzqIlcr5npzadkF7_Vr0LoKvXEKaF.swlE3bUbqKixXczh
 QM.NNrppS4MLRRZ2e775MArWbUI2Nw3I7kdiOe8gSflKtDcMVgFqQ.oD7HJCxHumWYKj7ZMFilQW
 Om6uKCB5aY_Rbr.3gK.jasWP1j_pv_JeXwMDRaraNXMiXcWS5UuqFyiHT3hmgqDM_Q3v0i7BuHhA
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 576178f9-12c4-4b8e-97f0-a70d14d805be
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:03:39 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:31 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: sm750fb: rename vendorID to vendor_id
Date: Thu, 17 Apr 2025 20:02:51 +0100
Message-ID: <20250417190302.13811-4-rubenru09@aol.com>
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

Fixes camel case check reported by checkpatch.pl

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index d4309e0d807f..9f660a9be5d6 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -26,14 +26,14 @@ static char *dvi_controller_chip_name = "Silicon Image SiI 164";
  */
 unsigned short sii164_get_vendor_id(void)
 {
-	unsigned short vendorID;
+	unsigned short vendor_id;
 
-	vendorID = ((unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
+	vendor_id = ((unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
 							  SII164_VENDOR_ID_HIGH) << 8) |
-		   (unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
-							 SII164_VENDOR_ID_LOW);
+		    (unsigned short)sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS,
+							  SII164_VENDOR_ID_LOW);
 
-	return vendorID;
+	return vendor_id;
 }
 
 /*
-- 
2.45.2

