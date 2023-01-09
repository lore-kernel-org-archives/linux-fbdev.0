Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60890C54EBD
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Jan 2023 10:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjAIKS6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjAIKSR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Jan 2023 05:18:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623C0192AD
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 02:17:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso2106258wms.4
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Jan 2023 02:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3sOlEh1WygNZ9VgKuMT1nyO+XwDijk/5Tq8drEBoAk=;
        b=MFsTsxkaZ1UIaBLLEtyfh6RzAoMnlZIPWc2WNX24+naYBw+7xbHepz8S0WIRSWvs1Q
         hFGnYAlOMC9nu7Dq8xrrL4T2gUcRQt0bt83THvKOHhC0DVH6vvLjMs2MAcBw909AJiRS
         qMCN+qyQ6vUnwNU3U1UBVFGfJPTey2337q681pGCUpaC6Inskp054voPJpa9s6Qla3o6
         4w8mPTO5r+A4aMr+Db/R86sLp8lJq3fNYQbV3tiDS9C6kYt5zGgwblJo3f2/zIo6mrC5
         hJy64lNfExzMNmb+xszSBOLj+2gPktUJZXWKdc9QtM36BOQLMe7I3ZOxN8IY0tak096M
         18+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3sOlEh1WygNZ9VgKuMT1nyO+XwDijk/5Tq8drEBoAk=;
        b=ZDhor1y0Bz+hwTlyk8MYnsgfmWIXJH84XPsKE8wShrFEGMcSCgBHuIgvrgnt50V1nz
         23n44WVA4tTTTaKprQFZY5NM1ajkTZ80ReEeZxQbwdeg96S7x95664lsf1Ro/dWHUF1d
         t8XnDWydkd+/gi0KiubbOzYBqFDBjT1gKlFqARvdn7k4W2v4H4HSqiwsS+fWS3OME2zJ
         oMaCgmcmTe/sQwrzcQ+Oq2w2y4mtJXmYd3ZyUGkfbAGrR+U9nFMHfdwu4ipAkwlDjxlP
         gIebFy/vvT+ffr1UCvhjFH5muUikeMmlEQxzVKWCqRXAzGcuWXo7zTbOsEyCkvSYysgV
         +XIQ==
X-Gm-Message-State: AFqh2kpsItCEUr4dDfd9/ZLJ12J6J0v1ChKrGQOH7SAq8YC+PWVRxDGO
        GX1t6IkFQnr0z8UQDZ6EN0O4Mo5o9MqyD37EyiM=
X-Google-Smtp-Source: AMrXdXsqG2Eq26xzrbOkrTahh2oj+h0pui/EEw14ypYWszSZeNLm98tUrOlKsZ9KmBa27ZomvzRi5A==
X-Received: by 2002:a05:600c:a4d:b0:3cf:6e78:e2ca with SMTP id c13-20020a05600c0a4d00b003cf6e78e2camr49520896wmq.5.1673259444880;
        Mon, 09 Jan 2023 02:17:24 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bg23-20020a05600c3c9700b003d1de805de5sm12213442wmb.16.2023.01.09.02.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:17:24 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:17:22 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/4] backlight: ipaq_micro: Use backlight helper
Message-ID: <Y7vpsigT9EUz9FWn@aspen.lan>
References: <20230106164856.1453819-4-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-4-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:54PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

For the tools:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


D.
