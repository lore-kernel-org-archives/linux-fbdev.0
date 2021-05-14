Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84617C433ED
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 14:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB6B613FB
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 14:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhENONR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 May 2021 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbhENONN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 May 2021 10:13:13 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FF3C06174A;
        Fri, 14 May 2021 07:12:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x8so28819635qkl.2;
        Fri, 14 May 2021 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Jwd1P1JHHf9PFyiIr+/zIkvbqGvzxkc5EOYFoSXG/cc=;
        b=GnfmSUUgE8e3pRIoPt+8zGnFtlQqa4HIXpmlO4vOt/zSkmlSR3ZCUIl6qWQrnimTEt
         YdujpPnu7mL4+XUlaTsqUMyWHIOdozU7pe5SIYy79oVQXDT5SgIVzcjqNlKM45TT2slb
         G+b+nxBqVSA/nyaEYzC8UJKZ+BfFo2fXDEWu+XMc1fg73l4rTQWLDrcjEfRi0NU5uXAE
         wV125438oaRa8bAGpq3jwhgTr+g1Taza7wrs3mFFmaH2lo+E/GiLL8PEUgu/nQuCcSdM
         ihbDObH83jDtfixgpumGgOy2TOY0Gf+EQ8pcO9IwNk1H6vA4WDrpp5Lu7zzi4PR2rWka
         LREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Jwd1P1JHHf9PFyiIr+/zIkvbqGvzxkc5EOYFoSXG/cc=;
        b=NthCfcwPLJTczdMtsgnPrGUBh3R0wNbd3U0MVEUezHFzSuLAsswR46bdM4WqbBbF5k
         GMtXrLkxOo0hLRRQ47rOdPiIWc8fManGBNuSN3jc2pyGj3aUXuClrQAa+XXFOIs+l2n/
         wNK13adfo1+doI5uJ0ImwOjNuhxKwv41IYv96GeUOahsGPvd+ZRUV/1Wx6m4hNYftppm
         881ga0zNeT3SHMji6nOjkAoDwxYYrqI0Nrjtgoc4n4Ok8BiaZu60y/y01UKjwyDvOy97
         8vS9ufQRpC3db42PNTkeQ5ZiGtE1Jeilpi2Clr1VNSKTMnd6KW6USFMch9qOZ2abaP7e
         +vHw==
X-Gm-Message-State: AOAM530LNkIminwzNkGpPilKiNUbdi3eUFEST8TL6jFzgeIBNhpq6r0v
        KJGP4qFe11IZibTVjnqRVgw=
X-Google-Smtp-Source: ABdhPJxerWa6xZdyNiwrGEblWJgWcOVaqKmW+9tecZxGpN4xfZgN08kGafoeC1ivQU7/PrutK6D1Fg==
X-Received: by 2002:a37:6891:: with SMTP id d139mr44052291qkc.466.1621001521243;
        Fri, 14 May 2021 07:12:01 -0700 (PDT)
Received: from ?IPv6:2804:14c:125:811b:fbbc:3360:40c4:fb64? ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.gmail.com with ESMTPSA id g6sm4495207qkm.120.2021.05.14.07.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 07:12:00 -0700 (PDT)
To:     adaplas@hotpop.com, akpm@osdl.org, jsimmons@infradead.org
From:   Igor Torrente <igormtorrente@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Mysterious operations in sysimgblt.c and sysimgblt.c
Message-ID: <027b5b6a-54ea-37e6-7b9f-26f4bad29514@gmail.com>
Date:   Fri, 14 May 2021 11:11:57 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello everybody,

I'm Igor, I'm participating in the Linux kernel mentorship program and 
working to fix some bugs found by the syzbot. I'm currently working on 
this bug below:

https://syzkaller.appspot.com/bug?id=071122e4f772c1ec834c7a6facc0b5058d215481

The bug consists of an out-of-bound access of an vmalloc vector at the 
imageblit function.

At this moment, I'm trying to understand what is happening between the 
IOCTL and the imageblit function. I tried to follow the commit history, 
but even with the entire history, and after reading the code several 
times, I have no clue why some operations are being done. Operations like:

Lines 148 and 177-180: 
https://elixir.bootlin.com/linux/v5.13-rc1/source/drivers/video/fbdev/core/bitblit.c#L148
Lines 251-256: 
https://elixir.bootlin.com/linux/v5.13-rc1/source/drivers/video/fbdev/core/sysimgblt.c#L251
Line 190: 
https://elixir.bootlin.com/linux/v5.13-rc1/source/drivers/video/fbdev/core/sysimgblt.c#L190

Anyone know/remember what these operations are doing?

Thanks for your attention,
---
Igor M. A. Torrente
