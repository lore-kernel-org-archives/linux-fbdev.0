Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682D9C04A95
	for <linux-fbdev@archiver.kernel.org>; Wed, 28 Sep 2022 09:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiI1JLZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 28 Sep 2022 05:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiI1JLS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 28 Sep 2022 05:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F86556F
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Sep 2022 02:11:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0210861DC0
        for <linux-fbdev@vger.kernel.org>; Wed, 28 Sep 2022 09:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AF1C433B5;
        Wed, 28 Sep 2022 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664356271;
        bh=8Ac9VJN6hOMB54pgc7YGs5fVvmhr+G9YDpSL6A6INKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9rMLE75Qeuy2XefhgL+hBKG9WjxQcu7vrQtSKX1f+hELVtlHEzJiTVidCQJ+GbDI
         SmH5RevcaH1zUEahuTe1kWhfbFy8Isecx10Z2aVtp+vnftbXu4U3ZMaj/H8GJ1Pfu3
         GsclsmIdyu3vpgq3tFdKa5YsjtQ8UibA7BchbIvTtXCvS4o3vx5s8QiyXH86G+scuf
         cYDFyn7WSaUSxrEV06K9r/v/bnozMoHOhP86DmrvHQqUAiJSTIFuHjfyaE55mdCaq0
         mgwmAVfuP2kMhu+gJKgH4btCnnumtrGGKRdux9+TDgjpWb1jD/gFnyBKLmWNebPpem
         YLbl1LKn+qPuQ==
Date:   Wed, 28 Sep 2022 10:11:06 +0100
From:   Lee Jones <lee@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jingoohan1@gmail.com
Subject: Re: [PATCH -next v3] backlight: gpio_backlight: Switch to use
 dev_err_probe() helper
Message-ID: <YzQPqjinYYAZdcR+@google.com>
References: <20220927033138.1945842-1-yangyingliang@huawei.com>
 <YzLW6zo/7k031jzi@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzLW6zo/7k031jzi@maple.lan>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 27 Sep 2022, Daniel Thompson wrote:

> On Tue, Sep 27, 2022 at 11:31:38AM +0800, Yang Yingliang wrote:
> > In the probe path, dev_err() can be replaced with dev_err_probe()
> > which will check if error code is -EPROBE_DEFER and prints the
> > error name. It also sets the defer probe reason which can be
> > checked later through debugfs. It's more simple in error path.
> >
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


The original patch is not in my inbox.

Was I missed from the original mail?

-- 
Lee Jones [李琼斯]
