Received: from sonic313-20.consmr.mail.gq1.yahoo.com (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA01FBCB5
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917237; cv=none; b=o/1/mhkt1ERNqcWYmnvz4kRKInO4SY+c9YtoeFKKSgsDt/lNZBMIq4hKJQ40DWtJG5dVIuIuwZnnDmwrrUsJFITYMN5O/XO692CxenC5WEVi+o8BprdjPnyFSXS7MbXncPiOcEceYfaQ3hLPgUTckQAlhMwy5bDDwpGV3mUjZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917237; c=relaxed/simple;
	bh=/WmMoTVrFRB6+6R5Oe3Wl2NgoVgmsIGBYLiyD1xZIgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcIvEIZcAuNdMiVGQcoRErZoMudaC7muJHOls0xXYLxdVZllMKH2rgN51FtBUPbtigfR/O0uu0iiKK8RDEoSsh39qNxuSzqkHYS56FZmgh0O6AqSHLySiRpGAjiRCkawUZvKxMk0SBmeU+2P8iiUMuwOm+jXqhp/1I1lGlp1DB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=t9q23F0i; arc=none smtp.client-ip=98.137.65.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="t9q23F0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744917234; bh=e/w/qJ5XSLcAyq79hoDAqncaFzqKvQQg2KNF90A93+E=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=t9q23F0iQoFTC9GdYXhwFMkOgT4JmU7bTKQTfq+1h9i4peyC01mXjzzPve8eue5kHhiVUc49B42ztTKN7PMyVes2y09l8cuFeKEsSTfVLULB5KCWhXIniKTGuac4+1z0qOpQrJ2RIVwoov6lHoQO1vgwpaZq5VA/JoT8A4JithwNJOx3G9NtXWBIkxLEyO2w7a17VjNi/91HCDuUOLGmk5EFcIZKF7FkggDyJctqHtRYAt3U/yjazse7z8MkdeCKvaZhCT7QGs2EJetpR30JFqBAuzytTHy4SIBknsQcc9CQmgz0SgdxxdJvmTcpPAIDA5DIDlDsKLJnWYvGTkocqA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744917234; bh=wa5R4/uVf2rdiD2sVDYmfpp5T6SK1qPmbkh2WpYwN+w=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=D9vgtcBSUQaRYKajD8uGNZQXHvGKBv9PpjQ/JI1dfutSgDFczvK/O1Nn08KZKyUbVqy7PWdRRIKJXrDx2Wavz0i2h1ZYvRLM8oShx+jfwVM7Ck2Bg9yhqPRhgvK2w3PCdJJUIfgUpFU7Af7V/rg08piZ/FXdo1b4JY7owK0P4KlEir1ktyJhaUlPjbyYjsqhld8eLf3PkblyWJWgoceNvc/V12+gM9NpdryAiW31A0lE9ojY+6xRaqy5u6z6FeFHvip48XaWizGc5LI/qc0F0EOqRsCyVM1Nra4OIZ4tletVVcf0YJqcZKH5ximqXI5Wbqd0FnhWgerjFHXr+ETIIg==
X-YMail-OSG: Urj5CDkVM1kIixSGwa8AMkniYP.TEnSAK9AfBdM__HLoM5Ru6kFlInaJqgBYs78
 fp52hAegmVG_e3VhzlO1Ooe71Zlw5Wdkfxe8S10WPoRxITzdUwo83P_Ew7LTXwxrUbhjvynMnDl8
 C43Y0YAKg1G5JxjXe7h7upQYLiJkpjwScTaDCzmbKUa9bVjBRW0o0TUP2t4YtlSwEuHwQBQj7KlO
 K2EIPWWPH1oSVoAe3HQ.rikxsm03MFfXLbI6A2i85o4g0DMEn1Lb40Ir7bUD0IIkjFTMbN40J0j3
 nT3KQzwnIuLRzFy5zSRAdsn9VAE_xG91KUBwZkOT3roKVHAIghooGa0O8YF9w0o49mMzy8f1TEsm
 gomtIU0BP_LsEIKwxmHPYq2mYMx_LJ7.1hpd1F2TTmtTVRiNdPTrXsnkUqky6Ua.rBSwgrqcQUY0
 Dqxap8UYy7oijSsW8sDlFkASGyG4y_qx1vsbJb8P5q0SLx0IjI4CmTn4QkWqUGdAAR016fQWx5YH
 rupWnBINHHFN28zNT5o7bhSSfcSUMUmWKXMkngCYRv_qbnBXj6.Lb89mufp44uM4VZsIaA6swBWH
 s7WMg4ZqtxxQuhzqZKWQM2Po60eeaojf6MDt9e2tQU1aZUQ8UdLYmbbrfIXNV7DfyoNnhpa6Q4DJ
 YBvswUjk2MVMt5yd2KUhQhS8NZDu6VK63QWiWP5MNg1pdgjiPRdFWMj.f7ju6YjJgJ0S_pt0BcDt
 PWN89yGlY6rv1kUBpnIiHPeJZiI1pkCtD2HnfUZsp3wDajTyo9pDP1I.b_IodUrSUAAp921m0Zwl
 GLHjRalqMeGhWrTFUWc004pL0T.boOcxVrzPZDKXWU1fo0rZ.13ca.s1m.7YZr8p84vRJw9p4v3N
 8Y8gMrcbW_AQJZVwQKmt60Ydr1eGkBJdwNqIbD5UrfHAmBpp2xQykXaZwMgoSAyOMGjec0SWYJGy
 mZoYmAUHMRQmAguQ5XH8VpD7eB21DtJDP9TnoDT.xViiYEgf5agmhPXjps1yXEAX6mRBg7GT2yg0
 PGBKzrTCsC7bjyNsqa10tw41qz1iPu0rWBNSiBnOhZXRAbSbPwDYvhnKW4AHpilGdDyDB9XrUr60
 ufOBlwCGNZdYubHp5vymw0lU8LHA261kMcCO5e3AOOnxBYXr_XxJTXVB4RbwTRii8FlOA7EzU0Ki
 pB7iJht3rH_U6vqbcx5vHnxIkWLvbxS303ZnXVHcuLFpyADD8mErRPDFU9QovLTGgyiA7OwrDq4H
 na2LFb9T8veLwcfYKIO1E9LctGBZ.USDShOgQWuG.Lkqz9u6kD0kHseAIsyQCJ54JOV78uE_ZlmW
 _Yo9LSysWvl4Tm9BackNoqWEJWopQlew5L6RtTrgpoXh9ZhvTmrI9QR2sytAAkYbLvgrWtX8Cwnm
 xSeMfb9rhrEGLu6nvAOrkt9z7vkitftgV8Ddo5EJR3vNTBGs0Ii.sd2Z6uY1i4S3nSY9oU2a1L79
 QWZ371rPHTWu4WKsWHmnZP.E5BcKgC4vDm.xxRkKnqhjPR.ue3n4p9XfTscc7WHWiTcsHoKLMWxs
 nOT1biN.4nfeuJ5FOcDxaYUezN0xPpZT9GcYAYvpjhhJg4auqKVMoWf.TOTNzMxYbaOX5q8jNdf4
 SKQJ5qVmbuENIFYcBixWcASGWG68cfpiuVvYk.vyMhk4jLTgr1L8k4yBnULuhccSsmYiVx5j4Sum
 ObwoZHaQb6KsRVdJQz3u5BWvDqdw_D7.jyiAsxyxviPp6i8iWlL06CPUtdb7WuddgPtKSt.EXXwd
 x5F8yKLWmahYim6zDHfnK8P3a2yW1iBHGzAslQL9zvKFl0FMPHURCj1pFLbP5bwZUZr2IMaTGtzW
 8PV5iHfaPJTAJYxtDMzkF9oIOm43pUzTJ_57g1rDmhvgNgvj.oZrf.J7kPmo3FIbU2t8lX289YsZ
 velqRgvQehkvXy8OJtvwp1l0PiQAz15FY.zS2Uk5_X2Lbk8yocPNMtyhXfHoHwuBp7XmI78L4OGP
 MDCxjyTr4HgG_Ksed9zqy6pW3iwzG12R85zHSvIQPbhASto0fr3gFKY9E.vVoANR6itRJdDr1gx0
 jmBOg0o_BwJ6KefuPygzDNzEdsLeNOr38WMfUwc7naa01zKXezMeyVqntP.k3naMOlHM6KNpLPPJ
 8xI8VGtq.7VdBAHRRGe3Y04JeK1DnX6vQLEPbWKLG_7AvQkzvFLy212Z2W0lHgYzjRD7nnVdmrka
 JpYi0F48Ai0ab0Os.CbDE8SHRbG6BmR7XzbjbNtmQXDGdUDbhQlkfTn_8EDrHVV38KdgFMdWLJQ-
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 8a009afe-3727-4a85-8238-bf230a1f9330
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:13:54 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:40 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] staging: sm750fb: rename detectReg to detect_reg
Date: Thu, 17 Apr 2025 20:02:55 +0100
Message-ID: <20250417190302.13811-8-rubenru09@aol.com>
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

Renames detectReg to detect_reg in a few functions

Fixes checkpatch.pl's camel case check

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 38 ++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 2ca72bfc67f2..769cbe768c49 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -289,28 +289,28 @@ void sii164_set_power(unsigned char power)
 static
 void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hot_plug_mode)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
+	detect_reg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		     ~SII164_DETECT_MONITOR_SENSE_OUTPUT_FLAG;
 	switch (hot_plug_mode) {
 	case SII164_HOTPLUG_DISABLE:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HIGH;
 		break;
 	case SII164_HOTPLUG_USE_MDI:
-		detectReg &= ~SII164_DETECT_INTERRUPT_MASK;
-		detectReg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
+		detect_reg &= ~SII164_DETECT_INTERRUPT_MASK;
+		detect_reg |= SII164_DETECT_INTERRUPT_BY_HTPLG_PIN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_MDI;
 		break;
 	case SII164_HOTPLUG_USE_RSEN:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_RSEN;
 		break;
 	case SII164_HOTPLUG_USE_HTPLG:
-		detectReg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
+		detect_reg |= SII164_DETECT_MONITOR_SENSE_OUTPUT_HTPLG;
 		break;
 	}
 
-	sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT, detectReg);
+	sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT, detect_reg);
 }
 
 /*
@@ -321,9 +321,9 @@ void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hot_plug_mo
  */
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
 
 	/* Depending on each DVI controller, need to enable the hot plug based
 	 * on each individual chip design.
@@ -364,11 +364,11 @@ unsigned char sii164_is_connected(void)
  */
 unsigned char sii164_check_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
-	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
-		    SII164_DETECT_MONITOR_STATE_MASK;
-	if (detectReg == SII164_DETECT_MONITOR_STATE_CHANGE)
+	detect_reg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT) &
+		     SII164_DETECT_MONITOR_STATE_MASK;
+	if (detect_reg == SII164_DETECT_MONITOR_STATE_CHANGE)
 		return 1;
 	else
 		return 0;
@@ -380,12 +380,12 @@ unsigned char sii164_check_interrupt(void)
  */
 void sii164_clear_interrupt(void)
 {
-	unsigned char detectReg;
+	unsigned char detect_reg;
 
 	/* Clear the MDI interrupt */
-	detectReg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
+	detect_reg = sm750_hw_i2c_read_reg(SII164_I2C_ADDRESS, SII164_DETECT);
 	sm750_hw_i2c_write_reg(SII164_I2C_ADDRESS, SII164_DETECT,
-			       detectReg | SII164_DETECT_MONITOR_STATE_CLEAR);
+			       detect_reg | SII164_DETECT_MONITOR_STATE_CLEAR);
 }
 
 #endif
-- 
2.45.2

