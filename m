Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EB2C07E9D
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Sep 2022 14:57:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiIZO5b (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Sep 2022 10:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiIZO5C (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Sep 2022 10:57:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55297645E
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:27:58 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bq9so10252819wrb.4
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=T7W3vMO9tuQw1ch0loPah1OFffLIuFMRKn5RdUQipcs=;
        b=yfgZBniecjUWpi3bk6V4rQIus/MCIZpz9t4A7SVfoQPg00l0Rk23hmYkPyEaObXEb4
         hErU2p41GocomjtVpFRtLhtaVT/pVCvWai5rb66aecDYLhjdoxtTjhCtiAlyt7d+GoDd
         ExMEssCO5FQeGG9RZtVpGSYpS9DPtffUjQ/gWMr+cXq41hPvghCzcjm/etv6p+RSNuWw
         dJPvz42iGKt7Ja2hRVDorsq9VDPdrWr5fG8bwkuv8zThTLQskIX9o+zoOWF7yyxCXf1w
         Q0eiNduP6bFY3YXQ0VhPbuwyLS6qyewDcnGye4M4V/Dq/FQAy3+iRIehVfaFaI11ezH8
         z2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=T7W3vMO9tuQw1ch0loPah1OFffLIuFMRKn5RdUQipcs=;
        b=t0WpGuy31BMYhom2AjWwnXaexP84SYiCHH6HZmsp6bLD14fqZkAgM/XhfBGB7ajBiF
         VvH05a0RtswDwheYclYzsg8biehhh1zFM3a57rxBoDk6FqQ4WrRW7/aAkRJSyYHP8yic
         skWl0bY75C5l/39XQ6c3BR2IqtWdqxxQVJkx0i/GZ1XW/neFyZu4KJr38qWsEnNlFyjn
         ktoXzAlw4QpW6gC6BsI/N55D9Cy0BUe1fHc6r5bCHJWo6/vWFagdkX6z1ZQCFOeknK+r
         uDkF457RGboIq8TkFmjKbmOTWr66eCTfsCFVQq2Rsa4caK6ZfOO5dE27HWp1EyvGaL7m
         caOg==
X-Gm-Message-State: ACrzQf32tyqKDACYhSWpw0JKzBSBIBo3HHVFRI/LCxZB7UI1WJO5Mrp5
        1Ex4Yq7yQPs3EMdgm0zI+hCkMg==
X-Google-Smtp-Source: AMsMyM44LUAubokNSp9WXwZur0Fu+NrElkwTgpu8o/bVy7gK60y+vIm67nYa43Tnf3t+D7BzAJmGhA==
X-Received: by 2002:a5d:6b09:0:b0:225:37cf:fb8b with SMTP id v9-20020a5d6b09000000b0022537cffb8bmr13370722wrw.179.1664198877330;
        Mon, 26 Sep 2022 06:27:57 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bn27-20020a056000061b00b0022762b0e2a2sm15616002wrb.6.2022.09.26.06.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:27:56 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:27:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cgel.zte@gmail.com
Cc:     lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next] backlight: lp8788: use sysfs_emit() to
 instead of scnprintf()
Message-ID: <YzGo2o3bVLnOiQJr@maple.lan>
References: <20220923063533.239315-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923063533.239315-1-ye.xingchen@zte.com.cn>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Sep 23, 2022 at 06:35:33AM +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the open-code with sysfs_emit() to simplify the code.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/video/backlight/lp8788_bl.c | 2 +-

This one has the subject right and is a good change. However I'd still
prefer it as a single patchset that fixes *all* instances of this code
pattern.


Daniel.
