Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEE5C6FD1F
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCPQMq (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCPQMp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 12:12:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30316CB04B;
        Thu, 16 Mar 2023 09:12:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6CA962082;
        Thu, 16 Mar 2023 16:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ACDC433EF;
        Thu, 16 Mar 2023 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678983163;
        bh=zpRv4tbjVYP5AURS7CJU3WXNZ9oiOItNVEJhDibdLaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKKMwIeuDKGRi2k9fqBltprHCMrM4DMlkmzGRs7UtEgFbnqDvNS1edNKZAou//BRR
         O+kK0y1KOgZJtGeYjy+VQShSP5D8NixJZYe7co2JNFgmfStGEp+1wD6VxCLRhwEfTc
         kk26aIlm3eRT4xMv89aPiFvgVQHKnUhgaBKn+NT5xjm8ghKJp2w1iSHNVBcAyxwUFh
         ssobCL8eV39GJRqx6T/wddcWaIZGeOqoqjU4kut18CfI0XF8oYwK52bUthqkM6NNH5
         Il8mhueMtz8gNZ83J/thhhSzvVOWOjQu31XLVocOSdtKK4W1AYfopm7g/vvLJFEhO+
         YKHsBWXEx8o7g==
Date:   Thu, 16 Mar 2023 16:12:38 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: hx8357: Use of_property_present() for testing
 DT property presence
Message-ID: <20230316161238.GS9667@google.com>
References: <20230310144730.1546101-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310144730.1546101-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 10 Mar 2023, Rob Herring wrote:

> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/video/backlight/hx8357.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

--
Lee Jones [李琼斯]
