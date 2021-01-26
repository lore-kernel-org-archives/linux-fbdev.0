Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8515EC433E6
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 13:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DEE206C0
	for <linux-fbdev@archiver.kernel.org>; Tue, 26 Jan 2021 13:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391808AbhAZNP1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jan 2021 08:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391772AbhAZMpp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jan 2021 07:45:45 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B420C0611C2;
        Tue, 26 Jan 2021 04:45:05 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r4so9690760pls.11;
        Tue, 26 Jan 2021 04:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=9a81CG4SHOE28Bf8JJ1zvGq039y62JTzwIy7vae083Y=;
        b=ky0kWgI1LhXYaXsAmJ3DPyuoBYZMViZexpYgH+lpR2fKLFGoegxnu9/k3rbGHODZyk
         Yr14jWtSXW7v5rStY+WOtp92vmAz+CqAlEcMBJxOQ9Bc6GjQbc/+4kUd9iNE3tLWEb3G
         VVlFyl4iftXuDICb/Gg9Sz8lFN1hxhWZwgHLDGw4Kl7N1RZIdUSdtG+fu7ds1ah1OwVi
         djgCyNSy9SP1y1FVl7T9/TstnplOWbfR7P4Uo2pgV1Orns/GptBAzM512RQAnKJKaXHw
         9LEHAGFBou2Fk8FhC4h+8/uYPOP3zBGt00OV3ir+5PbX0F3vwhq2/pUDGfd/nU7lAA3i
         hOTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9a81CG4SHOE28Bf8JJ1zvGq039y62JTzwIy7vae083Y=;
        b=X8UCF87zR495Cu3FMe7aIQ2jHdh53eCCgQneQ7oAqdsZRdEFBIDPkaLsp4vxJO8bE5
         t0gHx4aYLXk9BTDtaA6JBbbGjGCJO9K6/pBPEhKkzDXMCfBtyQcsIqa+ht91dBt9c41x
         /nfUREMxyO7HdlXnI9io3stu7J5DPeBQ9jyOedAp3QVD334PFNTJ2fVOO7GcZ0eamvcy
         5iHzzi5lRiVIeuGhUYhuGXjcmCTL8hIwLj925pReHoOvQdF4nVmgr3Zx/6RF44zRYg/R
         NTwOiJJ5DL2ZcqYMrVd+6mlyd4O4Atc2zfpMckuOC0ewropYM0z3UnRWTWUDcOMBiMGp
         CXpg==
X-Gm-Message-State: AOAM530Etcdzg0c2ojWIfM67u9PnbXUcI2JVK16aak+NYvQaJHDJmTg5
        z7tdDXDr3QUhi+0dzi7sCpM=
X-Google-Smtp-Source: ABdhPJxiCb7QZ0TikxQ7E5YkT7Pg9cG8f+dof/LTW/qDOqRE5N2oICgGiXNuVElqx4NoD4DJGnZazg==
X-Received: by 2002:a17:90b:fd3:: with SMTP id gd19mr6134207pjb.129.1611665105027;
        Tue, 26 Jan 2021 04:45:05 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id b203sm19214968pfb.11.2021.01.26.04.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:04 -0800 (PST)
Date:   Tue, 26 Jan 2021 20:44:59 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Subject: Re: [PATCH v2] fbtft: add tearing signal detect
Message-ID: <20210126204459.00002b7e@gmail.com>
In-Reply-To: <20210126081745.GX2696@kadam>
References: <1611564252-84205-1-git-send-email-zhangxuezhi3@gmail.com>
        <20210126081745.GX2696@kadam>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 26 Jan 2021 11:17:45 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Jan 25, 2021 at 04:44:12PM +0800, Carlis wrote:
> > From: "carlis.zhang_cp" <zhangxuezhi1@yulong.com>  
> 
> I was really expecting that you would fix this and Signed-off-by as
> well.
> 
> regards,
> dan carpenter
> 
I have fix this in patch v3
> regards,
> zhangxuezhi
