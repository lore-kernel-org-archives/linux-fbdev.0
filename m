From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 12:51:11 -0500
Message-ID: <9e47339105030209514b7a3f4c@mail.gmail.com>
References: <9e473391050301215019081bce@mail.gmail.com>
	 <Pine.LNX.4.62.0503021128001.14333@node2.an-vo.com>
	 <9e473391050302090926854d95@mail.gmail.com>
	 <Pine.LNX.4.62.0503021212550.14716@node2.an-vo.com>
	 <9e47339105030209302701e9b5@mail.gmail.com>
	 <Pine.LNX.4.62.0503021242370.15365@node2.an-vo.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503021242370.15365@node2.an-vo.com>
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
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>, esellers@users.sourceforge.net

On Wed, 2 Mar 2005 12:45:54 -0500 (EST), Vladimir Dergachev
<volodya@mindspring.com> wrote:
> 
> 
> On Wed, 2 Mar 2005, Jon Smirl wrote:
> 
> > On Wed, 2 Mar 2005 12:15:18 -0500 (EST), Vladimir Dergachev
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

Is memory management the only reason you need to give up on X?

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
--
