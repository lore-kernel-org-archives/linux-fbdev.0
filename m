Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA747C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDBF214D8
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbhAMUK2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbhAMUK2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 15:10:28 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED215C061575;
        Wed, 13 Jan 2021 12:09:47 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x126so1921443pfc.7;
        Wed, 13 Jan 2021 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=quEGMWpqr7/pNxdPiyN4UcKEYv34p2VMMn6TPSnLeRE=;
        b=huCcpMVXEfvnePLTSbMMyOnX4xJY9798nkfPZB4CTpCDdZG25t7v5T649T6VFkyr8q
         o5gm2R2OeStmg1cqAbWN1zg1yLsNKPi2jFiFJEjAeWqxXMvmGM6cXKbyrqy6NXXVspcp
         7qrBcZtlwZ704Z4IOyArXiJtLxjWLydZhS30MTbSbmIbeIZ9g5pos5ISnOkQUBBRO+NF
         9W1c9ckgWFTKVRndFv8KBej7e4nzS1Gt+1edTyJ543Am9JrCpni3bwsdn6j5hZpCgePK
         KTzpswu9AI4mPZtPp+JtBn3L5+pu0F85uJQqearmeQDMmmFWgSZUsuVTBW5ClMfOaqBr
         L/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=quEGMWpqr7/pNxdPiyN4UcKEYv34p2VMMn6TPSnLeRE=;
        b=HlOu2fZHFsz95gmCVqiMVwa+qau3ezAbAjDnSKgyCnhORLBk5guZ84ZuAyVWkIIg70
         FiKEaBl6VOS5Ae4Ptor+/JKRlmahKZ0Jhwfm77xHIdDJiVRRpGX07V2G5GoG5tTMCOwX
         TAZnMKhlIr3sheWBDeSwfCWuIOzj2TBzjNpyfs1xPUivkWyeX+LMUd5bhph4RSFyL9GB
         O6DFzBdQ9G67TAU8vsGtr5ELFbDVdg9gIaPJro4mCop4BTWrkA5CnLeyqCWuxjARJ7s/
         wrDE2BJkxgG4GgyN31mkgovKtTIs3neTQ1B5VViNqvWcxiCD6MBkSm5fH6BGCNggQG+F
         xVkg==
X-Gm-Message-State: AOAM532ZPQ+gHgjW67ekkK5MJ37+9CNkfZiJpiEZDUYgYWPeyJDhrj1M
        J4jol5zkK/JPoI9qaf0vmHq+aUXg1dDNQQ==
X-Google-Smtp-Source: ABdhPJwaRhjR6HWEFrwrnlZ65nwyNXiah21tWRAzbtXIE5YdP4RTqA8f2J1+UuDCwV/bBuRpKc6RfA==
X-Received: by 2002:a63:5a08:: with SMTP id o8mr3696381pgb.118.1610568587568;
        Wed, 13 Jan 2021 12:09:47 -0800 (PST)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id 8sm3174055pfz.93.2021.01.13.12.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2021 12:09:46 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 30/31] video: fbdev: s3c-fb: Remove unused variable 'var'
 from 's3c_fb_probe_win()'
Thread-Topic: [PATCH 30/31] video: fbdev: s3c-fb: Remove unused variable 'var'
 from 's3c_fb_probe_win()'
Thread-Index: AQHW6buC2l9DKORK3kqz2CrpGhFdF6ol/JYr
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Wed, 13 Jan 2021 20:09:42 +0000
Message-ID: <SLXP216MB047735F322B9D2040903217FAAA90@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
 <20210113145009.1272040-31-lee.jones@linaro.org>
In-Reply-To: <20210113145009.1272040-31-lee.jones@linaro.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/13/21, 9:50 AM, Lee Jones wrote:
>=20
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/video/fbdev/s3c-fb.c: In function =91s3c_fb_probe_win=92:
>  drivers/video/fbdev/s3c-fb.c:1176:28: warning: variable =91var=92 set bu=
t not used [-Wunused-but-set-variable]
>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Ben Dooks <ben@simtec.co.uk>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/fbdev/s3c-fb.c | 2 --
>  1 file changed, 2 deletions(-)

[...]

