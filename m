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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11232C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 20:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AC220936
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 20:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbhAMUIp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 15:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbhAMUIp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 15:08:45 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7D5C061575;
        Wed, 13 Jan 2021 12:08:04 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 15so2191760pgx.7;
        Wed, 13 Jan 2021 12:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=GvAOHyyN5kCSb4kRh6kQZkCrsdblAjjT4mfEiQcMWjs=;
        b=SRJDpTRoOnc/55yeZuX62rE09EfROrumcVxGsSu+cxj0OXOTsnzWramLoXqRGB8eCM
         Cr0sG6Nwerih/HfQSGX7qRIkN9AdkSQWoWDfusKgi7Di2QhGR7JY59FP0rea+YUAFShu
         POVeQWkvW+Lc/HJkTEBmPTZruw849rQIXeHQUfBQ1OIUjrh3p8GWeysJR2gNQG5kqZMG
         VhGoJ3lr3UkhxHOpCmuNHhirbAyYsIt4NWbQnGhdS0xOjGPIk/klKBT0FWjjVWtI9lRi
         LKP8AO1Y9BfQmTNDqOADZ5jCHoM5k0ICtR5UzKABdqDq+sFz3mu0zkLx0gD1dyHBFVHS
         M/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=GvAOHyyN5kCSb4kRh6kQZkCrsdblAjjT4mfEiQcMWjs=;
        b=tvyt++0l3ygo710SlZm8hK/cQR8/+z9HSa0+rUmLZx8mVhIQokH9gVQMtgtCAhuwkP
         L8tsmDkgOksMUBrOwwd4fgIWE3pyDnKSUCGJ2uUPjTaU2SUJt53lI8VTyfTqgzOIOe/M
         WDnqZQEZZ9gJt5txttBgxfcDabmQbb59hdQFaxdFrNzxAxxOHZTasl2MRuqxADbZ9DUk
         PmHs6zF9HBCj7WvyFOeTF3jYMKyO+iJbm/EATPtpyCGVVo7rznclsolnvZ8IabwnHwIl
         U8HjVwCGIxgkebHplkGSCmVns0z75OejQv9eRBuKlT0fUb+62hG5rjvTJNJqjmiGTPDX
         KQGw==
X-Gm-Message-State: AOAM532g9oqJ4DCOUqkYen2JeUvxOd75YA1ptpYgeh+uIDFxBAgcP/D7
        8cF21xlj2SrsfWB8ToJIfAY=
X-Google-Smtp-Source: ABdhPJz4GNVsIV8HRuAtlYRKV33MLDu80l1S3JbtW2/aUF32mW/+4BeeISwnc8RFWx7VccbvU31UXg==
X-Received: by 2002:a62:2946:0:b029:19e:6b80:669a with SMTP id p67-20020a6229460000b029019e6b80669amr4023104pfp.42.1610568484351;
        Wed, 13 Jan 2021 12:08:04 -0800 (PST)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id x12sm3417591pfj.25.2021.01.13.12.08.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jan 2021 12:08:03 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH 24/31] video: fbdev: s3c-fb: Fix some kernel-doc
 misdemeanours
Thread-Topic: [PATCH 24/31] video: fbdev: s3c-fb: Fix some kernel-doc
 misdemeanours
Thread-Index: AQHW6buCNbupbwFtTUu1nVILhje9oaol/Bqf
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Wed, 13 Jan 2021 20:07:58 +0000
Message-ID: <SLXP216MB0477F22596BA2B6AB34CDF45AAA90@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
 <20210113145009.1272040-25-lee.jones@linaro.org>
In-Reply-To: <20210113145009.1272040-25-lee.jones@linaro.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/13/21, 9:50 AM, Lee Jones wrote:
>=20
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/video/fbdev/s3c-fb.c:104: warning: Function parameter or member =
'osd_stride' not described in 's3c_fb_variant'
>  drivers/video/fbdev/s3c-fb.c:174: warning: Function parameter or member =
'variant' not described in 's3c_fb_win'
>  drivers/video/fbdev/s3c-fb.c:345: warning: Function parameter or member =
'pixclk' not described in 's3c_fb_calc_pixclk'
>  drivers/video/fbdev/s3c-fb.c:345: warning: Excess function parameter 'pi=
xclock' description in 's3c_fb_calc_pixclk'
>  drivers/video/fbdev/s3c-fb.c:742: warning: Function parameter or member =
'transp' not described in 's3c_fb_setcolreg'
>  drivers/video/fbdev/s3c-fb.c:742: warning: Excess function parameter 'tr=
ans' description in 's3c_fb_setcolreg'
>  drivers/video/fbdev/s3c-fb.c:1142: warning: Function parameter or member=
 'sfb' not described in 's3c_fb_release_win'
>  drivers/video/fbdev/s3c-fb.c:1172: warning: Function parameter or member=
 'win_no' not described in 's3c_fb_probe_win'
>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Thank you.

> Cc: Ben Dooks <ben@simtec.co.uk>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/video/fbdev/s3c-fb.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

[...]


