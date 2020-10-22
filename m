Return-Path: <SRS0=EkD8=D5=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE63C4363A
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Oct 2020 07:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3753C20FC3
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Oct 2020 07:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504811AbgJVHBy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 22 Oct 2020 03:01:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504809AbgJVHBy (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 22 Oct 2020 03:01:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16A7EAD4A;
        Thu, 22 Oct 2020 07:01:53 +0000 (UTC)
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     b.zolnierkie@samsung.com, gwan-gyeong.mun@intel.com,
        sam@ravnborg.org, daniel.vetter@ffwll.ch, bernard@vivo.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20201021121241.17623-1-tzimmermann@suse.de>
 <20201021230654.GS3942@pendragon.ideasonboard.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drivers/video: Fix -Wstringop-truncation in hdmi.c
Message-ID: <a07dff58-a6fa-8b3d-453a-a75bf47b5405@suse.de>
Date:   Thu, 22 Oct 2020 09:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201021230654.GS3942@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi

On 22.10.20 01:06, Laurent Pinchart wrote:
> Hi Thomas,
> 
> Thank you for the patch.
> 
> On Wed, Oct 21, 2020 at 02:12:41PM +0200, Thomas Zimmermann wrote:
>> Trying to copy into the string fields with strncpy() gives a warning from
>> gcc. Both fields are part of a packed HDMI header and do not require a
>> terminating \0 character.
>>
>> ../drivers/video/hdmi.c: In function 'hdmi_spd_infoframe_init':
>> ../drivers/video/hdmi.c:230:2: warning: 'strncpy' specified bound 8 equals destination size [-Wstringop-truncation]
>>   230 |  strncpy(frame->vendor, vendor, sizeof(frame->vendor));
>>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/video/hdmi.c:231:2: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
>>   231 |  strncpy(frame->product, product, sizeof(frame->product));
>>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Just use memcpy() instead.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>  drivers/video/hdmi.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
>> index b7a1d6fae90d..1e4cb63d0d11 100644
>> --- a/drivers/video/hdmi.c
>> +++ b/drivers/video/hdmi.c
>> @@ -221,14 +221,18 @@ EXPORT_SYMBOL(hdmi_avi_infoframe_pack);
>>  int hdmi_spd_infoframe_init(struct hdmi_spd_infoframe *frame,
>>  			    const char *vendor, const char *product)
>>  {
>> +	size_t len;
>> +
>>  	memset(frame, 0, sizeof(*frame));
>>  
>>  	frame->type = HDMI_INFOFRAME_TYPE_SPD;
>>  	frame->version = 1;
>>  	frame->length = HDMI_SPD_INFOFRAME_SIZE;
>>  
>> -	strncpy(frame->vendor, vendor, sizeof(frame->vendor));
>> -	strncpy(frame->product, product, sizeof(frame->product));
>> +	len = strlen(vendor);
>> +	memcpy(frame->vendor, vendor, min(len, sizeof(frame->vendor)));
>> +	len = strlen(product);
>> +	memcpy(frame->product, product, min(len, sizeof(frame->product)));
> 
> As this seems to be a legitimate use of strncpy(), isn't there a way to
> silence the warning without requiring this additional runtime complexity
> ?

Yes, the original code this correct. I looked through include/string.h
if there's better string function, but none fits. Most of them
0-terminate the output string.

The only simple fix seems to be to set gcc's -Wno-stringop-truncation
here. I'd expect that would be an even less preferable change.

Best regards
Thomas

> 
>>  
>>  	return 0;
>>  }
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
