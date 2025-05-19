Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B26284691;
	Mon, 19 May 2025 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747667825; cv=none; b=f2wtyt040RxjghJAiQF6Uz3muwhFVVOZLFSj9okhv6HetBWQ/ciV2qiyEPuQEoQqhkzhFzwdo7k4nY2gabirTEsAvi08TFQy1OXPgRxSWFQ4dM5/I9MlgdED6r2PVl4L9jAEUMH3yXqklJiYfaQkWqhU9WPwcP4kh86YUeiOBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747667825; c=relaxed/simple;
	bh=zkf8O0bw+vc+o28mPlO7IXvrATDPICkFdP+Lo0ulh00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u7nk3RNaznTZKym9KA0WRx77txI8hGpSFodRoIIb2twiUWUO9leHZnAieob7DtAFN4lmKi8NOfPpKkGGFt2zpEJ6l7Z7QHuNYBGI4N5KNXIiQUyFnvYPx+CHQw2svo900lW8kcHLJqD2cZkq6+QnlGZcVUeGKIzL0WGPU7K8SFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hZpI/vpF; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hZpI/vpF"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FF70438E1;
	Mon, 19 May 2025 15:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747667820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=slOxvsQxm/VN4tCHbzdZt/zyw1/DFM663Xlr25p0n4o=;
	b=hZpI/vpFiSjpzplUpgnJMyDNz2gZeYZ6nuW3i9SqeWX7RVSTYBcD2obv1dyuJwfy7Sq/Mn
	DIq5GIN0aGB6+/Avo30qh54kYZ+CRrLjNDP20JtgfKMLzJJwbX5/rw5bImOPV7gmE5GUVk
	WBmczrmK+xSn6JuINnBKj61mO7+yW8ngii0R19727gDhW8JFAYU4kk6iD8x0rFwYraXF04
	9196U2V9ExldWV+GjWRh+8rRFOXFlHa4oN1lZMIWhaOilaKwjsD5R/uVWm6f6dW3dY3N0v
	1YuNF7wfdH9Y9trIy9e0yNnFwKS5uo0i3f/8n7kIrXyyQdpC9+gtoVsNGl2YCA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 19 May 2025 17:16:39 +0200
Subject: [PATCH v5] backlight: led-backlight: add devlink to supplier LEDs
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-led-backlight-add-devlink-to-supplier-class-device-v5-1-76d6fd4aeb2f@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAFZLK2gC/x2NwQrCMBAFf6Xs2YVYEkF/RTzE7LNdGtKSrUUo/
 Xejx2FgZidDVRjdup0qNjWdS4Nw6iiNsQxglcbUuz64cL5yhvAzpinrMK4cRViwZS0TrzPbe1m
 yonLK0exnNIEvguThvPchUgsvFS/9/Kf3x3F8ASI6mIqEAAAA
X-Change-ID: 20250519-led-backlight-add-devlink-to-supplier-class-device-6dec4e04445a
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, 
 Jean-Jacques Hiblot <jjhiblot@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Saravana Kannan <saravanak@google.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddujedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedvueelteffuedthfevvdejffdutdetjedthfffvdehvdelveetkeejjefgjefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedrjeehngdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurhhiqdguv
 ghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepjhhinhhgohhohhgrnhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhonhihsegrthhomhhiuggvrdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopehprghvvghlsehutgifrdgtiidprhgtphhtthhopehjjhhhihgslhhothesthhirdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

led-backlight is a consumer of one or multiple LED class devices, but
devlink is currently unable to create correct supplier-producer links when
the supplier is a class device. One consequence is that removal order is
not correctly enforced.

Issues happen for example with the following sections in a device tree
overlay:

    // An LED driver chip
    pca9632@62 {
        compatible = "nxp,pca9632";
        reg = <0x62>;

	// ...

        addon_led_pwm: led-pwm@3 {
            reg = <3>;
            label = "addon:led:pwm";
        };
    };

    backlight-addon {
        compatible = "led-backlight";
        leds = <&addon_led_pwm>;
        brightness-levels = <255>;
        default-brightness-level = <255>;
    };

On removal of the above overlay, the LED driver can be removed before the
backlight device, resulting in:

    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
    ...
    Call trace:
     led_put+0xe0/0x140
     devm_led_release+0x6c/0x98

Another way to reproduce the bug without any device tree overlays is
unbinding the LED class device (pca9632@62) before unbinding the consumer
(backlight-addon):

  echo 11-0062 >/sys/bus/i2c/drivers/leds-pca963x/unbind
  echo ...backlight-dock >/sys/bus/platform/drivers/led-backlight/unbind

Fix by adding a devlink between the consuming led-backlight device and the
supplying LED device, as other drivers and subsystems do as well.

Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Fixes: ae232e45acf9 ("backlight: add led-backlight driver")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v5:
- separated this patch as a standalone patch
- improved commit message, adding feedback from Alexander
- no code changes

This patch first appeared in the v4 of a longer series, even though the
issue is orthogonal:
https://lore.kernel.org/all/20240917-hotplug-drm-bridge-v4-6-bc4dfee61be6@bootlin.com/
---
 drivers/video/backlight/led_bl.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index d2db157b2c290adc3a159023e9e2394fc877388c..8fe645b5b75447d009e1045dcf0c62d3bbc5425e 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -209,6 +209,19 @@ static int led_bl_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->bl_dev);
 	}
 
+	for (i = 0; i < priv->nb_leds; i++) {
+		struct device_link *link;
+
+		link = device_link_add(&pdev->dev, priv->leds[0]->dev->parent,
+				       DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!link) {
+			dev_err(&pdev->dev, "Failed to add devlink (consumer %s, supplier %s)\n",
+				dev_name(&pdev->dev), dev_name(priv->leds[0]->dev->parent));
+			backlight_device_unregister(priv->bl_dev);
+			return -EINVAL;
+		}
+	}
+
 	for (i = 0; i < priv->nb_leds; i++) {
 		mutex_lock(&priv->leds[i]->led_access);
 		led_sysfs_disable(priv->leds[i]);

---
base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21
change-id: 20250519-led-backlight-add-devlink-to-supplier-class-device-6dec4e04445a

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

