Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437C0C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Jul 2022 15:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiGYPCj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Jul 2022 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGYPCj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jul 2022 11:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81D5363F2
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658761357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHZGGE+UaT0lsujpHFYRwMapEZrOG0uqXxvqP8vp3jo=;
        b=GuvSgrGb5hYzZdz433UTXHO6rMonZw/5z9p0rTPC03wi4dB1BuYRkqnEmPuWEb24syNYEH
        YKR/iMGwq6i5ngd+vMdlYxVN9s/GqBJ626wKR4DPGkbmBnP7YhJ5Tdjugx7IUIIx0z/vcZ
        UZOTyhZJsZRkYVpAVzY7/alozYejP+M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-I6n-EbuUMwyRtWcJPSF0Zg-1; Mon, 25 Jul 2022 11:02:36 -0400
X-MC-Unique: I6n-EbuUMwyRtWcJPSF0Zg-1
Received: by mail-wr1-f72.google.com with SMTP id e5-20020adfa445000000b0021e45ff3413so1659643wra.14
        for <linux-fbdev@vger.kernel.org>; Mon, 25 Jul 2022 08:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vHZGGE+UaT0lsujpHFYRwMapEZrOG0uqXxvqP8vp3jo=;
        b=Sr+7qAvodkHsOpDyN563TAzgUOZGCnx1yAKpY6BBnWGl9HTcIKaIjvOmhSOyTu4udz
         Y78NlQfBiSAIM3Wpu6UkncBA3OjbxZMrtYUoVrcVp6U9xrQVx+vcvqh6prMwqMRRfUC2
         JzRzMgYv6Mc/9iO9GnPPeWExy68z7gNu6CFP48f4/ElVVdWOG5EWJvAg52yOlN9So4Zv
         m3WR927yaB+AbzYN8nLD3ZzVhdPtjaskThBpVAh2njfALOb+hKSkWwGKguqSyZOBHTKu
         xRpOb3WZHZhDdKexYMWJ0drIFJUmgm6j0BS+9wYkkLFht3jagRLy0PP4luZj28hRnTBC
         vNAA==
X-Gm-Message-State: AJIora/TJ4p5vd1oAAuYeI/CUqb0ngHc+xaGsdhNtjvAMnnF+sPS1fpL
        Nkvp9NXr/2kv9tmQAnFnwpyEWFS63x7OTJbxNYh2V4NVdJASqce+PYT+8/7KhWTHkWb7ByW1q4c
        Sg6InkcQRmFVDJ8AwOeLDfdk=
X-Received: by 2002:adf:fd42:0:b0:21e:4357:3f38 with SMTP id h2-20020adffd42000000b0021e43573f38mr7802991wrs.620.1658761354386;
        Mon, 25 Jul 2022 08:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1up2wqjTlCDkbuerUzqw3y4Lua29GD9rdcA18jLXX1pQ9fCVhFmF2mw6dWG6b5ahUovhc3P7w==
X-Received: by 2002:adf:fd42:0:b0:21e:4357:3f38 with SMTP id h2-20020adffd42000000b0021e43573f38mr7802975wrs.620.1658761354219;
        Mon, 25 Jul 2022 08:02:34 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o27-20020a5d58db000000b0021d80f53324sm11992170wrf.7.2022.07.25.08.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 08:02:33 -0700 (PDT)
Message-ID: <307f7551-aa47-ea36-ea58-ab4c552dca38@redhat.com>
Date:   Mon, 25 Jul 2022 17:02:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 03/10] drm/simpledrm: Remove pdev field from device
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
 <20220720142732.32041-4-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220720142732.32041-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 7/20/22 16:27, Thomas Zimmermann wrote:
> Replace the remaining uses of the field pdev by upcasts from the Linux
> device and remove the field.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Much better indeed.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

