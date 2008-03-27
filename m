From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2 v3] Driver for Freescale 8610
	and 5121 DIU
Date: Thu, 27 Mar 2008 00:54:03 -0700
Message-ID: <20080327005403.18d6ab07.akpm@linux-foundation.org>
References: <120648043867-git-send-email-yorksun@freescale.com>
	<12064804383051-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JemwL-0001f4-7z for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Mar 2008 00:54:30 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JemwJ-0007vx-SY
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 27 Mar 2008 00:54:25 -0700
In-Reply-To: <12064804383051-git-send-email-yorksun@freescale.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: York Sun <yorksun@freescale.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, galak@kernel.crashing.org, linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>

On Tue, 25 Mar 2008 16:27:17 -0500 York Sun <yorksun@freescale.com> wrote:

> +#if defined(CONFIG_NOT_COHERENT_CACHE)
> +unsigned int *coherence_data;
> +phys_addr_t *coherence_data_phy;
> +#endif

These identifiers are too general for use as global symbols.  I'd suggest
renaming them to diu_coherence_data and diu_coherence_data_phy.  Or make
them static - I didn't check.

I'll duck this version of the patches, as Scott's comments looked rather
substantial.


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
