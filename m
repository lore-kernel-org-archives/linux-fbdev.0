Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BE4C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Jul 2022 14:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiGYOsz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Jul 2022 10:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbiGYOsw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jul 2022 10:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDF8D18E01
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658760526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MrIFLSXgxumLrr5N+Xm5tSy/MudCUAu7YLr1DhCbnqM=;
        b=YKYzWO8AulUnlUbBhcE7DbtW5Me5arV2VNNU5kwhXTN6XKy4V8DD4e1dEr7TCgKeOUcLFc
        uXapo5QujX2320Gf2NBcjYT5fSZTXza+82oHi3vTFfrSStO7weeHRH2L4bkIPVa7Wm9kUZ
        fA5dlQkTxgueJP8fyfrgnzLw5sgLQAE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-3-CgSVLfPTN26CZoH2VAl1vw-1; Mon, 25 Jul 2022 10:48:37 -0400
X-MC-Unique: CgSVLfPTN26CZoH2VAl1vw-1
Received: by mail-wr1-f69.google.com with SMTP id h6-20020adfaa86000000b0021e47bcbc6dso1649340wrc.16
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 07:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MrIFLSXgxumLrr5N+Xm5tSy/MudCUAu7YLr1DhCbnqM=;
        b=CwMBAw78gyVoApFHISVUSym4irbGCrjY237/SKVN8aI4y/hIj6fuQBHezh6WcRzjc8
         ao7XBTG3YF8v5NpM8ItmounfIVGE9kEh6bX3Az0CTZWO9HinzxEAzqI6k4LYkOdksxwl
         D6+rjzbO9kHbqHQnsBnfUtO6ZQ6QI5Jy3k+bjUNs8jAitX9tkEFVIyZOEkUQBFtaHUs7
         SNxJZWMkgDAeH+LUOEVyVMYtJB2Ie/gQfY5dRvHc6iMGKr14IZiD96aCZYsA0kl5giaa
         sjH4md630NzWOr15+jw3SrIUbD5Sfi8sdl0F5RHafbv47MEtfpFYX04eb4fg58LvaFTZ
         9erA==
X-Gm-Message-State: AJIora99rZWK1jsVsSpkdggYL1ZiKA5Hrs9f2YIHp9txB4q6qmxuHddH
        oylt/Ym14TOl8Jh4dqbhCTFdTyDUUPVTCoXCDbqCVQ+PhkSQcbWLZeZ42VMo375Xr83R+9m932E
        A9HWLyalHyA//2ZGiYnSA6ZU=
X-Received: by 2002:a05:600c:a188:b0:3a3:1802:e327 with SMTP id id8-20020a05600ca18800b003a31802e327mr8922437wmb.41.1658760516686;
        Mon, 25 Jul 2022 07:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tnzVVUGDwiw4pcTWx5MAYSq6VOtiToiDObHgJ6Zic+31l2117wCx4rJ9QK42iIFmUvvV3/4Q==
X-Received: by 2002:a05:600c:a188:b0:3a3:1802:e327 with SMTP id id8-20020a05600ca18800b003a31802e327mr8922426wmb.41.1658760516510;
        Mon, 25 Jul 2022 07:48:36 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4fc9000000b0021e6277bc50sm10775122wrw.36.2022.07.25.07.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 07:48:36 -0700 (PDT)
Message-ID: <faad4b2a-c3dc-e6b8-ee2b-7aa920db3c0d@redhat.com>
Date:   Mon, 25 Jul 2022 16:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 01/10] drm/simpledrm: Remove mem field from device
 structure
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-2-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Remove the unused mem field from struct simpledrm_device.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

