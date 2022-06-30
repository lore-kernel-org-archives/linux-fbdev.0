Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D525C43334
	for <linux-fbdev@archiver.kernel.org>; Thu, 30 Jun 2022 23:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiF3X17 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiF3X16 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 30 Jun 2022 19:27:58 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109F344A26
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 16:27:52 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 93-20020a9d02e6000000b0060c252ee7a4so549850otl.13
        for <linux-fbdev@vger.kernel.org>; Thu, 30 Jun 2022 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SH4c10UHd2jm5iXZMsMlumPvXgKDKSukPGr/j2MwBes=;
        b=DOYeB54ERnxkc8KCdfg/9ohDBPJKXF4Zj3owMi8p+AOUa5ARLSnQ6//fWAcXaUSeYo
         pIbJo7hLhKev5eib3IyLpSXkMUnnDGAeqPNe8oSsRGAG/ReIqkW/mKCkXzKhz0k0zx7P
         XiC1PDBqdFcx69rKuM+WWlCRM4kpBxZ2tDOdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SH4c10UHd2jm5iXZMsMlumPvXgKDKSukPGr/j2MwBes=;
        b=gC28VET48yi06oLdQltqserr/nNlFrI0+ydnFBezi7QBiMn1taj7iEa5+NXLr+cN/f
         VLW+rpuWYqbfEaPqGrB7h87qBIAvz1fJCBbAm7BOIoAJN8bcu0nJ0BJnZVArIEnlB6GR
         DyvUj9OciTwoY/6MUiqHGDLTHaZBMJCzUh5d1IuonOopdhSI0M/3iBstc+jyKCMZh/TS
         VmiOxnL1xBbjSMsI241d0PbTI6wsfk9f0PwMZgkQOLASaMVhqKCrKRQuEk5thd2QbHJR
         0buoqTvJ5IQaIcmHC9wOhvkMEO4Df20YlL+gBK/VOm0sO/mK4cJfzDwg4qbh9UA50F8T
         HSzg==
X-Gm-Message-State: AJIora8iJSSsHNTISU+hXyaQSB85DHTswg7fup3skNbh0gM2M6YnCMCv
        oQgRRi7+Z6UdrXJ85jczhKIeTSfPug8l9MmvCZKk1g==
X-Google-Smtp-Source: AGRyM1uVXOUlD37mLQ7pLmkL8BIEdZdsnlXTlVxy7cY0Oa3nZ1gzq/kLiCUOdFyoe5MDzqiDJ+32/N24XhJQNeSiK8s=
X-Received: by 2002:a05:6830:d81:b0:616:c424:6f22 with SMTP id
 bv1-20020a0568300d8100b00616c4246f22mr5252300otb.77.1656631671458; Thu, 30
 Jun 2022 16:27:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jun 2022 16:27:50 -0700
MIME-Version: 1.0
In-Reply-To: <20220630173328.1369576-1-hsinyi@chromium.org>
References: <20220630173328.1369576-1-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 30 Jun 2022 16:27:50 -0700
Message-ID: <CAE-0n50Pe2=tYeuuhBVHsTV9BqU1huU-w-xMMn-1scj2OxBWbg@mail.gmail.com>
Subject: Re: [PATCH] video: of_display_timing.h: include errno.h
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Quoting Hsin-Yi Wang (2022-06-30 10:33:29)
> If CONFIG_OF is not enabled, default of_get_display_timing() returns an
> errno, so include the header.
>
> Fixes: 422b67e0b31a ("videomode: provide dummy inline functions for !CONFIG_OF")
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
