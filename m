Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1376CC27C76
	for <linux-fbdev@archiver.kernel.org>; Sun, 22 Jan 2023 15:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjAVPnS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 22 Jan 2023 10:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjAVPnR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 22 Jan 2023 10:43:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3B222032
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Jan 2023 07:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674402154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IonFMa0lsWsZdfNk5QE4jBoQi/ruUQHMn+oqAHgqoH8=;
        b=hvR1AOBnfzg+8s2xetfkwYYJuvSq5Oy5mctPpo+BivEm3uvzMGvVrd95NuRqyQWqbhUDVa
        HUgUqjCUEhR+QmqAJmDd6m9s9cu452mPRzNhnp1X62+cwI6ZxctwVeaqIM/E9HZov5PsQB
        zVtFRt37ivzGXyX7Ikx8LFM8/fY4df0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-135-XMUo-QupM5CnOsB-0DYJeQ-1; Sun, 22 Jan 2023 10:42:25 -0500
X-MC-Unique: XMUo-QupM5CnOsB-0DYJeQ-1
Received: by mail-ed1-f70.google.com with SMTP id m12-20020a056402430c00b0049e4ac58509so6894508edc.16
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Jan 2023 07:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IonFMa0lsWsZdfNk5QE4jBoQi/ruUQHMn+oqAHgqoH8=;
        b=Nr9hq2/wLRC8syTWJttojnP6teIrDfsF+D4EWeBvfDHSscfyXN8scwBz2D1Ndqk/+C
         kEdVl+zl/ch+jvUw/TFBHYynxoC5aOqLPUqV10aiA6pIbGYl/Qhe8moKYhQkPr5wqG8G
         m1d09v3d9w1P8kAva4E+povTDmgAIeIFVtnYcHJ/yhOSLbmIRHHl4Nx7Mi3kPY7QKT7+
         O/VH8IdirZ7kE2R/MyToN5m0nRD93hakbwo2KgIfkXsNoBgpKeAfQjexgO/jrfxMRsLw
         HBkHvl09PFwUanoUeOi1DEXHuU+lhyyPAmhHfQA5siF8x00NxPILupUbTph7E5gyuORs
         lcGQ==
X-Gm-Message-State: AFqh2kpLkr/TPCZPxVhHv7aLClj0YOFwzk7KXI9nIuyF9uHiuvyC11iT
        kzcMl48bwHCkk8uObvSg4iraopQcKO4bvoL+ta2rdMiFiNPzRUn6UwdqGh6CpqYIfxic08BMfse
        JJyR9P3AB7hu79Rmek6b9rCM=
X-Received: by 2002:a17:906:b317:b0:86e:5124:20b0 with SMTP id n23-20020a170906b31700b0086e512420b0mr24453774ejz.64.1674402144011;
        Sun, 22 Jan 2023 07:42:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvxYtwlzriBymW6Z3D7aPp6YK0SgRgIwBhy9+XTG6Yr2FXU6lFqP+zhk9rsn87ItyMtBAKvXA==
X-Received: by 2002:a17:906:b317:b0:86e:5124:20b0 with SMTP id n23-20020a170906b31700b0086e512420b0mr24453748ejz.64.1674402143767;
        Sun, 22 Jan 2023 07:42:23 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id mb9-20020a170906eb0900b0084d34eec68esm19871820ejb.213.2023.01.22.07.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 07:42:23 -0800 (PST)
Message-ID: <efcca646-5dc3-359a-5453-2fe241af8f8c@redhat.com>
Date:   Sun, 22 Jan 2023 16:42:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
Content-Language: en-US, nl
To:     Rob Herring <robh+dt@kernel.org>, Rayyan Ansari <rayyan@ansari.sh>
Cc:     dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230121153544.467126-1-rayyan@ansari.sh>
 <20230121153544.467126-3-rayyan@ansari.sh>
 <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On 1/22/23 16:36, Rob Herring wrote:
> On Sat, Jan 21, 2023 at 9:36 AM Rayyan Ansari <rayyan@ansari.sh> wrote:
>>
> 
> Why do you need this change?
> 
> The 'simple-framebuffer' contains data on how the bootloader
> configured the display. The bootloader doesn't configure the display
> size, so this information doesn't belong here. The information should
> already be in the panel node, so also no point in duplicating it here.

The idea is that early boot code which uses the simplefb node (no more
complex display driver loaded yet) knows the panel's DPI so that it can
decide if hi-dpi rendering / scaling is necessary or not.

This definitely is a useful feature to have.

I guess that for dt systems an alternative approach could be to
add a link to the panel node to the simplefb dt-node.

Regards,

Hans



