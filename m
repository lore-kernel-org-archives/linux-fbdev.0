Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC67C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 12 Apr 2022 10:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiDLKPn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356958AbiDLJzT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:19 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ADB2BB1B
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Apr 2022 01:59:05 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-df22f50e0cso20134615fac.3
        for <linux-fbdev@vger.kernel.org>; Tue, 12 Apr 2022 01:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:user-agent:references:in-reply-to:mime-version:date:message-id
         :subject:to:cc;
        bh=61Zhp6cmoUliim9YwiwcZpLzWn635tX3xmuezZ/XE1Q=;
        b=i+E8+24eJSPuwFpWwnhwRcMosCQtTEQoU0qVumPFd1B/5vOrb43OnnM06scRAF73Yq
         oMByED8vyfj7h/juyKz0L3ed4WqHpCgSlskOcx+kVCwtlWgCiSRQA57g1AuGyhRftLkn
         PMcblX+TbX+MHeKj3cpATLc7zfvBTrR1JonUwOgFtW9kUMKobrEyLRFKbEi6WgtAtS6n
         FCB8ilN1nAxUZedW0P+Azc/J+6dpMpBO/s4qN2MMBBKOQNBC+cNRVDAa2Xi5cUNXXxIm
         UJfzvicRT62Wq64zodMNVExN+Gzy0MnFtlZGEVwjmhUqQKDk5bd3GuHqulcLVnv1AYsL
         SMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:user-agent:references:in-reply-to
         :mime-version:date:message-id:subject:to:cc;
        bh=61Zhp6cmoUliim9YwiwcZpLzWn635tX3xmuezZ/XE1Q=;
        b=LAdNTFJusbgYC7LgusWl29j0FQVt9DPcgXPCZNGVHdhIbKm75jyg3RSXiLchKVKhvv
         3xZ2aRb3DVzmb+L0MLP0SCC0+aLScMw36rodjIzuUnVcAN5F/eY2rbWZZ60Owbpkgs/j
         bnpr7/sdhT/jGMVwnWlls2ZpGvlpFbrflhBuP9a44x5m8v6eXVGt7MEwdsigsEP44nFz
         xo/oAONSECS+Aj0tDS1ZlxUfm4zdRoJWDBjbTcYo28svI/4dmgXuXISuaotmW3a3M2vn
         hdON7MFcfkg+NFroa8MQq9+MixAsVGtJEIH2r6s9Kvc8lOeNdFs9LPfFN/xA3oiIuG3O
         nBAw==
X-Gm-Message-State: AOAM5302BayZ3WkctRAn8Qs5F/jLDGmyxIbW77EGQWshb5f4hAOvK+zG
        wQF09RYxRSRspgAa4b1KseX6KEyMXplrGiS1+Iv+9A==
X-Google-Smtp-Source: ABdhPJzgcHEvPZCp6gdbg7kDhJKlxditkMSAtxr85wga0tldVXhcDC3GVMdHj7CuZ6MWQrtRrZ1EySnMvRiS1vE8OqA=
X-Received: by 2002:a05:6870:f21a:b0:dd:9bec:caf8 with SMTP id
 t26-20020a056870f21a00b000dd9beccaf8mr1592268oao.78.1649753944968; Tue, 12
 Apr 2022 01:59:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Apr 2022 01:59:04 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220327223927.20848-1-granquet@baylibre.com> <20220327223927.20848-7-granquet@baylibre.com>
 <33212024-ae93-32c3-7890-09006057ff49@collabora.com>
In-Reply-To: <33212024-ae93-32c3-7890-09006057ff49@collabora.com>
MIME-Version: 1.0
Date:   Tue, 12 Apr 2022 01:59:04 -0700
Message-ID: <CABnWg9sckU58Ga-qUgd+pk2M75H4=XZyAyP69e5QJP0+dvsusg@mail.gmail.com>
Subject: Re: [PATCH v9 06/22] video/hdmi: Add audio_infoframe packing for DP
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, vkoul@kernel.org,
        airlied@linux.ie, chunfeng.yun@mediatek.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com, daniel@ffwll.ch,
        deller@gmx.de, jitao.shi@mediatek.com, kishon@ti.com,
        krzk+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        matthias.bgg@gmail.com, mripard@kernel.org, p.zabel@pengutronix.de,
        robh+dt@kernel.org, tzimmermann@suse.de
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 28 Mar 2022 10:09, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>Il 28/03/22 00:39, Guillaume Ranquet ha scritto:
>> From: Markus Schneider-Pargmann <msp@baylibre.com>
>>
>> Similar to HDMI, DP uses audio infoframes as well which are structured
>> very similar to the HDMI ones.
>>
>> This patch adds a helper function to pack the HDMI audio infoframe for
>> DP, called hdmi_audio_infoframe_pack_for_dp().
>> hdmi_audio_infoframe_pack_only() is split into two parts. One of them
>> packs the payload only and can be used for HDMI and DP.
>>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> ---
>>   drivers/video/hdmi.c           | 82 ++++++++++++++++++++++++++--------
>>   include/drm/dp/drm_dp_helper.h |  2 +
>>   include/linux/hdmi.h           |  7 ++-
>>   3 files changed, 71 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
>> index 947be761dfa4..5f50237554ed 100644
>> --- a/drivers/video/hdmi.c
>> +++ b/drivers/video/hdmi.c
>> @@ -21,6 +21,7 @@
>>    * DEALINGS IN THE SOFTWARE.
>>    */
>>
>> +#include <drm/dp/drm_dp_helper.h>
>>   #include <linux/bitops.h>
>>   #include <linux/bug.h>
>>   #include <linux/errno.h>
>> @@ -381,12 +382,34 @@ static int hdmi_audio_infoframe_check_only(const struct hdmi_audio_infoframe *fr
>>    *
>>    * Returns 0 on success or a negative error code on failure.
>>    */
>> -int hdmi_audio_infoframe_check(struct hdmi_audio_infoframe *frame)
>> +int hdmi_audio_infoframe_check(const struct hdmi_audio_infoframe *frame)
>
>I agree with this change, as hdmi_audio_infoframe_check_only()'s param is a const,
>but you really should mention that you're constifying this one in your commit
>description, or do that in a separate commit.
>
>Either of the two is fine.
>
>Regards,
>Angelo

Noted, I'll add it to the commit message.

Thx,
Guillaume.
