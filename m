From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Sat, 13 Nov 2004 10:00:38 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411130959280.4100@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <1100309972.20511.103.camel@gaston> <20041113112234.GA5523@bogon.ms20.nix>
 <200411132000.31465.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261856AbUKMSAu@vger.kernel.org>
In-Reply-To: <200411132000.31465.adaplas@hotpop.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Guido Guenther <agx@sigxcpu.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>



On Sat, 13 Nov 2004, Antonino A. Daplas wrote:
> 
> Why not use in_be* and out_be* for __raw_read and raw_write? 

Please don't start using some stupid magic ppc-specific macros for a 
driver that has no reason to be PPC-specific. It then only causes bugs 
that show on one platform and not another.

		Linus
