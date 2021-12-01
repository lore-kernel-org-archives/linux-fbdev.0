Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961ADC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Dec 2021 21:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbhLAWAn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Dec 2021 17:00:43 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44916 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhLAWAj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Dec 2021 17:00:39 -0500
Received: by mail-ot1-f48.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso37228750otj.11;
        Wed, 01 Dec 2021 13:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aN8dRcN6+zd7oasgWAONmcRJZK+uIK9pRTcKdcu5dUA=;
        b=DAbrJYMMU6ewaoA8qxAL/6zSWycYDxPTIcdXOPOpG2Nu7ZNNhvrnNItl2/d2pfPVlv
         j/VSgFpVDEuHTwgFvUmWK1uaUXljRrGB+3QvuDjNrY0s5I3wpshtzR+OsirDi7EXeMFX
         z2e0o0VVc5DrR3PJ4W1lmQscWgppS50h3GmgiR3wboTvf7qOcvvRt79z//TsBUukqAxR
         mqKgDUmnioJjIGsuIwNYM5pnU+lssvwY8bbVct4zPNx9ye/kk75j7pJAMofOwbXbiQHI
         I/TdSaJu4zJUlklxWUDunsNvdzTjrC90QX+FzxfTXBLFTtq1z2qHO+I20V5fUDPmA307
         nIwg==
X-Gm-Message-State: AOAM533eWlXtESVhGPVI0+Z6ADCRn6Fm4/WyV4rst1M0P7tLSlGbLk1q
        /hIMuC5x52mCdgKIIsIQJw==
X-Google-Smtp-Source: ABdhPJxqCAXkJXICQHbkkyRujU57Gt2ub99dnsnj7jJyb3igqg9+/2JuSfI76oP3+F8RkuNXG3nXDg==
X-Received: by 2002:a05:6830:3499:: with SMTP id c25mr8435409otu.206.1638395838094;
        Wed, 01 Dec 2021 13:57:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id be12sm612186oib.50.2021.12.01.13.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 13:57:17 -0800 (PST)
Received: (nullmailer pid 2749175 invoked by uid 1000);
        Wed, 01 Dec 2021 21:57:16 -0000
Date:   Wed, 1 Dec 2021 15:57:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, david@lechnology.com,
        devicetree@vger.kernel.org, maxime@cerno.tech, robh+dt@kernel.org,
        dave.stevenson@raspberrypi.com
Subject: Re: [PATCH 2/6] dt-bindings: display: sitronix,st7735r: Make
 reset-gpios optional
Message-ID: <YafvvLHSfY2U4eA5@robh.at.kernel.org>
References: <20211124150757.17929-1-noralf@tronnes.org>
 <20211124150757.17929-3-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124150757.17929-3-noralf@tronnes.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 24 Nov 2021 16:07:53 +0100, Noralf Trønnes wrote:
> There are other ways than using a gpio to reset the controller so make
> this property optional.
> 
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>  Documentation/devicetree/bindings/display/sitronix,st7735r.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
