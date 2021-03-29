Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BB7C433DB
	for <linux-fbdev@archiver.kernel.org>; Mon, 29 Mar 2021 10:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 711A261929
	for <linux-fbdev@archiver.kernel.org>; Mon, 29 Mar 2021 10:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhC2K2s (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 29 Mar 2021 06:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhC2K2f (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 29 Mar 2021 06:28:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69FC061756
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Mar 2021 03:28:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so18594812ejj.7
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Mar 2021 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FGsJ4xZ84OyCSAfqZtuaiVtx07XyTMxsRtbJsypRgQ0=;
        b=NsB7szuvnsVvmZr6fMEaieeRGj9x9QaZGqOI73CDo4jA2TR2ZQ4McdBi4nQRDQzHhi
         AQkCCAdeenVeAZy5lpU4yQjrdZkg1D7hFyTtlopJXDJNAxxHhGkeEVwiv5zWsx+dXjTk
         MN6TNGINXyNxNDcmCiRA8s7QEGIeV+QFYCai7Pslj3/Z7/8ws3ZZ1H7qiIJ52UxUrjap
         7F+e0tXM/ofOblfLBvEFqiVkntF7sQy20nlbwn15LNdWbPJ01clWSTka6IqrLXBU0vqy
         ugW9KMTQMjqSw5KSh7Otb/rBxb5LEJBTL29R+4n5pa8bRbmvtYnwpJQ8OEF2pU6Qh/1R
         1nxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FGsJ4xZ84OyCSAfqZtuaiVtx07XyTMxsRtbJsypRgQ0=;
        b=ZILSCFj8FnHOlKAtEC5J8piHQxXeZahsxM+NmZ7w4vp0eYhCE4yLEj3uA09DOpOicI
         llAX93v2ULyrceRD8Gt37jeJ1H1xfPO3TcipNyjbuhx9UMw3HrdXFbAR4kNImxfmj3bA
         kVrtDsU1kdYG65IA3ua5RXLZCAyuEWfSqcXj9MfRwaY3/INlrSAziWLK+rIWxlT09lgk
         oq2qTyvJ7m0F+THocLDg+mVoKMkgZpc+HrGFVOrWz8Ez8lm+i3/Kt0QdLYbmJOtmhaMw
         B9VUatVsGD6v9ICeTt9vAd7FVmYz1i/+ss04CSmHas8BdiwXoTAdZFb5WpwomZbMbbSG
         434w==
X-Gm-Message-State: AOAM531zTrcwuhnhX+UZCONMl5rcy7ZHdCIiZ1KmPa7J/XoGA1JfZuP5
        StmafAhXDwfoFezoGEUR4eHhCg==
X-Google-Smtp-Source: ABdhPJxyRisF2a7DxPDROOeg/GclKMFezzp1ztelOuEDIeJGxlql4tmRUFhVw7fB1msFcAt0U2iUgA==
X-Received: by 2002:a17:907:2d24:: with SMTP id gs36mr27997185ejc.344.1617013713856;
        Mon, 29 Mar 2021 03:28:33 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id r17sm8755121edt.70.2021.03.29.03.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:28:33 -0700 (PDT)
Date:   Mon, 29 Mar 2021 11:28:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        jingoohan1@gmail.com, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v6 2/4] backlight: rt4831: Adds DT binding document for
 Richtek RT4831 backlight
Message-ID: <20210329102831.rwvj46m6db76pp2a@maple.lan>
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <1616945059-8718-2-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616945059-8718-2-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Mar 28, 2021 at 11:24:17PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Adds DT binding document for Richtek RT4831 backlight.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
