Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB18C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 19 Apr 2022 19:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345577AbiDSTYb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 19 Apr 2022 15:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239660AbiDSTYb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 19 Apr 2022 15:24:31 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54BF1263E
        for <linux-fbdev@vger.kernel.org>; Tue, 19 Apr 2022 12:21:46 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 68BED2119F;
        Tue, 19 Apr 2022 19:21:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id DEDDD20F82;
        Tue, 19 Apr 2022 19:21:44 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650396105; a=rsa-sha256;
        cv=none;
        b=Ir5Hab98+53dg6Hlj7tR19dQNsXY0t9YesuMPKllRtdPolktgsqMGio0Wy/J+UygUNQe9a
        v7aGjrdB5cKW7r2hzgYsXmtQ9q2k3n5SEth1HWSa03bndvHnUcvauDZ57DFAe9k22knVXM
        D2ZrF+823oehBvEDrhhFPbo4h+kUI0QeeF3/gA6LfN7p0kgBmdiG/KypThmejWa4UELPkk
        sQZ78se1e+bX+c4GSMcanYzgyho3FMJSoSBIcfLF5aISjuW4J2iY8rzsfwPoN6ApKO9mGs
        O+Tov3lgVujB/ae6GOzaJsnTz9MGk40XE7AzQTHqnC+yX/U5cfAkNtX53ji2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650396105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=sVsng9DLDN55YcF0EyjuXTIIw+v25YZDIwBp8VCD4Kk=;
        b=thfNFP6QfcS39gEn+LxjtcvNgrvyYZEBDfrhDCFsrdg+12GaBImiZeHy+nTF65tZkO9ole
        GBK6ROqSvxq+mFdWu+0l00HEIWaod9aYrat+vlZ0yDNM0e0y2MCAyULzPAYW4TrtwnqWV+
        BNhMx0+kkWc6UBU7em/L1dQIi4invsCwjD+//wGWf+xXIMhnueR3C9B1ShjXxcnTDpoaHu
        Q2kbpKdvUIwnhuV9FcjnCJsAmkBt7DPseiuH6onqBUfTofrwyhu1XH5YwMqFY2rdtTnutD
        Zd1xpYDugMJxNTfjrC/yqxTSwHv1rYGMVWBHyokWANIEQkxaHe/RRH5RNnkqCg==
ARC-Authentication-Results: i=1;
        rspamd-5fd5798557-4qwrk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-Sender-Id: dreamhost|x-authsender|ian@linux.cowan.aero
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.255.147 (trex/6.7.1);
        Tue, 19 Apr 2022 19:21:45 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Chemical-Tangy: 0ad2c9aa2d9bd37c_1650396105193_4083120808
X-MC-Loop-Signature: 1650396105193:2692126077
X-MC-Ingress-Time: 1650396105193
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4KjYZb0vMxz1K3;
        Tue, 19 Apr 2022 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650396103;
        bh=sVsng9DLDN55YcF0EyjuXTIIw+v25YZDIwBp8VCD4Kk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=4k4ye652+roz0yL8ErtX8tPc/VrX59olFJTe8E5ZQ5IkmeAu8zjt0GmQAEJcALJ0w
         7PZehKS6PJpfhAEtq8O+rTwJLlCIgD/JsdHFDj3cTJq7Dj66WKXZwBkPRMmxrfIrql
         OWe7+OCXLCDk6/CuNBsD22nU3LR4a+9VPZ3Oz/+d005yp8zk3xsE7LZ2tlh1TzJJhx
         1jb0Mc8iQdxmOn7GQitem3zNNGqDLSznTQgRJkTgP/PSOFk/dPY13yvFO0ZuwUCDoa
         xtxAubIox73LDhrMWSY9ieLZ6ns05JxkltzpttjlOoWyJSTdyYQ1ZlcborJ+YfuXdB
         Rjl3nUqLkL+Ig==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     gregkh@linuxfoundation.org
Cc:     u.kleine-koenig@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        ian@linux.cowan.aero
Subject: [PATCH] Staging: fbtft: Fix style problem in header
Date:   Tue, 19 Apr 2022 15:21:28 -0400
Message-Id: <20220419192128.445023-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Removed an unnecessary semicolon at the end of a macro call

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/fbtft/fbtft.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 2c2b5f1c1df3..aa66760e1a9c 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -277,7 +277,7 @@ static const struct of_device_id dt_ids[] = {					\
 	{ .compatible = _compatible },						\
 	{},									\
 };										\
-MODULE_DEVICE_TABLE(of, dt_ids);
+MODULE_DEVICE_TABLE(of, dt_ids)
 
 #define FBTFT_SPI_DRIVER(_name, _compatible, _display, _spi_ids)		\
 										\
-- 
2.32.0

