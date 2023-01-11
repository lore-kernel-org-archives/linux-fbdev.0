Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EE1C46467
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Jan 2023 21:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjAKVvj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Jan 2023 16:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbjAKVvf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Jan 2023 16:51:35 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738422BD9
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 13:51:34 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id pe2so8378845qkn.1
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Jan 2023 13:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K7cAnoIF5ddqrNvYwjRRB1k8EiCmZovTNVjLwrtZdI0=;
        b=JI++sEPjknkaI9Wk2ynle7+yuSHPyn6A+iOATdMDRfX3rASwHe974ZIBBqwkzlZfe5
         BD9yxib38OazeJ3NeH1F740bvrnRdkbO5VAkUwKzyan5+h0PNAYNVRCprMIDE2Hsi+dd
         M9gBq6SC8CqWEgo37uEw3U67wauhGLuH7fldeu2l+UBuiDXVGy0xNkye3CeFsfNEjWSz
         AdiUPbkgDUA6jGNYbbNAIEhC9TjG2jAIalI2Sfv6nZg0N32EARR1yn6sqeQWnOtaNSpm
         LvtAxB5YzdruokA3js6rOVF/j9XIXkkdN++LQTQDfuKueH/l7Tkd00nduBXFQIE7/FCq
         XFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7cAnoIF5ddqrNvYwjRRB1k8EiCmZovTNVjLwrtZdI0=;
        b=MeWbxADUu2VsJIIlAHGoaZw9W+MA/90uMKmQHoR7hKor8QKSihkb1EsnAB6Z+ZSDTH
         wFTPHT963su7tOMYnw2p4AzzMJlOI5fcdZQdKjAJeQgW+Lj+0DQdtmGiWKh2knLapX6e
         ZocukT12gm0+/KV7vNt6iBBLYjnJIAx+UzoMeKObKnqoL1GGmdF+IH76eCR4aKlj5hqv
         KNVYsmyCcHEto8rgW89TpUdOnJZj+cBQYzDyrsEQn5Pha5XR8PJKINoTvVsoZ+BiDUCS
         PhLxSuuUI1qASTelD4WDTsLGAERp1CBjNpLEgtOLBcC52R3RKttCkm9BNMYdA9ZUBxVZ
         /WVw==
X-Gm-Message-State: AFqh2kpKneC6WFuyIFes7DD8szMsdWT+AjYnLLgTjnYmT/KoBvQMK/P/
        oayJTKF+4rBEIuE4S517CIJXKynShDpZklJk60Gbo3OX
X-Google-Smtp-Source: AMrXdXvcf4DBh3alDX3TkLtJZ+rEyntqBUx8vMupmvZ+RBNNYzypDJraykR+sVEYeoJqFtBe9YdU4dkCqBis8Qd8yD8=
X-Received: by 2002:a05:620a:4384:b0:6ff:bf9:21d0 with SMTP id
 a4-20020a05620a438400b006ff0bf921d0mr4037309qkp.555.1673473893358; Wed, 11
 Jan 2023 13:51:33 -0800 (PST)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Wed, 11 Jan 2023 13:51:22 -0800
Message-ID: <CAGRSmLuWKhmthR=evQ7-5MKnE44ABsCdqQeysUyMG7ssQkKCEw@mail.gmail.com>
Subject: Wake from Sleep doesn't work
To:     linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When a system is using fbdev and goes to sleep and wakes, the system
works fine but the screen remains black, fbdev doesn't wake up.

There was a patch from 2009 but I doubt it would apply today.

Is there a way to make fbdev wake properly?

Thanks.
