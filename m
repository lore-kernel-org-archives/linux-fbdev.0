Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009109;
	b=VsyHkKPjKYNLJKzcgPEIFs6MT/5kIBi63SWgcsuKjJjn7tO5Q2aRv5SrlrJHzdeLW7Q4
	 ZX5l13jktHbeTfqJUi1s2+Ww0wiNw8yBIAFJGHNAvaJ/VDHcVVIq5C+1K7ezwxXn4obim
	 RmGIVlo7ogYiGtPFKNqeB3tRCEY+glCdv6A8hP/OmvUBr+eNHK/qhdGnzDhvIg7ZYaJmp
	 A86AjExlBhnk06B2gXDl6tttCbWw6mDukDatddg9sO4X915/OqJodXALljtfJa4qV6i6A
	 LHdmTwWs0Xva4hIoLeC9gMPBg4XhA0EeFarO9r47nBIClh5uAk9AynPiytynnh5x9tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FxukyNQLWFXILJqtxON+jKNDyTFtWUyLnLvPqii2FBU=;
	b=UaHj2f5BwaaHaV52T8RTnGuithOo8ULd3JvDP+Im1OvFjDVa6dSqx4YXSJnthKcChxVv
	 bl0a4Ng2WHcHUawd9NOaUw6y6YreO4HfBn91uxYmOBUR6hGgUntHumw94VcM/5lv8QewB
	 2GdK4F0yrYwtm1sKEG7m8uwCgMSG0Xm0imRpi4bGqYBvl8sDUjtb42LoncliCMWiH1qTh
	 N+6xmZS61lF2UDIc2bZaTVjVWx8GfYSrIllXq3gZtn9Cm0TdqtYK+RX2o53W8isjJXspg
	 RJjTrN//34U99jwqorBsaXeoQeXOhcITVVqQQ9EvCTLQK4p7VV3Z3BUhQ6Rx2ZxmCcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kl01zkq0;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C848A60A383B
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 10:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C848A60A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kl01zkq0
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso21961035e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Oct 2026 03:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793009107; x=1793613907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FxukyNQLWFXILJqtxON+jKNDyTFtWUyLnLvPqii2FBU=;
        b=Kl01zkq06dWabUlLX29Q28eAyZcSkjuJhQkb0WJhvRCUt7UM6rDkfWcxYDVNWKMA4u
         IIxkhL/34d5UdRnBH3l4PKNDXIXsOavgqZnWqKKKGUqXnJREYgDD2+90GlP60hZr7/Wv
         4pQ04ADE6NT6vOMSO6VV+1TOfKBecmW7CnyePsMTJd2nX7U+CUwQX83BQ5bW/GjhuyWt
         9ycra/1N8dU9NBIaP3eeb6Crwq9UrluRiauWSGf3PEFZQ2B188pMbkw9xBczcf8aqkp5
         dnOeSblm0bAW7Ov44TjXDhaZrKxWSnApxyjzCvifnU6MLUFco8vnDI03WlyowW/SzZne
         37Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793009107; x=1793613907;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FxukyNQLWFXILJqtxON+jKNDyTFtWUyLnLvPqii2FBU=;
        b=NQSxxMUfYb4I8qt8iIZyd5KMk/XicNMXcfxddICzAXTnhzuSfEC0syIUvkYey1EYN0
         2yHBFO0dCULw0Lnuqzl+FwGsKpH+sSoeyFX91Pe5gzSeuQ7EMZKfc6L0tPKTNUtxnQRk
         IQ01CVe55KE7dG8laK3DPhxFHDbdy5QYW9C1NSeQ1aP5KXCiPrCpfnzldVbWhkLXmkA9
         had1MlQpaVpdg2yVh5xe+OBoWaZM3t0WclBT5rmKsE0XtH2j9/Gb84tI4nEUp2vYDi86
         +qWHVdy8/I7lWTh9g/9FwDChTpOhF/x1osFebgt5VId1Qxml+ivOp8FcJiI/7gK677+Z
         r7Vw==
X-Forwarded-Encrypted: i=1; AKwUvBz7sZhxnwUlN0xyKOmyn3qylmdAoSdT82KhnMsuAPPjFfveTkykvs3pOY3JihyrqFxrQhPv3XcSztl+mg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJT7FxKYI6YjC8ksn+JDuBMoYiAQBTr1y2x0peUBxSeH4OqNT49
	rXeFgW7yWI2vZt0uHPMCcoSYA6ixyDj99FZWrRkC1PfWdthiKit0YqeR
X-Gm-Gg: AYBFou1u5BFOEFKaJEsWntJYv5ueIlfJZCLz9PD0zZ2/NiPhzmyYlbPNguA/HH5hFeT
	GHGeimpiDGxCe+nC14iR8lc7d3L7VfmvMpgdDGcXzN3ax8hDYtyHgfEQmgFF3HBPP/YcMbMPGru
	lrLbs2Sa8CqvopVkp6SVUUizle74NYSjn18JHgHM+OG0E3B/Vjl7efEmtDR30ssQHxA6YNedsgA
	BbW4GxEGXDav8/nxKy9Fub1cwemeu4ouySyKCu/zVddd+tmpMZOuvcrDTuTjngcFgcrA1VVUuzC
	BqhF6MyJR1UhVZmnGBaLyojcj7jkAIFcMXBFHr9q8YHQ9gdTB6ylzq+5rvKVyUK0APG1WuL2/qJ
	0mnuMCtwPL3n4O+pp9V2bszJzPMe55du46dJkhNnISx9cOZ4Nbajzw1V4jbW18x01Z3VET8aZk/
	4i3bhafC27foMcG4QJdRL9WfoMQyR3nyNfMn2YMtdz7/p0toBQBpEaQqr4/ADIBb0Mu5NkXVSz0
	V9sI58GN2noHvzpryWPI2h2UKg2IHRtfpDd6RqZOLGHOXi1btxqXTYXeX7AjkepJX1jbV2P/Q==
X-Received: by 2002:a05:600c:870b:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4a35ac95981mr110653645e9.14.1793009106828;
        Mon, 26 Oct 2026 03:05:06 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a55e99fsm187916495e9.4.2026.10.26.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:05:05 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:05:02 +0300
From: Dan Carpenter <error27@gmail.com>
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, dennylin0707@gmail.com,
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: Remove unused fbtft_init_dbg()
Message-ID: <at8lztOr7xpvHEdo@stanley.mountain>
References: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026092423.66168-1-himanshu.bakshi478@gmail.com>

On Mon, Oct 26, 2026 at 02:54:23PM +0530, himanshu bakshi wrote:
> From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> 
> The fbtft_init_dbg() macro is not being used, so delete it.
> 
> Reviewed-by: Dan Carpenter error27@gmail.com

This is formatted incorrectly.

> 

Don't add a blank line in the middle of the Tag block.
Tags are supposed to be in chronological order.  So Acks come
after the S-o-by tag.

> Signed-off-by: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
> ---

No v2 text.

Please, wait a day between resends, even for small things.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter

