Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC01FDE22
	for <linux-fbdev@vger.kernel.org>; Thu, 17 Apr 2025 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744916621; cv=none; b=RP0nOMO02OyUfTB4GZVEawFysarxDOdVmX0iuJo6DmN7MqhXJSQOaMuMEvydpqzLVNDuX9Vgz1hcIMmGL9RrVD3mDJtnC8IlM3fueUi8uaiC/hKsYY3d8tmcRe1lBHv5+BExfx7nC/SgL4DUNi33HSlsuE9WzwOeGIfg6+jKv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744916621; c=relaxed/simple;
	bh=SWT2SDTvTDvviHUNto7hOAAiIqJxktnAI4OxZOPzDVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSUqBwDhc01C5HVjFx3B5oQRk1pY7jBT0K5rOnVCN5CNSDE0Z4EoXzgTtCC/VcJHMdhhOWYqHpI55YAY3/65/C3WsotXpE2S+7BDBpi8bYbyKtv606ltYbjRiUdT43F1x7jf21lJant9sSVZsG6FxcnT4uskLi1yA/kSjYTGL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=Ba4NyzyT; arc=none smtp.client-ip=98.137.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Ba4NyzyT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744916619; bh=DCAvxMnV7H//CmsH/U1kSW5dFUdJMpHy6WvYvOs+CmI=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=Ba4NyzyToV9bZ2oIvegMcH4O+Wx+a1SyVNi4J11zemkVDAdRnGdFZGROy8uUdDskm/dBpST2Jt8VOGH4iTAnzqwcK8Bm32oJJLZY+C+u8g0cTH4NVU2A0Xa/wsZhc+zAB/Qefzo4txEM3KwMjZqq17OIkEkWheKuGs9IXy9YXENvWtSi9iG/HEa0Ss9IHIo5B9BMNR7iAAuk7gT7x59gckPTHj8k2GSLfostt2e70YQWICD8vjvJaVI23sS/MmT0dOghjamLbKd30QSY9Iwd+fjjscIAJP2DtyRSdC8TOTXqZYB9d7w6dQTSeNf59zE0hD9eKN7Q+73vCFVkeQj6XA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744916619; bh=AsxqZuTk/nb8TcqT7p3C8V/2J1TyHdCLbemXao8pvEL=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=j5MP3JJL9K5rCnKoLSh7cDwACKHcfkTcudXM8aol2ieIDMdFDEbiLGe00dQtqNoA2wVH+/vINpUcT7e0G23jPPDPPV8X009v3bNbkHxhxBFfO2jHpgtYWm5RiY/4AzP65mj70voMK2tCcii+VMv+medzm7G0j/UJ0jVYrUZX5Zk61HkyrOM+MucIR+suCMhpcrgXIoLvnXMQYjStQlD7T9bDxI+YcheVHNS33PzfRRSmT7+fwN3HY3Gr3zVfvFXTMQdt35u4eof/m8JOhIblkMJunXZXNrD7+oy7gTtLJxa2pFhDRp+Re+Le7wrVXJPbexx5DIhr7FZUyEgvxBJWtA==
X-YMail-OSG: kQGM5RUVM1nwuD9V2CKLNNg6B3FjSWb__TtiTv2rAPw6otjkPVKqQKhklpLplcu
 uI9zqQ7vOGqaGNq5CYYhXK2WHm7gGHh1qOet3m2ezuFGA7vnTerofTdA9jQfk0_7YY8lIRVDaMuA
 .3hKLCScWn9aGRCPsENTcbw3f_8D2.UB4qYsMIFhgAyWq8JYzLOfdiCvXoF_IO8qQ1flxt1Sc8SE
 eMhHX7t1ZKswKMUtFiaRzTfSmaBxgNfs_0ZMbFt5EuA4i_qPKXp0XrjVixXpT9DnW86T6e6Ev1o3
 oSmhOrmdAU.hcHk3z5HSt5vRyK6h4bgy2_AFcnBQOv7N1ltT_VleCk1ikmF8P1PUQ7SaSidme7th
 dkwd4OdBCoycbeL7oouGUaDofQTMCeJVSpcpd.aQJHpzGf4F4IlYgiIW8fMPdBXRxPQXoEP2WuSH
 hGdxe4fJK1WHxzG2ltsO5ftJJUlBUyjJ9dnEelGMjn7kXAxZLzj61iTRD_VjOj.c39Ss2A0plStI
 X5w7tIC8MJCXMFQEJtVIRqNRy_cV7VRIJ8lBcTEBFqhDsqu7a6S1Pu1uvsDeR0B_V.8.b2KSiH.K
 Z787BM1lQ7x5RfAROhj9llmJ.aGcKc2CcKdvOWOy13im9wps08qNIvBPfOsz5HchwenT7icMS1Dz
 amiyOf_nko2qVBRvNLnyJRSxXkYdCZXBl.QwYAZbSlVVl86COJR4QDiIikEirygxim7LFGBayirC
 Q96rCuyx5ounBtJOPxBrCDCQmBgM__gdysEU.8sMZLj7lt89XNYoUy1KWEMztFE6RS8h48LRb42B
 8KNgMr8PjjTrVWn5429aPGNbGi8ov7bCKyE12nyeS.CFMQs79wF7C1PT0sIznPGiGaDmrYvnqBLW
 yTZhIejXX6rnf_qbIyVsq1QewYl3Bd_80vC3IUFhJRJFW2fw5LCUBj6Q0WPcrjhbrl.nTcdqQoda
 IsxELz5h1V7ZnwJrJRkSYWFNTwp3fBQG9I21rkEnazl4tQk.7RzRuqptX7f1623kFBR0cD5pPCkT
 cYVTUYQancL8I_3QPUA9IxkHoUvwM0PsMeHrgf3hft_54lpPxiYegzJ7w2GKOlKlxEfyZTtM3Hnj
 _yIn1tj2ri2rV.xmkQFlH9u60uM8zi27CtH3yh5KMG6GknUfViRSvV09HjacMV_9SKkqMV1tsgr5
 iEvGkN_LMGgqILAENBLnHxB_wrHD6fNaTYMBS102XOgWqZWcd.4rIxpGj9NdsrUmZ.iP7ukInls4
 Vnwp3.D7ioLq9XWUHbLciLKfhU9RmdpnUzd5iNJlSoqh5o8d4fEC6KGif_jly5f_dYNnC1H9QKCm
 FzT6OeFSQdfSevqr28bpG._QmZ2y20Ng08YkkAvR9tb7SWegAtVXcAAjJPKe0XjEUHNsdKrJTyR9
 FZSvZP5a.NORhBOPRMQ00HP.R.6VwbertzUP.kOgPuEeDn6XBJfXVCpsjPxXvBJVmx6dPC6Ec9UR
 dC8HwemKJjZbRMhMGhpTILH4hefcN97HpWxRaMF6Hx6HzvIioOyFPTH7imNS.M1OYaQ7T1tYQ_nR
 x0VM.cZ8xlmzMXdOcIF6LQ_vKAS.Xyu_kGz86sbNMUSHqaJwHipiuFmI3HbAwAlSKua_Do3r9AEs
 opLgi0sPX3wIreRg_zvjLbveK6jeQHZruOGHvIm5I2hPQJWW94Q6QSwzFjbKcpNJ6IbX1prgdGtv
 NOTN4Q6o4ceJcx.4GZ3sbByylSoMDx0ESmxhlU2DHdI9Kw5Q5dHoURiEJrpZUpG.f2R62dCgYrQG
 2hh5_AHrlot9NDJFYkHwDNLnXHrG80u.gOjOwM.wJW5nfmigKV6SLN9bz_AEqZIwPBmDcL2PDR3T
 rp6LIE.MtWvb0wESgvN2ebo1LbDS1YT7P2irFCJkfUFZrjI6d3DpvEJiawIOzquYkPi2xQaczyOW
 H4v8azkVBSjeR9sNVbZt.bMDcB5cmKfd8w6DF49zRPej55a0jTqUtqWcZ9Cs6ex8NJgIRL._2Hmd
 uHf3H2w2esyM08vQWVL7.VgUv8x3ZqIWH8Ri3.ze4VGls5DDDx2j3UhD4VYwXv2XtswvSfqNZ0Sg
 Nt4V7DKAV5LNJSwIjUIuW.dyiXMOF95WJDC6gFEJ8cdq_vBQKn7P_hRY0sM5xmt29Y1Qv0r8UwVU
 seRplurdmJSOw72UW7uPpjYZ_VNCYuWFtwwXs2lnchNlNm6hppYApUxc_S2SLZ.j2o.69OTI9pN9
 r1LBq0mI4PHZKmyLQ0Mhze7fRUPLY3JbOj1fRRH26cwNr0_.RfWW.u.4W7jbHWqs7ezhOU7DFwQ-
 -
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: bae8884b-80a9-4925-b2f9-5ea4dd051476
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Thu, 17 Apr 2025 19:03:39 +0000
Received: by hermes--production-ir2-858bd4ff7b-9r9sx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6040ee699aaf3d3f072b53831b62751d;
          Thu, 17 Apr 2025 19:03:34 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: sm750fb: rename sii164_init_chip params
Date: Thu, 17 Apr 2025 20:02:52 +0100
Message-ID: <20250417190302.13811-5-rubenru09@aol.com>
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

Renames sii164_init_chip's params in the header
file to be identical to the params in the c file.

This also fixes (one of) checkpatch.pl's camel case checks

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/staging/sm750fb/ddk750_sii164.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index ebc173658f0e..465631d3868a 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -16,16 +16,16 @@ enum sii164_hot_plug_mode {
 };
 
 /* Silicon Image SiI164 chip prototype */
-long sii164_init_chip(unsigned char edgeSelect,
-		      unsigned char busSelect,
-		      unsigned char dualEdgeClkSelect,
-		      unsigned char hsyncEnable,
-		      unsigned char vsyncEnable,
-		      unsigned char deskewEnable,
-		      unsigned char deskewSetting,
-		      unsigned char continuousSyncEnable,
-		      unsigned char pllFilterEnable,
-		      unsigned char pllFilterValue);
+long sii164_init_chip(unsigned char edge_select,
+		      unsigned char bus_select,
+		      unsigned char dual_edge_clk_select,
+		      unsigned char hsync_enable,
+		      unsigned char vsync_enable,
+		      unsigned char deskew_enable,
+		      unsigned char deskew_setting,
+		      unsigned char continuous_sync_enable,
+		      unsigned char pll_filter_enable,
+		      unsigned char pll_filter_value);
 
 unsigned short sii164_get_vendor_id(void);
 unsigned short sii164_get_device_id(void);
-- 
2.45.2

