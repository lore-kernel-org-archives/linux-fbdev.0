From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: [Linux-fbdev-devel] Re: 2.6.11-rc5
Date: Fri, 25 Feb 2005 17:59:04 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502251758370.20213@pentafluge.infradead.org>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
 <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston>
 <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston>
 <20050225172945.GA31211@suse.de>
Mime-Version: 1.0
In-Reply-To: <20050225172945.GA31211@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>


> cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
> fast_imageblit(237) s daea4000 dst1 fa51a800
> fast_imageblit(269) j 1 fa51a800 0
> Unable to handle kernel paging request at virtual address fa51a800
> 
> is bitstart incorrect or is the thing just not (yet) mapped?

Looks like the screen_base is not mapped to.
