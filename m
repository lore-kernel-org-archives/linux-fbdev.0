Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DF3C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 04:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572ED64D9D
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 04:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhA1ENY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 23:13:24 -0500
Received: from foss.arm.com ([217.140.110.172]:51028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhA1ENT (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 23:13:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A9F81042;
        Wed, 27 Jan 2021 20:12:33 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754453F66B;
        Wed, 27 Jan 2021 20:12:29 -0800 (PST)
Subject: Re: [PATCH v1 2/2] mm: simplify free_highmem_page() and
 free_reserved_page()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20210126182113.19892-1-david@redhat.com>
 <20210126182113.19892-3-david@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6e3b29cd-fbf8-2b58-e61e-9d378b095263@arm.com>
Date:   Thu, 28 Jan 2021 09:42:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126182113.19892-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



On 1/26/21 11:51 PM, David Hildenbrand wrote:
> adjust_managed_page_count() as called by free_reserved_page() properly
> handles pages in a highmem zone, so we can reuse it for
> free_highmem_page().
> 
> We can now get rid of totalhigh_pages_inc() and simplify
> free_reserved_page().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/highmem-internal.h |  5 -----
>  include/linux/mm.h               | 16 ++--------------
>  mm/page_alloc.c                  | 11 -----------
>  3 files changed, 2 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
> index 1bbe96dc8be6..7902c7d8b55f 100644
> --- a/include/linux/highmem-internal.h
> +++ b/include/linux/highmem-internal.h
> @@ -127,11 +127,6 @@ static inline unsigned long totalhigh_pages(void)
>  	return (unsigned long)atomic_long_read(&_totalhigh_pages);
>  }
>  
> -static inline void totalhigh_pages_inc(void)
> -{
> -	atomic_long_inc(&_totalhigh_pages);
> -}
> -
>  static inline void totalhigh_pages_add(long count)
>  {
>  	atomic_long_add(count, &_totalhigh_pages);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a5d618d08506..494c69433a34 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2303,32 +2303,20 @@ extern void free_initmem(void);
>  extern unsigned long free_reserved_area(void *start, void *end,
>  					int poison, const char *s);
>  
> -#ifdef	CONFIG_HIGHMEM
> -/*
> - * Free a highmem page into the buddy system, adjusting totalhigh_pages
> - * and totalram_pages.
> - */
> -extern void free_highmem_page(struct page *page);
> -#endif
> -
>  extern void adjust_managed_page_count(struct page *page, long count);
>  extern void mem_init_print_info(const char *str);
>  
>  extern void reserve_bootmem_region(phys_addr_t start, phys_addr_t end);
>  
>  /* Free the reserved page into the buddy system, so it gets managed. */
> -static inline void __free_reserved_page(struct page *page)
> +static inline void free_reserved_page(struct page *page)
>  {
>  	ClearPageReserved(page);
>  	init_page_count(page);
>  	__free_page(page);
> -}
> -
> -static inline void free_reserved_page(struct page *page)
> -{
> -	__free_reserved_page(page);
>  	adjust_managed_page_count(page, 1);
>  }
> +#define free_highmem_page(page) free_reserved_page(page)
>  
>  static inline void mark_page_reserved(struct page *page)
>  {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b031a5ae0bd5..b2e42f10d4d4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7711,17 +7711,6 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
>  	return pages;
>  }
>  
> -#ifdef	CONFIG_HIGHMEM
> -void free_highmem_page(struct page *page)
> -{
> -	__free_reserved_page(page);
> -	totalram_pages_inc();
> -	atomic_long_inc(&page_zone(page)->managed_pages);
> -	totalhigh_pages_inc();
> -}
> -#endif
> -
> -
>  void __init mem_init_print_info(const char *str)
>  {
>  	unsigned long physpages, codesize, datasize, rosize, bss_size;
> 
