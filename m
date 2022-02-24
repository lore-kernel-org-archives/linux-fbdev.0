Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E39C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 24 Feb 2022 08:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiBXIXA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiBXIW7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 24 Feb 2022 03:22:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22CCF15FCB0
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 00:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645690948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jkN+QCFWjhBZcF3q6Kse5Vg2WTpTjJb8OgeE2AujL7U=;
        b=ZPUsrzy0mMdj9tuVMrVpAdpbakENtXFIVscCu9I7oFmXQpYs1DulEH9jOMlorLuDrSEEjy
        lOCNGiSoJA+SGcA9DNYo+el5rVGYHuqZnPwJp8oQ0vG/VhD+2nHiLSaxA470DNNX6PFZM+
        oXc5+KN1mFosshkmKJEINF1UegUh2co=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-Z20Meh4bMNCApStm8G0Y-g-1; Thu, 24 Feb 2022 03:22:26 -0500
X-MC-Unique: Z20Meh4bMNCApStm8G0Y-g-1
Received: by mail-wm1-f69.google.com with SMTP id 22-20020a05600c229600b0037be079ebf6so91081wmf.9
        for <linux-fbdev@vger.kernel.org>; Thu, 24 Feb 2022 00:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jkN+QCFWjhBZcF3q6Kse5Vg2WTpTjJb8OgeE2AujL7U=;
        b=vnSs1I7UiMH5pWmNnkZipnFnqU9+2Wcaxc1jfi/lFP5JMAWfcxvdbP/SptxFy+jfxn
         bm7J7a6uj+FnsHXJn79Td4GTy0KIpVe6g9BwyXxJ4pO41s2j3qietTDTrbcUytae3znx
         gGF83cG9xP9Fm1HMdUsb0QZFX1d2msiqDAbHWuYH3DpZLqWGYjEDPZceeGTpHBjtcZt9
         UMPefrWb4gsOvWSb1Cr5tBeUKUsa9C9PviL3Fzb1QkcRo6yeK9QHYQRIlm+NHZ5JkXlw
         OWPTknilz5GKVHTuzZHEPRcIFsiiuOc+c0TaxsIm4kpMJbct4dHVo3zXdXlCv/GyJxRC
         EuXw==
X-Gm-Message-State: AOAM532nFDtG36Xp3jcFLnMpcSVgBwgFP1OO5fgJGAsiripxZQYcmEsO
        j7yngRCeNEsY4aX2jW2bePKtjwI1nC3FSZFabUfZHOtAugkqTYJwCWk4uq3nKAYWkO7ULd4WEKv
        mqCtMEW3UgXlBlwmhP4VZhdE=
X-Received: by 2002:a05:600c:1c1a:b0:37b:ead2:8e6d with SMTP id j26-20020a05600c1c1a00b0037bead28e6dmr10829653wms.94.1645690945569;
        Thu, 24 Feb 2022 00:22:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyv952eS8lOwFIzJtL+dkZyisK//nGSmETYzeXCs8mWOE9vRC3EZj2P41tAgcq1w3BRU5+wRg==
X-Received: by 2002:a05:600c:1c1a:b0:37b:ead2:8e6d with SMTP id j26-20020a05600c1c1a00b0037bead28e6dmr10829644wms.94.1645690945335;
        Thu, 24 Feb 2022 00:22:25 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n15sm2023738wri.80.2022.02.24.00.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 00:22:24 -0800 (PST)
Message-ID: <4c124a6d-f805-9235-301b-3525c4f0fdf3@redhat.com>
Date:   Thu, 24 Feb 2022 09:22:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/5] fbdev: Remove trailing whitespaces from
 cfbimgblt.c
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        deller@gmx.de, geert@linux-m68k.org, sam@ravnborg.org,
        kraxel@redhat.com, ppaalanen@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220223193804.18636-1-tzimmermann@suse.de>
 <20220223193804.18636-4-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220223193804.18636-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/23/22 20:38, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

