Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEFDC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 Oct 2022 13:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJCN4Y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJCN4X (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 Oct 2022 09:56:23 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C171EC72
        for <linux-fbdev@vger.kernel.org>; Mon,  3 Oct 2022 06:56:22 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s2so4089182edd.2
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Oct 2022 06:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HZQujTgwJYtzeQnyb4wklLi7ptB9x6VrWByoPZI0Obk=;
        b=KkR08Z40KwIU2Qm5MVvX5vHCzH7HJCvRDZ35+E6gk3OkyDmfv2ezRdoP9YbVb9r4eM
         m4ypr9EmdKxZ7OJDwYZlunSfH8R4sUphEJ2Yw7JU5eu6iH5gpQQiomZNWi9ONI1I1jRy
         7BeYBta6qUUiWbKupfxYu2+R3xwBRHlaju7iEN//5n2Ofuh8f70OJK6rYrSnfvWWdfao
         Gld/dXdUgDXScGSj2M3aYnH/rQ7UanAXb2eEFPeI+ZNMQVUZWHfRcCh1N7N7tSvQz6RE
         bby42220k0iW4Alqb1efjbKiMNDA0ux274A4N8uyxepUDUnVd1WIImGk4PZ6GcUpJBHw
         2V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HZQujTgwJYtzeQnyb4wklLi7ptB9x6VrWByoPZI0Obk=;
        b=blcel0HkhXCvvv5kjxSUyHbIUqaQ6xaMVoax5yHTrLyn8hYco2oASj9CploP8Bd8Z1
         Sgg2L3ERJ4pshIOHrVsdNQPa8DiY5lR92usuSWVZeiMzk6jO6F09PaoYJitYJhG56Y8D
         93/iJ+7TnagOOOoWeN17QKxGzQS94vkfUGDefi0B/iEx1Ae3Fqlf2+zlM5Q1+1OYX3HO
         XzV1QkXCvzyuHl4o1yLuc8Ou48c8xomIa9deoN9EBuhLULtqKaeuE7mhFon56EZCTq1I
         wTNrG5Crj2DfFL4EG2/s6nl5HIUjGQBP3siNM6dlaSYyNNyXjcZ4M7yH1Xhl/9XsqRUW
         O2sQ==
X-Gm-Message-State: ACrzQf0MeqmkWH8Xk3FPT6Euic7ccZ7ZmY15pvv8qrJPS/0WF/YG4gF8
        weqr4a9kGD623Cy2wgOVo3ETknZV8GFId5DA6wffhT84vbI=
X-Google-Smtp-Source: AMsMyM6Z5/o/SGBH8NKp4roTlu7+AecIzzBrgDrFqz1zbyZHISOeVe1aNk/TGnJXz6DRGx+NJY3AnWLiq1KVYf30Gsk=
X-Received: by 2002:a50:eb8f:0:b0:458:482d:43de with SMTP id
 y15-20020a50eb8f000000b00458482d43demr17543175edr.205.1664805380829; Mon, 03
 Oct 2022 06:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220926142059.2294282-1-yangyingliang@huawei.com>
In-Reply-To: <20220926142059.2294282-1-yangyingliang@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Oct 2022 15:56:09 +0200
Message-ID: <CACRpkdZ0dYWk9UGV41aW+++s=4YmFk90MpXZ9-7Wb+k1t0PBzg@mail.gmail.com>
Subject: Re: [PATCH -next resend] backlight: ktd253: Switch to use
 dev_err_probe() helper
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        lee@kernel.org, daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Sep 26, 2022 at 4:14 PM Yang Yingliang <yangyingliang@huawei.com> wrote:

> In the probe path, dev_err() can be replaced with dev_err_probe()
> which will check if error code is -EPROBE_DEFER and prints the
> error name. It also sets the defer probe reason which can be
> checked later through debugfs. It's more simple in error path.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
