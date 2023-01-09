Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B8CC5479D
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Jan 2023 11:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237103AbjAILEs (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Jan 2023 06:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbjAILEr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Jan 2023 06:04:47 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996841741E
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 03:04:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bn26so7776925wrb.0
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Jan 2023 03:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1o1h0/8Z9CTd9JzV9HYcBGjMEGQHN88SqgrqMI3CKE=;
        b=JfOf7Ybc+GU1nn8y1UcCvxhLZxdJnTmM6yTssoaGD6iHkSp9kw+vB/gkiSd9BYh1Ev
         0QFxzWP/4tG540eJGRXWjtCmZaqkjyjagRDq8bBhASM3grdf91bjsYv4KgV91OB6++4s
         YsO8YvQsF+0XVZ29S/f//4CfrmOe9Sy50FKX3juIAKrtyF082yVw33n51qKs/qdi7yYI
         5jeqjXKki1UkPiZnTc5D0T6QLRHn9xrUgbQ09ydGm4qnjFUmkdixeoByKFU5eYtKy7FR
         6A31HILTPPT2+/z7YlxLdMYcewFPN71b3Dgv09t0GfYu7LRrYZNWfX48SDylX3W4GzdP
         ASMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1o1h0/8Z9CTd9JzV9HYcBGjMEGQHN88SqgrqMI3CKE=;
        b=ws+3eW1fKiQAbVrEL6RDWZe1wxBNIapUje/b2wAELGW5CWcf/L+ZAx4+p1bioEY43c
         0y+Rozms2OOXOopA2sXeThsO5EYP8sB91Hwagop7cA35v+dXAmWhv0fvXGDk5GUoDt2O
         1Ot2InkJyIpD1hJCOCzyOMW/GB0ND8sU7G1BRkZMHH6pw4sIBgD3RagbSvHuIeeVaPEN
         wWi6J9b/MGeWVZ0/bs+rlSnLY5IBmlzFO/o0repgioWimY7rx90nm7UDAvsSYZZSM6AT
         ASVuagkULXlUWwJsUovN8wuscSvo6pr6qMtf/pRAgVyHJdtuotpCQsO7aKAu22lTMLmg
         bMmg==
X-Gm-Message-State: AFqh2kqEe+94KGcp8Jwl6C3OotPh9dZ9AgQgV54O+ZSn5UP+HE0aIX0k
        hGIEh1qtQ/oitN/xZtJpP+wPZg==
X-Google-Smtp-Source: AMrXdXt0sWws9FC7FmSd3zSlUGnJeOxvVL6lisTvf8bQ3vSNu8uoGcg+vPo7j6+ZFs9pmgtUvQuw9w==
X-Received: by 2002:adf:d846:0:b0:29f:4e42:33c5 with SMTP id k6-20020adfd846000000b0029f4e4233c5mr14183491wrl.55.1673262277116;
        Mon, 09 Jan 2023 03:04:37 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z6-20020a5d6546000000b002bc371a08adsm2060413wrv.101.2023.01.09.03.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 03:04:36 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:04:34 +0000
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
Subject: Re: [PATCH 14/15] backlight: tosa: Use backlight helper
Message-ID: <Y7v0wiBHXy7lH6tz@aspen.lan>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
 <20230107-sam-video-backlight-drop-fb_blank-v1-14-1bd9bafb351f@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107-sam-video-backlight-drop-fb_blank-v1-14-1bd9bafb351f@ravnborg.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 07, 2023 at 07:26:28PM +0100, Sam Ravnborg via B4 Submission Endpoint wrote:
> From: Stephen Kitt <steve@sk2.org>
>
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Just for completeness...
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
