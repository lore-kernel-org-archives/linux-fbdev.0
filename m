Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9BAEB64D7
	for <linux-fbdev@archiver.kernel.org>; Fri, 23 Jun 2023 11:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjFWLcp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 23 Jun 2023 07:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFWLco (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 23 Jun 2023 07:32:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764A295A
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Jun 2023 04:32:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31121494630so625685f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 23 Jun 2023 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687519930; x=1690111930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P9ZwMVs40czKD5XDSrs3iEN9LA7uWnLI8CR5BnKA0UY=;
        b=CBjeN7Yvl5QDbituklmqZYeodwleXYQass+yos6URLcHssixFhCMZxvF+jOiJBronY
         TUc+FzMyHVmqqqWiV9V+k5l6twTk122i3RyDlVkNHI3MWhcxB6hJgbF81mldq2SB0/o4
         +TSgcFT7VMD+sL+b8QR5RByGb5dEfhRF0t4C3w3BJBiJ2+UdO5VsrRvXs3LNp6ofdMjA
         kDgPzaJc8xIdR8XyFaJuykoj1vS04qnfS239pyKpQrtH4itrndfzksqWEYdq6rF8AQq/
         PhsCgdhin9pB5O5vUA8m9f+mNTumHP8dApeX+y6jtCT4yI/ogr8Conin9X3SJ2MG2PpU
         0u9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687519930; x=1690111930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9ZwMVs40czKD5XDSrs3iEN9LA7uWnLI8CR5BnKA0UY=;
        b=JpomLFMD8ikVkQN8WByS/JQwIU0SM9NsFqnNf60+ecYmSlWDdtipnRl/qwZyPK1Fky
         1fxT8zWdUlbFdn+hrYAFquGUsEkmgnrzIqIXtiEPbjJhbgbq0w4Ntw290x/KcidFGreS
         GMFEYxLWQpg+KSBspDM0L53R02k0lXEG6C/4sHm/MfqkMSk1Uh1DndArKS/GB75fNV6V
         cEmWZZ5gn6LyLJonYbxEM6rO52/k1AO+Ai9j7BAEH0xFP8vjNRc82UVF5ybQ8DhWLgqC
         F4ovsWVBiHxX7XN5H53Wp/SY9ciL5YJnQCaZHnVwinBhuDbxwsgi358C3VTIpx+e56/c
         Dzhw==
X-Gm-Message-State: AC+VfDzx2/joA0Rn8B21aY8PbgWrG9fz1zpmfJxZMokrspmtUm61u+t6
        k+gz5sS0g3j/vX++nfXPrjjuzA==
X-Google-Smtp-Source: ACHHUZ4yGE7Jj/528UNR5dVYTd1jl6cieW71vsAHwRVCrwh0+5oIyPiflT16AwEbtFUCmIfx+HhwlQ==
X-Received: by 2002:a5d:5751:0:b0:30f:c943:f925 with SMTP id q17-20020a5d5751000000b0030fc943f925mr16966957wrw.49.1687519929755;
        Fri, 23 Jun 2023 04:32:09 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id x7-20020a5d54c7000000b0031270cf1904sm9365570wrv.59.2023.06.23.04.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:32:09 -0700 (PDT)
Date:   Fri, 23 Jun 2023 12:32:07 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        lee@kernel.org, jingoohan1@gmail.com, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        deller@gmx.de, Yannick Fertre <yannick.fertre@foss.st.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: backlight: document new property
 default-brightness-level
Message-ID: <20230623113207.GB4426@aspen.lan>
References: <20230621215457.11297-1-alex@shruggie.ro>
 <20230622021303.GA68330-robh@kernel.org>
 <CAH3L5Qp3q=K5w+LbccZBJqvkz98WgFLqg__y7Be_=-2GsWQs+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3L5Qp3q=K5w+LbccZBJqvkz98WgFLqg__y7Be_=-2GsWQs+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jun 23, 2023 at 10:19:57AM +0300, Alexandru Ardelean wrote:
> On Thu, Jun 22, 2023 at 5:13 AM Rob Herring <robh@kernel.org> wrote:
> > > +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> > >    default-on:
> > > -    description: enable the backlight at boot.
> > > +    description:
> > > +      The default power state of the backlight at boot.
> > >      type: boolean
> > >
> > > +  default-brightness-level:
> > > +    description:
> > > +      The default brightness level on device init. The value can be 0 or 1.
> > > +      If omitted, the value is 1. In the context of the "gpio-backlight" driver
> > > +      the effect of this setting will be that the backlight is on/off.
> > > +      The difference between this setting and "default-on" is that this handles
> > > +      brightness, while "default-on" handles the power setting of the device.
> >
> > What power setting? You only have 1 GPIO to control here which is 2
> > states.

There are at least three states: On/Off/HiZ .

Currently the DT description isn't acually rich enough to allow drivers
to safely use the HiZ state so that is not why this change is potentially
useful today (but does illustrate why it is not "wrong" to put it on the
h/ware description).


> > I fail to see why you need 6 possible states with all the
> > combinations of 2 properties.
>
> So, the "default-on" bool gets converted to backlight power settings,
> which eventually gets converted back to GPIO values (at some point).
> Which sounds quirky (when saying/writing it).

Modern DT practice is to for the display to link to backlight. This
gives display control over power state (so backlight automatically
follows the display power state). On such systems the backlight will
be turned "on" when the display hardware comes up (regardless of whether
or not default-on is set).

Thus this control covers the case where we have a display that is
readable when the GPIO is off (e.g. transflexive LCD or epaper).
A display that is readable with the GPIO off means the default
brightness brightness at boot can meaningfully be zero. In this
case the backlight is nominally on but the GPIO is off.

In short, this becomes part of the hardware description, rather than
merely being a driver feature, due to the effect of linking display
to backlight in the DT.

Note also that most backlights do expose on/off via DT for the same
reasons (when the off and zero states both result in the backlight
output pin doing physically the same thing).


> But, yeah.
> That's one thing that also made me a bit undecided to send this.
> On the one hand I like the uniformity it brings.
> On the other hand, because there is the legacy behavior (the
> "default-on" property, and the fact that we can use the GPIO DT
> settings to control this) just explodes complexity/quirks.
>
> We can probably just drop this.
> I'll also admit that my doc-writing skills aren't too great.

It may be potentially useful for people building kit with sunlight
readable displays and trivial backlights as a backup in the dark.

Of course if the pin the backlight is connected to is PWM capable
then the PWM backlight is probably a better bet ;-) .


Daniel.
