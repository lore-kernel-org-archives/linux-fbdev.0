From: Eric Sellers <sellers-eric@rogers.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 13:08:23 -0500
Message-ID: <200503021308.23110.sellers-eric@rogers.com>
References: <9e473391050301215019081bce@mail.gmail.com> <9e47339105030209302701e9b5@mail.gmail.com> <Pine.LNX.4.62.0503021242370.15365@node2.an-vo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503021242370.15365@node2.an-vo.com>
Content-Disposition: inline
Sender: dri-devel-admin@lists.sourceforge.net
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Wednesday 02 March 2005 12:45, Vladimir Dergachev wrote:
> On Wed, 2 Mar 2005, Jon Smirl wrote:
> > On Wed, 2 Mar 2005 12:15:18 -0500 (EST), Vladimir Dergachev
> >
> > <volodya@mindspring.com> wrote:
> >>> I would find it useful if someone came up with a standard kernel space
> >>> V4L radeon driver instead of the Gatos stuff.
> >>
> >> By "standard" you mean "self-contained", right ?
> >
> > One that doesn't depend on X being there.
> >
> > Can one be build now that just ignores the memory management hooks?
>
> Sure, but you would have to give up using X on that card.
>
> In fact, Eric Sellers has already written such a module that provides V4L
> 1 and 2 support (Eric, please correct me if I got anything wrong..)

You can use my module with or without X 
(right now it only supports the older mach64 cards)

The only problem is there is no way of telling X where 
the capture buffers are. So you might get some corruption on screen when X 
uses that memory and it gets overwritten by a frame and then copied back.

The more memory you have the less you will notice this.
(so if you have a 4 meg card, you might want to keep your resolution and bit 
depth down)

If there was a userspace program that could allocate the end of video memory 
there would be no problem.

Eric


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
