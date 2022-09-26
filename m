Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F92C32771
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Sep 2022 15:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiIZPKj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Sep 2022 11:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiIZPJ5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Sep 2022 11:09:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865D89CC3
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:43:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so4973851wml.5
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Sep 2022 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4Mwz8FKBL/pek88MW/Akc2WY1dOZecC17pSrrx2Q9IE=;
        b=kTRKPUQCLXqb4d2iAz49BYOxe4BfJKfIXFq07cUnAFEHPQDQABF5IExhfE2AIYzzyz
         i6C/7ZIVBYCUv3+AF1QWroFN/7Sq4i60KlQ5mO+1NZ0BfBDsXm+bFyC5UFfak1E0PNMJ
         wTmBaGN4g4u6pdnFcnCFsxhYTypdZv1boBdTZ5i8FAz8H2H+9SvnX4kfzJs/tWQ9g4FZ
         TSliEY4u/Zf1WwgX521qTpKW/fhRxOMwh+XNa7zjHg+NE0eXT2BikZ3CBlO7G9WF0mVw
         V8fpzQ+I/jD9Y/6iT5ZUEYx9QnMfuXxyx2sEJ4+U7rsmPMdABoAP3ZVTHurIhQyqQ4/q
         dWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4Mwz8FKBL/pek88MW/Akc2WY1dOZecC17pSrrx2Q9IE=;
        b=5wOUX3TlUDvXY/NuhPaOo9dh+gLkKybNrIE3lb+etIhdkiumHFVDGSw0gjzcYPdxi3
         uJCsQSJ3FlGT/tgLKyZRc9WRbPpiKweDApjvTgaACN3oWr8G+Y35rfHydyoA43Ymy7Ep
         wcCsNf039LIhpaua5Ttf5VaRy7XtDPUS8uooE67rHzLhrKdhyAZT3DS24t1Z7pUs+lPV
         5ClOQpAIC1YQPvFZOKs2mQMgLUi9RuRrSLzbCJqQvABWwuKXI/rFLnnl2ITR+Nts86Si
         t/3sW5ma+KhlndvvTH6g7C+aEhwjrH5kcNGljQ9kuxd05SabiLmR65Mgz5ujmhHOIlHI
         OuGA==
X-Gm-Message-State: ACrzQf2Q/hSqtFeM2fkDoNh6TMw9VM/j1eZEpQPrGXS2IaiQ2tTbNpT9
        acWBAGDQ5qKTN2hiddVndY0BKA==
X-Google-Smtp-Source: AMsMyM4gKxq/yZ7TV1ieeu8m6Dr+MHG3dSv+57jpVevk1SNLxuAo8X7LvQUEvRNEsuo6CVlNC1kGPw==
X-Received: by 2002:a1c:4b05:0:b0:3b4:90c1:e249 with SMTP id y5-20020a1c4b05000000b003b490c1e249mr22626267wma.201.1664199809608;
        Mon, 26 Sep 2022 06:43:29 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id p21-20020a1c5455000000b003b27f644488sm10888886wmi.29.2022.09.26.06.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 06:43:28 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:43:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linus.walleij@linaro.org, lee@kernel.org
Subject: Re: [PATCH -next] backlight: ktd253: Switch to use dev_err_probe()
 helper
Message-ID: <YzGsf5CSlMB7VvTf@maple.lan>
References: <20220926133525.1107096-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926133525.1107096-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 26, 2022 at 09:35:25PM +0800, Yang Yingliang wrote:
> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.

Please add a SoB and resend.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
