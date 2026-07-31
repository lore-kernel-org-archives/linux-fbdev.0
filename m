Received: from mail.elsta.tech (mail.elsta.tech [194.150.96.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BA431A33;
	Fri, 31 Jul 2026 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.150.96.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509128; cv=none; b=F9sD5qDi5x2pttsl7fkSMv+V727B9vIxtp6CfuFngYK/BdxUkljtky7nMirBfdWky6mCuewwlgU6Nh2KFaH7TkU4t66hhllCqa3DGZDcdYa20uwtfxax9WyGePnvb73EKMoeviehdr0VYjaXe65c1zGQ7ZqrH30Gv6dvO71a+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509128; c=relaxed/simple;
	bh=R18v7JlIHSQ+KrVm896Zjr0kQ4ay/qD8VkRuhKMro/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QbI5CpmrRlWppWzJfpyAaSIvfXaOL7PBw3nwX+UujQ1LsPnye1xsyVueAwtaYdvDbFbaXBU7nkDIwM2ZttlRMtKGMs+trVBdJQRTZAUgfBBOcqJ6I2IZBT5PsKiXGcLSCl/+cGGsH2odI7MXezFaqjZfw/sDcckRgElJ+2P3VIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech; spf=pass smtp.mailfrom=elsta.tech; dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b=bg7wJb2i; arc=none smtp.client-ip=194.150.96.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elsta.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elsta.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elsta.tech header.i=@elsta.tech header.b="bg7wJb2i"
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 74E7D8D54A2;
	Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
Authentication-Results: mail.elsta.tech (amavis); dkim=pass (2048-bit key)
 header.d=elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10032) with ESMTP
 id w7PEtwJZ-xWm; Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.elsta.tech (Postfix) with ESMTP id 2D7928D54A3;
	Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.elsta.tech 2D7928D54A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elsta.tech;
	s=0883730E-C77C-11E9-9DA4-0BE9876769AA; t=1785509122;
	bh=VWGYu8llEVF6O3kCw77dF5+/EUISSbsKbqNRvIEkUas=;
	h=From:Date:MIME-Version:Message-Id:To;
	b=bg7wJb2ixNjp0FegeVh4/kBX+FQkTG440ie18LIqcUMsNW7sSl2DXtFqikEC5BbEN
	 6Gp/QfL4lzmg+p6F95qxBvx8POdiVnbca7pzyoIC+UV6mVq12gJH0I5RcAO4CjFH4B
	 pH829CiHy7AOIluFubLoIMSVmiH2B76u3d/9nXd3GTk78IrDy41Yl8HWIUFMUYIaXp
	 YChFHVWOqoOxRBKleFFWLZtcDqHJ6WqOKfunHkR4s+YxFbKXQAyD4EckOOFX4MV+R7
	 DkxD1fcWYaYxkJr4yzWzsSS20ANdzbsVWUU16AAdU403qM83vd0xwPgG9lCqIdRs/I
	 OMG+H+txJz5fQ==
X-Virus-Scanned: amavis at elsta.tech
Received: from mail.elsta.tech ([127.0.0.1])
 by localhost (mail.elsta.tech [127.0.0.1]) (amavis, port 10026) with ESMTP
 id MneSgpB53jwY; Fri, 31 Jul 2026 16:45:22 +0200 (CEST)
Received: from [127.0.1.1] (unknown [172.31.0.125])
	by mail.elsta.tech (Postfix) with ESMTPSA id D98F98D54A0;
	Fri, 31 Jul 2026 16:45:21 +0200 (CEST)
From: Jakub Turek <jakub.turek@elsta.tech>
Date: Fri, 31 Jul 2026 16:45:13 +0200
Subject: [PATCH v2 1/2] fbdev: ssd1307fb: add support for Sino Wealth
 SH1107 controller
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-feat-sh1107-v2-1-0d2893e44ebd@elsta.tech>
References: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
In-Reply-To: <20260731-feat-sh1107-v2-0-0d2893e44ebd@elsta.tech>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jakub Turek <jakub.turek@elsta.tech>
X-Mailer: b4 0.15.2

The SH1107 display controller is very similar to SSD1307 but the main
difference is that SH1107 has different memory layout and uses page mode
adressation only.

The SH1107 relies primarily on vertical page addressing mode where the
internal 128x128 GDDRAM is split into 16 vertical pages, rather than
the horizontal/tile addressing modes natively utilized by the
SSD1306/SSD1307.

Signed-off-by: Jakub Turek <jakub.turek@elsta.tech>
---
 drivers/video/fbdev/ssd1307fb.c | 87 +++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 644b8d97b381..19dc7671fa7a 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -20,6 +20,8 @@
 #define SSD1307FB_DATA			0x40
 #define SSD1307FB_COMMAND		0x80
 
+#define SSD1307FB_PAGE_COL_START_LOW	0x00
+#define SSD1307FB_PAGE_COL_START_HIGH	0x10
 #define SSD1307FB_SET_ADDRESS_MODE	0x20
 #define SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL	(0x00)
 #define SSD1307FB_SET_ADDRESS_MODE_VERTICAL	(0x01)
@@ -54,9 +56,11 @@ struct ssd1307fb_deviceinfo {
 	u32 default_dclk_frq;
 	bool need_pwm;
 	bool need_chargepump;
+	bool page_mode_only;
 };
 
 struct ssd1307fb_par {
+	unsigned page_address_mode : 1;
 	unsigned area_color_enable : 1;
 	unsigned com_invdir : 1;
 	unsigned com_lrremap : 1;
@@ -209,6 +213,34 @@ static int ssd1307fb_set_page_range(struct ssd1307fb_par *par, u8 page_start,
 	return 0;
 }
 
+static int ssd1307fb_set_page_pos(struct ssd1307fb_par *par, u8 page_start,
+				  u8 col_start)
+{
+	int ret;
+	u8 page;
+	u8 col_low;
+	u8 col_high;
+
+	page = SSD1307FB_START_PAGE_ADDRESS | (page_start & 0x0f);
+	col_low = SSD1307FB_PAGE_COL_START_LOW | (col_start & 0x0f);
+	col_high = SSD1307FB_PAGE_COL_START_HIGH |
+		((col_start >> 4) & 0x0f);
+
+	ret = ssd1307fb_write_cmd(par->client, page);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, col_low);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, col_high);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
 				 unsigned int y, unsigned int width,
 				 unsigned int height)
@@ -253,13 +285,15 @@ static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
 	 *  (5) A4 B4 C4 D4 E4 F4 G4 H4
 	 */
 
-	ret = ssd1307fb_set_col_range(par, par->col_offset + x, width);
-	if (ret < 0)
-		goto out_free;
+	if (!par->page_address_mode) {
+		ret = ssd1307fb_set_col_range(par, par->col_offset + x, width);
+		if (ret < 0)
+			goto out_free;
 
-	ret = ssd1307fb_set_page_range(par, par->page_offset + y / 8, pages);
-	if (ret < 0)
-		goto out_free;
+		ret = ssd1307fb_set_page_range(par, par->page_offset + y / 8, pages);
+		if (ret < 0)
+			goto out_free;
+	}
 
 	for (i = y / 8; i < y / 8 + pages; i++) {
 		int m = 8;
@@ -274,13 +308,28 @@ static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
 				u8 byte = vmem[(8 * i + k) * line_length +
 					       j / 8];
 				u8 bit = (byte >> (j % 8)) & 1;
+
 				data |= bit << k;
 			}
 			array->data[array_idx++] = data;
 		}
+
+		if (par->page_address_mode) {
+			ret = ssd1307fb_set_page_pos(par, par->page_offset + i,
+						     par->col_offset + x);
+			if (ret < 0)
+				goto out_free;
+
+			ret = ssd1307fb_write_array(par->client, array, width);
+			if (ret < 0)
+				goto out_free;
+
+			array_idx = 0;
+		}
 	}
 
-	ret = ssd1307fb_write_array(par->client, array, width * pages);
+	if (!par->page_address_mode)
+		ret = ssd1307fb_write_array(par->client, array, width * pages);
 
 out_free:
 	kfree(array);
@@ -483,13 +532,17 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		}
 	}
 
-	/* Switch to horizontal addressing mode */
+	/* Switch to addressing mode */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_ADDRESS_MODE);
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client,
-				  SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
+	if (par->page_address_mode)
+		ret = ssd1307fb_write_cmd(par->client,
+					  SSD1307FB_SET_ADDRESS_MODE_PAGE);
+	else
+		ret = ssd1307fb_write_cmd(par->client,
+					  SSD1307FB_SET_ADDRESS_MODE_HORIZONTAL);
 	if (ret < 0)
 		return ret;
 
@@ -562,6 +615,13 @@ static struct ssd1307fb_deviceinfo ssd1307fb_ssd1309_deviceinfo = {
 	.default_dclk_frq = 10,
 };
 
+static struct ssd1307fb_deviceinfo ssd1307fb_sh1107_deviceinfo = {
+	.default_vcomh = 0x35,
+	.default_dclk_div = 1,
+	.default_dclk_frq = 8,
+	.page_mode_only = 1,
+};
+
 static const struct of_device_id ssd1307fb_of_match[] = {
 	{
 		.compatible = "solomon,ssd1305fb-i2c",
@@ -579,6 +639,10 @@ static const struct of_device_id ssd1307fb_of_match[] = {
 		.compatible = "solomon,ssd1309fb-i2c",
 		.data = (void *)&ssd1307fb_ssd1309_deviceinfo,
 	},
+	{
+		.compatible = "sinowealth,sh1107",
+		.data = (void *)&ssd1307fb_sh1107_deviceinfo,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ssd1307fb_of_match);
@@ -658,6 +722,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 
 	par->contrast = 127;
 	par->vcomh = par->device_info->default_vcomh;
+	par->page_address_mode = par->device_info->page_mode_only;
 
 	/* Setup display timing */
 	if (device_property_read_u32(dev, "solomon,dclk-div", &par->dclk_div))
@@ -678,7 +743,6 @@ static int ssd1307fb_probe(struct i2c_client *client)
 	ssd1307fb_defio = devm_kzalloc(dev, sizeof(*ssd1307fb_defio),
 				       GFP_KERNEL);
 	if (!ssd1307fb_defio) {
-		dev_err(dev, "Couldn't allocate deferred io.\n");
 		ret = -ENOMEM;
 		goto fb_defio_error;
 	}
@@ -788,6 +852,7 @@ static const struct i2c_device_id ssd1307fb_i2c_id[] = {
 	{ .name = "ssd1306fb" },
 	{ .name = "ssd1307fb" },
 	{ .name = "ssd1309fb" },
+	{ .name = "sh1107fb" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssd1307fb_i2c_id);

-- 
2.34.1

