Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2F8C6FA82
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Sep 2022 10:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiI0K5D (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Sep 2022 06:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiI0K4w (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Sep 2022 06:56:52 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4382A9F0CF
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Sep 2022 03:56:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so802059wmb.0
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Sep 2022 03:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1XJBHcRSEVBdxRCScP707zcT8rSQCT7edZ1g0/htxRk=;
        b=pUS7QhQP5cGrbm+nUH5FSnKhNCujyXuMhhShWL/GXe7/y8hsTA2yD0l07pfEilsXwY
         D2E/qI4Hh6MhK8RxYBSvzCtLV6O2KYW/o7xU6lU4JWCVOm3w/VBFvJbNTIUGEX96UNNB
         1zWrZRH1m8NJ2UhncUcZT2dNM6okW/WWR0hrjoobCokk1CLaamCdQdQ30oA3MhvQZ60X
         yuFNEBXrqlXwB438Y2yWklHga0yCObRxSS6cTUWIFXZSxLH8DD2J69EYG5iQ/CHgqnWu
         faCth5OdDcNliBPvC2qWCWGtC/zFTV4wajw+SH9aonyg7Xhl3mq/DVX0eQPZG/Bqo24t
         n9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1XJBHcRSEVBdxRCScP707zcT8rSQCT7edZ1g0/htxRk=;
        b=r/t5cNp2TPst/NP+AZX9xM75c77VIUrVCt0eazne56GGZ7X0p5LWNBo/B+hWmyJVDX
         nxFoj+66ibKND1KkMC40sYOsUO4WzEGCjf+Qyj+VFJNlxZCXWrCEWnZOoo/YOY3Ygfot
         +A2FKy3Tsl0hOw7QRmh7LAJyL+Ym08f3IKJEbwNXUeJcIoFV/pnzwJiA6NXYUBVIfUXM
         fM3A6UNj2bOL2eBziFBjv/cFSVn2rGOq/VXP/8Y6wWowtFDuPTlianQDR556Klvt5sx2
         1jIuuiLoikuzhrkETS+el7Bx6SHYuo8mncsPNT2O+mF14Ds7ubrLgSHaCKRTfmfQStMb
         cGpA==
X-Gm-Message-State: ACrzQf3Gd/CvP9vrzYBmDUhZ1hRLk3p9BKJMnAeuRxA655E9a4EzaXz0
        Gdw/Mms2sSWAiJ60HR/cmoYvNA==
X-Google-Smtp-Source: AMsMyM50bBpGMcDLl8sfoP8lyLAdXtndWpMAyjMfquaKgWaxjFjP7Iq9XI59b7VH2Uz8ITGZgDijBg==
X-Received: by 2002:a05:600c:1d2a:b0:3b4:6e31:92da with SMTP id l42-20020a05600c1d2a00b003b46e3192damr2047894wms.103.1664276206416;
        Tue, 27 Sep 2022 03:56:46 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q12-20020a7bce8c000000b003b5054c6cd2sm15926716wmj.36.2022.09.27.03.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 03:56:45 -0700 (PDT)
Date:   Tue, 27 Sep 2022 11:56:43 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        lee@kernel.org, jingoohan1@gmail.com
Subject: Re: [PATCH -next v3] backlight: gpio_backlight: Switch to use
 dev_err_probe() helper
Message-ID: <YzLW6zo/7k031jzi@maple.lan>
References: <20220927033138.1945842-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927033138.1945842-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Sep 27, 2022 at 11:31:38AM +0800, Yang Yingliang wrote:
> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
