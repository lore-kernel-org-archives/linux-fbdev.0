Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D16C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 11 Oct 2022 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJKHq0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 11 Oct 2022 03:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKHqZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 11 Oct 2022 03:46:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D075A83D
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Oct 2022 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665474383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WSO31FFSWdoXBgwUfILs3D/eoN5/MJjkcgNLNdrIA0I=;
        b=QO5eOgp7AkRDZP7St3zhHNmyDQoFp5X7Z8QooYtDK2h32uuvqLaEAS3D4yFcLmqNROWaJx
        SNy2pkBuQ+qHwGxBSCOzaRQmNMSSQyHg9GMtG5T4LqbejW/uJboSnQTzvV85JFAmRhOWeT
        yxq32s25DKddw3SBIqXq46wmZokU290=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-92-c_nvB6BjMz6IZXfBZxdkJQ-1; Tue, 11 Oct 2022 03:46:20 -0400
X-MC-Unique: c_nvB6BjMz6IZXfBZxdkJQ-1
Received: by mail-wm1-f72.google.com with SMTP id c5-20020a1c3505000000b003c56da8e894so4009346wma.0
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Oct 2022 00:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WSO31FFSWdoXBgwUfILs3D/eoN5/MJjkcgNLNdrIA0I=;
        b=sYfBTC3kVXWMi4ixP5Dsmo2bhbDYWI9koapox+TufewXy+0oEZ7uyk1UuvYGoyoAFv
         cagIxco7pqOo4kaDL7HHWTZl7xBrIWes+1VuKloDsr7sOSQw50GdAB32PBfim/whioUe
         6DB0pOZQmWupTlb+cH/DgTp/FHfvjBU74a67Txagij9d8Ki/4lGH4EBPd0lWG5vM3BN+
         36cxPr+fVEaSjUsUHIEghoZ2sPtmtLukLcDUMWKxifvXqU8MnubvONcg/PnQsITfGeJH
         zRTVF9enUK9Y1V95s/7Es0eWHPo+4bpp63wplw3/I6r4G+ewakaawpeO5GOR7XLiSOlU
         U1Aw==
X-Gm-Message-State: ACrzQf187AJd5QNkX7Cd2tajsOqYawZQOI53X0bPpyc0JqHdDHPXJJZ3
        5XbXd0LwznSsRCXktVMgehvcqYQkK6nNzO4cgCsLcGoxS9DBn7vSZs+lvPzm/Hj7/hOP5scj4dY
        moamR/Mwi4ZxCoh8gwXPCg0w=
X-Received: by 2002:a05:6000:184c:b0:22f:edd8:821f with SMTP id c12-20020a056000184c00b0022fedd8821fmr7415905wri.363.1665474379320;
        Tue, 11 Oct 2022 00:46:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4dmWgqCGPFqZN8NPA8TsXuF3935TrGX3QAoadmbEV1e0/uHHFpUzYt1J3ZTNf2xQER2QOE6g==
X-Received: by 2002:a05:6000:184c:b0:22f:edd8:821f with SMTP id c12-20020a056000184c00b0022fedd8821fmr7415879wri.363.1665474379063;
        Tue, 11 Oct 2022 00:46:19 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bp15-20020a5d5a8f000000b0022cbf4cda62sm13716589wrb.27.2022.10.11.00.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 00:46:18 -0700 (PDT)
Message-ID: <23333ff7-3ae1-494f-7abe-62da6698fd00@redhat.com>
Date:   Tue, 11 Oct 2022 09:46:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v4 5/5] drm/ofdrm: Support big-endian scanout buffers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220928105010.18880-1-tzimmermann@suse.de>
 <20220928105010.18880-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220928105010.18880-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 9/28/22 12:50, Thomas Zimmermann wrote:
> All DRM formats assume little-endian byte order. On big-endian systems,
> it is likely that the scanout buffer is in big endian as well. Update

You say it is likely, not always then? Does it depend on whether the Open
Firmware is BE or LE ?

[...]

> +static bool display_get_big_endian_of(struct drm_device *dev, struct device_node *of_node)
> +{
> +	bool big_endian;
> +
> +#ifdef __BIG_ENDIAN
> +	big_endian = true;
> +	if (of_get_property(of_node, "little-endian", NULL))
> +		big_endian = false;
> +#else
> +	big_endian = false;
> +	if (of_get_property(of_node, "big-endian", NULL))
> +		big_endian = true;
> +#endif
> +
> +	return big_endian;
> +}
> +

Ah, I see. The heuristic then is whether the build is BE or LE or if the Device
Tree has an explicit node defining the endianess. The patch looks good to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

