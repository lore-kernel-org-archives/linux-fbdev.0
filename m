From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: Fix IO access in rivafb
Date: Fri, 12 Nov 2004 11:32:07 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0411121130550.2301@ppc970.osdl.org>
References: <200411080521.iA85LbG6025914@hera.kernel.org>
 <200411090402.22696.adaplas@hotpop.com> <Pine.LNX.4.58.0411081211270.2301@ppc970.osdl.org>
 <200411090608.02759.adaplas@hotpop.com> <Pine.LNX.4.58.0411081422560.2301@ppc970.osdl.org>
 <20041112125125.GA3613@bogon.ms20.nix> <Pine.LNX.4.58.0411120755570.2301@ppc970.osdl.org>
 <20041112191852.GA4536@bogon.ms20.nix>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262613AbUKLTdY@vger.kernel.org>
In-Reply-To: <20041112191852.GA4536@bogon.ms20.nix>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guido Guenther <agx@sigxcpu.org>
Cc: adaplas@pol.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>



On Fri, 12 Nov 2004, Guido Guenther wrote:
>
> O.k., it was the __raw_{write,read}b which broke things, not the
> "alignment". This one works:

All right, that's as expected. However, it does seem to point out that the 
riva driver depends on _different_ memory ordering guarantees for the 
8-bit accesses as opposed to the other ones. Whee. Can you say "UGGLEE"?

Anyway, patch applied. Thanks,

		Linus
