Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17019C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Dec 2021 21:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239256AbhLAVGu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353341AbhLAVFC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Dec 2021 16:05:02 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BECC06174A
        for <linux-fbdev@vger.kernel.org>; Wed,  1 Dec 2021 13:01:35 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so55128766wrr.8
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Dec 2021 13:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:cc:content-language
         :subject:content-transfer-encoding;
        bh=cwvui+qdm6o4ZBCSGekTkzJQ8eW+ZDFl8qkzfDK7qGs=;
        b=nnni6Cz9XfrpnREjVjJ3qU6idrJQkxJ/izedgQZiwydqcV/yvi1TSe8JbV+ZZwB0vg
         raD7MTVw+DvHc16prhi1HeVDtnZ+ImRbwqGZXeQQBzb2caYcpxDWFbWKdSLuJBpZ/8Rj
         kL4/UzcIF2XPKrArZBYEADnm8HMXijVuPb+7WaWzNBWg3Erw+r3qqrOwV8CK2Dfssye/
         P0RdI8pYEN8if0Ah4IsZe+f8WnbaFW3TGEXBb5WKsdH2ZnPCDbdsnzUKHjI3ZB2Pran/
         nK5sIABvihfVQ5pjGqdCVVS74macaZpbzxHsecDBkZeD3OCGEQ2WcYBW6GouaS8qqsSl
         RTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :cc:content-language:subject:content-transfer-encoding;
        bh=cwvui+qdm6o4ZBCSGekTkzJQ8eW+ZDFl8qkzfDK7qGs=;
        b=q4HE3/nuOz842f5zHjGH+m/zz+kbCXPO4mcFtOBjjUUkOnR6dRl+EVzJ2jgub6efHS
         P76ThFzIhBImFcnOUp6t1lMo8ZbrnkwDPjaDkCZBhl3pWmnRK1fER7XAI8202c9moByO
         Kh39wO5h4pQU53fj/SEDFGLbtdA0/4kAsN4G5CeXDKwdFpv5EMo0CJuA3A1BrwkwTuTE
         ppce2C9VEY4lV+JGEvX6sBhSxuf0BHgZnpSIhs8CGNIrvkONpyo7yxvBvCFrSeWW30IF
         LGG5AdjXasb+Yg6ySmzUUCdeKy1IA2qW81KtYyJfN4gNJUsrlf+bpSqpwm8VUhTeVgeH
         o4Sg==
X-Gm-Message-State: AOAM531UIyQuU2cadOgA4bXlwPk/zj78jgi1aVnuR9EO1sXGLdZmpDiS
        QF3QVc4gLQo2lo/GlKLwvz6Dgrn7gB8=
X-Google-Smtp-Source: ABdhPJwA2PlDRxVgGoDQjj93GVxXQ9ndvQaEeP3vjhUM1LswijOqOb6p3niWW+1ygygaj6qcarOO8w==
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr9423868wrg.433.1638392494414;
        Wed, 01 Dec 2021 13:01:34 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:4055:a69:db9e:1280? (p200300ea8f1a0f0040550a69db9e1280.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:4055:a69:db9e:1280])
        by smtp.googlemail.com with ESMTPSA id y6sm323567wma.37.2021.12.01.13.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:01:33 -0800 (PST)
Message-ID: <773dc6ff-f2b4-4192-a128-c34bd3f5be01@gmail.com>
Date:   Wed, 1 Dec 2021 22:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Content-Language: en-US
Subject: [PATCH v2 0/2] staging: fbtft: add and use macro
 FBTFT_REGISTER_SPI_DRIVER
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

After 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
compatible") we need to add spi id_tables. Changing existing macro
FBTFT_REGISTER_DRIVER would have meant to change arguments and
therefore adjust all fbtft drivers.

This series adds a new and simplified macro FBTFT_REGISTER_SPI_DRIVER
that includes a spi id_table, and in addition to that:
- does not define a platform driver
- uses macro module_spi_driver()

Also the MODULE_ALIASes can be removed.

Works for me with a SH1106-based OLED display incl. module autoload.
For now I changed this driver only because I have hw to test it.

v2:
- consider that spi id_table name consists of device part of compatible string only
- instead of changing the existing macro, add a new one and make fb_sh1106 the first user

Heiner Kallweit (2):
  staging: fbtft: add macro FBTFT_REGISTER_SPI_DRIVER
  staging: fbtft: sh1106: use new macro FBTFT_REGISTER_SPI_DRIVER

 drivers/staging/fbtft/fb_sh1106.c |  7 +-----
 drivers/staging/fbtft/fbtft.h     | 41 +++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.34.1


