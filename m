Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E71DE895
	for <linux-fbdev@vger.kernel.org>; Wed,  8 Jan 2025 21:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736370765; cv=none; b=Qg+Th6GGjM2+I9GCnsw4x3xvQ8MzqkeIGcrJ0FXuXJz6aN6H/npBS7U5R6IWdlUWIqRpoz1P8fNVK8UwM1zwglygqwNj5y1zDUm/YOUZZ0zoEOtlLAnT51MzgY3Gc+jGgGlE7YqAuClLGVMqBBOZ5o3rZVhexLhyA6sfYt9P2No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736370765; c=relaxed/simple;
	bh=jS32MEHwya3BLJq3lRZTGsz7QJ0y3q00irrzXM4dU/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CVAM/WjzoapUi0EryBuObL499iO3L+yP6lIAo5ZOPDcBdpirITpQs6gYzKjQL2MYX7RA0owKks8oOAQZTaJ7jrirSbV/g5pFiSiuLg8l0BAPV0E94YuZ8GGAJo+Zh9rp/KhBA6U1FqXSSYdZAvdIl58PWUhsHkNg0uJaEsE2AgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OmwYzxAL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OmwYzxAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736370762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7IxiThQS6Cse7A3b/CM1fKv8ccuu3lHxvYoroemHzVY=;
	b=OmwYzxAL+CpLn359hjWKJn7YAmX33gkhw/pVX6R1pFVFmfAUnnh9VaNHJFu9ewA/SKt4IS
	2zp1cJ2i+DHdp6AZccghxBX1LRtqPKvS49aKuiCOb7pNuhRLPLjYOTxyn6Qz9BNmwRQfOl
	z9gQrcVDytpuVDUkjHwxo90ZFnXau54=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-w0ijkINXOrqtJlRoGqcU9w-1; Wed, 08 Jan 2025 16:12:41 -0500
X-MC-Unique: w0ijkINXOrqtJlRoGqcU9w-1
X-Mimecast-MFC-AGG-ID: w0ijkINXOrqtJlRoGqcU9w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436248d1240so1178625e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Jan 2025 13:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736370760; x=1736975560;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7IxiThQS6Cse7A3b/CM1fKv8ccuu3lHxvYoroemHzVY=;
        b=BUJKZjiqdfPjjfCbdXE/7JnYEJK5Rom2vKqsWNRPZ100heT6KIkEijVhf5RtIPZ/vi
         7b9Xz4FQHHFD3VD7obNUbYCQcoAU9BEm6ZfWqKNcwB8fSmnKswYE0HVfCig6zGIOe0GE
         FuWCmCnFWzUDzqe/n7cvk3nj4qNEkPRo9oSaQBRBqKcEi3znzg+84LEQjqfb5fG2lj1f
         JDTL/MtGQg2W35e3ZEk5M8eHmMxANQ7lRY7wrWgihqHCJIqujuMVVom4Y0mvqScdRvq+
         eupyn1AfYlhbpYzQ1eeHcfdB63ll7R8/5djEcK8Wi1cuZvXbRAyBi5OOP50mSP1f2vp2
         ysVA==
X-Forwarded-Encrypted: i=1; AJvYcCXokImok4W84TdObQWjZQ6wG2LJ2OcSwTBm7u613fqkrqPIU7GP6CCQfa7OssslaRexiN3gXzGGCW0OaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjY8yHEZwX4mKmtZR3LBkayOWbjLnSuLorWHzKvaHYlMmtJ/XN
	ZwRxRYAAnIbKCWFUvF+2IC5FR95bpSIBYeQzVfhtcv59SrhfWfb4JVFZITyCfibklVTnBFdhFf5
	2S1BuweVF48Duqd7iGRgW0fHkxhh8Y6YSE3pzEB7R5Lt3hgivlY0NvlgEV8Bh
X-Gm-Gg: ASbGncu0loy8RmxOOfT5QeE/d5F4UCnSch3oGOs3zv7FZbkZ1FCJTj0HxEwklcrorf9
	BtMOB5l3RZYbvbjZYxWZiXXHpXJ6xCfk4zLEjta99XG4QczsLQN0wVn4yO6YKvxIMOrzawaCvgT
	dJnY+Gw9tkPG8mcGnVG7HVC5VIC/B/xCrNWuIfPrj4VlmqMs/A8OVwJV2NCSeLUY5CQCi8z0V/E
	7sU/6svSJ+vnNWc+1gky086PvZbGwqbVcD2oqEw9PxTbjgzFK25Vk2p/xSQoBdODSB+2Ylua8E3
	w75BKSMWcfI0mOKaKReezFF/gMNLtGzvFhi+4rfKu+SX0cJMXQKzdlQbfe8TVHdLkDEokJDAkU8
	oE/qqlQ==
X-Received: by 2002:a05:600c:a01:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-436e269715amr40429685e9.13.1736370760069;
        Wed, 08 Jan 2025 13:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEG0PXp4kXypKS88K2vg7pB4Jl1C7o4xE/MHkOHIy5/fPaztXmKRfd8MdWjYZXK3UFU0t4BVA==
X-Received: by 2002:a05:600c:a01:b0:434:9c1b:b36a with SMTP id 5b1f17b1804b1-436e269715amr40429225e9.13.1736370759073;
        Wed, 08 Jan 2025 13:12:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7? (p200300cbc70d3a00d73c06a8ca9f1df7.dip0.t-ipconnect.de. [2003:cb:c70d:3a00:d73c:6a8:ca9f:1df7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a28f17315sm48324196f8f.108.2025.01.08.13.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 13:12:37 -0800 (PST)
Message-ID: <34ad8349-c4c3-4370-a662-324fa91b32b1@redhat.com>
Date: Wed, 8 Jan 2025 22:12:36 +0100
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z37mE7NdQu-ZgBES@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.01.25 21:54, Matthew Wilcox wrote:
> On Wed, Jan 08, 2025 at 09:14:53PM +0100, David Hildenbrand wrote:
>> On 08.01.25 18:32, Matthew Wilcox wrote:
>>> On Wed, Jan 08, 2025 at 04:18:42PM +0000, Lorenzo Stoakes wrote:
>>>> @@ -280,7 +269,10 @@ static void fb_deferred_io_work(struct work_struct *work)
>>>>    		struct folio *folio = page_folio(pageref->page);
>>>>    		folio_lock(folio);
>>>> -		folio_mkclean(folio);
>>>> +		rmap_wrprotect_file_page(fbdefio->mapping,
>>>> +					 pageref->offset >> PAGE_SHIFT,
>>>> +					 compound_nr(pageref->page),
>>>> +					 page_to_pfn(pageref->page));
>>>>    		folio_unlock(folio);
>>>
>>> Why do we need to lock the folio?  (since this isn't necessarily a
>>> folio)
>>
>> Can you clarify the "since this isn't necessarily a folio" part ? Do you
>> mean in the future, when we split "struct page" and "struct folio"?
> 
> Right.  I need to finish the email that explains where I think we're
> going in 2025 ...
> 
>> Doing an rmap walk on something that won't be a folio is ... sounds odd
>> (->wrong :) )
> 
> Not necessarily!  We already do that (since 2022) for DAX (see
> 6a8e0596f004).  rmap lets you find every place that a given range
> of a file is mapped into user address spaces; but that file might be a
> device file, and so it's not just pagecache but also (in this case)
> fb memory, and whatever else device drivers decide to mmap.

Yes, that part I remember.

I thought we would be passing in a page into rmap_wrprotect_file_page(), 
and was wondering what we would do to "struct page" that won't be a 
folio in there.

Probably, because the "_page" in rmap_wrprotect_file_page() is misleading :)

... should it be "file_range" ? (but we also pass the pfn ... )

-- 
Cheers,

David / dhildenb

