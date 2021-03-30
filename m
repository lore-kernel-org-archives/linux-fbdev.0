Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC0AC433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Mar 2021 07:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7043B61989
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Mar 2021 07:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhC3HVn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhC3HVQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 30 Mar 2021 03:21:16 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D9CC061762;
        Tue, 30 Mar 2021 00:21:16 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so8982746pjc.2;
        Tue, 30 Mar 2021 00:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6AWbxRR3ovKhPy18pgbZKBcDCZkiPi+DKCTyfvtM7OQ=;
        b=tCQyB5y1N77+8Q36EAUCWIGXIzQF9hYVvqt72xdiMsbKKnFj+ANMSu7P++cPZ44zJ4
         mXE1NTOT5f2y077eiIMW20zimj9W3iogu10R7hnZ2Nk8GeCEp57wlceeNGs8XRicVY0d
         abaUvudh37KQ3MewnpJ1q0pv2Y9BvXIoKR2yfd2HiHjcoEyqeiXZ+FH0av/qHwTGshq0
         AtNxZJUq44ddyvMXg0ug6MXhY0rSNvw7XrbsmTpNG/JviJHCsInHcnMffaB+wbvtPCAE
         JczRuEu2s2nwh3hWLw2ndiZoGxDTYUafMxceogKZlKDCUPjG1BN0zRUdl2AqCwZWsrxE
         IDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6AWbxRR3ovKhPy18pgbZKBcDCZkiPi+DKCTyfvtM7OQ=;
        b=hF05i2C7LuZqqC9zx/KeEvnH17l8FZUfCKGaEaOP+HkLIL15DQIIHQDQcfeoxkF8VH
         I7Pq9d3nZgh9u3gUw7WTOnzAmak196KFLSQEhnpx7yE1o/g4OGsT3TtZOyzsc+QYowR4
         4rMpqFkciXYOEiOS3mAUp/Gfbdk0amIRqUPGa56LVQ/dQkccJjZYF3ViomPIavx3h2d8
         f2wtHGHC6ZHrQ5lSqO58iqVg9aJCUJVeNqf3OodVOKFx7gLF6NoQ1MZG4D8znMcd8/sP
         SCqpHYLvhyYcQe4EcwsqOWqjUYBOZ69SMRjgdrgcGHeQOdzSTkXHK2+kX7+GK6Y/0ZhQ
         fLHg==
X-Gm-Message-State: AOAM530861POG+XdOiYdAFIByyUjU08F3BXZjd/+ldu9CwHOns+9tqdM
        zSNtD+FonlO4+32QhnsNjS0Z63D1do7tvA==
X-Google-Smtp-Source: ABdhPJyDMXJU2SJetxKoq5cxCluKKPwaxsnUPUUHVlYIANFEgi3tRfSOi5Cfg/mZCwFy1GN7I9PBuw==
X-Received: by 2002:a17:90a:eac7:: with SMTP id ev7mr3038224pjb.158.1617088875921;
        Tue, 30 Mar 2021 00:21:15 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id x19sm19449315pfc.152.2021.03.30.00.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:21:15 -0700 (PDT)
Date:   Tue, 30 Mar 2021 15:21:10 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: fix a typo
Message-ID: <20210330152110.0000006c@gmail.com>
In-Reply-To: <YF3bpuh8RVg+3Nx3@kroah.com>
References: <1616763351-7433-1-git-send-email-zhangxuezhi3@gmail.com>
        <YF3bpuh8RVg+3Nx3@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 26 Mar 2021 14:03:34 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 26, 2021 at 08:55:51PM +0800, Carlis wrote:
> > From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> > 
> > Change 'tft' to 'TFT'  
> 
> That says what you did, but not _why_ you did it.
> 
> And this is not a "typo", as it is not misspelled and really is just
> fine as-is.
> 
> thanks,
> 
> greg k-h

Ok,i will undo this patch.

thanks,

Xuezhi Zhang
