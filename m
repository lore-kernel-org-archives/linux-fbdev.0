Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DCAC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Dec 2021 21:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhLAWBS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:01:18 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:45759 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhLAWBQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Dec 2021 17:01:16 -0500
Received: by mail-ot1-f47.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso37241528otf.12;
        Wed, 01 Dec 2021 13:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=//K6WrNNdMpHYOkOWh74IhNe5APWD9tbaI8fuCB3qaM=;
        b=Dj+usNvD5Dz3MSXKP8tG/RIq1xgzXHp2jm64vbJYERP8RR7cBXjTB7AvtCr6O+rKUD
         GRQfex+XRDjmQ3FaLBY+7U9+7HJAq0VMYDxgtpzlDQyz1GLganGE5AWy3eUk2tkXKBRb
         i8Xs1vo3/uIIB7oItzj4/qRkA7W0PvBCjvum3I1ea89QqGqGRRXkWBjGnU0MXiV24Xd8
         D/xGtPc1oYitxZOQwNCwUupyKYDajOeLi65x0eyNiLTMUNLGgNEDY9+rLjVexex3H0RV
         XkW3XV1Hy7gRwaOboPv6wn5PoVY/LxfrbkPgwOJG/4ROFy69BNrLkYrWv05DEjVnevjI
         9DpA==
X-Gm-Message-State: AOAM531jkjNc228dD2qr0s/px9ofOu1i1nRaa5WzXfUZryWhaP+pd6Nd
        gGtVZ6yNNfAnLwSybiBjGQ==
X-Google-Smtp-Source: ABdhPJxU0ByCUmBkqgOAJ1D4kaYrkltxru1tMYSyrRfbzYfu6ugRNzCqfZ2w09Xc+nuehdoGMGvvQQ==
X-Received: by 2002:a05:6830:4391:: with SMTP id s17mr8280415otv.118.1638395874824;
        Wed, 01 Dec 2021 13:57:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u136sm479201oie.13.2021.12.01.13.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:57:54 -0800 (PST)
Received: (nullmailer pid 2750212 invoked by uid 1000);
        Wed, 01 Dec 2021 21:57:53 -0000
Date:   Wed, 1 Dec 2021 15:57:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     maxime@cerno.tech, linux-fbdev@vger.kernel.org, robh+dt@kernel.org,
        dave.stevenson@raspberrypi.com, linux-staging@lists.linux.dev,
        david@lechnology.com, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 3/6] dt-bindings: display: sitronix,st7735r: Remove
 spi-max-frequency limit
Message-ID: <Yafv4ZJ1gDWgWDT5@robh.at.kernel.org>
References: <20211124150757.17929-1-noralf@tronnes.org>
 <20211124150757.17929-4-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124150757.17929-4-noralf@tronnes.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 24 Nov 2021 16:07:54 +0100, Noralf Trønnes wrote:
> The datasheet lists the minimum Serial clock cycle (Write) as 66ns which is
> 15MHz. Mostly it can do much better than that and is in fact often run at
> 32MHz. With a clever driver that runs configuration commands at a low speed
> and only the pixel data at the maximum speed the configuration can't be
> messed up by transfer errors and the speed is only limited by the amount of
> pixel glitches that one is able to tolerate.
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>  .../devicetree/bindings/display/sitronix,st7735r.yaml         | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
