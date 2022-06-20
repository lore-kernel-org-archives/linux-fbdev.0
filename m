Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE41FC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 20 Jun 2022 18:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiFTSQx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 20 Jun 2022 14:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242638AbiFTSQu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 20 Jun 2022 14:16:50 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5471A828
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 11:16:50 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id u37so10922105pfg.3
        for <linux-fbdev@vger.kernel.org>; Mon, 20 Jun 2022 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=euNOGFk0CS27OcgLap1u4g4jsXBFkehxJQnnbq86Opo=;
        b=CT/ieEsgy5YbTkv6MhV0bYz5Aajv+zonGBHU/qCj7tSzwFcS34lKPcxJnfnX3tTno8
         8v0kNFDi7PLgoGnOV2OUZkXR9s4pBOKj/5SNqWrEnUkTy3aSogxe5/VIxBaoeo3644Pk
         L38qarylbkDjQ+Lu07cKB0zjCmSQrvdNs321brpSRQ0stEB8oBeHo7fo+6Ri0WZhC7+o
         F3pIw3B9D/hRNbirajD0vD1cBnrqPxLZSbVuJlh8IwJMdiWc51T+d0yVo6Zch9PDJg9T
         0dQAD8s1/H4khHr+O3544Y+CCulzpVFrjPEPOmzkT6GJj0V+7nZGwfq4Vf7wyHNZhejg
         nkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=euNOGFk0CS27OcgLap1u4g4jsXBFkehxJQnnbq86Opo=;
        b=wsFfMRQ/lnN+Ne4l7vf8KD03SyrTAeeX+GQiIoUM7N71Q9WYfGDoShpB1Sv+sFRFrD
         DRMxMjf2YZOuAdtyIgtOTjWJjJF5OZesTZ0IRzxU1TjERk8wwS8yfgNpHG/qeEUV76OU
         dufX/37CBL+3mPALWFxyN554gefxo6Nze2UypRe34SgX0Lv/MYzviVIVxkhgajjWLxkc
         FyYN8Pm6GzaNjxM+vxTYy8ZILS4FAlpN1V+XrfbJ7e/TB8nfXRHisHDS52QsC9s+gzo5
         H8abB2nwrA6Q1YbtnorDMND67MVBZsNKEr9iYmytYcIZmwnx3vE08/5ULiuNkXvM8Sev
         3z8Q==
X-Gm-Message-State: AJIora/fOZvBCeWXH0+CQeJ4EZpgMGBTHZgMk+nRSHhu5Ifub/XoPxe7
        pAncSyRyl3rgSc4CXRYPO9c=
X-Google-Smtp-Source: AGRyM1t7Mx1WwUJFIT4xL+cb7eKv7bMJvjjbyHTHrfT9WDBc+Qu0T1pO8Vas3AjY4AqOv3Az39uXUw==
X-Received: by 2002:a63:68c1:0:b0:408:8699:7be5 with SMTP id d184-20020a6368c1000000b0040886997be5mr22264618pgc.339.1655749009604;
        Mon, 20 Jun 2022 11:16:49 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id qa10-20020a17090b4fca00b001ec9a3e9d4fsm3223039pjb.0.2022.06.20.11.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 11:16:48 -0700 (PDT)
Date:   Mon, 20 Jun 2022 11:16:45 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Message-ID: <20220620181645.GA690780@ubuntu>
References: <20220611192851.GA482606@ubuntu>
 <a12be485-3708-a84f-0120-d6938b322e96@gmx.de>
 <20220620141746.GA688683@ubuntu>
 <8372b659-e964-a82b-b248-0d5654fdc36a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8372b659-e964-a82b-b248-0d5654fdc36a@gmx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thanks for your feedback. :)
