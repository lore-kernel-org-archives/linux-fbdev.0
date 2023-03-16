Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD15C7618E
	for <linux-fbdev@archiver.kernel.org>; Thu, 16 Mar 2023 16:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCPQNM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCPQNL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 16 Mar 2023 12:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9771259B;
        Thu, 16 Mar 2023 09:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC66B62079;
        Thu, 16 Mar 2023 16:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDD8C433EF;
        Thu, 16 Mar 2023 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678983188;
        bh=g27dXTqF8cc5+DL08sOcgF0turBJEsDQXiN7ampWypE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rd/ImrvcXUQDHjMU2hEvZYEUn8o7nc7Is9kO+QZpGHJzwR5bM33QjOYGKec3ivP1d
         rOLpSXpfPwZ1dvknhlBJzDJk7Ui/iETMh5oext1RfIJSGS89Uw3MY5BV66S5NyEh3Z
         2O9QSpqZ93ls0UKwx8UIvh1TKAVgva9g7DslpD8jyzrBpQwVwdtWPPgJ2xN5SuxdgT
         sykJAWRFRAer5w3pqX23pTQKUsghKboh8TsMcyLK3+rhYDML8n60m96d0h1ME3PExa
         85s0QFkbF++9TqOjFGIys979iXGzqQhkh61P964QN7jpDtOBQRIBP76uG2pJ+Hu6Hg
         eXZEvN9Aet15A==
Date:   Thu, 16 Mar 2023 16:13:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: as3711: Use of_property_read_bool() for
 boolean properties
Message-ID: <20230316161302.GT9667@google.com>
References: <20230310144731.1546190-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230310144731.1546190-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 10 Mar 2023, Rob Herring wrote:

> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/video/backlight/as3711_bl.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
