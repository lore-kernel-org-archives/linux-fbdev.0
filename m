Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F9C00A89
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 10:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA18E2225E
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 10:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrBvBKgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgKBKwi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgKBKwi (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 05:52:38 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A180C0617A6;
        Mon,  2 Nov 2020 02:52:38 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t14so10475774pgg.1;
        Mon, 02 Nov 2020 02:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tIqjmuSJa/aLDfaBRrGmFrpGnbcflQTqm0uzq8ZOD5s=;
        b=FrBvBKgltnlkrDLjwRMFsHKFW/M/2huDzem/NZ0FwtAtqPL0TPrjBLiVj8xPtGqpQ6
         ATYUKiz/HTWggIs5pJZWqPQ9EDiDeREb+qdRlnFXl6X6paEvBnXBcrtBnx36jFLyGRO2
         DRLpVEi/SoMr1RyIeNKuI2Flvs1Z8ofaZTSqV3mwiljtjvH0NAPDLkJh6PxVB69Xmzbi
         /kwFctycSeRibulQBG1bTYt4hrgIu+Etz383kzjO/eaMhg88MgYE8KrGhQrhpGmjq6Uw
         iF7vgnZiP3WoWh/BJsiu4gHb3Dog63yxs6p4bJjF0QDEhG3skMCz/wKKB4RxzMoCBvvP
         k5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tIqjmuSJa/aLDfaBRrGmFrpGnbcflQTqm0uzq8ZOD5s=;
        b=MfKkBm8Uj52JLY4h+ssdKktAEh6pdOt7GxJ8DRloXRhlQBEOz+5jexNH7yKraEkazT
         ibpmPz/xz4L7cBCrfd0B0OMrc10w3wkuDVpQsI6xPHNiIkg6pNCads8OwR4ODWbrdrrp
         HPfSA77k8sTaWReDjtRMVjNCA6SfXvY4z/EnDXz8PaorTv2SULFPtbM6FrIafe1TVuy0
         xEQj/9N8NDoPsBP+88Hn6w1sch+91zCsT8xzi5VZaeLPJQ/8IAkQMlz7+ODDkR8U2+B3
         MLApoE+kg9I0htE7k1QJ97Ojh9pLV8ilYDOOv3zrLEiMss2lFOKRHOTbvjHHxFGcHCLB
         bjEw==
X-Gm-Message-State: AOAM531iY7MdRJYLEbJHd0QBZwvraUrSvh39EVkWGIOAoBKiZlr7Ra6n
        TjfnDQV2h8wQrOq58bL0SQ==
X-Google-Smtp-Source: ABdhPJybd2NlpBI6FvJ3VYPiHVgRRMnM/xlFcyYk80yOHver3rNSU/1P8ZYga0AGoCb6JANi0TFXmw==
X-Received: by 2002:a62:ddd4:0:b029:155:af54:3000 with SMTP id w203-20020a62ddd40000b0290155af543000mr21301123pff.64.1604314357575;
        Mon, 02 Nov 2020 02:52:37 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id 136sm13802489pfa.132.2020.11.02.02.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:52:36 -0800 (PST)
Date:   Mon, 2 Nov 2020 05:52:28 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] console: Remove dummy con_font_op() callback
 implementations
Message-ID: <20201102105228.GA1558395@PWN>
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
 <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com>
 <a8157089-bc72-c409-c7cc-2fd7eb087ebc@kernel.org>
 <20201102101347.GN401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102101347.GN401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 02, 2020 at 11:13:47AM +0100, Daniel Vetter wrote:
> On Mon, Nov 02, 2020 at 10:47:55AM +0100, Jiri Slaby wrote:
> > On 02. 11. 20, 10:36, Peilin Ye wrote:
> > > `struct console_font` is a UAPI structure, thus ideally should not be
> > > used for kernel internal abstraction. Remove some dummy .con_font_set,
> > > .con_font_default and .con_font_copy `struct consw` callback
> > > implementations, to make it cleaner.
> > 
> > ESEMANTIC_ERROR.
> > 
> > 1) What do you refer to with the last "it"?
> > 
> > 2) What's the purpose of mentioning struct console_font at all?
> > 
> > 3) Could you clarify whether you checked it is safe to remove the hooks?

I see. I will try to elaborate in future patches, thank you!

> > 4) All the hooks now return ENOSYS for both consoles (and not 0). Is this
> > intentional?
> > 
> > I know answers to the first 3 questions, but you need to elaborate a bit in
> > the commit log to connect those sentences. Esp. for people not dealing with
> > the code on a daily basis. Ad 4) I am not sure.
> 
> Yup the behaviour change from 4) needs to be called out. I think this
> should then also be done as part of the large patch series to remove the
> dummy functions from all console drivers.
> 
> I don't expect the errno change to cause trouble, and it's the more honest
> errno - changing fonts not supported is the truth. But if it is, we can
> patch that up appropriately when we get a regression report. That's kinda
> unavoidable with old crufty uapi like this one here.
> 
> Also a bikeshed: Additional information like the patch changelog or
> reasons why you do something is imo best to include in the commit message
> itself. It ends up looking a bit less tidy sometimes, but often there's
> crucial information in these parts that was accidentally left out from the
> commit message.

Sure, I will try to include sufficient information for one to easily
understand what I'm trying to do with a patch. Thank you,

Peilin

