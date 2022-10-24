Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FDAFA3741
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Oct 2022 19:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJXToY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiJXTn5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Oct 2022 15:43:57 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE21D9977
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 11:12:13 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id o64so11637705oib.12
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 11:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPf6G/73Hd0s0zh7PYg5rvhdRmvS3jQjXsc+lqFusyc=;
        b=AjYsHo2Z3OuUUh/xSPbrZpG62ywBnHnF591AZDKwOegtxEIledjNmuHNepuzREYRDi
         XVcv0oz7wzi9YQGB3Ixjk/NmgTOYTp6dsjR8VkRU/J8yMyMWiGwip/FWAf3pQ6q2fLfK
         jydM1OV8dRciJEEHOhmtJxgLm9NHbmS3MkrxRNxlQGa7i2ESkmpTfQ8LB57BBjZ+EAps
         VbcINCU+y/lfvPKv+MVfxR3T+pRl3/mNhnPPg70A2GAg4Z3m43inYvBdDrxmAi+VAEZ9
         aYnmZjgS7+zjirp6LYg0gktRNaQrmSWbx6g5qn7+POzW9sMzmvU0bWUVcxwfwQQqVPiX
         HlcA==
X-Gm-Message-State: ACrzQf3COm+RtuvI8W5fQ9ygmqGqc/zmFQxYvhVkMP8QpsllDjXeln1y
        N5gv8M2XaAoHfjJmaC+u+6bc3xJ6k54Tcf4VLgv+7A==
X-Google-Smtp-Source: AMsMyM4Gm7Aig8YT5fRJeyMGddzfvxxYUrUEmpPq2PCQ/RGA1i1Qlql9jRoJlFidSVPdqq8RCQds4g==
X-Received: by 2002:a17:90a:fe6:b0:212:bfc3:31f5 with SMTP id 93-20020a17090a0fe600b00212bfc331f5mr25482041pjz.215.1666634594766;
        Mon, 24 Oct 2022 11:03:14 -0700 (PDT)
Received: from localhost ([75.172.140.17])
        by smtp.gmail.com with ESMTPSA id mj19-20020a17090b369300b002131a9f8dcbsm1291814pjb.46.2022.10.24.11.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 11:03:14 -0700 (PDT)
From:   Kevin Hilman <khilman@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>, Bin Liu <b-liu@ti.com>,
        Helge Deller <deller@gmx.de>, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/17] ARM: omap1: remove dead code
In-Reply-To: <20221019150410.3851944-14-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-14-arnd@kernel.org>
Date:   Mon, 24 Oct 2022 11:03:13 -0700
Message-ID: <7hbkq1hzfi.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> After the removal of the unused board files, I went through the
> omap1 code to look for code that no longer has any callers
> and remove that.
>
> In particular, support for the omap7xx/omap8xx family is now
> completely unused, so I'm only leaving omap15xx/omap16xx/omap59xx.

Acked-by: Kevin Hilman <khilman@baylibre.com>

with a few tears shed since omap7xx/omap8xx was the first family I
contributed to upstream. :(

Kevin
