Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297C2C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 11:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiGKLbW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiGKLbI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 07:31:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A59C3646B
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657538011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NgrB0b1hGhY+Hu6lpXdXevvlkiE7V1d2yqtg5tmfmtA=;
        b=deqcrmHHYjOSwTYBixOb1KrikdqX3Pcdi70XUE7vduP8jH1lINNvJaumaRpCTH2RcfJNwc
        7CGTA+O0XiI20lbfgbdd7bnWwgS8vjiOPIKJbpPM4VNlu9kiCLiE8aFAqcXF+EVVg15gEl
        qGzQFxq3Gc6QmaZ8cs27hY6xc6D92Ns=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-bPrwEJl9PKiNs_jVUqbVLQ-1; Mon, 11 Jul 2022 07:13:30 -0400
X-MC-Unique: bPrwEJl9PKiNs_jVUqbVLQ-1
Received: by mail-wm1-f69.google.com with SMTP id k62-20020a1ca141000000b003a2e342a55bso1977360wme.1
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 04:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NgrB0b1hGhY+Hu6lpXdXevvlkiE7V1d2yqtg5tmfmtA=;
        b=rJ1lxE1kfEMlYrkliSzALJfuClFaXV+q7t2S0HSbjUB04j6Oo83coi6B41GTet4sk4
         YAY8usXbA+lZwh5oXLY0nCTFJHk91UbU8Uq9XOXIlxmAG8hlYYPm1rwCdqnhh/SmyyJg
         +dI5f3ChoSn9c9Oli8pNOF/UZMjH3PaI/GKgu+ZuHkztmZGZ2ENpWI04Y9WezzA3WWPm
         xmx9e1i6wWn0N3GDjdNMxnnUjE9MufuCLMdaykAlijExFcryeqQ1P6wns0hMNFGPupiO
         ONw8YceflLiW5fPMXdY9gcLSzo0RImsxGTVM3IDQ+GDgGGjFB+A0fPv8wZVKC80CMso9
         Dlow==
X-Gm-Message-State: AJIora+bmFBL7FRFbGSfToBsGTZ2oNMIvm2iGjWWhGIizXJEZ3X//9qX
        hXsgUiTlrT/QQmEiLqmJq3JZ9yVACksG155wPBsJzSGBlby+1wcFOV5gTOFdbqyLNEROktfMjA1
        PJCwAK4/OI+RyCoISjVIV1M8=
X-Received: by 2002:a05:6000:1446:b0:21d:27ea:5a01 with SMTP id v6-20020a056000144600b0021d27ea5a01mr16485644wrx.314.1657538009257;
        Mon, 11 Jul 2022 04:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vcs0nWJiY8DtaMjFckjPBveM2LCwxXVkUAHZMUUjNEZSyGr2GAAEWa2YiuJ4Zpzd1flJ5Yfg==
X-Received: by 2002:a05:6000:1446:b0:21d:27ea:5a01 with SMTP id v6-20020a056000144600b0021d27ea5a01mr16485626wrx.314.1657538009047;
        Mon, 11 Jul 2022 04:13:29 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g10-20020adfe40a000000b0021d6d18a9f8sm5562294wrm.76.2022.07.11.04.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 04:13:28 -0700 (PDT)
Message-ID: <210b1ae1-f663-dfe2-d9b5-2cd827d15f2b@redhat.com>
Date:   Mon, 11 Jul 2022 13:13:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/11] fbdev: Remove conflicting devices on PCI bus
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, maxime@cerno.tech
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        dri-devel@lists.freedesktop.org
References: <20220707153952.32264-1-tzimmermann@suse.de>
 <20220707153952.32264-7-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220707153952.32264-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/7/22 17:39, Thomas Zimmermann wrote:
> Remove firmware devices on the PCI bus, by calling
> aperture_remove_conflicting_pci_devices() in the probe function of
> each related fbdev driver. iSo far, most of these drivers did not
> remove conflicting VESA or EFI devices, or outride failed for
> resource conflicts (i.e., matroxfb.) This must have been broken
> for quite some time.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

[...]

> @@ -949,6 +950,10 @@ static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	int rc;
>  	u8 regval;
>  
> +	rc = aperture_remove_conflicting_pci_devices(dev, "arkfb");
> +	if (rc < 0)
> +		return rc;
> +

I wonder if we could think of a trick to avoid open coding the same check in
all drivers. Maybe a combination of using KBUILD_MODNAME for the name and
a probe callback wrapper or something ?

But probably not worth to invest more in the fbdev drivers and could be done
as a follow-up anyways if someone feels like it.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

