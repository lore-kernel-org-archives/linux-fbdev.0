From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: 2.6.11-rc5
Date: Sat, 26 Feb 2005 12:01:04 +1100
Message-ID: <1109379664.15026.108.camel@gaston>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston>
	 <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston>
	 <20050225172945.GA31211@suse.de>
	 <Pine.LNX.4.56.0502251758370.20213@pentafluge.infradead.org>
	 <20050225202423.GA24282@suse.de> <20050225212157.GA31227@suse.de>
	 <20050225233043.GA16187@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4qLJ-0007Yh-A7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 17:02:01 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D4qLH-00083Z-NU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 17:02:01 -0800
In-Reply-To: <20050225233043.GA16187@suse.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Olaf Hering <olh@suse.de>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 2005-02-26 at 00:30 +0100, Olaf Hering wrote:
>  On Fri, Feb 25, Olaf Hering wrote:
> 
> >  On Fri, Feb 25, Olaf Hering wrote:
> > 
> > >  On Fri, Feb 25, James Simmons wrote:
> > > 
> > > > 
> > > > > cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
> > > > > fast_imageblit(237) s daea4000 dst1 fa51a800
> > > > > fast_imageblit(269) j 1 fa51a800 0
> > > > > Unable to handle kernel paging request at virtual address fa51a800
> > > > > 
> > > > > is bitstart incorrect or is the thing just not (yet) mapped?
> > > > 
> > > > Looks like the screen_base is not mapped to.
> > > 
> > > rc3 worked ok, rc4 does not. testing the -bk snapshots now.
> > 
> > bk8 works, bk9 breaks, it contains the radeonfb update.
> > it works ok if the driver is compiled into the kernel.
> 
> 
>  modedb = rinfo->mon1_modedb; passes some shit to fb_find_mode() which
>  kills my screen(1) when DPRINTK is enabled. it dies because bitstart
>  relies on xres_virtual which is 0xcccccc or whatever.

I think the problem is that you have totally bogus EDID data coming from
DDC. I'm still curious what makes a difference between module and
built-in. Either we try to set a bogus mode, or we just fail setting a
mode at all and fbdev doesn't deal with that properly.

Did you try plugging a different monitor ? Also, do you have output with
a recent X.org (6.8.2 for example) ? Can you send me that log too ?

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
