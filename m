Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65587C433DB
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 Mar 2021 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1445261A10
	for <linux-fbdev@archiver.kernel.org>; Thu, 25 Mar 2021 11:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhCYLzG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCYLzD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 25 Mar 2021 07:55:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EC4C06174A
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Mar 2021 04:55:02 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u9so2420914ejj.7
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Mar 2021 04:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rZWmRs5uiiZzbSAbUlT9DJTNuhGAA3GeDnT628NrQ7w=;
        b=BxdtSvV+EZJHW2fk1eKvc8Ht075HnGSovHXfOkT72rSYHXnpbVRQrV3XFwBk5Uz0Ia
         YPTOHsrEV+C/SX8mBa3JTdHvS8+eSGyrq0/hH3s5l1LynwopCgPQznL28ypq95ledDHo
         dU/p7If9ZAEkOdVed9XtTJTg5PESS8Z7xb/xIeziSsGUWraA6H/jNPuB02PNJ03HYtgc
         TdTXg2EHDQQfOEcfw9Q65vrgKdO+atqRmtyT2Ry244nIbWtsg7OOF8J093kK3a3xYflS
         rV1kvTTLdB2kxFQQw+x3Rn69le1RwGPiZFhpBiRqWntzBi5KZmrpQefhTlBQb35DSoQV
         zrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rZWmRs5uiiZzbSAbUlT9DJTNuhGAA3GeDnT628NrQ7w=;
        b=cgoGaFn+CV8pM/cK7TRAeUVwAOQgS5v5T45rX5u3mju4XnqnCwwrlYWP8/eP2aTWFJ
         ADpgMEOz/ob9eF3btuG1MalZNfKkypuqswrfVIiULwDMHLxFF2JRv8tPejqMJA8+d2Nv
         QIVazs/FjpMikbl5fc7Vf6uFrM23xuNn0pPBdwWJFqt00lzfofuQ64hDRC9DF1twelKA
         yfvCJgDbAxQlSbebm5IV1tK+S4dEN0dBgU903PS3QlUdYzKl+eXvngyHfKFD4/pE/cV5
         lUe6AVw0lGVCIAZ/o9QwUOT0+4Ds2PjqdjfykVbWG1MEid1YN2SxyBHP69N63vqQy5cC
         TwhA==
X-Gm-Message-State: AOAM5302bECHUI/CoX4rRlR0PsyJOY2yMuHh0IZfTMymsRr1MwMiYbgq
        RcBTy2ZU6vMPyEO14K91qVoCsg==
X-Google-Smtp-Source: ABdhPJzPE/VIPxB5BtQOm53Z531/3bq0GIn3TATCJb4Fkb0yQXA0yz2x6HTeLa+stD5UMjNVUttscw==
X-Received: by 2002:a17:906:6882:: with SMTP id n2mr8901334ejr.50.1616673301376;
        Thu, 25 Mar 2021 04:55:01 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id q10sm2554598eds.67.2021.03.25.04.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 04:55:00 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:54:59 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Subject: Re: [PATCH v5 5/6] backlight: rt4831: Adds support for Richtek
 RT4831 backlight
Message-ID: <20210325115459.k5lj5wgype5skh57@maple.lan>
References: <1608217244-314-1-git-send-email-u0084500@gmail.com>
 <1608217244-314-5-git-send-email-u0084500@gmail.com>
 <CADiBU38aafx9H1Skz_hHmmkQgCGJSssE1VYBC6WddnGfR3ux1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADiBU38aafx9H1Skz_hHmmkQgCGJSssE1VYBC6WddnGfR3ux1w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Mar 25, 2021 at 04:22:11PM +0800, ChiYuan Huang wrote:
> Dear reviewers:
> 
>            Didn't get any response about this backlight patch.
> Is there any part need to be refined?

Thanks for the reminders and sorry for the delay. Have just replied
to the original message!


Daniel.
