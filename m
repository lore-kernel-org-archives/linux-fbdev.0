From: James Simmons <jsimmons@infradead.org>
Subject: Re: FBDEV updates.
Date: Fri, 15 Aug 2003 23:31:20 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0308152319570.30952-100000@phoenix.infradead.org>
References: <1060936833.13534.34.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1060936833.13534.34.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Otto Solares <solca@guug.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> That patch actually works here and I'm more/less waiting for it
> to be merged so I can send you the driver updates based on it.
> (It's becoming rather urgent. My pending PowerMac updates that
> port things to the new model are causing PM to break on PowerBook
> laptops now because fbdev has incorrect PM and the "old style" thing
> isn't properly ordered).
> 
> The only thing you may probably want to fix (because you know
> that code better than I do) are:
> 
>  - the "resume" callback in fbcon where I currently just refresh
> the foreground console, while you may actually want to refresh the
> one on this fb since I suppose that with mutiple heads, we may have
> consoles on more than one head ?
> 
>  - the suspend callback where you probably want to disable the
> cursor timer

Will do. I like to also handle Video mode change. Even userland will like 
to know when a mode change happened. For userland a signal can be sent. 
This would be useful for someone in X that runs fbset in a Xterm. This 
hoses the X server. It would be nice if the X server would see the signal 
change and adapt to it. Fbset could in theory be used again to change a VC 
size. Yuck!!!! But it is what people want.
