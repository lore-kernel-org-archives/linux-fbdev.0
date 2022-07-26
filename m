Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3880BC43334
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jul 2022 13:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbiGZNgg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238829AbiGZNgd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jul 2022 09:36:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3D8D9FFA
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658842591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2u/FwFPSYIYZn3XhpsCa5MLVVbvOOeOfOubBmW1ly8=;
        b=eGym5snp31sA+qGUz7cUncokPkNqSBxfnO5hWl+eSFrG8KYORC0TcMcZEJHnKVSEwnBWt7
        G1x/Zg0qEqSD/seXL+kDjZmsDS8WAuV6vHqMsFK6lfa/I0d/aDeqAlYqpukruNOY/ui/vU
        E20JMKtP0gzZ226fFrsCLQ6S+T85uhQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-vFIPhnF5OS2gPwZCDc4c9g-1; Tue, 26 Jul 2022 09:36:28 -0400
X-MC-Unique: vFIPhnF5OS2gPwZCDc4c9g-1
Received: by mail-wr1-f71.google.com with SMTP id n7-20020adf8b07000000b0021e577a8784so2076195wra.5
        for <linux-fbdev@vger.kernel.org>; Tue, 26 Jul 2022 06:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=o2u/FwFPSYIYZn3XhpsCa5MLVVbvOOeOfOubBmW1ly8=;
        b=XpCBGlXPaNLzJH2yJLiBm9bQ5iaocNsJ84rqK//tRQ48I/M9XdG1NmqMC8AqmmRQ3W
         Zg67CVxoOhoZAM6CIWdurVff86lAczpoTB16XHkVKQ1N8MiZJDlx+xam0CNB13T+HE3m
         NPETQopiF1j50SMKj6Qgcj9J9jmhcxDK3hnfrgouPDbAIobw16bZzr4ibD1OV9yGTx7J
         lESruYeIW9nEGJOK10ZJQ/2VVq6UdRodHLVgdHylg6jOK6MmNA8AW2XpfNxQN2asVXVK
         1mnfSd4p+wSvbjAs4JHT+cshwQKQvb5v9Jh+QSOFAU8f+XJ6/dWTx78gPsBK9DRtIumw
         Srdg==
X-Gm-Message-State: AJIora+qavQv2pUmBNeMjfVHVeSV6t/6Mzzpzd1Bfh/mXa7bPzBb+6ve
        2dAEwydgAX/D2/94ox6cqdYHR/wLkXvymBJhAe75N/vvFajsYBj1zgUlV93ZJ14YuRLl4BRtoCL
        sbcF0DF83WPBLvzoJe64trho=
X-Received: by 2002:a1c:e902:0:b0:3a0:2d95:49d4 with SMTP id q2-20020a1ce902000000b003a02d9549d4mr12603648wmc.189.1658842587588;
        Tue, 26 Jul 2022 06:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s+6AG/nzdOXc385y1ed+df7G89IH7y4dgdzREPE3h30Z3oCxeMhVdXILhe/dWGuohiWiGT+A==
X-Received: by 2002:a1c:e902:0:b0:3a0:2d95:49d4 with SMTP id q2-20020a1ce902000000b003a02d9549d4mr12603622wmc.189.1658842587119;
        Tue, 26 Jul 2022 06:36:27 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h19-20020a1ccc13000000b003a326ba4e99sm16742676wmb.34.2022.07.26.06.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:36:26 -0700 (PDT)
Message-ID: <3fb4d471-2653-07a6-8fbd-f59da6c113e0@redhat.com>
Date:   Tue, 26 Jul 2022 15:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/10] drm/ofdrm: Add CRTC state
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-9-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-9-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Add a dedicated CRTC state to ofdrm to later store information for
> palette updates.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/tiny/ofdrm.c | 62 ++++++++++++++++++++++++++++++++++--
>  

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

[...]

> +static void ofdrm_crtc_reset(struct drm_crtc *crtc)
> +{
> +	struct ofdrm_crtc_state *ofdrm_crtc_state;
> +
> +	if (crtc->state) {
> +		ofdrm_crtc_state_destroy(to_ofdrm_crtc_state(crtc->state));
> +		crtc->state = NULL; /* must be set to NULL here */
> +	}
> +
> +	ofdrm_crtc_state = kzalloc(sizeof(*ofdrm_crtc_state), GFP_KERNEL);
> +	if (!ofdrm_crtc_state)
> +		return;
> +	__drm_atomic_helper_crtc_reset(crtc, &ofdrm_crtc_state->base);
> +}
> +

IMO this function is hard to read, I would instead write it as following:

static void ofdrm_crtc_reset(struct drm_crtc *crtc)
{
        struct ofdrm_crtc_state *ofdrm_crtc_state = kzalloc(sizeof(*ofdrm_crtc_state), GFP_KERNEL);

	if (!ofdrm_crtc_state)
		return;

        if (crtc->state) {
                ofdrm_crtc_state_destroy(to_ofdrm_crtc_state(crtc->state));
		crtc->state = NULL; /* must be set to NULL here */
	}

        __drm_atomic_helper_crtc_reset(crtc, &ofdrm_crtc_state->base);
}

Also with that form I think that the crtc->state = NULL could just be dropped ?

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

