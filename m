Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17B5C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 17 Mar 2021 04:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC2164F96
	for <linux-fbdev@archiver.kernel.org>; Wed, 17 Mar 2021 04:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhCQEGU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 17 Mar 2021 00:06:20 -0400
Received: from m42-10.mailgun.net ([69.72.42.10]:51884 "EHLO
        m42-10.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCQEFu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 17 Mar 2021 00:05:50 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Mar 2021 00:05:50 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615953950; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JzDLSu+qwz6G/WNOU91LdfXeIczEE/TTUZtA6eKrw7E=;
 b=lI6xYLh1taMEtIhPBpoBxdtaDgDaMdsZHmlKzJeREpgEotBcBwDNKJTbgR93x4hK2wilI+nj
 AzpGYR0IQDrVN1gJbpdpNlxjG2i7r7823e18O8DC/JqQhLuCIaE4lvuF+yRltF+5upeemVHO
 giCVqiAL2Y/Jbl5Yy+Mih1BltlM=
X-Mailgun-Sending-Ip: 69.72.42.10
X-Mailgun-Sid: WyI4YmIzMiIsICJsaW51eC1mYmRldkB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60517eddc32ceb3a917d03bd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Mar 2021 04:00:29
 GMT
Sender: kgunda=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95D4DC43465; Wed, 17 Mar 2021 04:00:29 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 77AE5C433CA;
        Wed, 17 Mar 2021 04:00:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Mar 2021 09:30:28 +0530
From:   kgunda@codeaurora.org
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Obeida Shamoun <oshmoun100@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: qcom-wled: Use sink_addr for sync toggle
In-Reply-To: <20210315122158.ptqi6xvngf6ihjum@maple.lan>
References: <20210314101110.48024-1-marijn.suijten@somainline.org>
 <20210315122158.ptqi6xvngf6ihjum@maple.lan>
Message-ID: <347b2f4efa08e051ed764b22e5dc98a2@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2021-03-15 17:51, Daniel Thompson wrote:
> On Sun, Mar 14, 2021 at 11:11:10AM +0100, Marijn Suijten wrote:
>> From: Obeida Shamoun <oshmoun100@googlemail.com>
>> 
>> WLED3_SINK_REG_SYNC is, as the name implies, a sink register offset.
>> Therefore, use the sink address as base instead of the ctrl address.
>> 
>> This fixes the sync toggle on wled4, which can be observed by the fact
>> that adjusting brightness now works.
>> 
>> It has no effect on wled3 because sink and ctrl base addresses are the
>> same.  This allows adjusting the brightness without having to disable
>> then reenable the module.
>> 
>> Signed-off-by: Obeida Shamoun <oshmoun100@googlemail.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> 
> LGTM, although an acked-by from Kiran would be nice to have:
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> Daniel.
> 
> 
Acked-by: Kiran Gunda <kgunda@codeaurora.org>

>> ---
>>  drivers/video/backlight/qcom-wled.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index 091f07e7c145..fc8b443d10fd 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -336,13 +336,13 @@ static int wled3_sync_toggle(struct wled *wled)
>>  	unsigned int mask = GENMASK(wled->max_string_count - 1, 0);
>> 
>>  	rc = regmap_update_bits(wled->regmap,
>> -				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
>> +				wled->sink_addr + WLED3_SINK_REG_SYNC,
>>  				mask, mask);
>>  	if (rc < 0)
>>  		return rc;
>> 
>>  	rc = regmap_update_bits(wled->regmap,
>> -				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
>> +				wled->sink_addr + WLED3_SINK_REG_SYNC,
>>  				mask, WLED3_SINK_REG_SYNC_CLEAR);
>> 
>>  	return rc;
>> --
>> 2.30.2
>> 
