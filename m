From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FBDEV updates.
Date: 15 Aug 2003 10:40:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1060936833.13534.34.camel@gaston>
References: <Pine.LNX.4.44.0308142150390.15200-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308142150390.15200-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-08-14 at 22:52, James Simmons wrote:
> > what is the current state of PM in fb drivers?
> 
> Experinmental patch from Ben is in the works.

That patch actually works here and I'm more/less waiting for it
to be merged so I can send you the driver updates based on it.
(It's becoming rather urgent. My pending PowerMac updates that
port things to the new model are causing PM to break on PowerBook
laptops now because fbdev has incorrect PM and the "old style" thing
isn't properly ordered).

The only thing you may probably want to fix (because you know
that code better than I do) are:

 - the "resume" callback in fbcon where I currently just refresh
the foreground console, while you may actually want to refresh the
one on this fb since I suppose that with mutiple heads, we may have
consoles on more than one head ?

 - the suspend callback where you probably want to disable the
cursor timer

Ben. 
