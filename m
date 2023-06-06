Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82114C77B7A
	for <linux-fbdev@archiver.kernel.org>; Tue,  6 Jun 2023 05:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjFFF2i (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjFFF2g (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 6 Jun 2023 01:28:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DF01B3
        for <linux-fbdev@vger.kernel.org>; Mon,  5 Jun 2023 22:28:34 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so25210495e9.3
        for <linux-fbdev@vger.kernel.org>; Mon, 05 Jun 2023 22:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686029313; x=1688621313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mJOXSF88DjPrnCYvhp794YSBiOIag1Qb+70cCdfwYxU=;
        b=kPBHfTSe+3iTgyI53dScjnFVlv+5aI5Dq2IL68wZAwPflgnKzBa09ymP0f7PGhDCZX
         CrqY3Jlrpz2aX1JIXn/3FX+D/nRO2hcfOZI6PaMbbOlNIMoNvzO305kQaMJaAWjpH7Gx
         PWfaDq871RrRGMSrPWtOSI5GOstsH9UNXUegz2AVPdcc0DYDa7SVK0V2LhLq1rCL5/Rj
         CMEm+84URhyrfyZ4zlxBlxDZxstC+d5zEMsTVICDBCOK/OToigswOLCtsiFJoA3NjumT
         iPH6Uo0dSBFMa9CA0dMPHfyM9TtnsdladS07MzE+lJnRjEP1u6Mzt6XLhlioBaAXsvtO
         wCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686029313; x=1688621313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJOXSF88DjPrnCYvhp794YSBiOIag1Qb+70cCdfwYxU=;
        b=CMNUJK/aYdPKmu+GqdXlrHEY7jBn/kRpd5tQ8k7XINcQhwH5ZPgx4tIpWgsFLDAoni
         5BHycsUxuEU5xSuzC8T1Cin+jCwjbrqgpnvWjBKMVrjtiZ/OARB6+XNklcmogXTxj/Co
         yKgTc0PXXWxQ8dyrlyteugVMQxx43NPfHsbypf1+wrLtgCWYMNgCEV6kqqz0N3n0lKEI
         3fAUoNdh79vOumafaN/plaTL5jMpeZ1bXLmkgzdRj0G1xzb2PuGlj2F2bfpawGzm4y0t
         o8pxqpY8xEo1ISMHm1udwVfrWuwy3mjqzKfEopXY1O4d0Hv0744vjwBZyth7+rAMhmcC
         irMw==
X-Gm-Message-State: AC+VfDyHPUiMZPUxO4BWB916XzAE/7xiwbBexikGRk0TzXhaZLSgkRXp
        OagPiL0Y+sGJTlffMdMZRREk9Q==
X-Google-Smtp-Source: ACHHUZ53mQ64foMYdD4WiJ9aXcXW/Mh9UVrYMszuUl5utsyKjRZqTF91fgc6UpYXQ5nOqZPoVHtjhQ==
X-Received: by 2002:a1c:770d:0:b0:3f4:2770:f7e9 with SMTP id t13-20020a1c770d000000b003f42770f7e9mr976047wmi.17.1686029313452;
        Mon, 05 Jun 2023 22:28:33 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f4-20020a7bc8c4000000b003f7e717c770sm3198157wml.23.2023.06.05.22.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 22:28:31 -0700 (PDT)
Date:   Tue, 6 Jun 2023 08:28:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, javierm@redhat.com, sam@ravnborg.org,
        deller@gmx.de, geert+renesas@glider.be, lee@kernel.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 18/30] fbdev/radeonfb: Use hardware device as backlight
 parent
Message-ID: <f1bb576e-88cb-4c5d-a7a6-d45ffc48edb3@kadam.mountain>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-19-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605144812.15241-19-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jun 05, 2023 at 04:48:00PM +0200, Thomas Zimmermann wrote:
> Use the hardware device in struct fb_info.device as parent of the
> backlight device. Aligns the driver with the rest of the codebase
> and prepares fbdev for making struct fb_info.dev optional.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Benjamin Herrenschmidt <benh@kernel.crashing.org>

You left out the Cc:

regards,
dan carpenter

