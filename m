Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A9BC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65A7613B3
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbhDGGgK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345707AbhDGGgH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FDCC06174A;
        Tue,  6 Apr 2021 23:35:58 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d124so3344183pfa.13;
        Tue, 06 Apr 2021 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Kpadh2a52Sny43OWLtjjTywPE6OAtZ2j+jNoMxyDVSw=;
        b=COVHN0e75+tmi1XgiOPsCKXkUbcFba+PUO6pVjrFXU1/aQd8+8NccoFdAhVa4+2V5l
         p4AW2ahIK2qNHexph+yJA931r3n9JSYXVQpNc4EYihBLxFH2nLd3CZ+Ir24eFB9v+UNn
         i5xn+QoOHoPxV3gE3UOSNB5ZHqXF4MER94QtMheXelil7vH59UQNjGfNhYIrYyTiiC+W
         6kWD7GG71UB4pT0jUh4l279VfsQ6xazRgHB6Alvym8WtLI1HTjqB7GixrRGmTCDOfHGD
         MeRlnUWjwjPcdM7s2OOeMw0LOfHGhsz2JvSZXR7wVZj1Gbo9Fgt5rxKU8RC50+/+tKyW
         fZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Kpadh2a52Sny43OWLtjjTywPE6OAtZ2j+jNoMxyDVSw=;
        b=Fa6r2qGHx3HnWOXdSivheyA/oi9iTt/awk7iDvhqCHTOIzVILxEbBl22pfR27NLLIK
         o+WvSKYVrxNHqQaxteEU5yLY2HyWvFMR2lrNMMY+EeiR6a7qhOq6JsM/jG0t/aDhxloK
         ijKylJcsfO8Wm3kHGdt4bsRUeCnLR01qERcMEat+bISdF+gnOUzNawUjckKukMD+m5s9
         yhBMgDc5XIMs6cFA739ljJHKsKHJ0uBwCtAqeQ6PMyrGGoR1BGF/7AUoi5Z5W32yWkie
         DWHA4bEtp4zDDlZIaJhZcFQqnvXAbR9ISthMTqmOszcmwrTZoVZKNmRI08B2sq/yH90G
         LyYQ==
X-Gm-Message-State: AOAM533lzUOCjx5gNeV5bo0KqJ6wAavJB+WcT0IWK1NgA0MOeqwfJw/G
        moObrR39/+VIbXFLX6w5Gpc=
X-Google-Smtp-Source: ABdhPJyYyodEW+gfwmlphycKDQ2ep/z/1vWwxpaAalQ0Toek+O713NOHEYPOigtPIJoKhJk8w36+ug==
X-Received: by 2002:a62:63c7:0:b029:225:7c19:a8f9 with SMTP id x190-20020a6263c70000b02902257c19a8f9mr1689320pfb.39.1617777357588;
        Tue, 06 Apr 2021 23:35:57 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id ot17sm4048352pjb.50.2021.04.06.23.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:35:56 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:35:54 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/49] *** SUBJECT HERE ***
Message-ID: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Changes in v2:
    - Removed type information from variable names
    - Broken up the changes into smaller patches

Pavle Rohalj (49):
  staging: sm750fb: Update dvi_ctrl_device to snake case
  staging: sm750fb: Rename dviInit to dvi_init and update param names
  staging: sm750fb: Update param names of PFN_DVICTRL_INIT function
    pointer
  staging: sm750fb: Remove type names in variables and type definitions
  staging: sm750fb: Remove remaining camel case names in ddk750_dvi.h
  staging: sm750fb: Update displayControlAdjust_SM750LE to snake case
  staging: sm750fb: Update programModeRegisters to snake case
  staging: sm750fb: Update enum values in dpms to snake case
  staging: sm750fb: Rename sm750_set_power_mode function parameter
  staging: sm750fb: Rename ddk750_setModeTiming to
    ddk750_set_mode_timing
  staging: sm750fb: Rename i2cWriteReg and i2cReadReg to snake case
  staging: sm750fb: Rename vendorID local variable to snake case
  staging: sm750fb: Rename deviceID local variable to snake case
  staging: sm750fb: Rename sii164SelectHotPlugDetectionMode to snake
    case
  staging: sm750fb: Rename gDviCtrlChipName to snake case
  staging: sm750fb: Update function parameter names in ddk750_sii164.c
  staging: sm750fb: Rename local variables to snake case
  staging: sm750fb: Rename function params of sii164_init_chip
  staging: sm750fb: Rename function parameter of
    sii164_enable_hot_plug_detection
  staging: sm750fb: Update function parameter names to snake case
  staging: sm750fb: Rename function write_dpPort to snake case
  staging: sm750fb: Update local variable in sm750_hw_copyarea to snake
    case
  staging: sm750fb: Update local variables in sm750_hw_imageblit to
    snake case
  staging: sm750fb: Update local variable in sm750_hw_fillrect to snake
    case
  staging: sm750fb: Rename deGetTransparency to snake case
  staging: sm750fb: Update function parameter of sm750_hw_imageblit to
    snake case
  staging: sm750fb: Rename function params to snake case in
    sm750_accel.h
  staging: sm750fb: Update members of lynx_cursor to snake case
  staging: sm750fb: Rename function sm750_hw_cursor_setSize to snake
    case
  staging: sm750fb: Rename function sm750_hw_cursor_setPos to snake case
  staging: sm750fb: Rename function sm750_hw_cursor_setColor to snake
    case
  staging: sm750fb: Rename function sm750_hw_cursor_setData to snake
    case
  staging: sm750fb: Rename function hw_sm750_crtc_setMode to snake case
  staging: sm750fb: Update members of init_status struct to snake case
  staging: sm750fb: Update members of sm750_dev struct to snake case
  staging: sm750fb: Update members of lynxfb_crtc struct to snake case
  staging: sm750fb: Rename function hw_sm750_output_setMode to snake
    case
  staging: sm750fb: Rename function hw_sm750_setColReg to snake case
  staging: sm750fb: Rename functions *_setBLANK to snake case
  staging: sm750fb: Rename function sm750_hw_cursor_setData2 to snake
    case
  staging: sm750fb: Rename function hw_sm750_initAccel to snake case
  staging: sm750fb: Rename functions *_deWait to snake case
  staging: sm750fb: Update members of lynx_accel struct to snake case
  staging: sm750fb: Rename function hw_sm750_crtc_checkMode to snake
    case
  staging: sm750fb: Rename sii164_set_power function parameter
  staging: sm750fb: Rename local variable Bpp to bpp in sm750.c
  staging: sm750fb: Rename proc_setBLANK member of lynxfb_output struct
  staging: sm750fb: Rename fixId to fix_id
  staging: sm750fb: Update members of sm750_pnltype struct to snake case

 drivers/staging/sm750fb/ddk750_dvi.c    |  32 ++---
 drivers/staging/sm750fb/ddk750_dvi.h    |  80 ++++++-------
 drivers/staging/sm750fb/ddk750_mode.c   |  88 +++++++-------
 drivers/staging/sm750fb/ddk750_mode.h   |   2 +-
 drivers/staging/sm750fb/ddk750_power.h  |  10 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 152 ++++++++++++------------
 drivers/staging/sm750fb/ddk750_sii164.h |  40 +++----
 drivers/staging/sm750fb/sm750.c         | 130 ++++++++++----------
 drivers/staging/sm750fb/sm750.h         |  56 ++++-----
 drivers/staging/sm750fb/sm750_accel.c   | 148 +++++++++++------------
 drivers/staging/sm750fb/sm750_accel.h   |  42 +++----
 drivers/staging/sm750fb/sm750_cursor.c  |  14 +--
 drivers/staging/sm750fb/sm750_cursor.h  |  10 +-
 drivers/staging/sm750fb/sm750_hw.c      |  56 ++++-----
 14 files changed, 430 insertions(+), 430 deletions(-)

-- 
2.30.2

