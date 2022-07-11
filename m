Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02AFC43334
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiGKLfc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiGKLfU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41C44357C8
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657538506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EA1fN116GiBeZpsIBZbEwfZ8hmNEURQAPP+h9KqfA64=;
        b=ZkStEx5R0s8JF9vKRMkw7rgxvf8bDR4O2OyYoM+epWt5uRpNqwl4RDyzIqP8H2t4nuCOM6
        jfgSdFFULdxFFDaLarkn757EPcSSETUa6HNWVYN2CoJg/M8srx8AUKPIna4k3LxBYbZ39S
        UTXSFElQIK9Cara4LfavP5dtom24XVk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-byG8GR6FPYe8rvmg4ww0bA-1; Mon, 11 Jul 2022 07:21:43 -0400
X-MC-Unique: byG8GR6FPYe8rvmg4ww0bA-1
Received: by mail-wm1-f71.google.com with SMTP id x6-20020a05600c21c600b003a2e9d4a106so335954wmj.6
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EA1fN116GiBeZpsIBZbEwfZ8hmNEURQAPP+h9KqfA64=;
        b=turLpGqVtdJj8BT+bgEBDg/27dbRl3zAdo7hZutFEpUlYjmRGFCbvuNMo655kdrfpZ
         Ol6butJjAsWJTbM4yfeHXYKeeUs6aUuyGYo13kjBRU7YGwmc7M3sk629HxFIbuCX/sNj
         ItqKVArrLtbvBLOKYrC/nJc+akIfQWHE8cUeDANyPR2J3VB1xuPkbwU+Xtbmhj+PaGpK
         V8g+sbuiSqGccHsy/U6jVf5k/KEOFpNoKUrXFZLEcqwHzEBF12HqgMSezCGB5s3WU0xM
         un9GP3jSMtCsSGAHqAakrB0aRkhy/5uquQxJ2DpHDhJTGYXQNclNuubdmEY69KLR8tDF
         NrrA==
X-Gm-Message-State: AJIora+FDAm+QYge5QWToov+ySKWU5Z5b/JEWsL2UoSSorIZU5yRLgon
        I/Ec3GW2a4tSNDzPQwhjs9sY8cekhijPG5F47OrdqdqzGjKGMNjxwFwN9SS/xQ4uSm6Tjn3UFmK
        7RANgBMMjO0Okfrek77/NkTk=
X-Received: by 2002:a5d:64ac:0:b0:21d:7832:ecf9 with SMTP id m12-20020a5d64ac000000b0021d7832ecf9mr16718312wrp.86.1657538501995;
        Mon, 11 Jul 2022 04:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vViTnrccYUQiM5dtYGiMoQe3XlJipDQ2tJJSnuKHUKFgjkwhFFyBuMGkA64X7e1vg9JvJxGg==
X-Received: by 2002:a5d:64ac:0:b0:21d:7832:ecf9 with SMTP id m12-20020a5d64ac000000b0021d7832ecf9mr16718296wrp.86.1657538501845;
        Mon, 11 Jul 2022 04:21:41 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c2ca600b0039c63f4bce0sm9837768wmc.12.2022.07.11.04.21.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:21:41 -0700 (PDT)
Message-ID: <00efc10a-a033-02c0-d5b3-95a5a1494c5a@redhat.com>
Date:   Mon, 11 Jul 2022 13:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/11] video: Provide constants for VGA I/O range
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-9-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Provide VGA_FB_ constants for the VGA framebuffer I/O range and convert
> fbdev code.
>

I would probably mention in the commit message to that you are renaming
s/VGA_FB_PHYS/VGA_FB_PHYS_BASE and s/VGA_FB_PHYS_LEN/VGA_FB_PHYS_SIZE.

I do agree with the rename and think that makes it much more readable,
but think that's worth to mention the rationale for that change too.
 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

