From: Paul Mackerras <paulus@samba.org>
Subject: Re: atyfb in 2.5.51
Date: Thu, 12 Dec 2002 08:06:36 +1100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <15863.43228.89337.776215@argo.ozlabs.ibm.com>
References: <1039596149.24691.2.camel@rth.ninka.net>
	<Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0212110709030.2617-100000@maxwell.earthlink.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: "David S. Miller" <davem@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons writes:

> :-( True. We should always assume X or any userland app could be broken.

I don't think we can blame X in this particular situation.  When I
press ctrl-alt-F1 in X, it resets the screen to the colormap and depth
that the text console was using, but the kernel doesn't redraw the
text console screen image.  (I presume it also resets the resolution,
but since I have only tried on an LCD screen I can't say for sure.)

Paul.
