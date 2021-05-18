Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C25BC433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 01:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C45361396
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 01:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbhERBhJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 17 May 2021 21:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbhERBhG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 17 May 2021 21:37:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9940BC06175F
        for <linux-fbdev@vger.kernel.org>; Mon, 17 May 2021 18:35:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i9so11568245lfe.13
        for <linux-fbdev@vger.kernel.org>; Mon, 17 May 2021 18:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Y4UC937pcRi6mdp2HazCoUPjtNxk9PJkqRxwraum1Y=;
        b=gqVqIx8Ym2P95cU1nEwsXDnOMInJKjvLvl6PdHm+m4USuWxwS7QapJ/4AnjrYoQgjp
         Ul+p1xz0jsBYnf7HxkvT5KEQQnHy9T/2McLKcqfpIWocA0q+0ATrVtMzn0XcOX6uS6dk
         /MUMbUdum0s43SXkfV0oQ3/kVHBjAyHYj0f2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Y4UC937pcRi6mdp2HazCoUPjtNxk9PJkqRxwraum1Y=;
        b=BVU+CabsQpE+iwAy+oAPqjzFgNJSZuCC38Q/c9SrBcgoBk5HCfN7d+zJEpQ2+EEPwM
         0ezl0G/Z+rdBJ4rD6CSYLiNEvOkHlI2qt+iF2RhjRRT97QIad2WbusongA4tfCT/w7NC
         vnilyWhBF3ADOti56V1xHWwfL/6X7m1iJL/yuKqoLaRNn0biYXscIbGnu6X8TDgdJvNr
         DdfT7YNznR4WAD6jPQe0Jpn1MHWOtCmwnnCQVenaitzVhhkVzFmGzu4JqqyVQuc31HG+
         7YRaM1yxAM5hZ3Z99P5LncVj19s0SLTxcGt/XyyJrTGDs4Fo/p4osXuTKtD8pIozePIS
         lDZg==
X-Gm-Message-State: AOAM532ZTgWmo1NIab5aawtJRuxju81Oo2zMwrx0GQUaoniQN84iVT0Z
        BOC8Gf5Vnk/VRvLYxB+TUQrRoQ3Otzl6bCnh
X-Google-Smtp-Source: ABdhPJxJmajOyHnrWnhXeI0XqmldxaOMw6gOf6tMdoQeK61AWvZcSU9BSCPSHJ04WvAubxg0SjNT9g==
X-Received: by 2002:ac2:5687:: with SMTP id 7mr2145045lfr.549.1621301745789;
        Mon, 17 May 2021 18:35:45 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o15sm1271258lfr.257.2021.05.17.18.35.44
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 18:35:45 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id j6so8932862lfr.11
        for <linux-fbdev@vger.kernel.org>; Mon, 17 May 2021 18:35:44 -0700 (PDT)
X-Received: by 2002:a05:6512:36c5:: with SMTP id e5mr2066552lfs.41.1621301740633;
 Mon, 17 May 2021 18:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210518010940.1485417-1-sashal@kernel.org> <20210518010940.1485417-5-sashal@kernel.org>
In-Reply-To: <20210518010940.1485417-5-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 May 2021 18:35:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw9_rp0NYTsCqcGnUkcV5Qgv7FTxADtPrdq4KFmsj+Lg@mail.gmail.com>
Message-ID: <CAHk-=whw9_rp0NYTsCqcGnUkcV5Qgv7FTxADtPrdq4KFmsj+Lg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.12 5/5] tty: vt: always invoke
 vc->vc_sw->con_resize callback
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+1f29e126cf461c4de3b3@syzkaller.appspotmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, May 17, 2021 at 6:09 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>
> [ Upstream commit ffb324e6f874121f7dce5bdae5e05d02baae7269 ]

So I think the commit is fine, and yes, it should be applied to
stable, but it's one of those "there were three different patches in
as many days to fix the problem, and this is the right one, but maybe
stable should hold off for a while to see that there aren't any
problem reports".

I don't think there will be any problems from this, but while the
patch is tiny, it's conceptually quite a big change to something that
people haven't really touched for a long time.

So use your own judgement, but it might be a good idea to wait a week
before backporting this to see if anything screams.

          Linus
