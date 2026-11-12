Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794484209;
	b=bmvA4frtAmBrzsjhXc/xmu/Z3CqhI8eXjT/N8pVbGpzSx3nAI2gj3FvjSn8QDQEX2IAP
	 5FR4UDZ4nMVysLNcdwSzkykgYmtbt4oP0xfApYkqy8ARG1GiQ16uO8QtUDgS56XMKCllu
	 thVEAOKqTWamNf0c0G96XACoIceXJVw2KLa5JF5KvJ8AMzis50xeHi/lfQipEC7TbKzQS
	 Nw1FZf0R0kwfV0pgnljDaPl+FDWXEHvU2xGZeGS7qB1CcmNFPercfmcUOevVC6gsFec9/
	 kwYnLPN1QmGgwOubNV+rsx1tSW/0eqM8n2YW2KhX3MW3AQVTmDIvbqNWBO4PcbJcitA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=PW0k9eDKFqfRkgSsOSdWK+l0uZcCJyw9dSbPkXAxN3s=;
	b=CCjUhysCjGhTMwFZY0wTcHtlqEzwA39/IIEl27NpatOjWSiqa/T2WrliPkx8ovbE7PNZ
	 GprYaQnHGJCx8X+ZebdrmdZfyY/D1nLdTbyCcN0nZCV/LBZ8caH2IDiR/AFQLJy9Rao6h
	 TGr+tQ2iofsGsAaSdmNy59Efg9V+HQCMS0eLMQD41XbCUwUt2f5JErqR+Igx+aPz0Xxl7
	 CIkwycDVKgil3wLfBI8Je4QcbpMKhJI+OX53w5TGgXzhIJ1ay/gajmaduRQOx4HGSOKGN
	 bKv6/9jLWZvL1n2avpIF/uysXARkbQDuqpJePdBHzdR7BXVh8hzvqrdAGgLCfmJjiAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xG1K7a11;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.72
Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40621606A32A
	for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 11:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40621606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xG1K7a11
Received: by mail-oa2-f8.google.com with SMTP id 586e51a60fabf-4ad827109b4so845350fac.0
        for <linux-fbdev@vger.kernel.org>; Thu, 12 Nov 2026 03:50:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794484208; cv=none;
        d=google.com; s=arc-20260327;
        b=q/BPmRm0pxU5Rm9gxxEsGzsLDnccc1GEwiajkQMqkRw7jVDvGBOgBenjE6f4tkoIaB
         NrQPddqYaZ+YLwkoAgZeaZR8fCX2dYwPs/JzjLQ2hoUyR9nN7nykfkCLj88kGInccb0G
         gidhziDol70Q1g3Hyp+fbvAdgDfTDoKVzDmNQUFhbQYv+ai0l2pAcAivG597rknL+g6/
         LWr9D3n9226sqGHJEZrf59qXh1mVJcG3bWzz+1vbjTz8pU7plF4GUM0EsYWYPgAOrOXd
         pO3R40jqmMdYkDp7TzJFlzYGyzq1dMZ3gGSqjcfUsF6yEQyXozjxjlWlJvN+Fqsaf63P
         71Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PW0k9eDKFqfRkgSsOSdWK+l0uZcCJyw9dSbPkXAxN3s=;
        fh=NLcWcbLKLuOjOHqyBrClsgQWghBfgWhOTmvAkQooybw=;
        b=OvBNw6vzVBz/OVAUQ0hvAj6EkPjUgWHVA8psOtkTgS9+RhJeZN61ZS56h/bShzYPhW
         oB8IpH/Allv+MTwzKcqOD80vJ0VarRk2TDraFW3BRjUgODqxscY15ZsNZ0ipA7whja47
         ILojcVK3X8zcr+HhVKLxYmF16AmIaCLNziCKUIy+0gyXPbFBsZzbUNXC39/sH4Imthr0
         i8DmNQ0g7FOrQrhsJIiYSY/r/mXBpnKLrsqD6sjAyxaEy9/jv5JbGWjZgQdH2Rf6B84y
         Q7hsKcPyU0UCZMLjYVgSKJh2VDx767Iap5EZxBZyGWr6BexiPuYnKeyHiBxKHJ5flyxN
         fHCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794484208; x=1795089008; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PW0k9eDKFqfRkgSsOSdWK+l0uZcCJyw9dSbPkXAxN3s=;
        b=xG1K7a11d9nM0ZS0KF/dC7iSo7rQARxxJtnwLOUnbxB3uTUzJ0qcu3YUKZqpyl02IB
         Y+h1pQaJfto/4DkmBqQy1nkNs6G6PbSZW4JJ/Lutm/dofhGH1vOlnHsDzd+3GJu99ont
         AjJYIkopoWi85nv2EikKCDPAhO+jqrGdpJM+polyB2Nst6ec3oqEdeOvSJGn/4kJr3ez
         Jm1eO/09bTpMgxsHPiVkMiU6jNE434ysOKf9b8SzGBkMUNF/4b8SXDwjrpUuMhQ5/u1O
         sEPiRGfTFv0HfJsAndb6YbH+Cf0G7msnkevuX7Q2v4X7gJRHwO5UsMio7xST1Gvec+wE
         g45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794484208; x=1795089008;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PW0k9eDKFqfRkgSsOSdWK+l0uZcCJyw9dSbPkXAxN3s=;
        b=WC5E7BeuDmyGV3iW/oaxCCR7xCU5BqKMawQymlClqYweZkxm71GxFAtkLeAuG4Im5s
         AbRJYjgPNkYmFYDWvM3jPs9POvDzSEygpPLywCJV6BGpoTdOSICm4AiMV1iLOMs6h/11
         YoQ8SUGcbU8ipMAWuouugYuXID4duYZcV9eU7aub7D0tGakaqweJEukURNxFwKEa9ywI
         5Wxdm+zjsoIc6hhdLwm1ze0ZcwzxuYs2MqQiyvt0KPoS/Wt+fZs6MdIhUZ4QAl8IkuQi
         21wT0i8zubS8N39J33DuLnREIASAeC4DNrAmuO4KTdGZl3gJWP94pF4QGQDDh4UEnPvG
         aD2A==
X-Forwarded-Encrypted: i=1; AL+hErFSL7xdoTIHZ4KIXo0Meij36Jy6RwZaol8aMMa6SFEjrGL1EksCLIuYKXywE9JNurY3c+Z80OzfEyO/oQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+vwoxSpNHSPW++teXb+TY1qJAwo3cIjzpVUoBWKcK4AbjzCxvA
	GQzETWW8ftwDgdIQ1HTo4+DTYqQKN34L1/u3rASB6nsWmyu/bgRI4/aiQET3LRiBh9Dh93HyeHS
	ha/OZQqT2Om7evNUmDcqBmwQj+BTZfn0=
X-Gm-Gg: AYBFou1q/1V48VFG5MLcPTer7LcCCEoZPX25o4YD8TPv/MRnwVBKhOGL50q9lV9+Idt
	BCx8Jypp1RHklPN86/GSylvrQuX1v2dHGh2Ob098e41hFLUGT8FjRB94unX0JDl+JvnY9yaXRx1
	o8wYkZFkZcBMoW1Pt3HTlBjI4AkJqHltmpx2UIUkrei+kj5egh3uBedanXqx/6fhZa7cu5DzdW4
	lPlLqg2Aik2xtNAHg1aMT3/ToBZPOxuc3AZhrkEkDpxZB9/cijsH3Ow+wj8lLdfudEfmcr4fobb
	qQr1GbjNPvlSBEjN/Oxl3u1gGLMyArAFQVxFDsD4fJRsVj5A0rYqVKvolAC1ldjYARNzoMfM8Ti
	sgwaI1/s8l5veqRJtLhHwZJnavDuHMpkKUuCc9LRIODr7W88O8+PjkS4OnyxmoGgQkCQSijVJjf
	D4+N9NEvkiVUjzYa5xlGuOiYL1KyYm1U25mqLMGM9lbUK3tom2UkTKx51sXkNElVZ5tYrFHbyZk
	38=
X-Received: by 2002:a05:6808:250d:b0:539:dfe8:9960 with SMTP id
 5614622812f47-56b97d2052cmr4847599b6e.56.1794484208172; Thu, 12 Nov 2026
 03:50:08 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
In-Reply-To: <20261111163819.143147-1-himanshu.bakshi478@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 12 Nov 2026 03:49:56 -0800
X-Gm-Features: AclHuK99jfCHnUnNfvAVzgTNdsDa1C0fS3B-XZ44SaSca81MyWnGtLd2YK_PCFw
Message-ID: <CAGEkeHdBri8mbX9zctroRZeoMb=u6mYSn4xAum1x_UkyUZKRdg@mail.gmail.com>
Subject: Re: [PATCH v4] staging: fbtft: remove unused fbtft_init_dbg()
To: himanshu bakshi <himanshu.bakshi478@gmail.com>
Cc: gregkh@linuxfoundation.org, andy@kernel.org, error27@gmail.com, 
	cenzhang@linux.microsoft.com, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 11, 2026 at 8:39 AM himanshu bakshi
<himanshu.bakshi478@gmail.com> wrote:
> - Verified that fbtft_init_dbg() has no call sites in the kernel tree.

Reviewed-by: Hungyu Lin <dennylin0707@gmail.com>
