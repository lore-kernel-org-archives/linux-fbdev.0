Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F78C3526D
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Dec 2020 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474EA235F9
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Dec 2020 15:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgLQPCR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Dec 2020 10:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQPCK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Dec 2020 10:02:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B5C0611CE;
        Thu, 17 Dec 2020 07:01:17 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w1so3390985pjc.0;
        Thu, 17 Dec 2020 07:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4SrPDmHG0As/OwzJdej+CW/T5rDD9USMymspHe9EwBg=;
        b=X0kCkrqAT7KPt0gVo7ypcvogPfcJNnuOkWBf/Vw9ovHm4Ak8SUtve66eG9jvTKqYhx
         5IrJy6TJgT/Vo9msMYmnZcliucX3SkgZr0lfwJbOCGOIfie6yI9jyITeOiy7lWHz0WCi
         HP0qlQ7RXxQ8P8ZdL5G7L1F4KlhKONCuzwU2UQN/DESFirH+ADjAf6lX9nXTikijHA03
         leGsN+bZWGhbQA3DXsn2RazypZquOSeLjfZjb4XWFia0EvW1nNpVmRYZDVJAJXH7r0m8
         qANqBrdXnGdjHHSsiwyCuOh04ijx0/tECJIwK7KaR+75n5OdOmgOjTkxG7CEiBz3/bR0
         ckRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4SrPDmHG0As/OwzJdej+CW/T5rDD9USMymspHe9EwBg=;
        b=WeC2Jb16OL5z7WAkcTAp114Xa8UD2VRy4ujZfx3KKm6kD9X0pNL9gFO1Fkludg8GYA
         Cx98PGJSZkMKph5q2Pk1IBpydmw4X2aCkyUcTL9GdbPRgDZTWVlamoEzcZ8ARCd8swpk
         TtMDoz7LTovGrr1ENwRld1LrqP/1TAJ90Nvqb0Tia5j/iqC2y5LjlpTOxt53S5lNDBLs
         YkH6FseISIZ6ag1kevxUpXQD4nepSAo5G6DzdNZr25jjuYGkDr//Ug3rblfx1SvyWkwV
         JMC8CkLCzMy4YCdfLuNOw6FYGPi4kpZTJmKvaBoHhL+SKtQLEcxrBylHF3iaP0E8fHld
         7AtA==
X-Gm-Message-State: AOAM531neekUyEnSPD9yyV/N5j293ZR0wfyys3VucDhJ2AZp37pN8a/C
        zWUQMbvne4evVYxap/+ID8DxkGh0rwQobQ==
X-Google-Smtp-Source: ABdhPJyXbxS0F8jlUr5S3Q0HkjVcZZ5vpKYGTn4vLlO/8SnFTqlCfi2LGZR80GifsR0hpd7vrYaoEA==
X-Received: by 2002:a17:90a:248:: with SMTP id t8mr8536346pje.193.1608217276960;
        Thu, 17 Dec 2020 07:01:16 -0800 (PST)
Received: from localhost.localdomain (1-171-2-187.dynamic-ip.hinet.net. [1.171.2.187])
        by smtp.gmail.com with ESMTPSA id o140sm6189074pfd.26.2020.12.17.07.01.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:01:16 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH v5 6/6] regulator: rt4831: Adds support for Richtek RT4831 DSV regulator
Date:   Thu, 17 Dec 2020 23:00:44 +0800
Message-Id: <1608217244-314-6-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608217244-314-1-git-send-email-u0084500@gmail.com>
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds support for Richtek RT4831 DSV Regulator

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig            |  10 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rt4831-regulator.c | 198 +++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/regulator/rt4831-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 020a00d..3e875ad 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -931,6 +931,16 @@ config REGULATOR_RT4801
 	  This adds support for voltage regulators in Richtek RT4801 Display Bias IC.
 	  The device supports two regulators (DSVP/DSVN).
 
+config REGULATOR_RT4831
+	tristate "Richtek RT4831 DSV Regulators"
+	depends on MFD_RT4831
+	help
+	  This adds support for voltage regulators in Richtek RT4831.
+	  There are three regulators (VLCM/DSVP/DSVN).
+	  VLCM is a virtual voltage input for DSVP/DSVN inside IC.
+	  And DSVP/DSVN is the real Vout range from 4V to 6.5V.
+	  It's common used to provide the power for the display panel.
+
 config REGULATOR_RT5033
 	tristate "Richtek RT5033 Regulators"
 	depends on MFD_RT5033
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 6ebae51..eb587d4 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -115,6 +115,7 @@ obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
 obj-$(CONFIG_REGULATOR_RN5T618) += rn5t618-regulator.o
 obj-$(CONFIG_REGULATOR_ROHM)	+= rohm-regulator.o
 obj-$(CONFIG_REGULATOR_RT4801)	+= rt4801-regulator.o
+obj-$(CONFIG_REGULATOR_RT4831)	+= rt4831-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
 obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
diff --git a/drivers/regulator/rt4831-regulator.c b/drivers/regulator/rt4831-regulator.c
new file mode 100644
index 00000000..3d4695d
--- /dev/null
+++ b/drivers/regulator/rt4831-regulator.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+
+enum {
+	DSV_OUT_VLCM = 0,
+	DSV_OUT_VPOS,
+	DSV_OUT_VNEG,
+	DSV_OUT_MAX
+};
+
+#define RT4831_REG_DSVEN	0x09
+#define RT4831_REG_VLCM		0x0c
+#define RT4831_REG_VPOS		0x0d
+#define RT4831_REG_VNEG		0x0e
+#define RT4831_REG_FLAGS	0x0f
+
+#define RT4831_VOLT_MASK	GENMASK(5, 0)
+#define RT4831_DSVMODE_SHIFT	5
+#define RT4831_DSVMODE_MASK	GENMASK(7, 5)
+#define RT4831_POSADEN_MASK	BIT(4)
+#define RT4831_NEGADEN_MASK	BIT(3)
+#define RT4831_POSEN_MASK	BIT(2)
+#define RT4831_NEGEN_MASK	BIT(1)
+
+#define RT4831_OTP_MASK		BIT(6)
+#define RT4831_LCMOVP_MASK	BIT(5)
+#define RT4831_VPOSSCP_MASK	BIT(3)
+#define RT4831_VNEGSCP_MASK	BIT(2)
+
+#define DSV_MODE_NORMAL		(0x4 << RT4831_DSVMODE_SHIFT)
+#define DSV_MODE_BYPASS		(0x6 << RT4831_DSVMODE_SHIFT)
+#define STEP_UV			50000
+#define VLCM_MIN_UV		4000000
+#define VLCM_MAX_UV		7150000
+#define VLCM_N_VOLTAGES		((VLCM_MAX_UV - VLCM_MIN_UV) / STEP_UV + 1)
+#define VPN_MIN_UV		4000000
+#define VPN_MAX_UV		6500000
+#define VPN_N_VOLTAGES		((VPN_MAX_UV - VPN_MIN_UV) / STEP_UV + 1)
+
+static int rt4831_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int rid = rdev_get_id(rdev);
+	unsigned int val, events = 0;
+	int ret;
+
+	ret = regmap_read(regmap, RT4831_REG_FLAGS, &val);
+	if (ret)
+		return ret;
+
+	if (val & RT4831_OTP_MASK)
+		events |= REGULATOR_ERROR_OVER_TEMP;
+
+	if (rid == DSV_OUT_VLCM && (val & RT4831_LCMOVP_MASK))
+		events |= REGULATOR_ERROR_OVER_CURRENT;
+
+	if (rid == DSV_OUT_VPOS && (val & RT4831_VPOSSCP_MASK))
+		events |= REGULATOR_ERROR_OVER_CURRENT;
+
+	if (rid == DSV_OUT_VNEG && (val & RT4831_VNEGSCP_MASK))
+		events |= REGULATOR_ERROR_OVER_CURRENT;
+
+	*flags = events;
+	return 0;
+}
+
+static const struct regulator_ops rt4831_dsvlcm_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_bypass = regulator_set_bypass_regmap,
+	.get_bypass = regulator_get_bypass_regmap,
+	.get_error_flags = rt4831_get_error_flags,
+};
+
+static const struct regulator_ops rt4831_dsvpn_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.get_error_flags = rt4831_get_error_flags,
+};
+
+static const struct regulator_desc rt4831_regulator_descs[] = {
+	{
+		.name = "DSVLCM",
+		.ops = &rt4831_dsvlcm_ops,
+		.of_match = of_match_ptr("DSVLCM"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type = REGULATOR_VOLTAGE,
+		.id = DSV_OUT_VLCM,
+		.n_voltages = VLCM_N_VOLTAGES,
+		.min_uV = VLCM_MIN_UV,
+		.uV_step = STEP_UV,
+		.vsel_reg = RT4831_REG_VLCM,
+		.vsel_mask = RT4831_VOLT_MASK,
+		.bypass_reg = RT4831_REG_DSVEN,
+		.bypass_val_on = DSV_MODE_BYPASS,
+		.bypass_val_off = DSV_MODE_NORMAL,
+	},
+	{
+		.name = "DSVP",
+		.ops = &rt4831_dsvpn_ops,
+		.of_match = of_match_ptr("DSVP"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type = REGULATOR_VOLTAGE,
+		.id = DSV_OUT_VPOS,
+		.n_voltages = VPN_N_VOLTAGES,
+		.min_uV = VPN_MIN_UV,
+		.uV_step = STEP_UV,
+		.vsel_reg = RT4831_REG_VPOS,
+		.vsel_mask = RT4831_VOLT_MASK,
+		.enable_reg = RT4831_REG_DSVEN,
+		.enable_mask = RT4831_POSEN_MASK,
+		.active_discharge_reg = RT4831_REG_DSVEN,
+		.active_discharge_mask = RT4831_POSADEN_MASK,
+	},
+	{
+		.name = "DSVN",
+		.ops = &rt4831_dsvpn_ops,
+		.of_match = of_match_ptr("DSVN"),
+		.regulators_node = of_match_ptr("regulators"),
+		.type = REGULATOR_VOLTAGE,
+		.id = DSV_OUT_VNEG,
+		.n_voltages = VPN_N_VOLTAGES,
+		.min_uV = VPN_MIN_UV,
+		.uV_step = STEP_UV,
+		.vsel_reg = RT4831_REG_VNEG,
+		.vsel_mask = RT4831_VOLT_MASK,
+		.enable_reg = RT4831_REG_DSVEN,
+		.enable_mask = RT4831_NEGEN_MASK,
+		.active_discharge_reg = RT4831_REG_DSVEN,
+		.active_discharge_mask = RT4831_NEGADEN_MASK,
+	}
+};
+
+static int rt4831_regulator_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	struct regulator_dev *rdev;
+	struct regulator_config config = {};
+	int i, ret;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (IS_ERR(regmap)) {
+		dev_err(&pdev->dev, "Failed to init regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	/* Configure DSV mode to normal by default */
+	ret = regmap_update_bits(regmap, RT4831_REG_DSVEN, RT4831_DSVMODE_MASK, DSV_MODE_NORMAL);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to configure dsv mode to normal\n");
+		return ret;
+	}
+
+	config.dev = pdev->dev.parent;
+	config.regmap = regmap;
+
+	for (i = 0; i < DSV_OUT_MAX; i++) {
+		rdev = devm_regulator_register(&pdev->dev, rt4831_regulator_descs + i, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "Failed to register %d regulator\n", i);
+			return PTR_ERR(rdev);
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id rt4831_regulator_match[] = {
+	{ "rt4831-regulator", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, rt4831_regulator_match);
+
+static struct platform_driver rt4831_regulator_driver = {
+	.driver = {
+		.name = "rt4831-regulator",
+	},
+	.id_table = rt4831_regulator_match,
+	.probe = rt4831_regulator_probe,
+};
+module_platform_driver(rt4831_regulator_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

