Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A36CCA473
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Jul 2022 16:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiGYQXk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Jul 2022 12:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiGYQXk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jul 2022 12:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68DA117A93
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658766214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmfeEstC7MzRi4GsM10cgjXuSOhlEtm6GXZ2w8tMu/Q=;
        b=ZXejwEEbKoCrVx6y9E68DRci5COKMLJCMf5d5KPaLEBD+pKfNjWlq0mxgO5AcP14z4NNVq
        YNOiRX+i7bFco9+r4o18PN5i2XCaln/Q/hR35zyYUqQw2l9jLA7rOBrgjuun96mHRt8upV
        JWICG7/VEMhEMkyG4Z3NG4kH6QzRrtY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-Dp2L64akM46vAeu1a1Z9jA-1; Mon, 25 Jul 2022 12:23:33 -0400
X-MC-Unique: Dp2L64akM46vAeu1a1Z9jA-1
Received: by mail-wr1-f71.google.com with SMTP id a3-20020adfbc43000000b0021e46febb93so1684204wrh.4
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 09:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZmfeEstC7MzRi4GsM10cgjXuSOhlEtm6GXZ2w8tMu/Q=;
        b=js8kIf8E6epHgbitqhZLPBeE/zdrnxUiSffcd8GOu1a5IDz4T+hIcmrEz6gVWp7b0Q
         7+V5tzdPHySK5XMMbtkSpqCyF344/vENx1+v7lLk3P4ALw8VPignkoZHuWQgZ4hayBdo
         aCgyEI0DHnGgl3zMX89RdFENKLb4PUxK/tbo/M8kXai1yb7+Kb6zqSwlYNTN8W8kINeY
         nMz3yvKgqvNyvSLL6tikItRFyNNptnCtMJRQtMUaKFQfqLnL8CiqVa6pE9PkCnQiefVW
         bH+Wnbpw+cafqLv1FBBbuJv8xR4TNPgbENHBWB5LpdNbSX3bVJPe6Rq2RMZuO8gNy9w3
         8Ypw==
X-Gm-Message-State: AJIora+ahjWvbx6sR3Xd3HlFWvRl9YrUimsSa97EErCmFplYww4sdv3n
        frgHPymBOBfke8F3YKly3MwpmWoeSE+6H5fqJVzF3AOgQYvQxqU+GwsZARUjOChcprv/kBcA+FW
        +t1zrcMDdxUOtYlpK2EiZFVY=
X-Received: by 2002:a5d:64e5:0:b0:21d:945a:e7c4 with SMTP id g5-20020a5d64e5000000b0021d945ae7c4mr8441252wri.0.1658766212101;
        Mon, 25 Jul 2022 09:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tptHt0Y0I7YhJpqW280Dm+5gcnOs9JNd6o1Fbej5pCDlkvS7qocPnvna/n/WFRv1F+04pmvg==
X-Received: by 2002:a5d:64e5:0:b0:21d:945a:e7c4 with SMTP id g5-20020a5d64e5000000b0021d945ae7c4mr8441228wri.0.1658766211550;
        Mon, 25 Jul 2022 09:23:31 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c4fd400b003a305c0ab06sm20504556wmq.31.2022.07.25.09.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 09:23:31 -0700 (PDT)
Message-ID: <c411480b-27b2-8c0b-534f-bbabd8018577@redhat.com>
Date:   Mon, 25 Jul 2022 18:23:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 06/10] drm/simpledrm: Move some functionality into fwfb
 helper library
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, airlied@linux.ie,
        daniel@ffwll.ch, deller@gmx.de, maxime@cerno.tech,
        sam@ravnborg.org, msuchanek@suse.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, geert@linux-m68k.org,
        mark.cave-ayland@ilande.co.uk
Cc:     linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-7-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-7-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Move some of simpledrm's functionality into a helper library. Other
> drivers for firmware-provided framebuffers will also need functions
> to handle fixed modes and color formats, or update the back buffer.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Nice patch!

[...]

> +
> +/**
> + * DOC: overview
> + *
> + * The Firmware Framebuffer library FWFB provides helpers for devices with
> + * fixed-mode backing storage. It helps drivers to export a display mode of
> + * te correct size and copy updates to the backing storage.

the

it is "backing storage" or "backing store" ? I always thought that storage was
used for non-volatile media while "store" could be volatile and non-volatile.

[...]

> +/**
> + * drm_fwfb_init - Initializes an fwfb buffer
> + * @fwfb: fwfb buffer
> + * @screen_base: Address of the backing buffer in kernel address space
> + * @width: Number of pixels per scanline
> + * @height: Number of scanlines
> + * @format: Color format
> + * @pitch: Distance between two consecutive scanlines in bytes
> + *
> + * Returns:
> + * 0 on success, or a negative errno code otherwise.
> + */
> +int drm_fwfb_init(struct drm_fwfb *fwfb, struct iosys_map *screen_base,
> +		  unsigned int width, unsigned int height,
> +		  const struct drm_format_info *format, unsigned int pitch)
> +{
> +	fwfb->screen_base = *screen_base;
> +	fwfb->mode = drm_fwfb_mode(width, height);
> +	fwfb->format = format;

It seems a little bit arbitrary to me that format is the only field that's
a pointer and the other ones are embedded into the struct drm_fwfb. Any
reason for that or is just a consequence of how types were used by the
simpledrm_device_create() function before that code moved into helpers ?

[...]

> +static bool is_listed_fourcc(const uint32_t *fourccs, size_t nfourccs, uint32_t fourcc)
> +{
> +	const uint32_t *fourccs_end = fourccs + nfourccs;
> +
> +	while (fourccs < fourccs_end) {
> +		if (*fourccs == fourcc)
> +			return true;
> +		++fourccs;
> +	}
> +	return false;
> +}

This seems a helper that could be useful besides the drm_fwfb_helper.c file.

I believe patches 1-6 shouldn't wait for the others in this series and could
just be merged when ready. Patches 7-10 can follow later.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

