From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FBDEV updates.
Date: 16 Aug 2003 01:42:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1060990952.881.89.camel@gaston>
References: <Pine.LNX.4.44.0308152319570.30952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308152319570.30952-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> 
> Will do. I like to also handle Video mode change. Even userland will like 
> to know when a mode change happened. For userland a signal can be sent. 
> This would be useful for someone in X that runs fbset in a Xterm. This 
> hoses the X server. It would be nice if the X server would see the signal 
> change and adapt to it. Fbset could in theory be used again to change a VC 
> size. Yuck!!!! But it is what people want.

And for good reasons as we still have to deal with cases
where neither the driver nor modedb knows what the monitor supports...

Ben.
