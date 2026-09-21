Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B041F5FC;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789987586; cv=none; b=LpEzdYXmtdsO+rhAcIjVlN0qbF0x7eegsFV96R7hQ6tZ6DTaiG7DKlDG+unnjk5K+DYN3kMXI8xa43W9rQi/SFHHsLWAtdRKOCgym1h1UAuAhbGGGmZU2nJPkOSMwHzt2jPs53mc8+9eUT8adpJxW623yzRirahWWUaPFYtT7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789987586; c=relaxed/simple;
	bh=n5z+D92Tf4v9853MGiqmofw4VuQ92a5uY5YoXMvv1HM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+nlyJKeiBBvsxeK5eVoD6VC2DCYe8xB6ZzJM0wetF9JEHMMY50domNg7Vr1KDxtJKpp3p/KCk4sPhS5fN3fQgaWDlVFC8YcmPUQIsc+g+wL/UirW3ux4ft1qrycdGJ77UYyAWKm+m0HsJ/X+8+gxjz+E+wa+tknjW+Xtc8TNDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdsBzRI0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdsBzRI0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8F2DC2BD01;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789987585;
	bh=n5z+D92Tf4v9853MGiqmofw4VuQ92a5uY5YoXMvv1HM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LdsBzRI0poE8Pac0jEJIHy0xETKGcgs1X8jPzVOnpRfMcsuHEjlyFUlEfsLlUDlCt
	 5faZuG06K6sLYL6OGHiNsX1YWrAVf2xVLUEqXAn/WdkLwXgOBwOjrCnGDd4Cwu56IA
	 O9mOK5DLy0Ae9IPfVExTbpdu33pimXfmoir++82S/O4ke8aW89N0kww/P/liEWgrBm
	 FCYy/isODMU5FP+UrQrNreRPb8r+vSAgG7g4rKilfxSSq/feA0ZPtzKNbZkgBaJsZa
	 bNQn/v2oMGR02gQfymrJCi/fJXVD8yEXMmOSlMqobbRVQPZOYYNxrbswIvxu9QNZwg
	 5yyr0peM+B8lA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C3AC982F1;
	Mon, 21 Sep 2026 10:46:25 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Mon, 21 Sep 2026 12:46:25 +0200
Subject: [PATCH v4 4/4] backlight: qcom-wled: Read back the programmed
 brightness at probe
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qcom-wled-backlight-v4-4-bab8c7ef73cb@ixit.cz>
References: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
In-Reply-To: <20260921-qcom-wled-backlight-v4-0-bab8c7ef73cb@ixit.cz>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Kiran Gunda <quic_kgunda@quicinc.com>, 
 Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Joel Selvaraj <foss@joelselvaraj.com>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6134; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Vd0mK0QtPcwQRIQctDNdJy4/aT9MYS6AbqA9R9Lgs7M=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqsQr/SPXXhzir5slfNf//B0RQVNzZfsL8bCu40
 sNHQe0OfyqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCarEK/wAKCRBgAj/E00kg
 cohSD/43ZwcZK12PiDRqLFQ1BSQj/qpvka/d9RpoDqvnRgqK4kf2y0NM4dS2TQK/FdW5WZ+/Yi6
 y31aalt+YjK/Bq+IGnkO6rBIQHuRhNA6r3pDZKFVV2t0IG8sYVENY97njnDu2/NTvsBQ3UsSv4j
 pK9l2rU88hLobLSxO1zzEYAUrApOR/ibpYipJ12A7jwGrVUeJNF5eKYaLAudIO7AZv+B7UUms/h
 ssYYHA8EeTaukyFUvWw8PDd0KJsuEHa8GqolTOJxdQND6CJdl5Lx0Mlg7jWry/2wZZmtxPMjVBR
 JBZBXFs+8EeMXM9QapCVLV/aIgVeO+xUcOoQbMyQBMauFfXF0e/YDW/PR7Qhk4SlpHW8TMCvPWg
 ZYbG23sGon4Qo54P9PNe9IAQuwaHXq3eQJWZxkmfL0ExRhPhas0EUGledpjCjvTuiOOSNBnl4jW
 E6VPMZpoTLa1X5wUymOunEKw1tq8BWTDaw8Ic0mdjY0UhOahKxEhQ9AhiaJxPa9nouVdKZJnGSt
 rRS1pntI1oWsfwPcJClyNmXPLt51XZygdR1JLCUo65JPn5rqBWvMQLba4eXLY7xSCSKNToM1/2K
 BJMD71JkHf15/fCsvsPbv1dPF0z71Z2d1YZZTa5AoRBjjg6sTfUal+29YX7AOYBax7jxN95Hlzv
 F3B9oCckP7WZJdg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Since the previous change wled_probe() seeds wled->brightness from
MOD_EN, but with default-brightness rather than the level the hardware
is actually driving, so a backlight left lit by the bootloader still
visibly steps on the first update, and actual_brightness reports the
last value written rather than what the panel shows.

Add wled_read_brightness(), which returns 0 when MOD_EN is clear and
otherwise reads the brightness register the matching
wledN_set_brightness() writes: the first enabled string on WLED3 and
WLED4, the selected modulator on WLED5. Use it to seed both
wled->brightness and the initial backlight property, and expose it as
backlight_ops.get_brightness so that actual_brightness reflects the
hardware too.

A module that is enabled with the brightness registers at zero, which
wled4_setup() and wled_auto_string_detection() can leave behind on a
cold boot, now reads back as off. The OVP interrupt is then armed by the
first brightness update rather than from probe, which is what happens
on every other board where the module starts out disabled.

Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Assisted-by: LLM
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/video/backlight/qcom-wled.c | 74 +++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 3ce3bade3b8dd..ca350f320e177 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -285,16 +285,60 @@ static int wled5_set_brightness(struct wled *wled, u16 brightness)
 		  WLED5_SINK_REG_MOD_A_BRIGHTNESS_LSB :
 		  WLED5_SINK_REG_MOD_B_BRIGHTNESS_LSB;
 
 	rc = regmap_bulk_write(wled->regmap, wled->sink_addr + offset,
 			       &v, sizeof(v));
 	return rc;
 }
 
+static int wled_read_brightness(struct wled *wled)
+{
+	u16 addr, mask;
+	__le16 v;
+	u32 val;
+	int rc;
+
+	rc = regmap_read(wled->regmap, wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
+			 &val);
+	if (rc < 0)
+		return rc;
+
+	if (!(val & WLED3_CTRL_REG_MOD_EN_MASK))
+		return 0;
+
+	switch (wled->version) {
+	case 3:
+		addr = wled->sink_addr +
+		       WLED3_SINK_REG_BRIGHT(wled->cfg.enabled_strings[0]);
+		mask = WLED3_SINK_REG_BRIGHT_MAX;
+		break;
+	case 4:
+		addr = wled->sink_addr +
+		       WLED4_SINK_REG_BRIGHT(wled->cfg.enabled_strings[0]);
+		mask = WLED3_SINK_REG_BRIGHT_MAX;
+		break;
+	case 5:
+		addr = wled->sink_addr + (wled->cfg.mod_sel == MOD_A ?
+					  WLED5_SINK_REG_MOD_A_BRIGHTNESS_LSB :
+					  WLED5_SINK_REG_MOD_B_BRIGHTNESS_LSB);
+		mask = WLED5_SINK_REG_BRIGHT_MAX_15B;
+		break;
+	default:
+		dev_err(wled->dev, "Invalid WLED version\n");
+		return -EINVAL;
+	}
+
+	rc = regmap_bulk_read(wled->regmap, addr, &v, sizeof(v));
+	if (rc < 0)
+		return rc;
+
+	return min_t(u32, le16_to_cpu(v) & mask, wled->max_brightness);
+}
+
 static void wled_ovp_work(struct work_struct *work)
 {
 	struct wled *wled = container_of(work,
 					 struct wled, ovp_work.work);
 	enable_irq(wled->ovp_irq);
 }
 
 static int wled_module_enable(struct wled *wled, int val)
@@ -475,16 +519,28 @@ static int wled_update_status(struct backlight_device *bl)
 	wled->brightness = brightness;
 
 unlock_mutex:
 	mutex_unlock(&wled->lock);
 
 	return rc;
 }
 
+static int wled_get_brightness(struct backlight_device *bl)
+{
+	struct wled *wled = bl_get_data(bl);
+	int rc;
+
+	mutex_lock(&wled->lock);
+	rc = wled_read_brightness(wled);
+	mutex_unlock(&wled->lock);
+
+	return rc;
+}
+
 static int wled4_cabc_config(struct wled *wled, bool enable)
 {
 	int i, j, rc;
 	u8 val;
 
 	for (i = 0; i < wled->cfg.num_strings; i++) {
 		j = wled->cfg.enabled_strings[i];
 
@@ -1646,25 +1702,25 @@ static int wled_configure_ovp_irq(struct wled *wled,
 	if (!wled->brightness)
 		disable_irq(wled->ovp_irq);
 
 	return 0;
 }
 
 static const struct backlight_ops wled_ops = {
 	.update_status = wled_update_status,
+	.get_brightness = wled_get_brightness,
 };
 
 static int wled_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bl;
 	struct wled *wled;
 	struct regmap *regmap;
-	u32 mod_en;
 	u32 val;
 	int rc;
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap) {
 		dev_err(&pdev->dev, "Unable to get regmap\n");
 		return -EINVAL;
 	}
@@ -1729,41 +1785,37 @@ static int wled_probe(struct platform_device *pdev)
 	}
 
 	INIT_DELAYED_WORK(&wled->ovp_work, wled_ovp_work);
 
 	val = WLED_DEFAULT_BRIGHTNESS;
 	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
 
 	/*
-	 * The module may already be enabled, either by a bootloader that left
-	 * the backlight lit or by the setup above. Record that, so that the
-	 * first brightness update does not enable an already enabled module,
-	 * and so that the OVP irq is armed from probe rather than from that
-	 * first update.
+	 * The module may already be lit, either by the bootloader or by the
+	 * setup above. Start from what the hardware is driving, so that the
+	 * first brightness update does not step the brightness.
 	 */
-	rc = regmap_read(wled->regmap, wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
-			 &mod_en);
+	rc = wled_read_brightness(wled);
 	if (rc < 0)
 		return rc;
 
-	if (mod_en & WLED3_CTRL_REG_MOD_EN_MASK)
-		wled->brightness = val;
+	wled->brightness = rc;
 
 	rc = wled_configure_short_irq(wled, pdev);
 	if (rc < 0)
 		return rc;
 
 	rc = wled_configure_ovp_irq(wled, pdev);
 	if (rc < 0)
 		return rc;
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
-	props.brightness = val;
+	props.brightness = wled->brightness ?: val;
 	props.max_brightness = wled->max_brightness;
 	bl = devm_backlight_device_register(&pdev->dev, wled->name,
 					    &pdev->dev, wled,
 					    &wled_ops, &props);
 	return PTR_ERR_OR_ZERO(bl);
 };
 
 static void wled_remove(struct platform_device *pdev)

-- 
2.55.0


