Received: from sonic311-24.consmr.mail.gq1.yahoo.com (sonic311-24.consmr.mail.gq1.yahoo.com [98.137.65.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180521FF610
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917231; cv=none; b=TRgo+IwPvHk9uDBbal74+FU35GRy8tJyBi2byH3+FIFTALrPsaNSMhOxkCwxVUaSj6G76HQfNER4oc0a8neEAkvHSnmbypXMsVylUB2BDvhrbHsd2D9gMjWLFBReqAYMB5hGUHmywpWbWF/ExKqg7zsp4K0ru2DfcVlyboi02es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917231; c=relaxed/simple;
	bh=L6SdPOd2Ssp0R8bFUEdZpFt0iTf0baqjd0GM0QfWXWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHjsBr1qBT0rwP1ote5Lwb37DKWCoHo6G5ujTGO4YI8tC438tqC3+lHsQnWAblwsDITdlcRZEkuha/7CjPlzQ5u1eX+GpBxhuAN7wbeTb+8hOAFLL5dg2w4ivD67sqdCRxXdb8HkTzg5onMTU7LgKtHO40BXCiQlrTiMyPpy0Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=kwmybk/D; arc=none smtp.client-ip=98.137.65.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="kwmybk/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744917229; bh=RxCvByeLEbOiitcXU2m12OSRo5AUDmJRbM2o07h4ujc=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=kwmybk/De27dzuUJx95P/uRt7Qk37Kbc1tGoe+T6poy1isGUu/j6rMMON/pWy7fprse8USUCZxZAOSeYi0XCuubALQo72icZPr/ZAYHz/u0Ax4Gq9wpFCl2hKkobX1TnXJSosxDXZGhqxXo5xiUGZCCbfDDCMwPKcf3imBA8YVu6Ibm30ZhPqkTxkv8qd/2JAqUA20atiQSZ/QH02WTAEG+4dusZ2edW1C8drISfiqhAmP3dGgMiewShuOcJ8hDeu97U5R1YtodJj722t3yikepW2LVJuuVu8d6OO9fcnkD4iq9InVTng/ZeAdLFPDJfbLn+xbMTcTGD6OmQRV1Eig==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744917229; bh=5FWo8cQc/hB9NfLmJn54LX1h79NfN3s9oqpfAOm3Klm=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=XNgZEzJG6gRyBfUeJsZGrmUmAGYYHsLPfdka+yKcXLrc5yJS1XhkM0c7lB0MpD0u8Bkfcq0ABttyDlDhLoIsa1nlLXGPUeo7YYmPlZjjtu98edHdplFrAz6wS+KKR5+bs/xAACHFFH/Y3K3/6PdBR3z2JKWgrZ7hZwMfF9/b5/KfUmTuau4hY3dJW0yyjxgzsDS9tUBAjqTLsItEdoSgOjywhhgsMwFw2lZGTooXzH4k7Z4ZK820E4PC6uWlH9svA+22ac8Y5XGNrPksjBlERzqdUTNWu6b8+I0Z/CLxQP//J0DY+IlBjl/uM0bMMD7nmSfQcgYZ5hK5i4KvSmY0hw==
X-YMail-OSG: Bsn1QboVM1k.CXjKOD9a40GJDxZ_pa6I7oUPAOlqB1eczFCm6dI2ne.YbUPEwfC
 PRITJHlXTzxlrI_.YLzdN.VbbR7AdXuFLxvuox1CYYTNuBxZ1kQgGK_ezo878SYScLqQTtBLD_Ky
 2IIIAtYjOSSUA5X2AQleqDZT8LxZMF0dElT99yxqfdB8PJGNY6WyLzsB0EuJu_mffCntSj8mEUiJ
 RgY3Op7cJ190pH1nU2DgehYD3kFs0atW4yesNEfjZzOv_opKHYXrv8RChCQ5AcdpQg4UVFFHlYwe
 EAjzwNOHCT5WVFu9Fgjsw.AVzrrABZz3OfnNpJX3qitwwCr18yvI_grLVoXzIVoWpBXN40DbR8qB
 9vKaPP8ke8jQXz6ALwaO5nUeBEYz8wYF3hoawdoLvBKoduH7nJc2w5u3oK_j1Lbtumk.i99Wb9Md
 4ANIdz04YvzBk8XYtvCaOXUlStM9qmOKaWU.ctEGtAdrkfZ79mlS4iCUQwVxdCCltfKseHONQoVt
 JK4npKFVRCyo0jaX6skI4HviOVGix.x0H3OB_mfdk1sOHvuDhWGXF9FYMiyz.pv4NeyBo3KOHz9O
 8kxTtEooN3tHFEB5aJzFRfYb6ZaF37rVfRhWkTEZXjOvX0G.I_C2fIOTnxtdviGNUkfVAx9gDc6s
 Tw1U_kI7NoX.cQ4umZG44ZNSx_QR8omn2EJ2UV27v4s.O1_MNwo9d_GngUxwIF2Eyx9fDXMK87sZ
 Zy6fSttMcB.mZYOu.w.qMT6kVZ1.2PbGGtCNK2iyAa0Va9WMyVJbJiYzMVMUwAgAS6w7hPLR41R3
 i4D7FzE25Tr_Cv0lzWerQpnL1.3vOpzV2rB1RpyU.C0wetvai.XT2jzafqGueUZm1PgbbTNjT1DB
 _vEzZ6P.mJedEDyiBqDRo5_SlZXc01.9SE3Yy7d9Rf8g._TF39FJn.4gyYjpbPyvnox9xwouxcvF
 1Cr4wNB0k74hNU9Dr646b4yFrm0rYdIoQI6bd8.v9bnWLu62ANPljaC3TS2thyZmLlLZs_c60g3L
 ImrP3uB.5d_AfvVrMn5AixMQQL2K8PDUtTgZsxpONYVorBzhMytFnud.bAGNojr_OYU_g7b7NXJM
 VyZuLlqsfoT5j4Ml4Jmn9ooVswjgofAPJ0j_Dal_06DU2arnh55Vif7rXVEj20TxX2cEeu93Wt1O
 aGJRQGXlF4uplvUx4pgsDx1Z2MqpVND3TODFZAogPc9WYc3LQgDez7R7tI1cCmSUgsXWK3hN3fr0
 P73M8PxvsB2TR7.xZKJIkGNTLkbb17Eq0_oAYzUMGD_wPFgZkMiX0Hru4U8YWwGeDehPKWqdmtLB
 Kvtyy6272zyGXLkANWjYUGUrEJeU0R8QneSa8KFMqrdTRwhzd4z9cWiClLzuMR.uv9ACQZHCuVUx
 MQF7PbF_TyqJixNcnjLHhBenGAoaTu9dJvopYV_JFXJEQzkJvmiSAonjE9obgl7Fxeb1Snhq2AW1
 AC3Aq2GdS0E8EX9D15Xm4ZxK4pSaNmUYSe2ktwvF77YtgxgJzLm9HpZBpDnjqpFDLa0UosoZIT_o
 tVIof9cX4i4xCdC0rrKnQPOkNKucBFyrcmuCXb0iaUD2Y_zk7DPo8m8Z5IehrwQukyWheG5mZi04
 R7jYIDWQanr3N5l9PX8vLVAD8mM8Hy60_niC4i.iCFyS5ZKzTsmE435yps9rxuWJzKQo0IdmwoLb
 Vt96yjmpy0KhlQIFmonk3KDbF20n9gEn6ZCCsFhKK7paBXkfzbq43q85CKWYloSLX3sEo7fuURpn
 Ae.VlLb9iIpAGTC231hc7Ftm.zRDMVqqzWLonCCaCJ8lJI2a3NlpiXztbGu9.BBST39qH7LtXoEN
 eFYKEHlrI.v.H3Tv50ZbsI9aiXCC3Ah9kMCcJ5vAhUuzD36atV7YuYulG_Z0X7jODxduoDz7xfUS
 F6FnPB0VpYMFXVi8neAoc55dI903DvOVsjpSTvZj1Bx07EdS3WkYk.VsFDWbe_C6lQpxtv.M._tK
 HxIfxtUFLfhIqL4L.ksPSrbV06hn59ObWMQezzvs8Zgjz6lvIslhqN1dcw3Y4XKeBKhqXIi8odyF
 2ni1ufGuvg_v1ZnFJWUuEHIowo0RzdZMu_bcZzfGhL_ziC9yhaVOTjMyMMKUELK9Iv5rgP5wGucC
 Rwa5CnFiuyJtK39Li4aB013WSH6xNi.7uakZ3lWGsCuvupQHC5D7IPof8x52wW2v3KJJlmr4oK.8
 3egxJ2xnSnWlwiFKV6G2o2AUXpKuJLzJgehrgD6MJnBCUUVtHz2JaYyzaUWL.5jhZM591FRHyTBc
 VLo4BRquFQsYxJ2EF
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 70cf2c66-89ab-47da-9f45-34579a8c2829
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:13:49 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:38 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: sm750fb: rename sii164SelectHotPlugDetectionMode
Date: Thu, 17 Apr 2025 20:02:54 +0100
Message-ID: <20250417190302.13811-7-rubenru09@aol.com>
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

Renames sii164SelectHotPlugDetectionMode to
sii164_select_hot_plug_detection_mode, and the param
hotPlugMode to hot_plug_mode.

This fixes checkpatch.pl's camel case check.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index e2da110fab81..2ca72bfc67f2 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -283,17 +283,17 @@ void sii164_set_power(unsigned char power)
 }
 
 /*
- *  sii164SelectHotPlugDetectionMode
+ *  sii164_select_hot_plug_detection_mode
  *      This function selects the mode of the hot plug detection.
  */
 static
-void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
+void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hot_plug_mode)
 {
 	unsigned char detectReg;
 
 	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
 		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
-	switch (hotPlugMode) {
+	switch (hot_plug_mode) {
 	case SII164_HOTPLUG_DISABLE:
 		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
@@ -329,9 +329,9 @@ void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 	 * on each individual chip design.
 	 */
 	if (enable_hot_plug != 0)
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
+		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_USE_MDI);
 	else
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
+		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_DISABLE);
 }
 
 /*
-- 
2.45.2

