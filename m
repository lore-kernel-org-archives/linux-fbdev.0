Return-Path: <SRS0=iaJD=EL=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7108DC388F7
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Nov 2020 19:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF3920728
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Nov 2020 19:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ACwaGx3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgKETgO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:36:14 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:3928 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgKETgO (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 5 Nov 2020 14:36:14 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa4542d0000>; Fri, 06 Nov 2020 03:36:13 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 5 Nov
 2020 19:35:58 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 5 Nov 2020 19:35:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IACebdQDUK1LPo6dtFEzqoPn564iKyqzXEEOE+ViMcGLFXgwZepHQSyFZ8Qe5GQPD/YYEpTWoPS7Uff2gz0CbZVLDJeYx2uODzS0ytjN5/CxntsvGqDcKT7hJalCFbgRvCIEYfQ0PvnzBugfEfKSNmD3txNbH2Ajm503GukCsVV1H+iJWBBF/DTiV7dbwucG5M8HEq8U8C843r4DFFMcV1QtirC5ypSVpKSA4Mn+71sktqPDGCuofZQpNtXi3bqFTOtNoJfkJvXIHtYFar5WrzWxUmch1+tQTcCYWB2kZ8YspqytNcOjvXqn6UEg2GAJPlQIwg1KVbjNf6LqJm2yXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkt+EEj/AWdQBRd7cUpKSor6iRfLsu2dvJIC8FuRwXA=;
 b=n6Ilovgc5QZ4v2uzn8Fh2ddTm5FdVAmN/HDo3+fhN2JDK2eLgfkYYdMstJcWCrfoxowsBuEuU/+2E+ar0XaPO/5VZo2OmWJqHGMQaPdTSNxQzb7r4rnH/uuoPOvVeTUh8JK6o/qhNLKvS5E4tmLIFoWVg196sH8CVwnSPzAGRxwlLUHabKDNXuypE8H0F9UyUlJSr8FY0oZzeD+2JyVHTvFes787lCRb5dHtRXMbN78qWk2OvdCTW6KzLHi0CZ9HwrX2VFLCOELqQ8kCd6hG6I0WriQ5dcsk0XdbkY2IwZw+zL4trYiamel6hEmZz2GEoMxi0b4HHNEXalWxI7NYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 5 Nov
 2020 19:35:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 19:35:56 +0000
Date:   Thu, 5 Nov 2020 15:35:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] drm: remove pgprot_decrypted() before calls to
 io_remap_pfn_range()
Message-ID: <20201105193554.GP2620339@nvidia.com>
References: <0-v1-2e6a0db57868+166-drm_sme_clean_jgg@nvidia.com>
 <20201105191746.GC401619@phenom.ffwll.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201105191746.GC401619@phenom.ffwll.local>
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Thu, 5 Nov 2020 19:35:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kal34-000MOo-3X; Thu, 05 Nov 2020 15:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604604973; bh=rkt+EEj/AWdQBRd7cUpKSor6iRfLsu2dvJIC8FuRwXA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ACwaGx3dDTum1U+ykLD82m47Ai7xTcq52MKtpQXbs2qLqj29t0If9n3h/fxiaDM9U
         SQDPbLHmLROjzNvpDB2mnLRQ4waa1yIqso6xriHQesxp1MlRpHDC9mTqtXeIq+azxn
         1ZRJOorG2hXMQLCDCx4kvflSAGP07Py805QVQT0IX8xBJ48trEFGWy/+ZW5FKur1FX
         TNDD1NWygwZ2IF017JapYatlRLn6Awz3mQjP0GZ6Y15C0pu46HRTQ7pEhyWx8CL5st
         D5yX/u+OapKGOy3c/Ih5Xhkhi/CxPImlDrfGy7zifSJu1bUgLQ9vgt7MoVLmRMRNp3
         MC2rGZGeG8zYg==
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 05, 2020 at 08:17:46PM +0100, Daniel Vetter wrote:
> On Thu, Nov 05, 2020 at 01:00:19PM -0400, Jason Gunthorpe wrote:
> > commit f8f6ae5d077a ("mm: always have io_remap_pfn_range() set
> > pgprot_decrypted()") moves the pgprot_decrypted() into
> > io_remap_pfn_range(). Delete any, now confusing, open coded calls that
> > directly precede io_remap_pfn_range():
> > 
> > - drm_io_prot() is only in drm_mmap_locked() to call io_remap_pfn_range()
> > 
> > - fb_mmap() immediately calls vm_iomap_memory() which is a convenience
> >   wrapper for io_remap_pfn_range()
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/gpu/drm/drm_vm.c         | 3 ---
> >  drivers/video/fbdev/core/fbmem.c | 5 -----
> >  2 files changed, 8 deletions(-)
> > 
> > rc3 will have the dependent patch, this should not be merged to DRM until it
> > has the rc3 commits.
> > 
> > There are three other pgprot_decrypted() calls in DRM, I could not figure out
> > what was what there, but other than very special cases I would expect code to
> > use io_remap_pfn_range() instead.
> 
> There's 4 now, I think linux-next added one. It's another io_remap_pfn
> 
> Of the three you mentioned we have:
> - ttm and i915 use vm_insert_pfn (and ttm also can do also do pud_mkhuge
>   entries)

You can't insert IO memory with vmf_insert_pfn_pmd_prot() (it
doesn't set the special flag) so why does it need decrypted?

Jason
