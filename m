From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Date: 03 Apr 2003 00:20:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1049322054.578.3.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Petr <vandrove@vc.cvut.cz>


> Let really good. I applied it to my local tree but haven't passed it to BK 
> fbdev yet. The only thing I like to see changed is get_EDID. At present it 
> accepts a struct pci_dev. Now for generic support for the intel platform 
> we can get this from the BIOS. You already have a patch that does this. 
> It doesn't need a struct pci_dev in this case. It is possible to get this 
> info from the i2c bus but I never seen any drivers do this. What data would
> we have to pass in get the EDID inforamtion? So the question is how 
> generic will get_EDID end up being or will we have to have driver specfic 
> hooks since I don't pitcure i2c approaches being the same for each video 
> card. Petr didn't you attempt this with the matrox driver at one time?

get_EDID() has to be a driver specific hook

EDID via BIOS is a way to get it, BIOS emulation in userland is another,
on PPC, I can retreive it from the firmware device-tree in a different
way with some cards, and finally, I plan to implement i2c sooner or
later with some drivers...

Ben.
