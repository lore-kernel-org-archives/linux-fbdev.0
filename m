Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D57C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DCA61A81
	for <linux-fbdev@archiver.kernel.org>; Fri,  1 Oct 2021 14:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354448AbhJAOV7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 1 Oct 2021 10:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354434AbhJAOV6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 1 Oct 2021 10:21:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3D5C061775
        for <linux-fbdev@vger.kernel.org>; Fri,  1 Oct 2021 07:20:14 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v127so7333741wme.5
        for <linux-fbdev@vger.kernel.org>; Fri, 01 Oct 2021 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkvezXZi1fkQu2wSS8sN2XxyukeSXc1Ehs+Ng7L0v2o=;
        b=M37+gLJCudNwkTp3onhQJxl5TOiJ+FpReycB0OQLaRNEuWn1E3vnJuOczX97Uweqru
         jNnu7MsRbuYvB1nlUzf6sJsFOAAo9bxuptxMabl2H3kVl8wZK+HtrbvNaY0K13RLGA7Y
         cjBugFhfb27ajXQKgIhGNCuQS8sVlRR0lj/14pOJOki6xNOn4pdafgoxcNYW1QscNQcx
         KUeg0/EQs2mnzVr/8+sfA8yoYiwArhzRHcUXxmFvpVrn9SR8rEjvqwtygf5HLUutijZF
         aO6aZxd4+9mh5m7MMNgwbBmqEMsmFSG1uz26QSDG6SvB5bowL5YIFS1T1GxGymoPYZBF
         55ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TkvezXZi1fkQu2wSS8sN2XxyukeSXc1Ehs+Ng7L0v2o=;
        b=6IEKIRD43r0zj5RWXfn6Q4OhtNWeq9WDggC0GInlDQLyXN4Xpeyr9F7A6HP4sQRYBR
         VWgTizwu/ZhJX5Mdx+3EaU4LvSZWtcf0AqUDKIeBObTWzkrjQFLOFQMmtcQL+WnerDEi
         Er6iFhm706RY1aM1bmPBHT0VRSwt23gRAfrRz94dN2Q8RuCt4B8233ZUe/hEzf3lLkbe
         4ZmS/zQ1Id6ckZ6rhGVlrDlpS+GE7O2uXwacSyNorAh2fZ2jfgSqSHDGudqdBGMCDzDr
         ycjYulETBuTl9v/eaAXijr6aIl3F4Wwmd4WOuSqEFr5A9H4jHyEi0ceP7PZroqFPD81X
         rCrg==
X-Gm-Message-State: AOAM531W8UlDj91V6JfaaXK6dmARWtrIQ7man5/7n0fW0wE1lUy5Gvrj
        WiFq7g2k28onSICK+eRqiTo1NDmy5OfDHQ==
X-Google-Smtp-Source: ABdhPJzxtZlp1kEw8K9aNJvxGPN2K1mx0SKE8o8iaolaSDtaINwMztEVAHUiLcBZbVwCmCnCJqmBGQ==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr4695246wmj.160.1633098013189;
        Fri, 01 Oct 2021 07:20:13 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d129sm8300815wmd.23.2021.10.01.07.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 07:20:12 -0700 (PDT)
Date:   Fri, 1 Oct 2021 15:20:10 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: hx8357: Add SPI device ID table
Message-ID: <20211001142010.weg4w3doowdsj3ch@maple.lan>
References: <20210922151014.49719-1-broonie@kernel.org>
 <20210927094200.a7d73sl2k4x5xjch@maple.lan>
 <20210927114727.GB4199@sirena.org.uk>
 <20210927132417.lixg3ojhnwlleht3@maple.lan>
 <20210927133055.GD4199@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927133055.GD4199@sirena.org.uk>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 27, 2021 at 02:30:56PM +0100, Mark Brown wrote:
> On Mon, Sep 27, 2021 at 02:24:17PM +0100, Daniel Thompson wrote:
> 
> > In that case what is the point of including unconsumed driver data? Most
> > DT centric drivers that included this for modalias reasons leave it
> > NULL.
> 
> It's mainly there because it's generated fairly mechanically from the OF
> ID table - there's no great reason for it to be there while all
> instantiation is done via DT.

Ok. If there's no plan to change the driver to pick it up from the table then
let's remove the redundant values. They just make it look like somebody forgot
something in the probe method (instead of it being a deliberate choice).


Daniel.
