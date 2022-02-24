Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F51C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Feb 2022 08:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiBXIcG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbiBXIby (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Feb 2022 03:31:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B70E276D6F
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 00:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645691478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xo8E90uuxqaqeCLoq4VGnrq9hH/Zy3PficDmQA7NRyw=;
        b=V1KNdH2IDgASQCZ0/H4xoftljE4UcYArJ4jDLGdsIlF9WYxJacx3fTpZ4zcJUi6hwX1mdp
        3xbYr4vccjp+e8KNyyUaT1BAI+pY5LHiWnU8Oku8hHsEYCGXHH6tx5AH3aj5wdOJBeNqVL
        XIVQ5s9HSK5xIM9oBIeay4VZQ7++nXc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-7hj294qWOFmHDZkRaJwvKw-1; Thu, 24 Feb 2022 03:31:17 -0500
X-MC-Unique: 7hj294qWOFmHDZkRaJwvKw-1
Received: by mail-wm1-f69.google.com with SMTP id u14-20020a05600c210e00b0037bddd0562eso547020wml.1
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 00:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xo8E90uuxqaqeCLoq4VGnrq9hH/Zy3PficDmQA7NRyw=;
        b=5eIgK09uk+aK5kfb3ZpkQrP41bfEKF7rDiz4uMxXjqA4StnA95uxAeApQTiJVCyzMn
         VKHs65sRaNzRhz8X8u5wy7n/vBL3KfAYY359kkxgfERVgmXg2D+032uA+SJ/uMoaTCGp
         CG+eT7kWRN6HNbPoqm98Y0jh2CD4rjGmLpa8x1m4Yi5gBMFWWlr0ufmFzZNZUlbVax8j
         PEuUF9AVRdFIceyaLAaS+YYbz1kTOZ41pZxiLlGndhnStjaCp8ofsF81kKEvhm5dfKbX
         D/oIOjw7bygR7GtTqP1xmT8uKxXOt6vQ1FDEQ2I6xVTVEDj8e3Gqgl0PBT9aFs7aIDoC
         T6Bg==
X-Gm-Message-State: AOAM530G1p9yc6W1lXbgscgifXce9bNiOFFDmdHXHTF4Bn6wRdrQTfsZ
        Gphe98TGgmoS18NKIVT2gZr49TRm4vzoOwm5BbMAJjPGhTFBH/4sbL9qyMFhG3VvOaad6Pv76h9
        ZMKa3uuYekmZW/q171Gxdiq0=
X-Received: by 2002:adf:fe85:0:b0:1ed:895b:a90d with SMTP id l5-20020adffe85000000b001ed895ba90dmr1252315wrr.55.1645691475684;
        Thu, 24 Feb 2022 00:31:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1++PWNyaiY5KES+gGanSWUriLozwmCoh7hNVWlwC9b1XK24ZXZ8dYqS3bRhFmAzAF02gZaQ==
X-Received: by 2002:adf:fe85:0:b0:1ed:895b:a90d with SMTP id l5-20020adffe85000000b001ed895ba90dmr1252291wrr.55.1645691475459;
        Thu, 24 Feb 2022 00:31:15 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u12sm1990215wrs.2.2022.02.24.00.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 00:31:15 -0800 (PST)
Message-ID: <6692a3cd-21c8-3f09-cf55-ea2b8af34d30@redhat.com>
Date:   Thu, 24 Feb 2022 09:31:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 4/5] fbdev: Improve performance of cfb_imageblit()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, geert@linux-m68k.org, sam@ravnborg.org,
        kraxel@redhat.com, ppaalanen@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220223193804.18636-1-tzimmermann@suse.de>
 <20220223193804.18636-5-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220223193804.18636-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/23/22 20:38, Thomas Zimmermann wrote:
> Improve the performance of cfb_imageblit() by manually unrolling
> the inner blitting loop and moving some invariants out. The compiler
> failed to do this automatically. This change keeps cfb_imageblit()
> in sync with sys_imagebit().
> 
> A microbenchmark measures the average number of CPU cycles
> for cfb_imageblit() after a stabilizing period of a few minutes
> (i7-4790, FullHD, simpledrm, kernel with debugging).
> 
> cfb_imageblit(), new: 15724 cycles
> cfb_imageblit(): old: 30566 cycles
> 
> In the optimized case, cfb_imageblit() is now ~2x faster than before.
> 
> v3:
> 	* fix commit description (Pekka)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Makes sense, improves perf and makes the two more consistent as you mention.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

