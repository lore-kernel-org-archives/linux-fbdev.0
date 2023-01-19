Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C1C004D4
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Jan 2023 14:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjASOuI (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjASOt6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 Jan 2023 09:49:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B26F304;
        Thu, 19 Jan 2023 06:49:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF7861B75;
        Thu, 19 Jan 2023 14:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F10C433D2;
        Thu, 19 Jan 2023 14:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674139784;
        bh=Nj0bt9bd3JDbtdvpPvykPH8iGTPAgO0G9hvoRoH1WvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3skYmbaykIsDQm0MwcnKr1N0B5E4FJTX8qU/BP4V4S+KQBewh9UpgUpEtj+BtCnK
         jk9fUR3XI7DCmUDxh6+vDnQcUFs89GqjSKN/FsTfqLeDaCjPiikpNq3lvfOn8WQHx/
         3UdBh8j8uHgE04Bw5/dZRERlT0/WqBs5IIA5mrtHs8iXu5CXopi651X6xY+MJ1sktt
         jxhUrMKTxTFtfzy/bGgaDxWv3Kw5uaSELV1L3e2kKBTpiG+0aMVVUr/sX0DPk84dxh
         mwLUGx7XV/BHORoyqt9dZez1csDTmEnE7hwEGMequ1icEY3mbolIlpvnArSpb4FOxn
         uh4YDtDHPCZWg==
Date:   Thu, 19 Jan 2023 14:49:38 +0000
From:   Lee Jones <lee@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: sky81452: fix sky81452_bl_platform_data
 kernel-doc
Message-ID: <Y8lYgv2LP1Ywbq7z@google.com>
References: <20230113064118.30169-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230113064118.30169-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 12 Jan 2023, Randy Dunlap wrote:

> Correct the struct name and add a short struct description to fix the
> kernel-doc notation.
> 
> Prevents this kernel-doc warning:
> drivers/video/backlight/sky81452-backlight.c:64: warning: expecting prototype for struct sky81452_platform_data. Prototype was for struct sky81452_bl_platform_data instead
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/backlight/sky81452-backlight.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
