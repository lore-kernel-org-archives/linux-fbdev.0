Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB44BC433E0
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jan 2021 15:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859D923406
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Jan 2021 15:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbhAGPf6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Jan 2021 10:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbhAGPf6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Jan 2021 10:35:58 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE836C0612F4;
        Thu,  7 Jan 2021 07:35:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j1so3733064pld.3;
        Thu, 07 Jan 2021 07:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=WOA/lkT1Penwdm7gXlUndjIxo8Lg3413qdHlpeu3jD7BYjhN1LZim/MO+fJhP8iclc
         N51f6I4W5xKMGU+bVSaI762UmMNKQcI6cAe4TnkwmyNTt9yzgXAoezYKDLqBMcI9CNH0
         B5aIGN85xpHhJGnHerR2ercSEor/1x2rBoOCpIqc9P7GcnI7akxoSKPnh9SfR7SuK3GF
         RyQ6IPsNJlF90P7IGmQpIgt2OPJfnfoOmPlXkUkKdl8larWWpUr7lsNYnPXLWOcQ6W2F
         Zs/7MuZ1tlFnT8JwSdlU7Eb+vc9ESW0/lQPvDAn8ipAIVSdN0RTLc5hJwtAA5PBWBWDM
         BZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=kEPidncPYZDlpFaJF1cW419MNxt988b8+f1a0ZnEP0JJb/HzhyPVO1BXveplVbphIs
         eDMgp3jt9xqS3O+3sXOMkcJy3t38WDngW0rdgSQGO8Kz/YsIERvErMI/ZUXwr54GiEC9
         46Ht/AwyvXQFl3DvZeqlX41cV0C8ClUJEPlueAoELMkhKpQoR7+e58Td17hI9BO3jFXc
         3GKhfGpfbkPKWRT+xRKSxhIobSseJW8j23d603zURsaLewhsie9xeWL4mogMB870lTLz
         EIK9rM7DYhzf1TWeaBRgw5M6Qm1HfL5M9CnqPMB2qvSkj+52MDryUyfKGDpoq91LngUY
         KFqw==
X-Gm-Message-State: AOAM531RUyYNjNvOAu0/Iri32Sq3Qs2bhv7I4TNxpzBiKVA933UULujM
        5/4kv4SZSHWBYEkwWuzXOgQ=
X-Google-Smtp-Source: ABdhPJwvwamLoP+1QuroMiFTCmhR6rH3SSRmOiMJ5l6SjFj5E0rwYBnmpCZXtO6EELLJm+q+fxSJVA==
X-Received: by 2002:a17:90a:4a18:: with SMTP id e24mr9208627pjh.140.1610033717428;
        Thu, 07 Jan 2021 07:35:17 -0800 (PST)
Received: from localhost.localdomain (ec2-13-212-86-85.ap-southeast-1.compute.amazonaws.com. [13.212.86.85])
        by smtp.gmail.com with ESMTPSA id q26sm6308528pfl.219.2021.01.07.07.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 07:35:16 -0800 (PST)
From:   xuhuijie <huijiexu295@gmail.com>
To:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        jirislaby@kernel.org, yepeilin.cs@gmail.com,
        b.zolnierkie@samsung.com, penguin-kernel@I-love.SAKURA.ne.jp,
        george.kennedy@oracle.com, natechancellor@gmail.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [Patch] fbcon: i want fbcon soft scrollback feature come back
Date:   Thu,  7 Jan 2021 23:34:44 +0800
Message-Id: <20210107153444.1719-1-huijiexu295@gmail.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

