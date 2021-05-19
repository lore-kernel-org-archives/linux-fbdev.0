Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5766AC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 21:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 278A1611AD
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 May 2021 21:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhESVgp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 May 2021 17:36:45 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:33630 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhESVgp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 May 2021 17:36:45 -0400
Received: by mail-oi1-f175.google.com with SMTP id b25so14540791oic.0;
        Wed, 19 May 2021 14:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2rgWWzmu9+l/+keqWvE5o3R7X9qXR0ySXAn+ph51bgs=;
        b=D830CuH6Noa+O2Hq0Crom2p9enNfgVF6VuiMH5Ak5Lj7GhWcTv7rN8sHyYRAv9+cvo
         8xFVD0QQzP+nNAGQx2c4wrwVO0+2yDd06cqkfNqoBu3MnnWatAHx0lRmRr57fbxEDYUe
         g893kW+f+RzlWX3lSbGFsk0BSoAmv/fHlRObsOW2pLof/rxI53ljXEvmnCW4EPNXL5OO
         X0Ly0qWAw/oHygy20wy7RrIeCLBOzEAf4QzYiiXTpSq4QWvU0QAwS6gdfkW8frlre5jB
         /fxdE3gvg/0iRkJX+j2IZEe+Le01eHKWrry0Gw73HGfF7BIqx3UD/vh8+3q6gqb8uSe/
         Klpg==
X-Gm-Message-State: AOAM531RIpkrzGuvqdl+dZa1xzp6cqdE8wSqsLx9ecjE7LCSseAYWKyI
        N2oJlhk840keklm4CPzxaMZ+yw7qqA==
X-Google-Smtp-Source: ABdhPJyxgegfTcfNU9tUV1HgiyoVr8+U6uW9P8E1qSVwfvrfm/k357lHNjRPmR4qmC2FQCMHyZdaag==
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr964288oiw.31.1621460123905;
        Wed, 19 May 2021 14:35:23 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e20sm132049oot.11.2021.05.19.14.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 14:35:22 -0700 (PDT)
Received: (nullmailer pid 3694182 invoked by uid 1000);
        Wed, 19 May 2021 21:33:46 -0000
Date:   Wed, 19 May 2021 16:33:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: ssd1307fb: Convert to json-schema
Message-ID: <20210519213346.GA3694120@robh.at.kernel.org>
References: <20210518075131.1463091-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518075131.1463091-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 18 May 2021 09:51:31 +0200, Geert Uytterhoeven wrote:
> Convert the Solomon SSD1307 Framebuffer Device Tree binding
> documentation to json-schema.
> 
> Fix the spelling of the "pwms" property.
> Document default values.
> Make properties with default values not required.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> I have listed Maxime as the maintainer, as he wrote the original driver
> and bindings.  Maxime: Please scream if this is inappropriate ;-)
> ---
>  .../bindings/display/solomon,ssd1307fb.yaml   | 166 ++++++++++++++++++
>  .../devicetree/bindings/display/ssd1307fb.txt |  60 -------
>  2 files changed, 166 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/ssd1307fb.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
