From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK console] console updates.
Date: Fri, 1 Nov 2002 09:40:05 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0211010937050.6296-100000@maxwell.earthlink.net>
References: <20021030215258.A10037@infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20021030215258.A10037@infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux console project <linuxconsole-dev@lists.sourceforge.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Wed, Oct 30, 2002 at 01:56:38PM -0800, James Simmons wrote:
> > I doubt this code will go into 2.5.X but it is avaiable for anyone to play
> > with it.
>
> Why?  I don't want to live another release with the old, crappy console,
> and you've been working on this during almost all of 2.4 now..

Give my console diff a try.

http://phoenix.infradead.org/~jsimmons/console.diff.gz

Its against 2.5.45. It has 3 bugs I know of.

1) Switch back to X messes up the screen.

2) I had to disable the beeper. I have to think of a proper solution to
   that problem with Vojtech.

3) Software suspend is broken because the console has moved from the
   global int currcons to private struct vc_data to represent a VC.
   BTW what was the author of that code trying to do any ways?
