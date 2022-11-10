Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA19C433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Nov 2022 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKJUur (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Nov 2022 15:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiKJUuq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Nov 2022 15:50:46 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB3445A3E
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Nov 2022 12:50:45 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-13ba86b5ac0so3504417fac.1
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Nov 2022 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CwL7aq5cSs9HEaq0nqBlSMF4bh+wklN/OA+m+xjVg1s=;
        b=c0ZfMKCxMTI2b6N8HwLJSwPpMWI1RGwNPoaCQMBK0iq91fjfVrM7WQDsHtjg2L0Kcb
         sZz5mQqL9TKa323CvP5paVCRdLHynD0nLPJ8xQg4Sk2CzDmnm2dbRPn+ZUbwIQ/PWXD3
         GwPay++TL2h7tLjYeug7kp271mTKD/7mY1czue3WyyEX21dWogbywYqn+aZDs6lk2LdM
         FJ59FdxQ7aYNUYJIlRaJMGvQ26EaZ4ZAashMRsu4pPBYzQqpn5fqTNH9LcwokbBpAVFq
         fLKrCbpkPZr4X4vA0l8jmkyebT/xsNQMWkm6L9uRmbM81G00MnO4J9/21DGzx0gXajb2
         /zIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwL7aq5cSs9HEaq0nqBlSMF4bh+wklN/OA+m+xjVg1s=;
        b=6pMqfP3Y7D54uiXjFx8LP+KQoLFVIBIpZUjWaswCrTY0TvcniRJ8dSJvG6VbNTZDgN
         kqHfMoF6cs76TXIUfN3+qOIUlSebhk7R0YPyqMvOc1yAn5jp8Mx8zPN1Ms2guTybI27H
         cGZ9URmZn+L5w6iRB6QvWPVa/zeZyPyQ4HuH6CqSKrOo5uGOPkaXuUhyMBpd5eB9elLo
         xHCbcqzVfUJlZPfJ7nRtdsObiBKLGpKB6gWQkMCmJ6Mco5QlzB+laaVogNv/iLfDymgs
         aFWrAdyt7qhdUoDfT/s76wseb+tkMFEI+cCqIm0K7gphNELHlpODWGrN+YLnlGdhfMoj
         JUCw==
X-Gm-Message-State: ACrzQf1ujOYNDBgI4rTqsP4++pbgDOGyIfYDrWc/LsID78Nxp5bKsekw
        BgkBRspMYuEzsDhxKU4ecEouUo05/KRnN0wNp2yLF6Od9YI=
X-Google-Smtp-Source: AMsMyM4ir0uLwB/7TgR6k0nSyFkY6+GdJd+6Dnlj/FzeBmQlXGZEMY8wBY8hmgV8tb+meHSkJoGL+HDlbfMmJGwOHOI=
X-Received: by 2002:a05:6870:5b8e:b0:13b:d693:2ee1 with SMTP id
 em14-20020a0568705b8e00b0013bd6932ee1mr2119868oab.77.1668113444445; Thu, 10
 Nov 2022 12:50:44 -0800 (PST)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Thu, 10 Nov 2022 12:50:33 -0800
Message-ID: <CAGRSmLtF3Nwpbdh8M=AL1GiVNLK7jWTWae+FMKq=c=P50hzgyQ@mail.gmail.com>
Subject: scrambled screen
To:     linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Customer with Lenovo Ideapad MIIX 310-10ICR has issue with newer
kernels updates.  The screen is scrambled.

Kernel 5.10.19 works, later with 5.10.91 he had a problem with it, as
well as 5.15.x

Here's a sample of the screen:
https://www.dropbox.com/s/wvunl4acd5dkt55/IMG_5327.JPG?dl=0
