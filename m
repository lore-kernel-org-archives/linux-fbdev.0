Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC34C001DF
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 Jul 2023 10:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjGNK35 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 Jul 2023 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjGNK34 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 Jul 2023 06:29:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1252D48
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jul 2023 03:29:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so16067315e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 14 Jul 2023 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689330592; x=1691922592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh5IM3hcbkTlsZ0QohBnPm9+/WljTdptQDAe3KRHGao=;
        b=O5ufoN9bQiWKXDmCStIX+Io10WRu2B69Deqb5KVzrXV2sqgY9JCnNvyATagBuE+ark
         IS32r2PfYWd5XlLUlJoSJAAAXm5+hxTEjMb0ZCe5fK3NGofpUv7OKY9G8Xf6nBs65XhV
         mN24wwtq2SFoDgOh1XzRQP48JVgtE3qQg6DtMC8WgMhj9t2D3law3WPvQE1ujYDEF2HF
         HQ2Wfv1wVIeu2S+ZqWDReHbCASDvhIqXVdLZ+6qiMuNgb/mQI71489JITRwjOarUlIKd
         T4bv/caHqvEm2PmjsCWaoXFBLjd4pTJ0r4FnJChubfG5R2bSvz1FrPJ8nXiDNobJSVlf
         ylLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689330592; x=1691922592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh5IM3hcbkTlsZ0QohBnPm9+/WljTdptQDAe3KRHGao=;
        b=kyjMd2AR9IzC4At3nGlBl8f8tySdOFaayzWImY3dHqvlhEGkf/mr+lI5ngdnBsml9U
         UNH9BVLlhFDvrDWmaqjbnlDIr2ZYFk/za+witYpeqtr/o3leuK+hSsdcZX+Y9gye/j10
         vRkznDSW+f74suFTWsUGobQ9YGiPJXWZFZKMEwb93b0dnW2pISsIrCPj+vG3Y/vDn3fw
         qEDBD6YwfBSixWJAZDLKFbHqarjUi57oWFsIv4c+QfEDO4tK2lxlQOEtV/tvHCuaCvYa
         42EwGgF/sTDIh/0gv2K+oBz+22Fs1a89Pnwjx4REymKQlJqa/bzV4eWkEQH5Ojg376JM
         /QVw==
X-Gm-Message-State: ABy/qLa1ufdLUIQwZjyQR+PmDPWAXI57mqvWQ3mk596hpxfL+QXmHK6K
        o70qAxOh/rjHf0FY8azACONyz0FZBIZh0s2ct9Y=
X-Google-Smtp-Source: APBJJlFnsQ9uvLjsHZQ9SREHQ216HPPGjASy9AiZYJZlWwyGhQieiRuOjHKJ7s1mAu1WpSfMQoCtmw==
X-Received: by 2002:a05:600c:2254:b0:3fa:984d:7e9f with SMTP id a20-20020a05600c225400b003fa984d7e9fmr3534844wmm.6.1689330592448;
        Fri, 14 Jul 2023 03:29:52 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b003fbb5506e54sm1094832wma.29.2023.07.14.03.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 03:29:50 -0700 (PDT)
Date:   Fri, 14 Jul 2023 13:29:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-sh@vger.kernel.org,
        deller@gmx.de, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        javierm@redhat.com, dri-devel@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-nvidia@lists.surfsouth.com,
        linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-geode@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v3 00/18] fbdev: Remove FBINFO_DEFAULT and
 FBINFO_FLAG_DEFAULT flags
Message-ID: <b3c23ea3-f46c-43b9-b12a-9f55de2294c6@kadam.mountain>
References: <20230714075155.5686-1-tzimmermann@suse.de>
 <CAMuHMdWoeyJPAgPgFi545SJFcaVCgZi1-zW2N5cBeU9BnHgo1w@mail.gmail.com>
 <47a3ab8d-5e8c-db2c-fcde-5c2b1bac32aa@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a3ab8d-5e8c-db2c-fcde-5c2b1bac32aa@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jul 14, 2023 at 12:24:05PM +0200, Thomas Zimmermann wrote:
> > 
> > >    fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
> > >    fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
> > >    fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
> > >    fbdev: Remove flag FBINFO_DEFAULT from fbdev drivers
>
>
> I wasn't happy about this either. But I could not come up with a description
> that fits into the 74-char limit for each commit. They only differ in the
> method of memory allocation. Do you have any ideas?

fbdev: Remove FBINFO_DEFAULT from static structs
fbdev: Remove FBINFO_DEFAULT from kzalloc() structs
fbdev: Remove FBINFO_DEFAULT from devm_kzalloc() structs

regards,
dan carpenter

