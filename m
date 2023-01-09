Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0323FC54EBD
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Jan 2023 11:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbjAILDI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Jan 2023 06:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbjAILDG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Jan 2023 06:03:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249314086
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 03:03:04 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d17so7753176wrs.2
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Jan 2023 03:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zefo0+cIWrVM5FFfr0NEPPr+QlP+S4JK9M0A8dYdzso=;
        b=oGr26Y/fiwHYFqrJohN/Z+dunayrmT0xuC0ParAo9r2mbdlha7JmZ5TehQNI7/mIWp
         hWSaPL393d7ahA2QrXLa47EcjFnu5YT3Jb1N9fthnTAQrjCxXX5POnD6hWqlfRrvA5rI
         D/zve+wX42+oAgMs/sBQZoe1LdpaOjZRMLxj9/pt72r0tOe0R/+AjRzibKCDbZ/OAUkz
         Q0BxMJI//BsazsVVwnI2dgwGh987r5dh+ydGEkKrBjeM7d2rKYJ1AA6ZN5E5Avw5UebQ
         EnTIpNqs1kyVGp6yaaqvQXZQzoIn0NGA/pp6hh/yoW71e/0duhXVOBRms7rLUxGdJdLd
         s8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zefo0+cIWrVM5FFfr0NEPPr+QlP+S4JK9M0A8dYdzso=;
        b=Swdz8zpUpBzZZ1q65s3dg1eRlhzw654SvTiAD7r/XK+JzgbLm4s33s7rd7D1SrDirC
         YQIXA4fyZ44L3g4iSisvRWnTQ4LW1ZVfPD3oPnAfZb+COLjhvZXACSP1BynnyY2lAxqc
         TOSnuTs68CHYpIZTO3WY/KIkrrpBtnwqjdalaOvXhMfXOLHP1ZuF3mQ1v52G/GOwmeWK
         4q+YQEERVNPLVfgHaeX63hIJexo0yQlR9gcQbxyBCOfjM0KqnytOYRnPpQbxABxcCKG7
         +QrK4tf8MIheOk3XptVURUKQRHciVr0F2e3UI6g6dTSPpovySvPaohE1bNbQVJhKSivM
         xFxQ==
X-Gm-Message-State: AFqh2kpru3nywV1D0mROFW7Y/qVxV+LE4sl6Begdbvat6anaUYzOqcW/
        dnM3wC2+oPo1DcKOXJYSw5fiyg==
X-Google-Smtp-Source: AMrXdXuJ229PsMqnsutJQhmCnDx582UTxhRGjYEWDOJCs8UDfbNlBoANEOulxPZfAp5vzNYgBBmlzA==
X-Received: by 2002:a5d:56cb:0:b0:28d:66c4:3102 with SMTP id m11-20020a5d56cb000000b0028d66c43102mr23679733wrw.12.1673262182985;
        Mon, 09 Jan 2023 03:03:02 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o14-20020a5d58ce000000b002879c013b8asm8250053wrf.42.2023.01.09.03.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:03:02 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:02:59 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     sam@ravnborg.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, Stephen Kitt <steve@sk2.org>
Subject: Re: [PATCH 13/15] backlight: omap1: Use backlight helpers
Message-ID: <Y7v0Yw3kg9E8j5Bu@aspen.lan>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 07, 2023 at 07:26:27PM +0100, Sam Ravnborg via B4 Submission Endpoint wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
>
> Rework backlight handling to avoid access to the deprecated
> backlight_properties.fb_blank member.
>
> The rework includes removal of get_brightness() operation,
> because there was no read back from HW so no use for it.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

This rework will result in additional calls to omapbl_send_enable()
during updates so, if anyone who cares about omap1, is filtering LKML
then a Tested-by: would be nice.

However, I doubt the additional calls will do any harm so even with
that absent:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
