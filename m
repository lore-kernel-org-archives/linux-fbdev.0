Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6650C678D5
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Mar 2023 07:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjCHHjC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Mar 2023 02:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCHHjA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Mar 2023 02:39:00 -0500
X-Greylist: delayed 241 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 23:38:47 PST
Received: from h-241.webit.at (h-241.webit.at [213.208.138.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978632716
        for <linux-fbdev@vger.kernel.org>; Tue,  7 Mar 2023 23:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=winischhofer.net; s=rsa1; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=np2VeMjbFObtnEPKwHULGC9atl9R6YcO1ecS1ymUv9w=; b=NUwKJgdS/D7HyEhaJ8BQic2610
        7+RzyW6H8ns30uSFexbfPEAN/sZmaUUhdOrMqW6MOsmLpfXt2V8OJ4TZN9gL6jmeInz+uWDFvoD76
        ZH0lD4Cvw/nABr5LHHynklz8et3O2M0VWK53cd7qFfOeFvoXt3SGiPKiMlJdOT9IyMwU=;
Message-ID: <59fee461-5aa5-dc66-2470-df55eaf0fe76@winischhofer.net>
Date:   Wed, 8 Mar 2023 08:33:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH] MAINTAINERS: orphan SIS FRAMEBUFFER DRIVER
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308071921.10963-1-lukas.bulwahn@gmail.com>
From:   Thomas Winischhofer <thomas@winischhofer.net>
In-Reply-To: <20230308071921.10963-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


Confirm.

/Thomas


On 08.03.23 08:19, Lukas Bulwahn wrote:
> This was triggered by the fact that the webpage:
> 
>   http://www.winischhofer.net/linuxsisvga.shtml
> 
> cannot be reached anymore.
> 
> Thomas Winischhofer is still reachable at the given email address, but he
> has not been active since 2005.
> 
> Mark the SIS FRAMEBUFFER DRIVER as orphan to reflect the current state.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5d8f46f35aa4..354577534aef 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19191,9 +19191,7 @@ W:	http://www.brownhat.org/sis900.html
>  F:	drivers/net/ethernet/sis/sis900.*
>  
>  SIS FRAMEBUFFER DRIVER
> -M:	Thomas Winischhofer <thomas@winischhofer.net>
> -S:	Maintained
> -W:	http://www.winischhofer.net/linuxsisvga.shtml
> +S:	Orphan
>  F:	Documentation/fb/sisfb.rst
>  F:	drivers/video/fbdev/sis/
>  F:	include/video/sisfb.h
