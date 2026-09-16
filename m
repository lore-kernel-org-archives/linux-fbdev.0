Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06248D868
	for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 09:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549354; cv=none; b=n5X59b2c5Rj+vXnF1Y1lGrra/nxm1rVAHIn6t+1u3nt++RdrkPmHuloQj1GIjMskOhBo2my3gSMslPxS3/N8ocbf+Xl3pY9cTZLEtKrkZ3KA9ryDq0mgftmEFjdSy3I+sbKJ8r6ivA6pF++OUruCTDNYhJl+2jUFbyBGjxzcc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549354; c=relaxed/simple;
	bh=j5sbj2aiiq+G7EZlSbj67WaGpilF88mvU2dc4Sb1Ous=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtUAdVu0Uwao8q4KgWHCLq8KXsIovPe/SBs8mUh5yYb2QfngDmH/Sw2v/DXZP8CjDIFmwVEC2+oJOjL/hA2jMVHNMDz0MLxVGTUUJ+xAmcv994yVjEAUeU9K8yis6s5e1fmJmoTIDG5gVVNWWMH+1aJDJl+vY2kQrNH3O/0ajgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgianMGT; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgianMGT"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48439feca17so436968f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 02:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789549323; x=1790154123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mLpJwVn/HuZGfr8ir4XRFNtWV419k47czEV7zvOmQAU=;
        b=WgianMGTSKKfNGAx7NvwWaXyUWZjEYY2LP6oAv1z3V85xpqsdECDvoEwBnRSEdmBBU
         qPZeqacwlLNGEXoMwpme2PiYCYU9S/UxgEFfZ+cYMQMPx9S6RaFCf5XsAvO4eitIpG8i
         70oDS8Z8ZBeCuJSE5FyO3z7+lhjpWEO2myH1X2Zdg6AxgFddELaw8smGZAgUl0CwsWkE
         VwaQoZ/qDN8bBhppPR9D4Qp9xa0uim1ZDECy6gFxOSk0BRixGFRB41NVyEDLexKP7K8/
         Ij/S/qsfbbRsf6eM7MfId+ErhQOulxgTJUghbASlIpg6QKjFlrf4hZAkllM9p6ojHeav
         P8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789549323; x=1790154123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLpJwVn/HuZGfr8ir4XRFNtWV419k47czEV7zvOmQAU=;
        b=q42zObMEZJv5P3Dnob3fTiiF+eNevPLgZeoIXVgkXg3hqEsiPcG1n251/8lPeHw8jt
         ulO/RaT+3PIYyZ3OFyEx9ficB/TcZ+7ebmPsEIGLy6Sop11RedmYfg0gQAUHNt9fCr1v
         VtoO2wC7ayxKsUwN7PK9/EdrDaJKJJgJrPI9QY5GvM65f0BbIxii3XPP9DhR+nWMuLXc
         1BnhspWhggOsDVekJBPRdeOrLCxgFDfg+jjsD5nc83nzInwqc6+M9hm9+EM1PPnOTLMw
         K21PH7qn0OeYaKgkV+HDP+13RT//YBj4A10LN2zwCAjTYtVg67dBmdD0Bq8FlGH7pLq+
         N4wQ==
X-Gm-Message-State: AFuF++nwP5o4elLGqC2XEZrzwmlMZVfRjJzlYX5Eu0yRqVMwyq+xxVsD
	C+TI+x5Fe1bIprtF/YML4vSDdENW5LAB4yxTzWCK2vBvfYtq9oE1V4mtOcYmIjJy
X-Gm-Gg: AYBFou0vXmjXbFlvsNOUAjQMDilRE3KjPPhQXm8RBW0quXs1QXs7PawEWBXyPE7B9Uh
	fcGVggPyLSmu46xTeXWEuUM8J7Tg3+mE7eMyz8wlXERICWAVHFtb7waQi0YvvM8yxHyFzGhCddB
	PWFwO6R2O20pTjct6dvx+yThTfcSxpwqZlezKbmIcLfH9r3rI/FIJ3FX5wXEHGoZt0zxOO3y4c4
	0dunDd4qqsg6m9JG6aHoeqgjfWSHEAqE1FHvuyYWx1o5N2f4suyIjgOfsFjkKS1/0EyYdrrs4In
	X8ch2b2UtDIbLfnIwBj5wrbrIppUASGPhIVjWX+LyfLuZyD5eNCWSJNVoS2Ppkzg/jRDf/0Chle
	uKLm5UbV0GiAp/ukJ+b0zBhg5vjNYdfHPNmr6ZFiyM8kgtvZDV3ZoDLlNU3l1QuuPBsC+8oxS6H
	S514AjmFfDHpAsVwNXiyNViAjG9Q9EtiWMij3lLkfPLdWb31W/Xf0VYn2gkJHx36e8
X-Received: by 2002:a05:6000:1845:b0:487:370:d03b with SMTP id ffacd0b85a97d-4870cf201dbmr2386458f8f.19.1789549322496;
        Wed, 16 Sep 2026 02:02:02 -0700 (PDT)
Received: from omermac ([82.222.238.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf4161fsm5229696f8f.34.2026.09.16.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:02:02 -0700 (PDT)
From: Omer PALA <palaomer100@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: remove unnecessary parentheses
Date: Wed, 16 Sep 2026 12:01:45 +0300
Message-ID: <20260916090145.34881-1-palaomer100@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary parentheses around equality checks in sm750_accel.c

and ddk750_swi2c.c to clear checkpatch.pl checks and improve code

readability.

Signed-off-by: Omer PALA <palaomer100@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 2 +-
 drivers/staging/sm750fb/sm750_accel.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index e63f3b00e..24ad58207 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -393,7 +393,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
 	 * Return 0 if the GPIO pins to be used is out of range. The
 	 * range is only from [0..63]
 	 */
-	if ((clk_gpio > 31) || (data_gpio > 31))
+	if (clk_gpio > 31 || data_gpio > 31)
 		return -1;
 
 	if (sm750_get_chip_type() == SM750LE)
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index bac9a2098..21aed73d8 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -202,7 +202,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		}
 	}
 
-	if ((direction == BOTTOM_TO_TOP) || (direction == RIGHT_TO_LEFT)) {
+	if (direction == BOTTOM_TO_TOP || direction == RIGHT_TO_LEFT) {
 		sx += width - 1;
 		sy += height - 1;
 		dx += width - 1;
-- 
2.55.0

