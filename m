Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8C4C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 04:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4076164DCE
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 04:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhA1EFG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 23:05:06 -0500
Received: from foss.arm.com ([217.140.110.172]:50862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231146AbhA1EEW (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 23:04:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FFD11042;
        Wed, 27 Jan 2021 19:54:01 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271A43F66E;
        Wed, 27 Jan 2021 19:53:55 -0800 (PST)
Subject: Re: [PATCH v1 1/2] video: fbdev: acornfb: remove free_unused_pages()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20210126182113.19892-1-david@redhat.com>
 <20210126182113.19892-2-david@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <292c749e-427e-0a8d-c163-9f739af873a8@arm.com>
Date:   Thu, 28 Jan 2021 09:24:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126182113.19892-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org



On 1/26/21 11:51 PM, David Hildenbrand wrote:
> This function is never used and it is one of the last remaining user of
> __free_reserved_page(). Let's just drop it.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

There is no other reference for free_unused_pages() in the tree.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  drivers/video/fbdev/acornfb.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
> index bcc92aecf666..1b72edc01cfb 100644
> --- a/drivers/video/fbdev/acornfb.c
> +++ b/drivers/video/fbdev/acornfb.c
> @@ -921,40 +921,6 @@ static int acornfb_detect_monitortype(void)
>  	return 4;
>  }
>  
> -/*
> - * This enables the unused memory to be freed on older Acorn machines.
> - * We are freeing memory on behalf of the architecture initialisation
> - * code here.
> - */
> -static inline void
> -free_unused_pages(unsigned int virtual_start, unsigned int virtual_end)
> -{
> -	int mb_freed = 0;
> -
> -	/*
> -	 * Align addresses
> -	 */
> -	virtual_start = PAGE_ALIGN(virtual_start);
> -	virtual_end = PAGE_ALIGN(virtual_end);
> -
> -	while (virtual_start < virtual_end) {
> -		struct page *page;
> -
> -		/*
> -		 * Clear page reserved bit,
> -		 * set count to 1, and free
> -		 * the page.
> -		 */
> -		page = virt_to_page(virtual_start);
> -		__free_reserved_page(page);
> -
> -		virtual_start += PAGE_SIZE;
> -		mb_freed += PAGE_SIZE / 1024;
> -	}
> -
> -	printk("acornfb: freed %dK memory\n", mb_freed);
> -}
> -
>  static int acornfb_probe(struct platform_device *dev)
>  {
>  	unsigned long size;
> 
