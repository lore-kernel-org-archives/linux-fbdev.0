Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5708C433E0
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A6964E22
	for <linux-fbdev@archiver.kernel.org>; Sun, 31 Jan 2021 20:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhAaUIi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 31 Jan 2021 15:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhAaTqL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 31 Jan 2021 14:46:11 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B15AC061793;
        Sun, 31 Jan 2021 09:31:15 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y10so4410762plk.7;
        Sun, 31 Jan 2021 09:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEuL+hVALlT8knIGIfWrKAZ33sVizOsXkuWP5jla1Js=;
        b=ANSbmVI1xwMVRP1E0zjIWUnQq6BtG0DwLwTiHADYdhlxw+zYHUFBREJvvy1Ftb24W7
         wyXCThnYlwN/wCCjn6aXE1sbHGDpfKlQdGAnjo4OBYMR31sblgGE59ToHFB9zQZCwH+/
         6Ct4bxT1MTB5R+04ZmXaKmt64SSh5yiQ2dw5J420g0LA3Q3ta1PKeWyhNENozGoB1Sbv
         lgs9zi/fY7QXvt1MD1QzlCr54G9o4hwxiS9EoR7jsvu5+ffww09twJrJbikAY8LqrdLt
         FFhCrwiVdkW/mFVkFj9FiN03y1OATjCPUhUJwI5e0UX7dW4MdgGPnSujGAb/fehHbUl+
         GYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEuL+hVALlT8knIGIfWrKAZ33sVizOsXkuWP5jla1Js=;
        b=g6OzSXSc7nTG1etEfzMCrHdL1/wyBlR5giurjuq7SQskiF/49/AM6Q6ow2pV7dtQZP
         g9bwOVE2qafKuqsp4Chhwx1au0KWCI0R3Js58CdmQVSgBF3HXP3xSf/ucGskYgyzXPqZ
         9wexbVPr+MDqDLjKKongnC6SOKlMNy3r0NBe1XKXTckjDY0Tzi5KM9/hzOvtBc59g8kN
         DXD+wK36PyBmIrLcrxpygqLBtBYrFJoUcZTidjXcCQFKn6yicn2quSgn8MXnd7o6cjTR
         /ezL40WkXlSHwAEMrr8I8QkLoyKma9TWxHugTUlxB9MNjZCiHihaHz9ETXYJgNCN6WJT
         HxmQ==
X-Gm-Message-State: AOAM532s8j+N3gPMIcFX0DBD0xLSwJXjMRf+CG8/RZTnFrLs5sX6B/GG
        mqW1K8FT8AtfNO1Vv1Mct4Fq1Kyg2vq1gw==
X-Google-Smtp-Source: ABdhPJwClbOYDSZgU1qyhZKF5sKoWjPX/HRVrzUbA9w6Ly4Wkml4MfQKKspYRwVmGG102CbvmJnvxg==
X-Received: by 2002:a17:902:b116:b029:e1:58b2:2280 with SMTP id q22-20020a170902b116b02900e158b22280mr2028228plr.29.1612114274980;
        Sun, 31 Jan 2021 09:31:14 -0800 (PST)
Received: from localhost ([2402:3a80:11ea:e144:a2a4:c5ff:fe20:7222])
        by smtp.gmail.com with ESMTPSA id r194sm14995355pfr.168.2021.01.31.09.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 09:31:14 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        William Cohen <wcohen@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rric@kernel.org>, greybus-dev@lists.linaro.org,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH 02/13] staging: greybus: Switch from strlcpy to strscpy
Date:   Sun, 31 Jan 2021 22:58:23 +0530
Message-Id: <20210131172838.146706-3-memxor@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210131172838.146706-1-memxor@gmail.com>
References: <20210131172838.146706-1-memxor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

strlcpy is marked as deprecated in Documentation/process/deprecated.rst,
and there is no functional difference when the caller expects truncation
(when not checking the return value). strscpy is relatively better as it
also avoids scanning the whole source string.

This silences the related checkpatch warnings from:
5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 drivers/staging/greybus/audio_helper.c   | 2 +-
 drivers/staging/greybus/audio_module.c   | 2 +-
 drivers/staging/greybus/audio_topology.c | 6 +++---
 drivers/staging/greybus/power_supply.c   | 2 +-
 drivers/staging/greybus/spilib.c         | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/greybus/audio_helper.c b/drivers/staging/greybus/audio_helper.c
index 3011b8abc..1ed4772d2 100644
--- a/drivers/staging/greybus/audio_helper.c
+++ b/drivers/staging/greybus/audio_helper.c
@@ -166,7 +166,7 @@ static int gbaudio_remove_controls(struct snd_card *card, struct device *dev,
 			snprintf(id.name, sizeof(id.name), "%s %s", prefix,
 				 control->name);
 		else
-			strlcpy(id.name, control->name, sizeof(id.name));
+			strscpy(id.name, control->name, sizeof(id.name));
 		id.numid = 0;
 		id.iface = control->iface;
 		id.device = control->device;
diff --git a/drivers/staging/greybus/audio_module.c b/drivers/staging/greybus/audio_module.c
index a243d60f0..0f9fdc077 100644
--- a/drivers/staging/greybus/audio_module.c
+++ b/drivers/staging/greybus/audio_module.c
@@ -342,7 +342,7 @@ static int gb_audio_probe(struct gb_bundle *bundle,
 	/* inform above layer for uevent */
 	dev_dbg(dev, "Inform set_event:%d to above layer\n", 1);
 	/* prepare for the audio manager */
-	strlcpy(desc.name, gbmodule->name, GB_AUDIO_MANAGER_MODULE_NAME_LEN);
+	strscpy(desc.name, gbmodule->name, GB_AUDIO_MANAGER_MODULE_NAME_LEN);
 	desc.vid = 2; /* todo */
 	desc.pid = 3; /* todo */
 	desc.intf_id = gbmodule->dev_id;
diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 662e3e8b4..e816e4db5 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -200,7 +200,7 @@ static int gbcodec_mixer_ctl_info(struct snd_kcontrol *kcontrol,
 			return -EINVAL;
 		name = gbaudio_map_controlid(module, data->ctl_id,
 					     uinfo->value.enumerated.item);
-		strlcpy(uinfo->value.enumerated.name, name, NAME_SIZE);
+		strscpy(uinfo->value.enumerated.name, name, NAME_SIZE);
 		break;
 	default:
 		dev_err(comp->dev, "Invalid type: %d for %s:kcontrol\n",
@@ -1047,7 +1047,7 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
 	}
 
 	/* Prefix dev_id to widget control_name */
-	strlcpy(temp_name, w->name, NAME_SIZE);
+	strscpy(temp_name, w->name, NAME_SIZE);
 	snprintf(w->name, NAME_SIZE, "GB %d %s", module->dev_id, temp_name);
 
 	switch (w->type) {
@@ -1169,7 +1169,7 @@ static int gbaudio_tplg_process_kcontrols(struct gbaudio_module_info *module,
 		}
 		control->id = curr->id;
 		/* Prefix dev_id to widget_name */
-		strlcpy(temp_name, curr->name, NAME_SIZE);
+		strscpy(temp_name, curr->name, NAME_SIZE);
 		snprintf(curr->name, NAME_SIZE, "GB %d %s", module->dev_id,
 			 temp_name);
 		control->name = curr->name;
diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/greybus/power_supply.c
index ec96f2888..75cb170e0 100644
--- a/drivers/staging/greybus/power_supply.c
+++ b/drivers/staging/greybus/power_supply.c
@@ -449,7 +449,7 @@ static int __gb_power_supply_set_name(char *init_name, char *name, size_t len)
 
 	if (!strlen(init_name))
 		init_name = "gb_power_supply";
-	strlcpy(name, init_name, len);
+	strscpy(name, init_name, len);
 
 	while ((ret < len) && (psy = power_supply_get_by_name(name))) {
 		power_supply_put(psy);
diff --git a/drivers/staging/greybus/spilib.c b/drivers/staging/greybus/spilib.c
index fc27c52de..672d540d3 100644
--- a/drivers/staging/greybus/spilib.c
+++ b/drivers/staging/greybus/spilib.c
@@ -455,10 +455,10 @@ static int gb_spi_setup_device(struct gb_spilib *spi, u8 cs)
 	dev_type = response.device_type;
 
 	if (dev_type == GB_SPI_SPI_DEV)
-		strlcpy(spi_board.modalias, "spidev",
+		strscpy(spi_board.modalias, "spidev",
 			sizeof(spi_board.modalias));
 	else if (dev_type == GB_SPI_SPI_NOR)
-		strlcpy(spi_board.modalias, "spi-nor",
+		strscpy(spi_board.modalias, "spi-nor",
 			sizeof(spi_board.modalias));
 	else if (dev_type == GB_SPI_SPI_MODALIAS)
 		memcpy(spi_board.modalias, response.name,
-- 
2.29.2

