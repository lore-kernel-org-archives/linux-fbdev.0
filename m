Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49F0C636D4
	for <linux-fbdev@archiver.kernel.org>; Tue,  7 Feb 2023 16:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjBGQFC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 7 Feb 2023 11:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjBGQEv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 7 Feb 2023 11:04:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB25693E2
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Feb 2023 08:04:49 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id y1so14061196wru.2
        for <linux-fbdev@vger.kernel.org>; Tue, 07 Feb 2023 08:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mkf6lOjY+w6DriQTsiaHaBfCPRbIUyjacQUodaIbLxU=;
        b=IUBq3RMtPA3k2MKRTgAfydlMP2qwP0EC81gv4qLy8dAyOBq6pIXbsZ67OTGzT90+qw
         ZAMttaxC9lrUZIQzT9IRp01AeJktYdQLMVNZuH9U4iNDZ2qRLSUJtcHr/MYgQ3Yrquq9
         XYwK7y6inyycbsI07PRq87GMq0tGE062k1JN9+4vhrekZ+j3PDg6T/kjF23V31T+Wa/N
         btSMmWetssqTLRpbKS+q8CNKaHnioeI7FBfNsoF+vOP1PcbvNWNn2aWA1sn0nDuTbVXv
         PeheqzRFdrkj9Hvit6RfZ93rT+bzJNdiBc0Y2uibhh3sLv01uUdfz3mSPBXye/LL9cKC
         kV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkf6lOjY+w6DriQTsiaHaBfCPRbIUyjacQUodaIbLxU=;
        b=hWtsqHb9iAhl9V/S7vziJjuMFBTa9l7JALP39UvRwFJiP13Z/xc/UMCRr36yBoAru0
         hmoj+UzBdDXTGoqkOUTinAyrdVgWH0WuYOcwrWtjPOeiqotVOh2H3WGpGpVhrqakxl/H
         joXxfpkomxbVSB9P/wKftYoZ7W4bRVpl0rR5J6WzyJx61Pgb4mSdzPOvUlGOtgeLn4lr
         YHHu0+BE3bhltEVtfw0OIeoS0s8l1uN5ctWJ4inNp11f0XVClMkbsm+JfkcemxzmKPL6
         H07YQA7T5WYQrbT1NXby7EP+7CbBOtKC+mT4cegNVb9Ln+wBMcF7zJGX1Xpyow7EIcRZ
         Vu8Q==
X-Gm-Message-State: AO0yUKUMGbI6Dx3Oi79Uc1/D35AKKGD/l8F19ImPPeQSzzIAN/EkwRDN
        CCOUksEYfhbUprUfF2u2KFKJ8w==
X-Google-Smtp-Source: AK7set9LgoQq1EFwiHlPQBez/yjb5wqI/qwX7KEaVYJBXi2mBz0UnHVgxLE673PKnV0Mh116yXa5lA==
X-Received: by 2002:adf:e0c1:0:b0:2bf:960b:7282 with SMTP id m1-20020adfe0c1000000b002bf960b7282mr3532660wri.44.1675785888336;
        Tue, 07 Feb 2023 08:04:48 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id bj24-20020a0560001e1800b002bded7da2b8sm11685999wrb.102.2023.02.07.08.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:04:47 -0800 (PST)
Date:   Tue, 7 Feb 2023 16:04:45 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] backlight: hx8357: switch to using gpiod API
Message-ID: <Y+J2nRyDpOE0ihfj@aspen.lan>
References: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
 <Y+DmBGiq9kvRBHLY@aspen.lan>
 <Y+HQfDtiqUso7e9k@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+HQfDtiqUso7e9k@google.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Feb 06, 2023 at 08:15:56PM -0800, Dmitry Torokhov wrote:
> On Mon, Feb 06, 2023 at 11:35:32AM +0000, Daniel Thompson wrote:
> > On Tue, Jan 31, 2023 at 02:57:06PM -0800, Dmitry Torokhov wrote:
> > > +				dev_info(&spi->dev, "im gpio[%d] is not here yet, deferring the probe\n",
> > > +					 i);
> > > +			} else {
> > > +				dev_err(&spi->dev, "failed to request im gpio[%d]: %d\n",
> > > +					i, ret);
> > >  			}
> >
> > These last two clauses should be updated to return dev_err_probe(...)
> > instead.
> >
> > With that change:
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> So you want to actually suppress the deferral message unless debug
> printks are enabled? So you want this to read:
>
>
> 		if (ret) {
> 			if (ret == -ENOENT) {
> 				if (i == 0)
> 					break;
>
> 				dev_err(&spi->dev, "Missing im gpios[%d]\n", i);
> 				return -EINVAL;
> 			}
>
> 			return dev_err_probe(&spi->dev, ret,
> 					     "failed to request im gpio[%d]\n", i);
> 		}
>
> Did I get it right?

LGTM.


Daniel.
