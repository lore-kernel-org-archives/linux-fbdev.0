Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C19C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 09:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbiCHJcx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345383AbiCHJcv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 04:32:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 331F7329AD
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Mar 2022 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646731874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4qouXnlwX5t+UMG1KaeRHyqe8z7wUEDOrDVLTeWY98=;
        b=IZhwDPwLpTCXwz+U5eAMpk+8mkXQhgHtSa77jFNg2m5AsAvrw+judpuLrGW4n3FgX3igfD
        tPaWVDjLe2zVNKifzJdVXKwWv3NI5URhKn9gVeeYCbKsD5vESj93ckbUBwqb9jActJ4CVz
        FOBoB6LobdAu/Q6a9X0N7JgGSpbKK0s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-ayy-C0eZOOu4gLyZrLg4Pg-1; Tue, 08 Mar 2022 04:31:13 -0500
X-MC-Unique: ayy-C0eZOOu4gLyZrLg4Pg-1
Received: by mail-wr1-f69.google.com with SMTP id l10-20020a05600012ca00b001f1e4669c98so1579046wrx.23
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Mar 2022 01:31:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=x4qouXnlwX5t+UMG1KaeRHyqe8z7wUEDOrDVLTeWY98=;
        b=0PIwsCTN3cLCqIa/GxYe02ea5ytDDG+WJppUCttwVi0Gy/jeGW1YJlseN7pFgwv8y5
         squcHZQE3u25iLClCxTw2J8xKxkUvUyod22YW8v+HnMIcFOe66PQzbfkjgfFHwu6+2Dw
         Ts7kMUiIgQd74LWVKbl1P8C38HXaf80OloyZ0nZbAadkveHHeoacmuIUflO6cEp6MGlk
         IdQ7u+eKL1VEbPS4OGFTNOrhO0zJrUf9OyeHKOjzpVSYKc25PXSYmuaojE7voBAFauDh
         hAHOSxsME8oUyedJ6/o2Lxsw/wppKr3pvlWzjcMCr2wZ4VFKeFRq+pBV6sg40iKQ+zDP
         cB2A==
X-Gm-Message-State: AOAM530D6YhqZMhlhzCnjkRf7HMRYJkKeywZvdTQS+ELtIZWk3N/UUdb
        77ojpTSgcSCtHXl2ojELB6VmQxso+5NCpBrkhVCtmNaa9qnPJngBjHUaSCOlmUICNQ3jXWwZSPx
        h/m58I5MnhzOkwmpFcXcGzDI=
X-Received: by 2002:adf:ea0d:0:b0:1f1:f958:a90c with SMTP id q13-20020adfea0d000000b001f1f958a90cmr5983636wrm.22.1646731871991;
        Tue, 08 Mar 2022 01:31:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2YcYQtOKaJj6Kx9VJLZ9GXsAOh+8pPCVnE98u0EUxvrX5Nnbiit3xxbS2WR2MOzf0v5nzXg==
X-Received: by 2002:adf:ea0d:0:b0:1f1:f958:a90c with SMTP id q13-20020adfea0d000000b001f1f958a90cmr5983622wrm.22.1646731871789;
        Tue, 08 Mar 2022 01:31:11 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d18-20020adff2d2000000b001f025ea3a20sm22158909wrp.0.2022.03.08.01.31.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 01:31:10 -0800 (PST)
Message-ID: <a9e7aa2c-9954-94ee-6f7c-0d6822342897@redhat.com>
Date:   Tue, 8 Mar 2022 10:31:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/9] drm/simpledrm: Use fbdev defaults for shadow
 buffering
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220303205839.28484-1-tzimmermann@suse.de>
 <20220303205839.28484-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220303205839.28484-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/3/22 21:58, Thomas Zimmermann wrote:
> Don't select shadow buffering for the fbdev console explicitly. The
> fbdev emulation's heuristic will enable it for any framebuffer with
> .dirty callback.
>

Indeed it does. Not related to your series but looking at this
patch I noticed that drivers/gpu/drm/tiny/bochs.c will be the
only driver that sets .prefer_shadow_fbdev after this lands.

The driver is using GEM so I wonder if after your series this
DRM driver could have a .dirty callback and the field just be
dropped? Or there would still be a case where it is needed ?

Anyway, just wanted to mention in case I forget later.

Your patch looks good to me and I think it could be pushed
without waiting for the other patches in the series.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

