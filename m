Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140538FB9
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Dec 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832992; cv=none; b=pnVCv6+tWj/AkgC/n2nQHAezbJ+DxMeE2qL/957+y3sVS8Ogk5P6jofhw8G9efVzaMi+JkBOfsyVsJXbyk6rXuagIoJqXgRArDv4+K2G2O/D9rj9Xf4/MOqRxwJi6XZsfAjWtd2sey3zrmIAvuVBRcBKCaBHknKIi6NnmrbXe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832992; c=relaxed/simple;
	bh=TH79rIVD/GQsVc7djXy+oRhVpOuraI2O52UHrqvhK2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVcNqQjBxaoSKVhvaQn1PFtM0lZB/r4MFQrumO70iaJte846CM5WNd4CkDo+quyUpWYycPhcf7HaGi/RtYzoJhvash6Tseuf2LcJTodbiTYFcFx3CJxBxivf6jOUQtcyYPWDPOE3eiXMCtquUpgcUBdOogD2vUY2xQ5h9tUU2NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnCMCf0a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnCMCf0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733832990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lXKHp7PTPeLrFs3yLv8CjwlFKDB9W3PSURISJTTUMQg=;
	b=OnCMCf0aIO6CSydtCAGaGss5R3Qq3JAiUPEugXY1yrnfY9HB+iyjBjbzDhhMrRAr6C4InL
	qtwpq2KjskvogoVSRhHNW1514166aOq+Sy8qneIe8+6okZncDg3AA1PjzBWCsnJg3cv089
	YAflsQ8i2FSZgJv2o2YPdZmkxUyV2aQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-nYK13h-lOl-_i35KmIAMRw-1; Tue, 10 Dec 2024 07:16:29 -0500
X-MC-Unique: nYK13h-lOl-_i35KmIAMRw-1
X-Mimecast-MFC-AGG-ID: nYK13h-lOl-_i35KmIAMRw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dc37cb3eso3151823f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 10 Dec 2024 04:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832988; x=1734437788;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lXKHp7PTPeLrFs3yLv8CjwlFKDB9W3PSURISJTTUMQg=;
        b=t5GgVygNGGhf828kTvqdCoGXc8uvinYezE1bCnNTCkgSOc+p5Gu9Nooe4CEVV6gnPi
         52Rini//BPdCHrFPMXtJQzAVZT84QzgLdfsJ+AfR/CQkqNm0Thns0qdPOvEvvV0oNrdP
         vPjY9o8lS46TSqzbWSsNP5Zlqu22t5AtJ6N2YeUTguBJFNfT/VxvTcKIXe9wnms8yx40
         IS4qnrqwFOL5O/u/ssOfWnToerQjJGDxmQ4Q/D69xwXMrwdcLTREBhrsag3l9mlkBHid
         ytuOA706Vka/FdtQvllk99TJkfdo8XIpy3lx6D5Gs0hnfdbW9SHoZ+sOQFu/mfbZh5J8
         d0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUUJ1XXkZFKGRHCc9/eN1SLfc1UZ9jaov3c6zoxbbMw96QSca3W9Tt850+OttmUF1Spo2qE0+YXhTcioQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eKQue+Eq21FgA53YXL30GpWeOEd7x/WzCmW5gq7iTtuhK9tF
	cg/Fr5Xt6tY19GOsm87eOc0sRcLInKnFCdIVYjyEoRiAe8rmMEcwL7mqPu8ivW3sReZvbePhyYP
	P3pxA69kBv9U3dHNqP6fNLKji109rOuKxt42lfFfAsdkZgYpEVYlOYvC8zJvG
X-Gm-Gg: ASbGncsC7TJIMqYM7YlXFe4fs+x7pkn/198nm7jluVKcrdWQ7ZIqXRpGmpwKGUOl6rH
	FL44xTMimlC/p63fUcWW0CU3rtIi1tgdcykvQsZf44vZ9WHk0l16n7BVMeSFKsR1hKE4Nd/5v/P
	hX4kbpWHV8Vax1ytptbRXUq4/fp0DqQhQqWYNMSp1VeeotYT4W9xzTELZbszcC6ILjsOii8tyjo
	FXnaTxTf6QxOt7M0v/rMiGqKPv/r8vDA8ySNsvamnFOpe0DIvw4znXaUGl3KVcFx0dkTUwhiTRU
	rzkAuiBlLK/BLDxkNgmz8jzYPoOY5yvUXMN49pj2zAux9/da9U6zn8LLYkm1dUOSgv9+VXs+U+K
	5O2LEPg==
X-Received: by 2002:a5d:6c69:0:b0:385:df4e:366f with SMTP id ffacd0b85a97d-3862b3d094cmr12060651f8f.38.1733832987883;
        Tue, 10 Dec 2024 04:16:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUtAVYwl95714e4M/5rFlPd3XdXauYVwgHgacxP4Jrf3GCmac2hrDCWK6xExtVYysSYZZd3Q==
X-Received: by 2002:a5d:6c69:0:b0:385:df4e:366f with SMTP id ffacd0b85a97d-3862b3d094cmr12060626f8f.38.1733832987490;
        Tue, 10 Dec 2024 04:16:27 -0800 (PST)
Received: from ?IPV6:2003:cb:c723:b800:9a60:4b46:49f9:87f3? (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862294b1e3sm15641181f8f.109.2024.12.10.04.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 04:16:26 -0800 (PST)
Message-ID: <1a02554d-d7c1-4925-8180-a39bd6ecdd32@redhat.com>
Date: Tue, 10 Dec 2024 13:16:24 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Removing page->index
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-s390@vger.kernel.org
References: <Z09hOy-UY9KC8WMb@casper.infradead.org>
 <cebb44b2-e258-43ff-80a5-6bd19c8edab8@redhat.com>
 <20241209183611.1f15595f@p-imbrenda>
 <023d1c53-783e-4d6d-a5e9-d15b9e068986@redhat.com>
 <20241210130420.534a6512@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241210130420.534a6512@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.12.24 13:04, Claudio Imbrenda wrote:
> On Tue, 10 Dec 2024 12:05:25 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 09.12.24 18:36, Claudio Imbrenda wrote:
>>> On Wed, 4 Dec 2024 16:58:52 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
> 
> [...]
> 
>>>> I know that Claudio is working on some changes, but not sure how that
>>>> would affect gmap's usage of page->index.
>>>
>>> After I'm done, we won't use page->index anymore.
>>>
>>> The changes I'm working on are massive, it's very impractical to push
>>> everything at once, so I'm refactoring and splitting smaller and more
>>> manageable (and reviewable) series.
>>>
>>> This means that it will take some time before I'm done (I'm *hoping*
>>> to be done for 6.15)
>>
>> Thanks for the information. So for the time being, we could likely
>> switch to page->private.
>>
>> One question may be whether these (not-user-space) page tables should at
>> some point deserve a dedicated memdesc. But likely the question is what
> 
> maybe? but given that everything is changing all the time, I'm avoiding
> any magic logic in struct page / struct folio.

I think Willy wants to get rid of page->index in the next release, so 
any way to avoid the page->index usage in s390x is appreciated. 
page->private might be the low hanging fruit. If your approach is 
feasible in that time frame, it would also be great.

-- 
Cheers,

David / dhildenb

