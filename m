Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C5AC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Oct 2021 19:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE525611C8
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Oct 2021 19:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbhJDTfw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:35:52 -0400
Received: from relay03.th.seeweb.it ([5.144.164.164]:35695 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbhJDTfu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Oct 2021 15:35:50 -0400
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 126E51F673;
        Mon,  4 Oct 2021 21:27:43 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] backlight: qcom-wled: fix and solidify handling of enabled-strings
Date:   Mon,  4 Oct 2021 21:27:31 +0200
Message-Id: <20211004192741.621870-1-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This patchset fixes WLED's handling of enabled-strings: besides some
cleanup it is now actually possible to specify a non-contiguous array of
enabled strings (not necessarily starting at zero) and the values from
DT are now validated to prevent possible unexpected out-of-bounds
register and array element accesses.
Off-by-one mistakes in the maximum number of strings, also causing
out-of-bounds access, have been addressed as well.

Marijn Suijten (10):
  backlight: qcom-wled: Pass number of elements to read to
    read_u32_array
  backlight: qcom-wled: Use cpu_to_le16 macro to perform conversion
  backlight: qcom-wled: Override num-strings when enabled-strings is set
  backlight: qcom-wled: Validate enabled string indices in DT
  backlight: qcom-wled: Fix off-by-one maximum with default num_strings
  backlight: qcom-wled: Remove unnecessary 4th default string in wled3
  backlight: qcom-wled: Provide enabled_strings default for wled 4 and 5
  backlight: qcom-wled: Remove unnecessary double whitespace
  backlight: qcom-wled: Consistently use enabled-strings in
    set_brightness
  backlight: qcom-wled: Consider enabled_strings in autodetection

 drivers/video/backlight/qcom-wled.c | 88 ++++++++++++++++++-----------
 1 file changed, 55 insertions(+), 33 deletions(-)

-- 
2.33.0

