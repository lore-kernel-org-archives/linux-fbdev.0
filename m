From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
Date: 29 Jul 2003 16:22:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1059510171.8538.53.camel@gaston>
References: <Pine.LNX.4.44.0307291753530.5874-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307291753530.5874-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-07-29 at 12:55, James Simmons wrote:
> > > matroxfb tried to use a 'dead' for handling hot removal, but your code
> > > looks definitely saner
> > 
> > My code wasn't really intended to deal with hot-removal, more with
> > "what happens if printk occurs during the Power Management suspend
> > sequence", but I tried to keep the notification mecanism simple
> > enough so it could be used for that as well. Also, indeed, the fbcon
> > changes should deal with hot-removal in some way (though you surely
> > also want to "deatch" from the fbdev's in this case).
> > 
> > Among other things that could be used for is live monitor insertion/
> > removal detection (some HW are able to do that), "pivot" monitor
> > kind of things, etc... typically via the mode_changed hook.
> 
> I knew it was a matter of time before "client" management would happen. 
> Is this a 2.6.X thing tho or shoudl we wait for the next developement 
> cycle. I don't mind working on experimental stuff.

We need that now for proper power management.

Ben.
