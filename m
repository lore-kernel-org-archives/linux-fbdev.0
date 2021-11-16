Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BE6C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 15:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1131463219
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Nov 2021 15:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbhKPPp6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Nov 2021 10:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238553AbhKPPpT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Nov 2021 10:45:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C66C06120F
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Nov 2021 07:42:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w29so38376930wra.12
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Nov 2021 07:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MaOSO/5HtReWKBBksqBOQJDhfTRE2n/pBGJORKYgmI8=;
        b=dpMihBVSiTIhJ8gwEIK/0RaxfyXs2DtvxfMOWHwvsfqgQpUny0lQtED0wIphEPCb6v
         AEzTzY5KUWh+ZBUlwhm1MKOSsfEKvWzAZN6hA0iVz1ZkNSHET0GNQ7X4qOZ4ru7PoXmg
         a/08/a6OGQp4ufg1hfyxfYLxOjuSPoP4Iv2indtDuuY25uHOzB4zY/j/Htu2gPPN48F8
         +FDsCnukvP5bxxuyqV5df/R9Dld2m5MFGmv/6quqjj8jagtwmzBL49QLLLkaiJPMV3TB
         utBJFccrrLjAw31i2P+rtb2jHXojpAt5V88ehKxTw8pEyulGHnLBAJQgM7JuB/O0nT8J
         yzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MaOSO/5HtReWKBBksqBOQJDhfTRE2n/pBGJORKYgmI8=;
        b=KXR1225BTDv9BlNTez3nqOdlqU5FLGJLfRdKghKBHiKkyzUzh8G623IjGNthraau5D
         +PerzwvzPfa01oh7f9dtvCuNTv4yeSojUi7M/R2dSt2xOlEy9G63+qqxCRqMBkdKTMi+
         PeL00Em+WYknH45eEYzRCYPLgdmECWUnkBjiR7sk/RoVsra8CMRfL2tvUcDvbt4GX+iy
         j7yJis7/zcmmLF7ZVpND3zAlHh+1S7rcd6Z0YF0VGvvX6dt6e7qXpHgvqAkHLkFDMcs3
         SN29LZfAKvAmOSZzj5fCJ9JSxDaXnCFUZsbGZ+E3vF/tzzX8otvSXS9pzdOCdh9xiIQp
         n+BQ==
X-Gm-Message-State: AOAM533RS6kFClKZn16BfY41jVomke+8BOyM35t8hygxeS3de1jSGw9Y
        2GRQJw0B2t5pm8VbYIcmIQgElA==
X-Google-Smtp-Source: ABdhPJwGazAeHXqWI2KmcXg8HN2YudpmutPJQ1rdklClDDMa6uJ9nc+mW3BEpIrYrJ5e6pEnv6kpCA==
X-Received: by 2002:a5d:5303:: with SMTP id e3mr10447721wrv.73.1637077337983;
        Tue, 16 Nov 2021 07:42:17 -0800 (PST)
Received: from google.com ([95.148.6.231])
        by smtp.gmail.com with ESMTPSA id q4sm17892469wrs.56.2021.11.16.07.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 07:42:17 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:42:15 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 0/9] backlight: qcom-wled: fix and solidify handling
 of enabled-strings
Message-ID: <YZPRV2jD1EBYGdHL@google.com>
References: <20211115203459.1634079-1-marijn.suijten@somainline.org>
 <20211116120213.n7qxqfi62lrxhyl7@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211116120213.n7qxqfi62lrxhyl7@maple.lan>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 16 Nov 2021, Daniel Thompson wrote:

> Hi Lee
> 
> On Mon, Nov 15, 2021 at 09:34:50PM +0100, Marijn Suijten wrote:
> > This patchset fixes WLED's handling of enabled-strings: besides some
> > cleanup it is now actually possible to specify a non-contiguous array of
> > enabled strings (not necessarily starting at zero) and the values from
> > DT are now validated to prevent possible unexpected out-of-bounds
> > register and array element accesses.
> > Off-by-one mistakes in the maximum number of strings, also causing
> > out-of-bounds access, have been addressed as well.
> 
> They have arrived piecemeal (during v1, v2 and v3) but all patches on
> the set should now have my R-b: attached to them.

I can see that.  Nothing for you to worry about.

I'll apply these when I conduct my next sweep, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
