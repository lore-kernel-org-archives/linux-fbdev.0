Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D1FC32771
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Sep 2022 14:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiIZO4f (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiIZOz5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Sep 2022 10:55:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC49474E14
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:26:11 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z6so10256376wrq.1
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=X/u3aGJCrbkEF/LSnrxfR5RsWBFDbfL2F5GZoEHQi8Y=;
        b=HFRSaNDSXe/IPWDRdSnalB/Djq1JReM3c5LxDtVPZmVL4Sg3Qto1PqRPhVK/O0+IaV
         FkIkWDniefzUs3O3qL0vC8P6McDxYq+QkZtszEJXQTrnQ3waKQGTMfIqN3e1ezxAgbBz
         YXmAGLouSYiXVQTNPUzVoN1oMdePXpI5ed5nN1lsET+6xuE8C1FxX/rVEfCTnMaYkEz0
         RXd4L7zzJUWOIT9rjRT9L/rKw5qyi6tFx6X/zAfIgXNWEj6LYHDxDG01oiHh9ZOCO+M5
         ZN2wdkX5UaRFpJWASR9vE7BqmT+O4jHbMptqccVV4OSEd+NLRW1slYLYh2A1g8nMXOoj
         zkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=X/u3aGJCrbkEF/LSnrxfR5RsWBFDbfL2F5GZoEHQi8Y=;
        b=MdoXZ58lV2C6lYRgmpGAhNPbc+04WEIPkcrpeuDcICmXNiLSaUT16xM/OK/crdpruH
         pRDHAEdpgU7Yoc3y3TloqErgvpPZqC84UpeR+zEYUenca5N6CrqFa10FEHXWQxuag6sa
         gWTTFvoQv/XECezJ44tM3jo2JHFOoKxMorD5IinCorFqvZonZq5BlJGM1NL9iTpezlKl
         4Q3DtkgGOTT7JX8uwKdaFBqAZlbGTkl08r7YDBp+kHTIijpn5DAKt/i7+j3r+drnxkkI
         zlfLRy/LDFLjUBZbv7GMzJ7EmUYEPKQnhwyBqd0Bkdoe9G9qhpnpTeHioWRa86QBRZX3
         I8EA==
X-Gm-Message-State: ACrzQf1DQf8fcJKlIBKsl9QOYYQkCwD4kydjQRJNt7Cg+UCziTIaUlC9
        O6/tGC2eUCaehSzF+jq7tYWxKw==
X-Google-Smtp-Source: AMsMyM7bdSH4MyMF/cAXzQhTpAYfJdBsDU+kNXp/imo+o4zN/aIMYHRa1VbumeSNQYJ6cILehPuMnw==
X-Received: by 2002:a05:6000:1849:b0:228:c87d:2578 with SMTP id c9-20020a056000184900b00228c87d2578mr13552933wri.274.1664198770388;
        Mon, 26 Sep 2022 06:26:10 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c19cf00b003a2f2bb72d5sm13904956wmq.45.2022.09.26.06.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:26:09 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:26:07 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cgel.zte@gmail.com
Cc:     lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] backlight: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <YzGob83cBFfuxOXQ@maple.lan>
References: <20220923063448.239259-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923063448.239259-1-ye.xingchen@zte.com.cn>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Sep 23, 2022 at 06:34:48AM +0000, cgel.zte@gmail.com wrote:
> Subject: [PATCH linux-next] backlight: use sysfs_emit() to instead of
> scnprintf()
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/video/backlight/lm3533_bl.c | 10 +++++-----

Looks like a good change but the topic tag ('backlight:') looks a bit
generic for something that only impacts the lm3533_bl.c driver.

Also it would be good if this patchset included the same fix
for *all* drivers that a grep shows contain this code pattern
(e.g. git grep 'return scnprintf.*PAGE_SIZE').


Daniel.
