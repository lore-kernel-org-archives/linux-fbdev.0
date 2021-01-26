Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEACC433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 13:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9696207A9
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 13:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313615AbhAZWit (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391560AbhAZSWw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Jan 2021 13:22:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611685286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iEgpuJzqa3JbPGol8wUz7D5/XSGXIIng43V/18schz8=;
        b=EmZvw1ZfB1SmxsWf7iuJDE8+1ygKdkgJM0Ufk1EURAWDMxGfVXC8mOAKHfPE6mIdBEDY2g
        a33TGygVRFG8zTeki2AUs0saOeV0fWKOxxz7kV+Qy/SUk27qHRF1Mb0TSDfEcgIqq7LtDP
        2gizcKJmX2AqMVq39coJML1djHcpmfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-SzPm_gAKOoa_muj_u5Rr-w-1; Tue, 26 Jan 2021 13:21:23 -0500
X-MC-Unique: SzPm_gAKOoa_muj_u5Rr-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30283107ACE3;
        Tue, 26 Jan 2021 18:21:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7DC318A77;
        Tue, 26 Jan 2021 18:21:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 0/2] mm: simplify free_highmem_page() and free_reserved_page()
Date:   Tue, 26 Jan 2021 19:21:11 +0100
Message-Id: <20210126182113.19892-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Let's simplify and unify free_highmem_page() and free_reserved_page().

Gave it a quick test in i386 QEMU with 4G of RAM - seems to work just fine.

David Hildenbrand (2):
  video: fbdev: acornfb: remove free_unused_pages()
  mm: simplify free_highmem_page() and free_reserved_page()

 drivers/video/fbdev/acornfb.c    | 34 --------------------------------
 include/linux/highmem-internal.h |  5 -----
 include/linux/mm.h               | 16 ++-------------
 mm/page_alloc.c                  | 11 -----------
 4 files changed, 2 insertions(+), 64 deletions(-)

-- 
2.29.2

