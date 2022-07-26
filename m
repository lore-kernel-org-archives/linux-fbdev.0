Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46355C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jul 2022 13:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiGZNir (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234013AbiGZNiq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jul 2022 09:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 330841F2FF
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658842725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Adj4jrU1SP5osnWw1jwoXpRrBSvPiISvLrv57eggvs=;
        b=gpKi9+W9y9WFIkTGRS8lmMVSiMpjjcAq33XprPWTOJoKipe1/dl1dbNtpA4o+2Jyl2S29U
        0bPcwVTteOxaMhwI5knBviCRRpfuGDiGhG6s2T4yQvHIUawOfadjioST6p4U4AXxOhoXCh
        lE+F6kAagMIxAoWJmu56HOI2Cq/ElvA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-SoTvHrbGOM2C4KZHCh_4tA-1; Tue, 26 Jul 2022 09:38:41 -0400
X-MC-Unique: SoTvHrbGOM2C4KZHCh_4tA-1
Received: by mail-wm1-f70.google.com with SMTP id t25-20020a1c7719000000b003a3564fa721so3429909wmi.2
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 06:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+Adj4jrU1SP5osnWw1jwoXpRrBSvPiISvLrv57eggvs=;
        b=KSdCxrcA13BN4dVoblakW+YU9ieK6nJhpi55EoLLeGswiSqFMLuoPg6J0hNOs316kL
         IUfLgxXQNKJAmu0B8gkX9aE4Jap3CRXF5rrD+//nY4iPOZ32sqdTFq1NMCZ6WMA5ZGfK
         MKX5LHUeUnWdLsDpK8/1aEADxbFWumFNFeD71VyS6nKcMR7pShynpKl6PupvynYmcWHx
         9MpZ4k/DQugPmmVm26vPi/lSRBqhnx0N4CJSdH3PKrMcCd9Zivdd26zVBvBU62mdCJvY
         KkfAlPu9czU/mSO1wjFfUGATyVNMj6xfJNMu/9WVzsfomZ/9m24t/ke/4MrZH4ccRgdT
         Y0EQ==
X-Gm-Message-State: AJIora8pMngV7Mc/tlFwhMOLOaqCt1G9su2ZtueVuCFxorR4s0S7P+Ii
        MwTXyDJEuXapvbojZn+ljd3wn7kgbrxwCRkiCt3zlVPzgrTz0idTYeA7Ap+QCLVlMUp6EsiXpjR
        q+KgItszV2XoE9FxBCnDb4sw=
X-Received: by 2002:a05:6000:1541:b0:21d:b298:96be with SMTP id 1-20020a056000154100b0021db29896bemr10656795wry.206.1658842719913;
        Tue, 26 Jul 2022 06:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vn5gO3Bopg+51fzCZTQS+LUztnjj2PQ5ldn7oubUEVRSuljc6/I3CCwqkTlMx6jNch/xeE8g==
X-Received: by 2002:a05:6000:1541:b0:21d:b298:96be with SMTP id 1-20020a056000154100b0021db29896bemr10656771wry.206.1658842719436;
        Tue, 26 Jul 2022 06:38:39 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c248500b003a3279b9037sm21045175wms.16.2022.07.26.06.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:38:39 -0700 (PDT)
Message-ID: <7b1a2807-59c7-d524-af8e-1ec634c740a7@redhat.com>
Date:   Tue, 26 Jul 2022 15:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/10] drm/ofdrm: Add per-model device function
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-10-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-10-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Add a per-model device-function structure in preparation of adding
> color-management support. Detection of the individual models has been
> taken from fbdev's offb.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

[...]

> +static bool is_avivo(__be32 vendor, __be32 device)
> +{
> +	/* This will match most R5xx */
> +	return (vendor == 0x1002) &&
> +	       ((device >= 0x7100 && device < 0x7800) || (device >= 0x9400));
> +}

Maybe add some constant macros to not have these magic numbers ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

