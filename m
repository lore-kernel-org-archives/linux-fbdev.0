Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC3C468C16
	for <linux-fbdev@vger.kernel.org>; Mon, 17 Aug 2026 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986514; cv=none; b=E2Wx5/gLMNB2+f7BkQ2ZYeLhRcF8Hfl7XKU4nynwzJ0p0QCx/8IsF9GBAMZiJNb/lRJyYwRakQVcAHFhP9uhrBp/EXRQlMlUq/vA7ne2HjRmGM0glRQt1upWaba7o5AVgaSnqAhDagW0GOrYm8sbLGmVHP+pHtlf6RHUGS+yzSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986514; c=relaxed/simple;
	bh=s+FoGS5WzMdufybgtPfLDGjXb1dO80fzVrSl5HIbp+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYyIbCh1mKYo49nYHXp0QoOblw2YRZ1/ijFnSks7tHb5TnLBYJxvGKYkAekUaLmlZsjF2r0193rkxZJqW3gP9eeAVZz3KJTb1vXgF44Yx5epXVo1API0e4lkTWQEm4yq3zJVK+h6/Zb8utsu/wl7acqgfytT7CWCDt/dJmzbrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=MMomg6G5; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="MMomg6G5"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260817170820f7ebafb646000207bf
        for <linux-fbdev@vger.kernel.org>;
        Mon, 17 Aug 2026 19:08:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XOiQlDaJbPdkiK5caFg2Y3B12sCvby6hBxVy0+YU4PU=;
 b=MMomg6G5b3jiLEw6lPWorL7JT3CQFC/vEm4nI/QPDvPoDDZvCwLbXLnvrwNJjZzRuwQ7Hx
 QghWzTIMUCAGq3z4CiQaI7XvaplbYOFwwEcSVetSyuogru/VKuD3mkzPQOyGjjW2A+GsUGx7
 M0COtTQwbZfk0VBIoc4JThmksT+NljzHxY5JmKZ2X7cIgV7pAAktRO4j3sPp7GIx7GGZGwMW
 fVR1FpQ3HZV2FRLyqlQZqzCNp52KHnlNZz/bAdgZBlVooUWOBO2JG1G95OqNErrje3lohBSq
 saJZ9KUoqu8FZTczYja3GRwLojsZebEHAr1XLljCrezCBNeoP2jTVyNA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Andrew Davis <afd@ti.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH 2/2] leds: lp8864: Register a backlight device
Date: Mon, 17 Aug 2026 19:08:15 +0200
Message-ID: <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The LP8864/LP8866 is a display-cluster LED backlight driver. Expose a
standard backlight class interface in addition to the LED class device,
so it can be used by display/panel stacks that expect a backlight.

Use the new devm_led_backlight_register() helper, which spawns a
led-backlight device driven by our LED and tied to the I2C device
lifetime. This keeps the driver a plain LED driver, requires no
device-tree changes and remains backwards compatible with existing DTs.
It is a no-op when the led-backlight support is not enabled.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/leds/leds-lp8864.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp8864.c b/drivers/leds/leds-lp8864.c
index 204727f2f350e..47896dfc13c11 100644
--- a/drivers/leds/leds-lp8864.c
+++ b/drivers/leds/leds-lp8864.c
@@ -10,6 +10,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/led_bl.h>
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -264,9 +265,9 @@ static int lp8864_probe(struct i2c_client *client)
 
 	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev, &init_data);
 	if (ret)
-		dev_err(&client->dev, "Failed to register LED device (%pe)\n", ERR_PTR(ret));
+		return dev_err_probe(&client->dev, ret, "Failed to register LED device\n");
 
-	return ret;
+	return devm_led_backlight_register(&client->dev, &led->led_dev);
 }
 
 static const struct i2c_device_id lp8864_id[] = {
-- 
2.55.0

