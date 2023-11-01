Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C2CC4167B
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Nov 2023 17:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344700AbjKARU5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Nov 2023 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344639AbjKARU4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Nov 2023 13:20:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BBD122;
        Wed,  1 Nov 2023 10:20:24 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so72699a12.1;
        Wed, 01 Nov 2023 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698859222; x=1699464022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGYRtD14AMjlSx5ypiRtfDyWzdVtTMVzKNvsWe94RrQ=;
        b=D+6hBTUQ1MOnmXz+pdaYDgNhXgi0zXLTmSFRvGLsisQUdi9YsxLgCdYFDYFVYY7Ove
         0ppjej0YC1QB/uQyP8qRlMAohtUTIjzGZdiJ7sHi6njR6ZCVHlZtRfhA44B0oN1GAQh7
         ysZYzlStNJnsExGuuM4/JmB31FT/9i/zsiCFZczcNgT0y8+CbRVVDK930yAoGXCYJ7ve
         HdUfEJkAjuCqNstcxjCZZExtkJoHpC10syTdxkSEx6wSY8vo8/rZftJv9lR1KihI4Ac0
         +hc8yh+6gOzOjqCpPsSg/HGgbG9jptoAMQDQ871bQu19cQ0HShiTqmVhKgBW1sn1lNuv
         OOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859222; x=1699464022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGYRtD14AMjlSx5ypiRtfDyWzdVtTMVzKNvsWe94RrQ=;
        b=nEfvmTA9aiFYcPZ0klcQ9dgTMgOHGx3vZjLjx7OEOFwmsgBICFAmW82XXQWUw8vGZ9
         okh6Tw7/K6oZ6dsxHhcDmodf9a637dfXWD8mckPltuNHeaYilm2yN+gPl/yT3FuzvqJR
         ezoFXo4GbCHi3l28ONQPMAgSnWJQ1I54W/NMD7PNX0vxXtTycKlK8v6xRSETfKW8REaz
         lYBCPYW7PjN7r7ZvVINx0hSRgeEBkC0NYB7OSQmfnd9Vvh88N3M5+dPnyz8brMc/biAn
         UKi4iaEEw1VEx8g3HF/rGx7lvOrR8Kse4jjxg1levQXq7+GwbRmaLIqugbe7m0faoDb4
         jXUQ==
X-Gm-Message-State: AOJu0Yy9NJhaP6zaDINqgtyKNXjZgL0qiDrynDncKHQwqlKx+Qfav7bo
        FnGyd8lyJ5/5voJgcAkkEHk=
X-Google-Smtp-Source: AGHT+IHFwXKaaYWeVmJCz3wFQN72tp9xV/NmWeUU7CNkjV41PW5YpSY0drztYQcuhUhlcfRBUEtxig==
X-Received: by 2002:a50:cc48:0:b0:540:2a8f:806f with SMTP id n8-20020a50cc48000000b005402a8f806fmr2824158edi.3.1698859222149;
        Wed, 01 Nov 2023 10:20:22 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906c31400b00993cc1242d4sm157958ejz.151.2023.11.01.10.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:20:21 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>
Cc:     Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 0/2] fbdev/simplefb: Add missing simple-framebuffer features
Date:   Wed,  1 Nov 2023 18:20:15 +0100
Message-ID: <20231101172017.3872242-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

This contains two patches that bring simplefb up to feature parity with
simpledrm. The patches add support for the "memory-region" property that
provides an alternative to the "reg" property to describe the memory
used for the framebuffer and allow attaching the simple-framebuffer
device to one or more generic power domains to make sure they aren't
turned off during the boot process and take down the display
configuration.

Changes in v2:
- remove unnecessary call to simplefb_detach_genpds() since that's
  already done automatically by devres
- fix crash if power-domains property is missing in DT

Thanks,
Thierry

Thierry Reding (2):
  fbdev/simplefb: Support memory-region property
  fbdev/simplefb: Add support for generic power-domains

 drivers/video/fbdev/simplefb.c | 128 +++++++++++++++++++++++++++++++--
 1 file changed, 123 insertions(+), 5 deletions(-)

-- 
2.42.0

