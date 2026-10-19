Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993C49B209
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399604; cv=none; b=br4O6GdbayEgaSY2Lys8+u46chtS6WqwlEbEVHi+bBFWuaTS/KK4QFPc4nt7czoHzQ2I2zioXNaIcuvUQkjm1wzPv7PUXrDJj4qs/oRuBsNfioKdaPoeJmq4Z8d0UMq+7/o3BaCb51XFcJ3WdtrlwyScpaSQ7TrdtgwNVGTUxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399604; c=relaxed/simple;
	bh=eHZnAQ4WZ6l0Eaf7O6GrKOei6GuPLKILghtVjSoOUZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8WyphfAsYcnIJNG9rOQr6sPzmw9vsAz1iZypCh+teOfyLPgiWR2Ar5+tCYLxaK0fy8ZnCVr2PhzTvZNgvtri+lnHABFqWX1kfqK77Z8f+TAqmjbPA+on/YR99TDTWi4GDeuY+FZzFvdr1yUmj3/n2RRb2MGb08dvQoYoFvgXu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGCBEKQk; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGCBEKQk"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-35829219da8so3345396eec.0
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792399602; x=1793004402; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R81uGUDBlkE6/NsZn54/pArgBx2k2sR0sHNuKkRuNRE=;
        b=TGCBEKQkm9ByF8rvnvFnmryNDAtYJzZVjaHD7See3f37qJQ6bm4SthcPi7aoNyn3mn
         UQJhGGtiAgQkekfzYzM5ELHrgZZCcMwoAG/3Ck2xWlmvDxD4IMuD3UT9x0OcCmssenT3
         9XisLTYxJJYKEQyVtRnR6zRu/SxKw7ptJEHm/Hg+RwdMHiQifoorTHwT61RelEVzy17l
         Uq0NHQTNkJxmBJyRBHqvMJBP8zJiAJs82liG6cEBH3VE9KG9ebkzHzeBYYwhIODuVbkP
         WJk7ASSpPwYb7OZQZazYWwoCmHHg2jiZ4GSYP8nAmRit5c1MzhVQzwynfRU+jPBeNYgu
         9FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792399602; x=1793004402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R81uGUDBlkE6/NsZn54/pArgBx2k2sR0sHNuKkRuNRE=;
        b=MWuJOPqYJt3a+CydkwEmfaXdByKxpdzw9uIlX33+pHtIDEIZ0Or7F+7s2W935WaIpB
         YvD4sLP7yOrRX8UJloigDObNYa0IBnT+fjvknhKpnG3Q2+SMqkedUqKG9zyrABd0N+yG
         SupUxx/dC5js3yDT6VaaCKbOs5LvcixDWkntUpR5zo0XFQhCIe/DJyJgIFo0UkAxUHzN
         fkhp03odtoAQetfCQo3c8d8+IkNQkZjwvKIDdIIEfvAzOC9TElYweiYgIMAG4qimX4dR
         o5TyTtg+hHfAAA3I/C/iubfTp6n8xYevjSqmk9DDWzi8Xs0xc1I/h5NkmDoRoecrnH8J
         hwaQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFtfShIVHJ3QQBsB97ROBPqfD+G+yXHryWeUwT83dObGQvWGTJOi0EAv/bqxG31EVdpDF1XhZRNW4JGQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJJSZL7NPS3Ju6hUmKclKKnAaupeepCGqFJN2l1edZzd/Ape7QL
	U8K0IhPcsJZrpxAFflh4D/Gt4/4lO6yIerIRZRD9ci8YTxVUcDc71QZuOd6LqY8HCkCaOQ==
X-Gm-Gg: AYBFou1oV9MJxUvIp5c8HdXJ4kb7SmtR0LscY17iSxfDJC9ua+YS7XmuhS3mq2J3Za1
	MWCSnkGjLeKeOptfUs9N0b6fvJC8dknP+N59kJMNhxCm2nrP8UCn00lCtFOvT5RUxWnTykQcPky
	tDSYqpI3uLscqEN8tViumi+7cs4cfmQvLAy3aqd/WMn6p36WOBYb/RYsQu0YGkLtK/vu5KffA1q
	j/V+14usBjptsLpE8D4pbiRyq5vJtzdfN/swWuMtMX+rNigc5WaRStM8BWuqNO2dYheRYFj2qra
	0j/M5W4VJiofxDLJgvij2B/FYKOlXAdFQvJlYjwKveBSW1xPzqpGXsemdVoZ0fgpnmdx6FhyjSB
	dyfVuMe0GQUPwnzfVcbX6GRw7omzoClUtKiUQX0lv4NOuEom3iMEV2ES4whUh+wEWZY0UOLdf+j
	EACi5De6A9MYpl649Zl04IvZBEJelZzKhlRhxSv0T7sjXn2iELDATi3XRF70wcdW9itSd1Nk0/B
	/X37YG1MekUG2nXmx8N/g==
X-Received: by 2002:a05:701b:2092:20b0:143:808b:b178 with SMTP id a92af1059eb24-1825c27d1a0mr14024480c88.26.1792399602431;
        Mon, 19 Oct 2026 01:46:42 -0700 (PDT)
Received: from blue (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360826875b3sm32116751eec.21.2026.10.19.01.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:46:41 -0700 (PDT)
Date: Mon, 19 Oct 2026 16:46:37 +0800
From: yyaqia@gmail.com
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de, 
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fbcon: Rebuild rotated font buffer on font change
Message-ID: <atHdEJjrSTrlZtSU@blue>
References: <20261016073023.490430-1-yyaqia@gmail.com>
 <20261016073023.490430-3-yyaqia@gmail.com>
 <3382a02c-ed79-4214-99c5-dc81ee59d633@suse.de>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3382a02c-ed79-4214-99c5-dc81ee59d633@suse.de>

On 2026-10-16 09:59, Thomas Zimmermann wrote:
> 
> It's way too long and boring to read. Can you please try to shorten the
> AI-generated commit description?
> 
> 

Sorry for that, I was a bit lazy to think commit desc by myself. I am
new to kernel and a little afraid that my message does not cover all
things.

> > - Also select the blitting type again in the error path of
> >    fbcon_do_set_font(). On tile-blitting hardware, set_blitting_type()
> >    uploads the font map to the text engine; without the second call, a
> >    failed vc_resize() left the engine with the rejected font (found by
> >    the Sashiko review).
> 
> The problem is that rotate_font can fail as well. Handling that in the error
> path is not possible; hence results might be worse than keeping the rejected
> font.  Can you try to keep the original rotated font and reinstall that
> directly?
> 

Good advice, I will fix this in V4.

Thanks for your review,
Yao Yiqi
