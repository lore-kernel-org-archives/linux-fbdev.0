Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D21C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F30D6138B
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 07:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhDGHPe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhDGHPe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 03:15:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2B1C06174A;
        Wed,  7 Apr 2021 00:15:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t22so5189291pgu.0;
        Wed, 07 Apr 2021 00:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xQE1x5Wlwo0FkTtk1ID3OZqFs74eCdmYBQNxjWcjwgo=;
        b=qcKNudJvXRZGAb6RMTkLyyjO6OXwMsp0WiJOh0k225yb162e+0nVK7PkEXi2HJuEDP
         GnM7NOnF+yIF4f8kD5yIsZIBBux3GJ/t5tWw12Q9TnHb+W027qCYfkToYVss6ms1FTQW
         KVXD/ubqTm9esBiKWYRVnF344XyRhp/DFM7gxtNLE3iW6d9pMWiXScWSeoT+3Qq6nSER
         5pJ/GTCueomOAmDG/d/LaSfX9G/Ub0nKctmBvwDRxs365q9hY2XCxW1BlK23VLQOk9y+
         KF40+Qwh3BiI76aK+Ld1tT4NvvI/SkOVVxTHyynrpPYJPHTgq2LW59t4XEDWa031c/No
         2TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xQE1x5Wlwo0FkTtk1ID3OZqFs74eCdmYBQNxjWcjwgo=;
        b=jYPWDYbtpV7q0nLzJhF7qnn2ChUyRNaDNEtAbDJC293aZj5/90WjZwQCZPd68oE8HA
         zvsgba+BI/rthNL7pNp5POQpvewqBElEf4biQku8ytxsy5G203dlHEPJyWrQUtpRuHjv
         xh/7Mm4mdqhxoM1Esd0XOs64dVNjEwqVeuZD3E/nbDst1MBbOmZVoPX0iWJnExgQNlJk
         B52D5iEmGLKgv2MgQUqvLbaUXoHdbXthanxfJBn8WWYRQ85ExBaxIwP8ma3AkfLwuLuC
         T1j0b1aA994Qzzi29+89+uW1P/imzPWChKaRqpw2yNVEE13H+pD9x5ko6mq0PzjKBKF9
         WiMg==
X-Gm-Message-State: AOAM532bsWGAfwvMkw/0UbV5M4rptwePBQMumP/YlekFAbYZ+oDZ4Jak
        CszKCLvx+Owi5BqsxrUx5qVepM7VUuecnw==
X-Google-Smtp-Source: ABdhPJzoeFNegPROiZUCkPiphoW7Hrg9bxg2xwnfw33qrrc+B6UkpFtMMh4cRXqTW2vUL/vnqOk+Pw==
X-Received: by 2002:a05:6a00:1585:b029:203:6bc9:3ca6 with SMTP id u5-20020a056a001585b02902036bc93ca6mr1658045pfk.79.1617779724531;
        Wed, 07 Apr 2021 00:15:24 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id i7sm19631273pgq.16.2021.04.07.00.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 00:15:24 -0700 (PDT)
Date:   Wed, 7 Apr 2021 00:15:22 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/49] *** SUBJECT HERE ***
Message-ID: <YG1cCtbvINJ52tGT@localhost.localdomain>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <YG1aVx3UuXR2JrC+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1aVx3UuXR2JrC+@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 07, 2021 at 09:08:07AM +0200, Greg KH wrote:
> On Tue, Apr 06, 2021 at 11:35:54PM -0700, Pavle Rohalj wrote:
> > Changes in v2:
> >     - Removed type information from variable names
> >     - Broken up the changes into smaller patches
> 
> Your subject is very odd :(

Sorry about that, I overlooked the fact that I reran format-patch. The
subject should be:

[PATCH] staging: sm750fb: Convert camel case to snake case

Should I resubmit?

-Pavle
