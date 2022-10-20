Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C8C433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 20 Oct 2022 20:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJTUFZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJTUFW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 20 Oct 2022 16:05:22 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40A7E77A4
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Oct 2022 13:05:18 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id u15so893441oie.2
        for <linux-fbdev@vger.kernel.org>; Thu, 20 Oct 2022 13:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3kqzNKZdLHbQGVRoA6TT9TNlPerDzkcvPk08IZ/y3eE=;
        b=QgRBMUtYjUC9XqyTURdHv/HvgeBxWTHGdNW3yw5i54E18RnwalgNO6voNRgpHVoymn
         Rr3v+cufUCg9rPyXPSJvojTtM/CbhjhFkf4uJan4qZAsWdmo+vwWf4E0VhLqOD4Nqvmk
         49y32Xj/dRz3iFsDIfbSH5a7SYH30pDd3EvLqCXwPF9sMAVsZmeLOrY8j1lPCv7PVZY0
         OvGLVk+3vk6xYGt8S1F52V8CBbZAsMNQZ9U8fBh9X5HwjPOx9lULuIugmxS9PbYI+fFE
         ZSoxAbcuwbBR81JOX2lKivhhBWvRdlh+f1WIEQp37O7v+86Ye8uIkB2BClkMpHMJq7c5
         d0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kqzNKZdLHbQGVRoA6TT9TNlPerDzkcvPk08IZ/y3eE=;
        b=rsOYPh2nrx1NmmVN7TDAh19uD1bpuo37VcNs28zs2pzY/14MnzrPiQICUT6f3boIDn
         vYYyxFrmABeHkv8L6pesXgwksqPzKPgqi8oNxSGHm9mIlkucNaTZ99SQmldngw4Wt8aP
         nx4jONehHfQtfNATFxJV4pjx4u3Q/mFY4HufvuEf5Y/z/ITwmCLF8ChJRu/Mk7e4DL7Q
         mSb5t3SZmYYbsPX81Nbv78Fmkj9RilL33OwDltZxR1x2lExyarfKWWGU41Dig20lpaxa
         DXu8qLUTiQHUmmO8VTDX6gnhd4jFjUIrBOCPcBS0YVSWmfv8QLx7LZtG1gWVF8Exk3ag
         Cb7w==
X-Gm-Message-State: ACrzQf177O6QeujIvEoSGRFSsEweL+pRXExsbT2YBvvIxpD/JbbL8gDo
        +qPmnAtApYDNNKhjtDKVIBG6py4IRHY=
X-Google-Smtp-Source: AMsMyM7u4FprY/yjd2wr8bzOxdFQJLyXzS3w3BhmoAK/ZqKp4WX7jH/89I7s++EHag0Dp5i+f7rNyw==
X-Received: by 2002:a17:90a:9381:b0:20a:79b7:766a with SMTP id q1-20020a17090a938100b0020a79b7766amr54627940pjo.33.1666296306582;
        Thu, 20 Oct 2022 13:05:06 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b00172e19c2fa9sm13299061plg.9.2022.10.20.13.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:05:06 -0700 (PDT)
Date:   Thu, 20 Oct 2022 13:05:01 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     steve.glendinning@shawell.net, deller@gmx.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>, yangerkun@huawei.com,
        imv4bel@gmail.com
Subject: Re: Question about patch "fbdev: smscufx: Fix use-after-free in
 ufx_ops_open()"
Message-ID: <20221020200501.GA320135@ubuntu>
References: <363cdfe4-f54d-0ce4-2f03-bcfe998deeef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363cdfe4-f54d-0ce4-2f03-bcfe998deeef@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Dear,


An additional patch has been submitted for the disconnect->open race condition you reported:
https://lore.kernel.org/linux-fbdev/20221020200113.GA320044@ubuntu/T/#u

Thanks for reporting.


Regards,
Hyunwoo Kim.
