Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5C5CD6E7B
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Oct 2023 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjJKOiP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbjJKOiO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Oct 2023 10:38:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F49B6
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Oct 2023 07:38:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso2255545a12.0
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Oct 2023 07:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035091; x=1697639891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vZToVsgXRWZfLo5rsOcN+LGMRHmIudHJDej1lZABCM=;
        b=ZPG63Me1VzkVQSeA04ihbbc8+94ix4zYxueN6xhxop6ngCdURSH3udl6wRcOfVGzKe
         oJHUpfPThJcs56Kw+tq3ttQ8/dpTQxEaMWiaQEihKXBIr+7ieBfOpxnG4/VVmr2Fes3/
         G9zvuk4l07VktpGm1o9Il/4TO0Jv9HmGilV7IZCVlIb5KX7wHiVEkK0E9WZ8SSxbvx//
         w09/U6NdZ+ctlY4enartvMqEiV7RQLPDekzX7Bm39YeyTr8hsQjhyX5aWuAQpvop++kj
         mNB0ND1huj4KbWOmUcBAfTKPRtlcu4hUf3HNarHPh327iYGAfKn2gCct3AgDGWbq/RER
         3vEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035091; x=1697639891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vZToVsgXRWZfLo5rsOcN+LGMRHmIudHJDej1lZABCM=;
        b=anZU3SLIqfkhqsOtW3hONS+abSVbVgDC4RdUPlqOpN3lQx5p0EZlr0z7L1oav0/UuD
         c7AHzuz5v2eQnUQTDjniz64XeJpgOEMs7O5MzYv0XHlPNzDyRTmNj29+vJPlJAyw+07c
         pvjdaii3PdSKXm5pfiWZCRUwFsLezmXnQz7LfMgdXxEGWvVugkbtnJDS1H/pDuxOxamF
         hASOq3BqE6yFRfQrzr4EF6uhIuKFqnqhp+ksjRi6Y1+U5KAUyUtCte+Kz1XYKM8CSSif
         hNEb/DoC+RYX+YFrI2y339dBAHsHJUc6yKAMFZE3v9bCVMTzjZaZsoubjIG4UExahNsx
         kW1g==
X-Gm-Message-State: AOJu0YywIRlKgp6P/M3afIeRVkNml6eNJB5+F2cuAI+Z6K9WZyQM081T
        +p1bt/7M5HiDXjdpzzaEhog=
X-Google-Smtp-Source: AGHT+IEgMDBcdZeBV7mjfwI0zrFa57ZIWS69YdUT342bDnOI5fH1lDw2opQoqPAh1K00pWXBJvDyrA==
X-Received: by 2002:a50:fb0c:0:b0:530:8759:a3ac with SMTP id d12-20020a50fb0c000000b005308759a3acmr18356337edq.2.1697035090568;
        Wed, 11 Oct 2023 07:38:10 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id d5-20020aa7ce05000000b005346a263bb1sm8872167edv.63.2023.10.11.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:38:10 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>
Cc:     Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] fbdev/simplefb: Add missing simple-framebuffer features
Date:   Wed, 11 Oct 2023 16:38:07 +0200
Message-ID: <20231011143809.1108034-1-thierry.reding@gmail.com>
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

Thanks,
Thierry

Thierry Reding (2):
  fbdev/simplefb: Support memory-region property
  fbdev/simplefb: Add support for generic power-domains

 drivers/video/fbdev/simplefb.c | 128 +++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 7 deletions(-)

-- 
2.42.0

