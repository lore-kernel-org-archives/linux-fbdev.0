From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: RFC: disallow modular framebuffers
Date: Fri, 4 Mar 2005 04:37:43 +0800
Message-ID: <200503040437.43495.adaplas@hotpop.com>
References: <20050301024118.GF4021@stusta.de> <200503040350.51163.adaplas@hotpop.com> <20050303202039.GH4608@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6x56-0004LJ-If
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 12:38:00 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6x54-0003jm-L4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 12:38:00 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 18853F502D5
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  3 Mar 2005 20:37:47 +0000 (UTC)
In-Reply-To: <20050303202039.GH4608@stusta.de>
Content-Disposition: inline
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
To: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Friday 04 March 2005 04:20, Adrian Bunk wrote:
> On Fri, Mar 04, 2005 at 03:50:42AM +0800, Antonino A. Daplas wrote:
> >...
> >
> > > Is there any reason for these being three modules?
> > > It seems the best solution would be to make this one module composed of
> > > up to three object files?
> >
> > Yes.
>
> Two possible solutions:
> - rename savagefb.c and link the three files into savagefb.o
> - merge the other two files into savagefb.c
>
> I'd slightly prefer the first choice, but I can send patches for
> whichever you prefer.

I also prefer the first one even if it results into a big patch because
of the rename.

Tony





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
