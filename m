From: "David S. Miller" <davem@redhat.com>
Subject: Re: atyfb in 2.5.51
Date: 11 Dec 2002 00:42:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039596149.24691.2.camel@rth.ninka.net>
References: <Pine.LNX.4.33.0212102215450.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0212102215450.2617-100000@maxwell.earthlink.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2002-12-10 at 22:18, James Simmons wrote:
> > AFAIK, the X "mach64" driver in XF 4.* doesn't care about UseFBDev.
> > Marc Aurele La France (maintainer of this driver) is basically allergic
> > to kernel fbdev support.
> 
> :-(

I've always stated that the whole fbdev model was flawed, it makes
basic assumptions about how a video card's memory and registers are
accessed (ie. the programming model) and many popular cards absolutely
do not fit into that model.

> I will have to go threw the X code to fix that :-(

There is nothing to fix.  You simply must restore the video state when
the last mmap() client goes away.  The __sparc__ code does exactly that.

I think relying on an application that mmap's a card to perfectly
restore the state would work in a perfect world, one we do not live
in.  Furthermore, fixing up the state like I am suggesting makes life
much simpler for people actually working on things like X servers and
other programs directly programming the ATI chip.
