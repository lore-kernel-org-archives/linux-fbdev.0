From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Date: Wed, 2 Apr 2003 22:55:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
References: <1049298087.1993.54.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1049298087.1993.54.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Petr <vandrove@vc.cvut.cz>


> James,
> 
> Here's a revised patch.  I was able to receive source code from SciTech
> (c/o Kendall Bennett) which allowed me to fix bugs and complete the
> parser.  It's probably around 90-95% complete in terms of basic parsing.
> 
> It also fixes memory leaks which was present in the old patch.

Let really good. I applied it to my local tree but haven't passed it to BK 
fbdev yet. The only thing I like to see changed is get_EDID. At present it 
accepts a struct pci_dev. Now for generic support for the intel platform 
we can get this from the BIOS. You already have a patch that does this. 
It doesn't need a struct pci_dev in this case. It is possible to get this 
info from the i2c bus but I never seen any drivers do this. What data would
we have to pass in get the EDID inforamtion? So the question is how 
generic will get_EDID end up being or will we have to have driver specfic 
hooks since I don't pitcure i2c approaches being the same for each video 
card. Petr didn't you attempt this with the matrox driver at one time?
