Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32762C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Feb 2022 08:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiBXIkN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiBXIkM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Feb 2022 03:40:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 761D515FCBD
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 00:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645691982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pLo3BT+JpXVVTvEFvgX4MJjwLYSwkDRz6mnMAcRuACw=;
        b=HitPFiWGp0LK4eJkNYtVb8meS+18NVIIml9VdsKHP7p9Dtzb9loEEA++sgrOj+9GhwATJ6
        8OdjKQvub10NwYHzzsgkKAip9KawM8M1K5MQ1R+34ZqXAmZxWgxzrBpNinxOruqoeF9OsP
        lb7K+HU+Dz33+VD+vZIr1W+liqlvaeY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-pGJdYLpYOX2jOfeXWIIMHQ-1; Thu, 24 Feb 2022 03:39:41 -0500
X-MC-Unique: pGJdYLpYOX2jOfeXWIIMHQ-1
Received: by mail-wm1-f70.google.com with SMTP id j39-20020a05600c1c2700b0037becd18addso551730wms.4
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 00:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pLo3BT+JpXVVTvEFvgX4MJjwLYSwkDRz6mnMAcRuACw=;
        b=wGh7316Yo+M7+n/nlat5hXWz96CEBBBhQBquTy9sYSywg15ruG88gd9gnml6bvQ/hT
         Tjeq3YSEgfJGL+rSMLcjrwo7/e5dl7FxSMJ82mSEoLP3QGLiNNqh9Z6xh3Mr+jBDwh8g
         OUwOg8ElfkmtQEoZD4CdWUK4RB4iqln4Fq1MNQywaijUpkiUuM1CLWkg4EejmmUhOYfb
         /nIGdhLpO+CjSlsEEEzkOPtv8ySM/1MVbFv/nzGzClofZICm2bUD+jtXJJurcYBqRiZj
         eaKfiIr8Pqiw0du+s6kJ7b/0ubi1UT17OHvlnctY+qB8E5l7/exQnII181LdjoFP71w3
         l90g==
X-Gm-Message-State: AOAM530mNXEgWHJyglM1MQ8H2zCZvn2W+erRRgTaZH2xdoNn2i2Pw4hz
        SM02PcI/d4ZCqeI16udwzkZa1yZqlQSxaORCICFc+gzCQJKQjvjkckD4+Ptmgr5VtR4q5vWWZvs
        Au2DHqodZKrXbtczXkb37JFY=
X-Received: by 2002:a05:600c:4f03:b0:37c:b58:9c35 with SMTP id l3-20020a05600c4f0300b0037c0b589c35mr10410914wmq.118.1645691980325;
        Thu, 24 Feb 2022 00:39:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7/+PPy5JuHjRbucsEnsdP1Hay+tcT6GGR3KRsDQQmXUJyHejk0aUvttSsAMn+eiRGPwn3aQ==
X-Received: by 2002:a05:600c:4f03:b0:37c:b58:9c35 with SMTP id l3-20020a05600c4f0300b0037c0b589c35mr10410895wmq.118.1645691980127;
        Thu, 24 Feb 2022 00:39:40 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b10sm2349050wrd.8.2022.02.24.00.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 00:39:39 -0800 (PST)
Message-ID: <16e21d99-26db-5e1f-564e-3fc1db600d29@redhat.com>
Date:   Thu, 24 Feb 2022 09:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/5] drm: Add TODO item for optimizing format helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, geert@linux-m68k.org, sam@ravnborg.org,
        kraxel@redhat.com, ppaalanen@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220223193804.18636-1-tzimmermann@suse.de>
 <20220223193804.18636-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220223193804.18636-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/23/22 20:38, Thomas Zimmermann wrote:
> Add a TODO item for optimizing blitting and format-conversion helpers
> in DRM and fbdev. There's always demand for faster graphics output.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

After fixing the typos mentioned by Sam:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

