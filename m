Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F3C61D97
	for <linux-fbdev@archiver.kernel.org>; Wed, 25 Jan 2023 07:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjAYH3S (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 25 Jan 2023 02:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjAYH3S (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 25 Jan 2023 02:29:18 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D0E1E1C8
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 23:29:16 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so594711wms.2
        for <linux-fbdev@vger.kernel.org>; Tue, 24 Jan 2023 23:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/zYb3mbFmjgoGxZfiqbziu2v8uAqk6hubRFYbxoSlc=;
        b=t6xI6eMY7T3NthJ8wINZKhVY4l2iBv+ao3N88MgKk0VGCKAVAjNjw8mNfFy8BTBMrG
         XgidFiiVBZBy+anLYqLhffAZjms+FGkPzTpgdgnOnKSncoQUPWV1lcSdkygzL6EmuW9I
         4YPGTwFyfLQOaUhDJF3SpXECnzEX6vwCg3ET5kHJ6xam4Puzf/80T1ksN+VLIA6uATxM
         ZIPYrNJhgunMvk8sPM11Gxirc6WS1IrmdvW+3qz4dhYDIXvg9He/GVuvPhOyqetY2ajJ
         Q0QJkv8Dp6PCcbuqv+Sc2JLYlFXFqJwX6hoB35vzT0V8JsJlK22MFGGMsMDn3OWfyhm3
         N3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/zYb3mbFmjgoGxZfiqbziu2v8uAqk6hubRFYbxoSlc=;
        b=HLHo6Iw4quLU9/9R8td0rd1PpQ08bD5WX/9M3Sxph2XP/npHIaDmaZzxzKEqYge3JI
         Ndgrs45/kh6xz+32wcXKQmNE2xLv9xclQGkF1Izt61Z/3GJily59UajJGam3KLgbUTcF
         ZNugxgLg6c6of2htJHYVWzXnmLuFzTbufGHlxdzY/LhiRKmWujotC8ODDt8Vyz1a8YtF
         U3tpKm62YHXJVRc7tAX6CdEutoSb7s48h0cYJ0Ov8kvv/cV3Ip1UyiQsOi4Ik0KI7Aee
         teMVKtHMHmv0mLroALd321mjC3dqTVMBJkDXYcFCcVTyl5iAjk7Im5yamAHEM6oKzuY4
         gr4A==
X-Gm-Message-State: AFqh2krpQ+imX/CWSrDhFWyt7YTMTDv0B9ttZQxtlysL7bZEafUTIukI
        PqJ5mq9ywSdkM7DWN7Zb7yKTLA==
X-Google-Smtp-Source: AMrXdXt9SGOwxEXr5Ol6TM9T8P204nWihJ4QLUqzCiu7G3/To6p6IruhCE/rq6883y/w0Ulpsu1yqA==
X-Received: by 2002:a05:600c:c05:b0:3db:2252:e50e with SMTP id fm5-20020a05600c0c0500b003db2252e50emr23239325wmb.24.1674631755424;
        Tue, 24 Jan 2023 23:29:15 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g9-20020adff3c9000000b002bfb29d19e4sm2778121wrp.88.2023.01.24.23.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:29:14 -0800 (PST)
Message-ID: <90125055-929b-fdd1-3489-cfdc913594a5@linaro.org>
Date:   Wed, 25 Jan 2023 08:29:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
References: <20230124224142.7133-1-rayyan@ansari.sh>
 <20230124224142.7133-3-rayyan@ansari.sh>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124224142.7133-3-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 24/01/2023 23:41, Rayyan Ansari wrote:
> Document the optional width-mm and height-mm simple-framebuffer
> properties.

As pointed in previous discussion - you should have panel node and take
the properties from it. The physical dimensions are not properties of
framebuffer device. These are properties of panel.

Best regards,
Krzysztof

