From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] s3c-fb:  enable fimd driver for s5pv210.
Date: Wed, 19 May 2010 02:50:00 +0100
Message-ID: <20100519014959.GD4720@trinity.fluff.org>
References: <4BF29B5C.2050202@samsung.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4BF29B5C.2050202@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: InKi Dae <inki.dae@samsung.com>
Cc: akpm@linux-foundation.org, ben-linux@fluff.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com

On Tue, May 18, 2010 at 10:51:24PM +0900, InKi Dae wrote:
> I'm sorry for being late.
> 
> this patch is for s5pv210.
> to support s5pv210, CH_ENABLE bit of SHADOW register should be enabled to enable window layer on s5pv210.

I'd like to hold this until the chnages for multi-hardware
support and header file cleanup are done.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
