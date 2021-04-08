Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB67C433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 09:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381296113A
	for <linux-fbdev@archiver.kernel.org>; Thu,  8 Apr 2021 09:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhDHJRj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 8 Apr 2021 05:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhDHJRi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 8 Apr 2021 05:17:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E3C061760;
        Thu,  8 Apr 2021 02:17:27 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i4so800668pjk.1;
        Thu, 08 Apr 2021 02:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=3mu2tgSjeO8kAVzp1TsCINDeAL4xZ2nSQTlFe4YLtTA=;
        b=Q2DOlAeE25xirlQIVu5MqdlYUXnkzzHice1uOMGrS2vhGvC+fBot5hS5rc7qHxpwhw
         4BcxuXLji6ORs+7mmgdaGq6aB7qPRJ6S4fjoPzPkf4jaOVAodJSwbCrYJfmmCmmhZ8qL
         H9j1jJpHogvqOW/c/Pll/LipELBeyBnf6kpzocrxo8lNe7zPYI40jwuiLdrdhfGtdJ8z
         2E6gSneC9Sxoo+9EoYBhlZnPlj1HeGGtT0MVuHYgx7IEV8WULa1XhCwTdPWGZ/JgrOqX
         0u0crnClnqHZaNx3VN5W4BhOtSmeAm40NoQRPFj0RZka+iaBIIeFrJqbwqYILGN8HItx
         gHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=3mu2tgSjeO8kAVzp1TsCINDeAL4xZ2nSQTlFe4YLtTA=;
        b=XKhySXFsnftPI/w6qUJYBwcm/JXiz8Lkc6+yCaKIkbPzSabs0zUt1xrFqWPKliCRIr
         FuEE7a7x1RGNZT4u4gZuK19v8X6+tr1cI8NWjWV0rtHcpjwxwFSOkfk867iaXITWRZXL
         PNY7djL4XIGEx37/oYw4/AzXBw+D9OvhTGgbaYOsE29uFCwp688wwnKHqCd7Bq5VDfiR
         dZuZ3DdZ1eKHMS2v/iVxYjjdqWxgdSsF7hXKRKdBUCpjM8LdL6uzn3IMXmwRMoF+GtcI
         iKJ8Tli2rZuxJk/RssTgmQwZG8od3nfEPNlacqFoWu9M9CQgfk1CjHal68cqAPJWRmbQ
         bDoA==
X-Gm-Message-State: AOAM5332PYukWcsohJqRJMghU/8KIXlGdk5J8w/2AMbElzsZj8pu12Ei
        nD4kG3Jijoro6CzzkZuN+wudp06F1Ss+6A==
X-Google-Smtp-Source: ABdhPJz6EWrSHYrC3lLKoIkpxc7TxjVAqcqhnexSFarvAreG36tjZCUsesDGdy4iPUCVwyjHEIk0kw==
X-Received: by 2002:a17:90a:890f:: with SMTP id u15mr7369430pjn.25.1617873447113;
        Thu, 08 Apr 2021 02:17:27 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id 12sm23771545pgw.18.2021.04.08.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 02:17:26 -0700 (PDT)
Date:   Thu, 8 Apr 2021 02:17:24 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: sm750fb: Question about dviInit from ddk750_dvi.(c|h)
Message-ID: <YG7KJDoolmQRhZsd@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

I was working on some checkpatch fixes for ddk750_dvi.h and ddk750_dvi.c
when I noticed that dviInit function does not seem to be invoked in any
of the files that belong to this driver and can be removed. Am I missing something?

Thank you,
Pavle
