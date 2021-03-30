Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF7EC433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Mar 2021 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B6B661935
	for <linux-fbdev@archiver.kernel.org>; Tue, 30 Mar 2021 07:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhC3HWO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhC3HV5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 30 Mar 2021 03:21:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8A3C061762;
        Tue, 30 Mar 2021 00:21:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v8so5687820plz.10;
        Tue, 30 Mar 2021 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSq6DhHZ17SSR0hD3afvhBzW8Nbjp13pkdoj8e4op4o=;
        b=Wpk7ZHmI24lbm0lREwmt4FgB+PoQmBhscx0Msy4G7nxtg+l5pzG4e/OUjGzo1LSKE7
         FjrgjY0485V1nDXiHKO82Zpetwjrgk8abFAF7Jzb4vkWhaEpLXtzVybFYyyNlJ4XRhHZ
         WPut5FzG7ATtfEcESpmDuNAq0XwNXnR77P0sA2jMJr5C3oZfTBjWd4RXC8qmFE2MgXWX
         H+V2kLeiQpSDDOT7jpbmy4k3/CNdb1siXgwIshCQZERo++4jXZ+xnAyj1D82uHb1vVuC
         kAoNs40VI8nC/eWnmMWrPSEUvvs/1tyh0eFNjlqnHvSjwXYBpuomjcG4mZRlYQbSeFil
         mxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSq6DhHZ17SSR0hD3afvhBzW8Nbjp13pkdoj8e4op4o=;
        b=W+VOl3hR3/Gw6UjB7gonNRGF+oim2re4Ad0HZMyk08bpSgYAdfdOjl3oF0jm6qYqac
         imcYClKgk+rQZJDwqGTe0O0BiFPRAdVpxkcAp7229D/zDA6ROJnc8fS50ryYHUT4iP34
         CWg5q9gsLWp0fyx+qE9wyf6MYapMd1j4IznQTDgTYWNNurAR1EjtUUxrfR0dhFNL5dEZ
         WVyL3WImn/dDZ7hmYhzAiY9etQFNkq/ziCG3i0V0xwr1AeN4utv6i0SCQnM8cwsU8q+O
         DzySgje9sPEsEblyZs5jNmxT+tmgU0o0IhG+6YGffUkaB0kR5oHOWIKX5rG5VKe8CFJq
         Zqqw==
X-Gm-Message-State: AOAM530EJKPO/mJ8aa2ozgbYJ4h3WSfyK9+cOdaU5mPG6pzf4F9Z8YGD
        seoPlUmLpvdWwunSQeRhxTmEb+PKICN24w==
X-Google-Smtp-Source: ABdhPJw7q0qHayC7JzyVW5ZMjugnrrDfPnEQJVDhEmuAyth8iyBCeEU1jHDc8WZ4FOlsl4iQPQphCA==
X-Received: by 2002:a17:90a:a898:: with SMTP id h24mr2962057pjq.9.1617088916998;
        Tue, 30 Mar 2021 00:21:56 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id s19sm19612940pfh.168.2021.03.30.00.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:21:56 -0700 (PDT)
Date:   Tue, 30 Mar 2021 15:21:52 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: change '16 bit' to '16-bit'
Message-ID: <20210330152152.00003f82@gmail.com>
In-Reply-To: <YF3rt28vKzt7CDIh@kroah.com>
References: <1616767770-70063-1-git-send-email-zhangxuezhi3@gmail.com>
        <YF3rt28vKzt7CDIh@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 26 Mar 2021 15:12:07 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 26, 2021 at 10:09:30PM +0800, Carlis wrote:
> > From: "carlis.zhang_cp" <zhangxuezhi1@yulong.com>
> > 
> > Change '16 bit' to '16-bit' for a same style.  
> 
> Why?  This is up to the author.
> 
> > 
> > Signed-off-by: carlis.zhang_cp <zhangxuezhi1@yulong.com>  
> 
> Please use a real name, not an email-alias as a name.
> 
> thanks,
> 
> greg k-h

OK, i will undo this patch

thanks,

Xuezhi Zhang
