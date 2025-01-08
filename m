Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3CD19EED0
	for <linux-fbdev@vger.kernel.org>; Wed,  8 Jan 2025 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373787; cv=none; b=LsPBnjhKMpXKeppsDOGOS+DY/n3CLNe+Z/flGrJG2Y8nVjOaAO675RB4hYGFnfIzR6hTL1gyRB0E6i37tb70J67kfwSmZgud8Nvy0WbKzkgV6iSRVcG8zTM5VkJxSd5GUyHCyM4cwBvl6CpWoOPLKQrgC9SAoh5clVqHaWtV18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373787; c=relaxed/simple;
	bh=t+JivmoftjhywWNeCaflCos/KX1R2R1wf7UHBxvGM7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8qLfKg1Wx5HBnBXKZB7ic4bdp9E3+PLlYvsPFlCUWAOFjqycO4fOorqbrw+xFyxZvf9UXHk/oPajnugcYXLNDmCPi2H09HRD2GBlTRtAxLoOCMvAF+Z2KO2XwkV2QAUUmStPCs5SVYIjvLXCfvDWd6xhnl0rRQZ54vpRUFlPgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEfKCERr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEfKCERr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736373784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Kk6HPyiEBK0OVPGvkDK7PZ9JY8SSS471bf1iolkcmRc=;
	b=WEfKCERrfAutJ2YScDQZD6lQQLZH04iXJaFFNM3xuzdCF5G0v4yO3v0CaZe7wkFqYQaU2n
	tknir7UVXJCbfGO/VkqMz1KR8qr28i362MC7cLAe5o0ZeTadGBUFIRlDCZI8LcvY2/gra3
	WI8HerC2S0Tn8RUt6MzMikJXywuCALU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-eBHrxL4oP86IrCqatAPLrA-1; Wed, 08 Jan 2025 17:03:01 -0500
X-MC-Unique: eBHrxL4oP86IrCqatAPLrA-1
X-Mimecast-MFC-AGG-ID: eBHrxL4oP86IrCqatAPLrA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-388d1f6f3b2so91003f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jan 2025 14:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373780; x=1736978580;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kk6HPyiEBK0OVPGvkDK7PZ9JY8SSS471bf1iolkcmRc=;
        b=uU8V4ldadvP/W5BbZsSr/fD1YVOLGYGz4tkf8IyUuDVGWrzVZ4EUyVgUYiFAfY3qSp
         tmR+EmVWXJzBFTUuCkWAPwbYsaXP1U4LBFVGRxueP7/v+Z2AkeqqM+nJhSyN4Wo2iO02
         sVahNs1TneZqnn4uBBx7LtQlredNtj7VKcq/eeBkVTR7jlFf1swNffEQUSigYCf53H0Q
         HMZYieNuxE6FJnLK36MEA2vJnT0wYqkgp8yiYLTSMET4QO0/SwHRrJE3i1/C7V1rNR2v
         O8vLrp57hoy6elMi9oA4G9/yQXGW0BoOgCpYE58XaNTnLkllLXe4WRgyI19jLZUPrp3u
         XJFw==
X-Forwarded-Encrypted: i=1; AJvYcCXKAHbBHKQHsmX/Fw8l6lSB7HuxNuMuJMUXH1jmcpnxL5tTm9DHd10CxSr9X+rKOBJ+cXRyj3YbmZsH6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuGsxCU8xVfCVkfTY3oqC6oXXgwDoSXmGxJDWwDiTJlvwzt9C
	m6deans6k3uNOGa+wZJgzoSdJY0QkNh4NUXyUEeg0sMHD6jTr+M+K8D5+CNCpwjGPODe7UgUXXQ
	Xp7zoJsyDYkJNoGQiokm8odB6ZccQ92CBP/4iXzk3Tqex9fg+hvZuJvbmeB7q
X-Gm-Gg: ASbGnctrE9xtJjuvtMyhJHFqacGFa3gMIM33FoWYtLfEv5Blxfiipq7bwchpRCQnGbz
	iPu30SHqG22EahLdBMcwuKDfL1bDQ9YARAe7gUKh/stCXRrDNIGWzge7rbMWKnqpcosBBSjFC+L
	GcAx3VxI4NXGUC4RDV0wFc7AW2jKyCQSWya5EG7AElNW1g/R4UL5pTa3A1J/UHTiw3yz+0SA5ea
	Gxx5j20OvZVM1+vM9oh5Y18hNGVNGjAPSlQFVtPLDUNUdrQ2P3kWFRJTHdKyV+odguD+mLDopg7
	Gf3ljqokJUTj6sfwnXS2gbA4aDalc6W8346xKqaDE0+qy7piEnM8dLthCZkWQVKpVwfsh0eEJMD
	SNmkRyQ==
X-Received: by 2002:a05:6000:4601:b0:385:d7f9:f166 with SMTP id ffacd0b85a97d-38a87303f71mr3583625f8f.17.1736373780001;
        Wed, 08 Jan 2025 14:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE153c4lxErMIOibHpB/I8wjRh0VGwff0OREF8gpiOBXYUx5D380ZnYjP9k1hzGjIWnUd5U8w==
X-Received: by 2002:a05:6000:4601:b0:385:d7f9:f166 with SMTP id ffacd0b85a97d-38a87303f71mr3583606f8f.17.1736373779662;
        Wed, 08 Jan 2025 14:02:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcceb374sm51192615e9.0.2025.01.08.14.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 14:02:58 -0800 (PST)
Message-ID: <9ef12649-7e82-4b5a-8090-e0645ffbf3dc@redhat.com>
Date: Wed, 8 Jan 2025 23:02:57 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] fb_defio: do not use deprecated page->mapping,
 index fields
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jaya Kumar <jayalk@intworks.biz>,
 Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1736352361.git.lorenzo.stoakes@oracle.com>
 <1e452b5b65f15a9a5d0c2ed3f5f812fdd1367603.1736352361.git.lorenzo.stoakes@oracle.com>
 <Z362xoQMxQRxYUlJ@casper.infradead.org>
 <b7465ad8-50ec-490b-a62a-e535e0a4691c@redhat.com>
 <Z37mE7NdQu-ZgBES@casper.infradead.org>
 <34ad8349-c4c3-4370-a662-324fa91b32b1@redhat.com>
 <Z370QO_Qq8-g4DZ6@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z370QO_Qq8-g4DZ6@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.01.25 22:55, Matthew Wilcox wrote:
> On Wed, Jan 08, 2025 at 10:12:36PM +0100, David Hildenbrand wrote:
>> On 08.01.25 21:54, Matthew Wilcox wrote:
>>> Not necessarily!  We already do that (since 2022) for DAX (see
>>> 6a8e0596f004).  rmap lets you find every place that a given range
>>> of a file is mapped into user address spaces; but that file might be a
>>> device file, and so it's not just pagecache but also (in this case)
>>> fb memory, and whatever else device drivers decide to mmap.
>>
>> Yes, that part I remember.
>>
>> I thought we would be passing in a page into rmap_wrprotect_file_page(), and
>> was wondering what we would do to "struct page" that won't be a folio in
>> there.
>>
>> Probably, because the "_page" in rmap_wrprotect_file_page() is misleading :)
>>
>> ... should it be "file_range" ? (but we also pass the pfn ... )
> 
> I don't think it's unprecedented for us to identify a page by its pfn.
> After all, the acronym stands for "page frame number".  That said, for
> the one caller of this, it has the struct page and passes in the result
> from page_to_pfn().  So no harm in passing in the struct page directly.
> 
> I would not like to see this function called "rmap_wrprotect_file_pfn".
> Files don't have pfns, so that's a bad name.

Agreed.

(it's too late in the evening for me to give any good suggestions :) )

-- 
Cheers,

David / dhildenb

