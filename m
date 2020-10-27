Return-Path: <SRS0=EV96=EC=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB8C388F9
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 06:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C1D216FD
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Oct 2020 06:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603779774;
	bh=OX6Gx1/fazV7MgcdQVipYlPzthf7xQVRu6z13u2l37g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iAhJD8wc0q1LrE/n4x1Sn+mA5fvznu522wVNaef4zN+cW1s8P/OLkVS9TEtZ0308r
	 ZGEb9Qyy7qlxLjvDlpX8YMq0nZVP+fjyh8v6x3z64oLZ+YhGHFzUSfEPNuMVYuTiX+
	 CkCxWgnR0NbFSMb0zd729mPmeBf13uhH0Bwi+aJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506443AbgJ0GWy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Oct 2020 02:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506441AbgJ0GWW (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Oct 2020 02:22:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3728B216FD;
        Tue, 27 Oct 2020 06:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603779741;
        bh=OX6Gx1/fazV7MgcdQVipYlPzthf7xQVRu6z13u2l37g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTJ1CB3eGJLWuPKuMtrCh2xzKMlhQJzY7OyRAEsQkiyXoPuPQ3/UIjGDGEqhF+yiJ
         /JPjDYkCvD4H+1UIX0jaI6YuJn7BO30UI5CnA+4On75ZvM89inOD78+DF0csBaErG6
         F1x+QZ7ywt8xKjBsnK57ByYzRrtRKf0Opyz+4ATM=
Date:   Tue, 27 Oct 2020 07:22:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     stable@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        b.zolnierkie@samsung.com, jani.nikula@intel.com,
        daniel.vetter@ffwll.ch, gustavoars@kernel.org,
        dri-devel@lists.freedesktop.org, akpm@linux-foundation.org,
        rppt@kernel.org
Subject: Re: [PATCH 1/1] video: fbdev: fix divide error in fbcon_switch
Message-ID: <20201027062217.GE206502@kroah.com>
References: <20201021235758.59993-1-saeed.mirzamohammadi@oracle.com>
 <ad87c5c1-061d-8a81-7b2c-43a8687a464f@suse.de>
 <3294C797-1BBB-4410-812B-4A4BB813F002@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3294C797-1BBB-4410-812B-4A4BB813F002@oracle.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Oct 26, 2020 at 10:00:11AM -0700, Saeed Mirzamohammadi wrote:
> Thanks, adding stable.

Why?  What are we supposed to do with this?
