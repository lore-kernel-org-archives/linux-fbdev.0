Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794053662;
	b=s1RUo9l6/pNB6tTtC0MTH6no0c3mKEiRr2h1yFX77Bku0EZGmcXVtk+B2UXVVRxSOn5V
	 7c3150M5f4edsmnamQpMF69Ko3PRCJgL6hGAwGwezFRtSNxw6C/Mbh+EuO58pbFBLDMDs
	 /MmzOq0smewGQrvHujau/vGjdzAlbIzXBQBEKfMW8ad7QJKLL2GXacV57WZOo6mzznz4s
	 a7fmkLJKXYrZH1BODvgNfW3yXQdwnSTc/foIC3r+d5d6HTQ4I4jM9YlKlZk6e4N1PiMVS
	 FHh4t0rMPdvjto/XKmuejvP7piFZwfFo7C6B/Jcp5qUE5s6JJW2vlZYYEV+JqD2nezA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053662;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KLNhZsOZO6tTwWVA3EvqxE7uAVIt4SVNmhY1DO4o9K8=;
	b=lgwAPZ+pdK8RWS4K9cLxSH74NJs5403faPYVI3rCpQSwpFRUOOvck7TlrIxO0T4H1VOJ
	 0PAWRhz4XTUDTUlKg7JG9ZfKg6RwlB6OQFnWo+ecpZwCqrCS3IJmUuOK51T9AXls8wONV
	 umPeCUZYzR3CHTzHhh3dMIYp26y7xzkRimBb1WDGllHi8JLTclmU4JNW9e9qCicc6Jxiw
	 xwObfZ+7T6atQQkTMdqAoHJhEFC1uC3fMqhmtgzf4g2RhkuqFh/U5gpnJuMg7SmUikMU3
	 5KDSYPAh/xQDyrGsOG3f7whxrt7Qg6LaLVo8O5Uo9ia4fKvp1+LzfeD4Dv69uLy+uyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="iEsVy//j";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C67606A32E;
	Sat,  7 Nov 2026 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEsVy//j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794053662;
	b=kTHmCC7MksAoIiL/5om88CTyztVFMxA9P4TuaTuJArVIbxOp+nYI/OMR6ZjPGXcTWWMf
	 JdDxZ6ATXPN/pTg9kdHPFegPa4DCuuO+E6M3wRtn70VbMQ6l1fs3aMAPTgip+rjYoXtLM
	 4Ds1obQ/yrmQWEMd+mk1camcynv4oFaWCnacVgIShdCvVRO2GVXe7rym6F34GzmRToT2d
	 YEHYi+B/ctHgY3hP3GgvmN+48xqSoMc/8T6BkgUXKGeTAmvn1oC+tDo2wb2H3T3Kjx1kQ
	 kaqZMWm3IAutRQq4KQmlhXCAMSNQYPs6F/pEbHKZXzpcESOeIFKJrXbl3y/V5/iI9nw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794053662;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=KLNhZsOZO6tTwWVA3EvqxE7uAVIt4SVNmhY1DO4o9K8=;
	b=QySIw+JLLNds5gYhhEYt6CudzzBfmx9i7+bwA6tBzRBFOEa7OVjNrMB06fAk8Rxu4T9r
	 X3EOSIeoG3FUyrhdOlsZsyNH4QscDjz/umCqypfg/LrZ/Ymvpm5GPvjoazYUZ/S+BteSv
	 37VdrlL3IGblX3JsT+xW11lOxBxnrJrMsYKSnd+OI0sgh0ErwiqAE5vCdrAN5R4m6AAzc
	 IsW8NclzdiPDyLRz9HvH2N68cryND3VI1++aV4b1OuZYhp96gLMwNzcLd7NaWxDBgDgWR
	 pBtIywzjSotdhYzrPVuq/MK1UklClNTGEu1I+G0w/io6aY4kCieHp+h6IhBade65VFA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 11EE71F008A2;
	Sat,  7 Nov 2026 12:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794053662;
	bh=KLNhZsOZO6tTwWVA3EvqxE7uAVIt4SVNmhY1DO4o9K8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=iEsVy//jb9cQw2hi0wk/weWIm5r0hg/HaI8iHXLrKzlyXMtGkOdUGluodcDaKqV1y
	 5tW07BVByMc6P//JMvOBtUS6MdRkrcuwKOchty5EQ9ZfbyBal+nlwQkRLxcy5tQNNG
	 p9enJn2n1Q0tA/VuDPrNXlAG2R/qlR0aGK8FKRnKF4WkxGoAgBB2Fm9lDDGMsjjyGq
	 RGlxN6Ci5sMOsRAz3Mf7Gu8J3VN0SwBQY6iaDp+nFdUXr+GWaPuoizK6p+pBQx4CYF
	 FeEw8bhgFb3TnFQiGRU8pMkMdQqbMeY8a1cNo2jx/etCnPIIemhM8w+Txd1rPSPhce
	 DA6fcPQMkAIXQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 87D9B47BD3;
	Sat,  7 Nov 2026 12:14:20 +0000 (UTC)
From: Michiel van Beers via B4 Relay <devnull+michielvanbeers.gmail.com@kernel.org>
Date: Sat, 07 Nov 2026 13:13:55 +0100
Subject: [PATCH 2/2] backlight: lm3630a: Allow setting the full-scale
 current per bank
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261107-lm3630a-led-max-microamp-v1-2-ec9e441d9b2c@gmail.com>
References: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
In-Reply-To: <20261107-lm3630a-led-max-microamp-v1-0-ec9e441d9b2c@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, Michiel van Beers <michielvanbeers@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794053659; l=4765;
 i=michielvanbeers@gmail.com; s=20261107; h=from:subject:message-id;
 bh=YrzYv6G6kHsv+ddU+T8TW/TH8CUbRepEUJYvTRcaRMI=;
 b=AxjxhDxW4d8uyHa/Ajw798sulzFMQpjt0l1f26RDUoln07lDkm9ImfdqGOj44LNdOD02Rgqwy
 aYrLfl8hcI3D36FNfD9EoBboShr3XxNwv9FOXh0Ou6PqF5TiUSMfZNo
X-Developer-Key: i=michielvanbeers@gmail.com; a=ed25519;
 pk=C+lOje7u3+2x3o2NLMXrwz2veP2++eXfIi9MtYsUo4k=
X-Endpoint-Received: by B4 Relay for michielvanbeers@gmail.com/20261107
 with auth_id=1444
X-Original-From: Michiel van Beers <michielvanbeers@gmail.com>
Reply-To: michielvanbeers@gmail.com
Content-Transfer-Encoding: 7bit

From: Michiel van Beers <michielvanbeers@gmail.com>

The driver always programs the full-scale current of both control banks
to the maximum of 28.25 mA (code 0x1F). Boards whose LED strings are
rated for less have no way to lower it.

Read the optional led-max-microamp property of each led@ node and
program the full-scale current register of that bank with the matching
code, I_FS = 5 mA + code * 0.75 mA (datasheet SNVS974B, 7.3.1.11). The
code is rounded down, so the current never exceeds the requested value.
Values outside 5000 to 28250 uA are rejected with -EINVAL.

Without the property the driver still programs 0x1F, so existing boards
are unaffected.

Signed-off-by: Michiel van Beers <michielvanbeers@gmail.com>
---
checkpatch --strict reports errors on the two new kernel-doc lines in
lm3630a_bl.h; the hunk does not include the comment delimiters. With
-U15 it is clean.
---
 drivers/video/backlight/lm3630a_bl.c     | 40 ++++++++++++++++++++++++++++----
 include/linux/platform_data/lm3630a_bl.h |  4 ++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 8ef8163c7fef..1189011bb89d 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -80,6 +80,25 @@ static int lm3630a_update(struct lm3630a_chip *pchip,
 	return regmap_update_bits(pchip->regmap, reg, mask, data);
 }
 
+/*
+ * Full-scale current register code: I = 5 mA + code * 0.75 mA, code 0..31
+ * (datasheet SNVS974B, 7.3.1.11). Rounds down, so the result never exceeds
+ * the requested current. 0 means "not set" and keeps the chip default 0x1F.
+ */
+#define LM3630A_FS_CURRENT_MIN_UA	5000
+#define LM3630A_FS_CURRENT_STEP_UA	750
+#define LM3630A_FS_CURRENT_MAX_UA	28250
+#define LM3630A_FS_CURRENT_MAX_CODE	0x1F
+
+static unsigned int lm3630a_fs_current_code(unsigned int microamp)
+{
+	if (!microamp)
+		return LM3630A_FS_CURRENT_MAX_CODE;
+
+	return (microamp - LM3630A_FS_CURRENT_MIN_UA) /
+	       LM3630A_FS_CURRENT_STEP_UA;
+}
+
 /* initialize chip */
 static int lm3630a_chip_init(struct lm3630a_chip *pchip)
 {
@@ -93,10 +112,12 @@ static int lm3630a_chip_init(struct lm3630a_chip *pchip)
 	rval |= lm3630a_update(pchip, REG_CONFIG, 0x07, pdata->pwm_ctrl);
 	/* set boost control */
 	rval |= lm3630a_write(pchip, REG_BOOST, 0x38);
-	/* set current A */
-	rval |= lm3630a_update(pchip, REG_I_A, 0x1F, 0x1F);
-	/* set current B */
-	rval |= lm3630a_write(pchip, REG_I_B, 0x1F);
+	/* set full-scale current A */
+	rval |= lm3630a_update(pchip, REG_I_A, 0x1F,
+			lm3630a_fs_current_code(pdata->leda_max_microamp));
+	/* set full-scale current B */
+	rval |= lm3630a_write(pchip, REG_I_B,
+			lm3630a_fs_current_code(pdata->ledb_max_microamp));
 	/* set control */
 	rval |= lm3630a_update(pchip, REG_CTRL, 0x14, pdata->leda_ctrl);
 	rval |= lm3630a_update(pchip, REG_CTRL, 0x0B, pdata->ledb_ctrl);
@@ -472,6 +493,17 @@ static int lm3630a_parse_bank(struct lm3630a_platform_data *pdata,
 			pdata->leda_max_brt = val;
 	}
 
+	ret = fwnode_property_read_u32(node, "led-max-microamp", &val);
+	if (!ret) {
+		if (val < LM3630A_FS_CURRENT_MIN_UA ||
+		    val > LM3630A_FS_CURRENT_MAX_UA)
+			return -EINVAL;
+		if (bank)
+			pdata->ledb_max_microamp = val;
+		else
+			pdata->leda_max_microamp = val;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/platform_data/lm3630a_bl.h b/include/linux/platform_data/lm3630a_bl.h
index 530be9318711..43383c476c09 100644
--- a/include/linux/platform_data/lm3630a_bl.h
+++ b/include/linux/platform_data/lm3630a_bl.h
@@ -37,10 +37,12 @@ enum lm3630a_ledb_ctrl {
  *@leda_label    : optional led a label.
  *@leda_init_brt : led a init brightness. 4~255
  *@leda_max_brt  : led a max brightness.  4~255
+ *@leda_max_microamp : led a full-scale current, 5000~28250 uA (0: default)
  *@leda_ctrl     : led a disable, enable linear, enable exponential
  *@ledb_label    : optional led b label.
  *@ledb_init_brt : led b init brightness. 4~255
  *@ledb_max_brt  : led b max brightness.  4~255
+ *@ledb_max_microamp : led b full-scale current, 5000~28250 uA (0: default)
  *@ledb_ctrl     : led b disable, enable linear, enable exponential
  *@pwm_period    : pwm period
  *@pwm_ctrl      : pwm disable, bank a or b, active high or low
@@ -51,11 +53,13 @@ struct lm3630a_platform_data {
 	const char *leda_label;
 	int leda_init_brt;
 	int leda_max_brt;
+	unsigned int leda_max_microamp;
 	enum lm3630a_leda_ctrl leda_ctrl;
 	/* led b config. */
 	const char *ledb_label;
 	int ledb_init_brt;
 	int ledb_max_brt;
+	unsigned int ledb_max_microamp;
 	enum lm3630a_ledb_ctrl ledb_ctrl;
 	/* pwm config. */
 	unsigned int pwm_period;

-- 
2.43.0


