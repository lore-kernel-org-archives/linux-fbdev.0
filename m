Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1DA20ADF8;
	Wed, 20 May 2026 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779245757; cv=none; b=MHzfQOvrika53I75i3uwNZ6SuL81JiUeahYqJXeo3e13BPeyXzGdSVRvDiB0KHIcaDP8fzUs7tf8p3Wc24AdAa0fjrH+2pc4C23LVnkajBmERrVGlySegBEE+cfT7tvKs6dvBdsXD6Ptd1WvNMLnOtAbIGFG0mbiDo7aT55GOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779245757; c=relaxed/simple;
	bh=ctXPt6Tm49nF9zVciFNofLG+cJ8uXlivnpIOlXYp4RM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TytPdurDBBwZwbczgMd81kDarYJH6iYQ4KauZL7omoWdj8+p/UxsCpD8ZhC6EvlDQezG3hvVkl9HBMDSuyYYUxBF4NJRHJUgzepjj3iBVxArW7auYtqCvnTRUr0+myu1/F4MvWWAE/wktV1sRZ7BuFGBEtUHCSJkS8t5ER22KaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 67eab38453f711f1aa26b74ffac11d73-20260520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ac6fe59b-c39f-4cfd-b4ec-66397558d3d2,IP:0,U
	RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:3
X-CID-META: VersionHash:e7bac3a,CLOUDID:76d88fe4dfed9b1d6ba784b9d3b7a7dd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|123|850|865|898,TC:nil,C
	ontent:4|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 67eab38453f711f1aa26b74ffac11d73-20260520
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1602025270; Wed, 20 May 2026 10:55:49 +0800
From: yaolu@kylinos.cn
To: deller@gmx.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	yaolu@kylinos.cn
Subject: Re: [PATCH] fbcon: don't suspend/resume when vc is graphics mode
Date: Wed, 20 May 2026 10:55:46 +0800
Message-Id: <20260520025546.71982-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67a1f756-996c-404b-8eff-f705ff151ed3@gmx.de>
References: <67a1f756-996c-404b-8eff-f705ff151ed3@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026/5/19 16:10, Helge Deller wrote:
Hello Helge,
> Hello Lu,
>
> On 4/30/26 08:01, yaolu@kylinos.cn wrote:
>> From: Lu Yao <yaolu@kylinos.cn>
>>
>> Don't need to do suspend/resume for fbcon in graphic mode. 
>
> Do you still have the possibility to test this issue?
>
Yes, I  still can test this issue.Do you have any other items to test?
>  
>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>> ---
>>   drivers/video/fbdev/core/fbcon.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>> index b0e3e765360d..450e690d0bd2 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -2602,8 +2602,9 @@ void fbcon_suspended(struct fb_info *info)
>>           return;
>>       vc = vc_cons[par->currcon].d;
>>   -    /* Clear cursor, restore saved data */
>> -    fbcon_cursor(vc, false);
>> +    /* Don't need to clear cursor and restore saved data in graphic mode */
>> +    if (vc->vc_mode != KD_GRAPHICS)
>> +        fbcon_cursor(vc, false); 
>
> I think checking for "== KD_TEXT" is probably better.
> And, maybe using con_is_visible(vc).
> So:
>
> +    if (con_is_visible(vc) && (vc->vc_mode == KD_TEXT))
> +        fbcon_cursor(vc, false);
>
It seems more reasonable. I'll submit a new patch soon.
>
> Helge 
Lu Yao
