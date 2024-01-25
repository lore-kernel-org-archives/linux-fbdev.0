Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE901BDD3
	for <linux-fbdev@vger.kernel.org>; Thu, 25 Jan 2024 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706214162; cv=none; b=l9jbXUtrc7fLUwtHa2G2uNW8+1pUlnwNZowoIoBspFAucDOT3CZ85C10PU8XLABrTi/eNB8FBa0iskInwCBpsVGiSySTQWxh5EHlcGHYVwekLig7ClQCfDdhtgPijSTVIWcM57KXpOSbtyfGONfUGwioc+u+F0KRcGASlJCJAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706214162; c=relaxed/simple;
	bh=O3ooH8/duDDCld9UTZOCr4l7u1P7UYgyqLjLD3vteBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWVFbDOQIbpNFM6d+GZeJgCIYb8UPoH1wr1i+S/t8n5oJqe/dyDfa9lyZuHMH0dBcYjyOfvffrodWTZYM2UDUgq7Yo5TGv5BueAjolic/jsqRGoSLLyRFR8oLeYlFPSSZrfRn9oC8SJY7ISSnhCcqgUbKY0OUowtnqXIcp4l9+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Rlc+5ulv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Rlc+5ulv"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55d000834dcso212093a12.1
        for <linux-fbdev@vger.kernel.org>; Thu, 25 Jan 2024 12:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706214157; x=1706818957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgx7mklBpB9KounVQy5eGpWd3i905pv75d99Q4ggPTM=;
        b=Rlc+5ulvuvv1T5WKCiXUe8pq4kzSTFOEsTjXA3UBZ3YUJgVC2l6+bMhdcWn6ryOwka
         3PeMQ9Y0B4wI5uC75vGV+tPVH4k8ODoR4kcI1UjjDY3YIN6wxYiF8Iak68oXktDBpX4Y
         W2agJ55ql9t/8XzJPefSRj+tmpAP+oCM22oRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706214157; x=1706818957;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgx7mklBpB9KounVQy5eGpWd3i905pv75d99Q4ggPTM=;
        b=TC/4AzSDgdzPrudHHSLorumt0Sec8kWzkB+FLloRelefPVd7ni4RjteU0gQ4aNKBwp
         jFlPq+4vjKCO3yVRpU1QIecv7h1WBk9tWM0yJKgdR5OUbxh6yJogY0rPiZwzsFwSI/ZN
         SXF6b53lRl3MIJDHKcTmPYHbgKUwdw++HnDNHmsziQDvUMfa8792je5sL4vRFOdIg1CU
         4rFpxFVyENIIHxDXsC3W6RGPZhgW1znwtsOLpPfi3hfAdCqoEp893HXgROmRJLtqXbtY
         E8mKlPbShjWFHS3UIE4WQSWgSKqW2Mqwh2fG88OqxXSK1v3hLNB4/Z/2ZCyS8qq8rVdU
         lZQA==
X-Forwarded-Encrypted: i=0; AJvYcCU/8ZtdFhCg9JwlJX6XXJuo1h0R8SwJFhK6dscf9VXOJovOD7OKPd0Xeli16Gna/RAKKTSYRNtMuzHayKUglJDwXB2dCyF2QENsiuU=
X-Gm-Message-State: AOJu0YzzMCXh2eyPdif7UzSo00SYk/rfr0bCqPyKa3UD2uVgc0vVSFOu
	Nw37InO2xjhj49d+xV2HoV0BPTUEhk6ABLkMNvCarj6d8he/nrNUWzsDcbGCLyg=
X-Google-Smtp-Source: AGHT+IFaTRwxaZ3kossB3H1YRQdr9l0tTF1yAxPBdIIOdK1uRobh4zyGMgDW9fgGjUXK1GGr2MpHAQ==
X-Received: by 2002:a17:906:f804:b0:a30:ff7f:e583 with SMTP id kh4-20020a170906f80400b00a30ff7fe583mr148157ejb.2.1706214157490;
        Thu, 25 Jan 2024 12:22:37 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id ps12-20020a170906bf4c00b00a31225fed97sm1372278ejb.104.2024.01.25.12.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:22:36 -0800 (PST)
Date: Thu, 25 Jan 2024 21:22:34 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Matthew Wilcox <willy@infradead.org>
Cc: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
	Jaya Kumar <jayalk@intworks.biz>, Daniel Vetter <daniel@ffwll.ch>,
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Subject: Re: fb_defio and page->mapping
Message-ID: <ZbLDCkpq9zxkdyLt@phenom.ffwll.local>
Mail-Followup-To: Matthew Wilcox <willy@infradead.org>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jaya Kumar <jayalk@intworks.biz>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-mm@kvack.org
References: <Za_1d4MVxKeQOP9B@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za_1d4MVxKeQOP9B@casper.infradead.org>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Jan 23, 2024 at 05:20:55PM +0000, Matthew Wilcox wrote:
> We're currently trying to remove page->mapping from the entire kernel.
> This has me interested in fb_defio and since I made such a mess of it
> with commits ccf953d8f3d6 / 0b78f8bcf495, I'd like to discuss what to
> do before diving in.
> 
> Folios continue to have a mapping.  So we can effectively do
> page_folio(page)->mapping (today that's calling compound_head() to get
> to the head page; eventually it's a separate allocation).
> 
> But now I look at commit 56c134f7f1b5, I'm a little scared.
> Apparently pages are being allocated from shmem and being mapped by
> fb_deferred_io_fault()?  This line:
> 
>                 page->mapping = vmf->vma->vm_file->f_mapping;
> 
> initially appears harmless for shmem files (because that's presumably
> a noop), but it's only a noop for head pages.  If shmem allocates a
> compound page (ie a 2MB THP today), you'll overlay some information
> stored in the second and third pages; looks like _entire_mapcount
> and _deferred_list.prev (but we do shift those fields around without
> regard to what the fb_defio driver is doing).  Even if you've disabled
> THP today, setting page->mapping to NULL in fb_deferred_io_lastclose()
> for a shmem page is a really bad idea.
> 
> I'd like to avoid fb_defio playing with page->mapping at all.
> As I understand it, the only reason to set page->mapping is so that
> page_mkclean() works.  But there are all kinds of assumptions in
> page_mkclean() (now essentially folio_mkclean()) that we're dealing with
> file-backed or anonymous memory.  I wonder if we might be better off
> calling pfn_mkclean_range() for each VMA which maps these allocations?
> You'd have to keep track of each VMA yourself (I think?)  but it would
> avoid messing with page->mapping.
> 
> Anyway, I don't know enough about DRM.  There might be something
> unutterably obvious we could do to fix this.

It's just really old code that's been barely touched to keep it going.

The issue is that the entire defio stuff is pretty bad layering violation.
Not sure what the cleanest way to do this really would be if it only
touches the ptes and nothing else. Not sure what's the right function for
a bit of pte walking for that.

That would still potentially mess with the mapping by the gpu memory
allocator in bad ways, but I think at least for all current ones it should
avoid problems.

Definitely agree that messing with struct page in any way is really bad,
we simply didn't get that far yet.

I think the cleanest way would be if we have a fb_mmap only for drm
drivers in drm_fbdev_generic.c and sunset fb_deferred_io_mmap and use that
to just replicate the ptes from the kernel's vmap into one that is ok for
userspace. The fbdev implementation in drm_fbdev_generic.c is the only one
left in drm that supports fb_defio, so that would catch all of them. To my
knowledge all the other defio implementations in native fbdev drivers
aren't problematic since none use shmem.

For I while we pondered with proxying the vma to the driver's drm native
mmap implementation, but that gets real messy plus there's no benefit
because fbdev assumes a bit too much that the memory is permanently
pinned. So we need the pinned kernel vmap anyway.

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
