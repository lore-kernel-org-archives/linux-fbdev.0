Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BB0C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Dec 2021 21:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhLAWAa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:00:30 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:34400 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhLAWA3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Dec 2021 17:00:29 -0500
Received: by mail-ot1-f42.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso37257209otj.1;
        Wed, 01 Dec 2021 13:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YrRZ+cDt9aijwJi2m8Tkj3TgFbHG9MWj6VoJ8Ts+1zU=;
        b=M0OhF9Xq0ZuZww4QvZ3LhBjwPzVUAPcx9TQZp87yfQFSe73PgrOZOnm7s3njGKqDRw
         j/X+b/EXmo7plzNWzWUyE+8EaDFt8MqiMbDm+PCisJGDEnMImZgEv29O1yWy87K7pFnP
         HPwe+DQEuLSMABVe4G6pkBLhEn/4IXkmzUHEKMMDwwmnB48HSekjash+G6KP5U01o+10
         mrgKwQGMaS8R2fGWzLW5VTz//2i6bGRM1uqT8RyDh7YzQpZxaQKeUAabpK2kQqLG7Jv7
         bPMg/1Ksm8OnnN4qAYs8FVlnCwAsWzs5X1yCcCwd6f/HUMmqTa2kGNj8JBC2Vk32PC+4
         3UpQ==
X-Gm-Message-State: AOAM532wY+IUa81ksVMnN5Fb3Ru3whbUpMZxcuoG9ErNsEKUQDJvrOED
        Mha0Ycx4oGtSYI6JuisHld1ZjtJK9Q==
X-Google-Smtp-Source: ABdhPJziPLuy+LbX4tUcDrFPtbefkHNQNGxg04CykWpyhOEvg829/JhZ5WltvkfPJ+HJXg+GN1Nt/A==
X-Received: by 2002:a05:6830:18b:: with SMTP id q11mr8427647ota.113.1638395826668;
        Wed, 01 Dec 2021 13:57:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h26sm346938oor.17.2021.12.01.13.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:57:06 -0800 (PST)
Received: (nullmailer pid 2748731 invoked by uid 1000);
        Wed, 01 Dec 2021 21:57:04 -0000
Date:   Wed, 1 Dec 2021 15:57:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        david@lechnology.com, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, robh+dt@kernel.org,
        maxime@cerno.tech, dave.stevenson@raspberrypi.com
Subject: Re: [PATCH 1/6] dt-bindings: display: sitronix,st7735r: Fix
 backlight in example
Message-ID: <YafvsMJksKEYn5n/@robh.at.kernel.org>
References: <20211124150757.17929-1-noralf@tronnes.org>
 <20211124150757.17929-2-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124150757.17929-2-noralf@tronnes.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 24 Nov 2021 16:07:52 +0100, Noralf Trønnes wrote:
> The backlight property was lost during conversion to yaml in commit
> abdd9e3705c8 ("dt-bindings: display: sitronix,st7735r: Convert to DT schema").
> Put it back.
> 
> Fixes: abdd9e3705c8 ("dt-bindings: display: sitronix,st7735r: Convert to DT schema")
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>  Documentation/devicetree/bindings/display/sitronix,st7735r.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
