Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05112C77B7C
	for <linux-fbdev@archiver.kernel.org>; Tue,  9 May 2023 06:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjEIGtv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 9 May 2023 02:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjEIGto (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 9 May 2023 02:49:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D86810EA;
        Mon,  8 May 2023 23:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PbZUIlEwLxdApfWlTodlcMm6K5WCErVJpDX/q+SYV/o=; b=P6C0II8T3ToIDwdqzyhUAGJI/D
        ZCNC7WWDlvhvS9TP8hS5heFGY2y1fn4CvmpBwZRLK/SUhz7LqJX/4Qa45fz11oJU8k/AMFOhAHEr3
        +EWXJyg4O3XLRiADhyF/ipdHNeGii9lWT9BzHXZHp5pkptpBYBW632Ra0BctIfX/yhlj0k+Agmbuu
        LnutvhNKYS+hmxC+61WS22dWlvIlP1iAdbPbzVHNi/48lEfafUa14tSUupbJbAoyuFdZn3h3yMAsC
        ibLMeiZxLLk++miuJUDtabe5m1vwyoCbIE9NkFMB3XCQMNvk3dPsbTLKInjxivBc8zcfYlbVarwGF
        n4DvmLgg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pwHA6-0060xC-0Z;
        Tue, 09 May 2023 06:49:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04BA530026A;
        Tue,  9 May 2023 08:49:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E121A2B0DE80F; Tue,  9 May 2023 08:49:24 +0200 (CEST)
Date:   Tue, 9 May 2023 08:49:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pjones@redhat.com, deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Cannot boot an i386-UEFI thinkpad lenovo tablet-2
Message-ID: <20230509064924.GB2065796@hirez.programming.kicks-ass.net>
References: <ZFnoXiZGGhuWDl2S@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFnoXiZGGhuWDl2S@Red>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, May 09, 2023 at 08:29:50AM +0200, Corentin Labbe wrote:

> The bios speak about a debug port, but I found nothing which seems a
> physical debug port output.  I tried to wire the microusb power port
> on a USB host, but the host fail to enumerate any device (I tried also
> a spetial USB cable with data/power separated to be sure the problem
> was not the host failling to give enough power)
> 
> The tablet has only one port, so I use a hub for keyboard and USB key.

USB debug port is probably that one port, USB debug also does not work
through a hub :/

USB debug in general is a giant pain in the rear and I've never had much
luck with is. If it's that old to still need a i386 kernel then it's
probably USB2 at best and that requires a special magical cable too :-(

