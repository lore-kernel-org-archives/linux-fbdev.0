From: Olaf Hering <olh@suse.de>
Subject: Re: Re: 2.6.11-rc5
Date: Fri, 25 Feb 2005 21:24:23 +0100
Message-ID: <20050225202423.GA24282@suse.de>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <1109287708.15026.25.camel@gaston> <20050225070813.GA13735@suse.de> <1109316551.14993.63.camel@gaston> <20050225172945.GA31211@suse.de> <Pine.LNX.4.56.0502251758370.20213@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4m0o-0008Ux-Ps
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 12:24:34 -0800
Received: from cantor.suse.de ([195.135.220.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D4m0l-00016W-LB
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 12:24:34 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0502251758370.20213@pentafluge.infradead.org>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

 On Fri, Feb 25, James Simmons wrote:

> 
> > cfb_imageblit(320) dst1 fa51a800 base e0b80000 bitstart 1999a800
> > fast_imageblit(237) s daea4000 dst1 fa51a800
> > fast_imageblit(269) j 1 fa51a800 0
> > Unable to handle kernel paging request at virtual address fa51a800
> > 
> > is bitstart incorrect or is the thing just not (yet) mapped?
> 
> Looks like the screen_base is not mapped to.

rc3 worked ok, rc4 does not. testing the -bk snapshots now.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
