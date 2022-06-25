Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EE7CCA480
	for <linux-fbdev@archiver.kernel.org>; Sat, 25 Jun 2022 22:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiFYWGj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 25 Jun 2022 18:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiFYWGj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 25 Jun 2022 18:06:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFA8120A9
        for <linux-fbdev@vger.kernel.org>; Sat, 25 Jun 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656194791;
        bh=EwaVMR8oiSixq6wztSNXL31Q5jPVJex904DPd06PKOk=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=CQ+ZnUciwmIoK+k8gmTkAPO1EH7GLKCvOBhrg9bWUzkf/F7f3sFhpP11XwqYqB06T
         uQA8ZutpksKDitgcCArAy+O7fwTIarMMAfcLyZP3Lu2Q6rTnhER42+88z5P8apiEKn
         jSthw1/v8ddadtmppd941Zm0XgU8y8j2kvm0TEQ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100.fritz.box ([92.116.162.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6qp-1nK7f22Rkx-00pc9I; Sun, 26
 Jun 2022 00:06:31 +0200
From:   Helge Deller <deller@gmx.de>
To:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v3 0/4] fbcon: Fixes for screen resolution changes
Date:   Sun, 26 Jun 2022 00:06:26 +0200
Message-Id: <20220625220630.333705-1-deller@gmx.de>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xLazHeRtgqJMrmYygwGPTDqhiF/3rHyg7D27TMDqLg5RpXgUTew
 GtfXs/ZNeVHGn0R97MTfzROKLoe6NkFTPfCITPann5HBqBDImzKdR2bie6xXJgjhFgazW6g
 pwlPOGYxLg/9gQDUjzwdy+jfJf0rt0Xc4/aZbvLWUqv6MlVMekOSU2t7jYjLSHYLwty2wYG
 TXpZ5j2tRCADieu5pzJsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A6zZegXqmuk=:bTu7ozJBsfeoLvLATgUr+i
 F+Ijh89g0ZBzS8/849C7E3KWRvFXJg0O0L/MuQFpQO5/n9xauHg5PAeCaXbc0LPMG2ybzXQb8
 4xwQrK0bF7D1EA3hxy1RO0ehOnrNn44c04SoMK6D8okdTclBiqZI5q47gSLkdIioAofXP8R9E
 W3jZ7F+M7Nr3Gq+BIjghoiNAJ9K24/2sBPjr2JjucMDdtjN3Rkw2Eg6p/wcCTvDzReNCS/x1C
 qDfBI0OIlwo9irun+n9rGhxqBln/M4AUR6FDuRszL2R+YPkKEWGZiXZB1bwd6il0L1ScxolFq
 Y40vXx4gFXgBXUolO/UbeO8hkgehGUN0OxNeEan+1xElx/CmrUq1lDfp6Lhd78kicj/7l5mP9
 FK/uIkyisi1KCk897fZ8juVo5aouvsXz8C2TIhCJzS70s74heT9C93FfDtjWedFMBdMfQvnYH
 LdZc6VofpR3gRjBAkjndffG5YXPqeQIKtf97UBkLPox//ouUCsF3aBdCR6rA+7L/P1pTyn0ld
 jcrtQKqUBv/AMewLouUXtrgJlwyvCyrecBom9NqZdjBfYg+BXBdcOX4buQ4gxVt91/F5FMru0
 9hFMKEh09MD1pQlnwer7vjmGzfqudGzi4cQUI3pB64nzF9blYVjmnZM40QMEq+4oIONTWI5jS
 /49y1QMk0DliRQO+v5tZ0flIgWI8qKDr76kDEtrmwTEBr7CT2dkqt3MT1t6D/WHxWAd7CcOa0
 9IgCMSNQS3WQE4u53lcTxz1YD2WF7u97DA/h3goJh5G1t7rl9BW43SjAIGVFMoxKQEnkORAR1
 W3a609zontwBhJX4xcFJfmUB8suortEnwWJcWIsQLpxU6blycU+tC2ZgnfV1xypuekYO0lUQ5
 +IFOU9S1zdwV2uMOdduOspnEJoPIqgzniRH+Nd7A0tGj/WPV4FjtfUXgnU7I7APA6qDlS+FSU
 xWwi1MwfIHHOtviWqUs9dQ4H7O21nQ98PjR5z0e7e5AFvcppP+KDJN4cXpKZDd3BSuG22dQGG
 1DH/g0OXcoiqt83ihzAwU0D20rAxZlADvq8RUpv8Hat9lG8ApcnWebQHrsgXLBsAgHLu5A8m2
 K0NrH7RdZsNO5ZE3u1Ff3vde2dNHObX874KC4dVoDGgGvY99EQNpUWK7Q==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This series fixes possible out-of-bound memory accesses when users trigger
screen resolutions changes with invalid input parameters, e.g. reconfigure=
s
screen which is smaller than the current font size, or if the virtual scre=
en
size is smaller than the physical screen size.

Helge Deller (4):
  fbcon: Disallow setting font bigger than screen size
  fbcon: Add fbcon_modechange_possible() check
  fbmem: Check screen resolution change against font size
  fbmem: Prevent invalid virtual screen sizes

 drivers/video/fbdev/core/fbcon.c | 32 ++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c | 10 +++++++++-
 include/linux/fbcon.h            |  4 ++++
 3 files changed, 45 insertions(+), 1 deletion(-)

=2D-
2.35.3

