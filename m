Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77064C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Mar 2022 13:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiCINm1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiCINm0 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Mar 2022 08:42:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F286B17B0E5
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Mar 2022 05:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646833285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ssBZVyi4+h9kP2qv31uprsTOl0+0RRXY3OyMT9dWw3w=;
        b=Z5a4hrKsr2dPkMlgsGPgW1Kw8YljupKRlvlI0UeN3SHhGpstpwX624wjmLp06O+lXLKBk3
        Yab8j1fRVqbFWEM9Lx5shCgaSnavfz80rMFOwzpgsKh4+gJBl18B4dzDyNFCDSLM5H7G+e
        O4EHiTKYzn62g9LiNa+gjNNAgNi3hJg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-dY1a7ck4Nc2l4xpenNhoww-1; Wed, 09 Mar 2022 08:41:24 -0500
X-MC-Unique: dY1a7ck4Nc2l4xpenNhoww-1
Received: by mail-wr1-f71.google.com with SMTP id o9-20020adfca09000000b001ea79f7edf8so770975wrh.16
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Mar 2022 05:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ssBZVyi4+h9kP2qv31uprsTOl0+0RRXY3OyMT9dWw3w=;
        b=0eiX8JRuxkxTfpSAJLb+/tHl+gG8HNB/KnuisZBG7iw8e64XiHcUX/QAFlCwHvNGi0
         EpXr1xe49NTJGpYmkdvEhPvDp0f//csqKSSKw5NImGB9mmBkX6dc2G3OMv0ucYy9kSUZ
         E7x2ck+3HuhNrs2EqCt9AFQWteiSqD6oESCbnG02DOiLCU3AE0C7XL5a3xngwllcJTWJ
         xr3qFlOf9sV+TtQleTBYSnb7OFeR9j5oYag1TRqu1rJf2tRBzaTt2rJVUY4jzQ5ikY9M
         bUNxjmGEuGa279s6a+fifiyTlm9FZaSi10pVFyMXlD1ZVAhND9ZWO6or2pEnyqSFE7e0
         xvtg==
X-Gm-Message-State: AOAM532/rRoaNqlTAMN1ltt+kW4VWHiphVnUqNgcMBtya1wcumORSgvU
        MsgVCFpTIYadkA6W23a7sANUC7/B/8X+kFRPqvrufrl263LzD/M0b8BcWbhUVG76rwTXswzxYrN
        wAEkBr0Uxj0teUAfag8X5T4s=
X-Received: by 2002:a5d:538b:0:b0:1f1:e60b:20c2 with SMTP id d11-20020a5d538b000000b001f1e60b20c2mr13695559wrv.294.1646833283582;
        Wed, 09 Mar 2022 05:41:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyES6IHb68vtll06LYWTE9X9Tv+reEFiMr6+v6lhyVKOWCvdsUheCN8hBAtdi7CCeUXh3nUHQ==
X-Received: by 2002:a5d:538b:0:b0:1f1:e60b:20c2 with SMTP id d11-20020a5d538b000000b001f1e60b20c2mr13695542wrv.294.1646833283309;
        Wed, 09 Mar 2022 05:41:23 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bl20-20020adfe254000000b001f1fa450a3asm2676460wrb.72.2022.03.09.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 05:41:22 -0800 (PST)
Message-ID: <09acb08a-7b96-69d0-2fb9-80381e234877@redhat.com>
Date:   Wed, 9 Mar 2022 14:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 RFC 10/10] drm/fourcc: Add DRM_FORMAT_D[1248]
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1646683502.git.geert@linux-m68k.org>
 <e05254ba67598b3973010a7b6f31dd6b20a66844.1646683502.git.geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <e05254ba67598b3973010a7b6f31dd6b20a66844.1646683502.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 3/7/22 21:52, Geert Uytterhoeven wrote:
> As Rn is light-on-dark, and Cn can be any colors, there are currently
> no fourcc codes to describe dark-on-light displays.
> 
> Introduce fourcc codes for a single-channel dark-on-light frame buffer
> format with two, four, sixteen, or 256 darkness levels.
> 
> As the number of bits per pixel may be less than eight, some of these
> formats rely on proper block handling for the calculation of bits per
> pixel and pitch.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

