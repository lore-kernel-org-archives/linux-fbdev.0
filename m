From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK updates] fbdev changes updates.
Date: Tue, 29 Oct 2002 14:08:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0210291408110.1363-100000@maxwell.earthlink.net>
References: <20021029205529.A2145@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021029205529.A2145@infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Tue, Oct 29, 2002 at 12:46:16PM -0800, James Simmons wrote:
> >
> > OOps. Forgot the link.
> >
> > bk://fbdev.bkbits.net/fbdev-2.5
>
> Does it still contain the random file movearounds?

The reason I did this was to prevent adding another chuck of agp code. The
current work around for AGP fbdev drivers to have there OWN AGP code. So
we can leave the agp drivers where they are at or the framebuffer layer
can have its own AGP code for itself. Which way do you think it should be
done?

1) Fbdev layer has it own AGP layer

2) Use already existing AGP layer code.
