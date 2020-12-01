Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8938C64E7A
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8917A206CA
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 09:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6J/Qqlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgLAJrU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgLAJrU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Dec 2020 04:47:20 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59CBC0613D2
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Dec 2020 01:46:33 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c198so1861178wmd.0
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Dec 2020 01:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yc69n6TYS8s8mnl2FbsGRORIwflmhq2kMj7KnUSbA8k=;
        b=j6J/Qqlfd872o2nRB+YDqXzI7k4zFcKHVgUFc5Ab63Wu7cMN64yIeAnt2k/a/xb53l
         MtWSIH6oUfi68e3zbL4zpM389zXYEFyuieUcGBkf+qtAUlDcQavpVG6qVzsf+NXRByD5
         SGogUzW8o7rpZh2HtMStj7vhHnblQQnpwwdqZRbJoPc7NZDm5/QlYlhroDNSsjpH8tTi
         U0whcFsBzSDBU7mpWG5Fk/ylTYb/IAwZJoztAb4RF4Qvs2byaDeKcdyUGIWwgOLQrrfG
         MP53rZxR6Ttla7TSW7GCFxnPLELTNL5XPtvRwH9sUYXcKTWkUZX2jGE+n5aoNz4WaD+C
         Dlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yc69n6TYS8s8mnl2FbsGRORIwflmhq2kMj7KnUSbA8k=;
        b=Y82R/lyYDDne3Aes80yvrM/K1NJ/dmWyqIKAwKr5Gt4woCifZGNGt8EpxNUy5iv6CH
         5tkXsYI6V6D5CdoDUz5FAO3tmOv3bKqnPD0FrzzKxW6pTqMYfwajohNXzts+zlr19bae
         3bfqGNega67kLypXKPzs+Fk7bL1T864SnWSMPbUvQIlKpEkP+1MOpLDwdg8uxH+S8Hpd
         ZXWdLHFrIQAVzG+4K9lrMxEZlQkWUhKYM9DX9cPSs3qVTnTxgTBpmavX12W8BUctmhJc
         rQT0TcVtZ7g6RPUbjvxOSr7Z5m5JFJvYD0g79V8ObzG67UiAS4INWpl4+DZd4txG9vde
         n18w==
X-Gm-Message-State: AOAM530f+wOFXMUv5vqg1VyA2HoYC5y4/2Fxc0IufWDIlsTKfOdMij8o
        SCxBF5KEiSjqhc6tU6kLD9/Esw==
X-Google-Smtp-Source: ABdhPJz89N1wsgduPoOJWxEC6lffQ1jGcCwQStOOlbZe4E9zySHh35HkIlQMklSS8+ephNH5LixsPQ==
X-Received: by 2002:a1c:55ca:: with SMTP id j193mr1816945wmb.87.1606815992493;
        Tue, 01 Dec 2020 01:46:32 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id v7sm2028079wma.26.2020.12.01.01.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 01:46:31 -0800 (PST)
Date:   Tue, 1 Dec 2020 09:46:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        George Kennedy <george.kennedy@oracle.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 13/28] video: fbdev: riva: Fix kernel-doc and set but
 not used warnings
Message-ID: <20201201094629.GG4801@dell>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-14-sam@ravnborg.org>
 <53f3e91e-d8da-bce6-878c-7842250a7a7c@suse.de>
 <20201130183549.GA1498572@ravnborg.org>
 <20201201084718.GF4801@dell>
 <20201201090745.GA1980788@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201090745.GA1980788@ravnborg.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 01 Dec 2020, Sam Ravnborg wrote:

> Hi Lee,
> 
> > 
> > Cop-out!
> > 
> > Do what I do and make something up (joke)! :'D
> 
> If I thought anyone would actually read the comments then maybe yes.
> But I assume that apart from this thread no-one will read it.
> 
> > 
> > > > Well, it fixes the warning ;)
> > > 
> > > Yeah, I could not dig up anything useful to say here.
> > > Was tempted to just drop all the kernel-doc syntax but that
> > > was a larger change.
> > 
> > Did you trace it from it's origin down to it's final use?
> Yeah, but not something that seemed useful.
> I could have added "translating from pixels->bytes" as they
> are described somewhere else. But I could not convince myself
> this was right so I just silenced the warning.
> 
> The only reason I kept the kernel-doc in the first place is
> that I am told some editors use it.
> 
> The only effect the kernel-doc in fbdev has right now is burning
> effort that could have been spent (better?) somewhere else, and
> I would personally prefer to drop the kernel-doc annotations.
> 
> But I already discussed this in another thread (not fbdev related)
> and I was told it was useful for some, so it is kept.

I personally think they should be kept.  Despite not being referenced
by any kernel-doc:: key-words.  As you say, it can be helpful as an
in-code reference for driver writers, people debugging code, et al.

Not sure I would just repeat the variable name just to silence the
warning though - that is definitely a hack.  In the thousands
(literally!) of these that I've fixed thus far, I haven't needed to do
that.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
