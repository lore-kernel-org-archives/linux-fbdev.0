From: Adrian Bunk <bunk@stusta.de>
Subject: Re: RFC: disallow modular framebuffers
Date: Thu, 3 Mar 2005 21:20:39 +0100
Message-ID: <20050303202039.GH4608@stusta.de>
References: <20050301024118.GF4021@stusta.de> <200503012115.29023.adaplas@hotpop.com> <20050303165649.GF4608@stusta.de> <200503040350.51163.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6woZ-0003FR-DD
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 12:20:55 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D6woU-0004JW-72
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Mar 2005 12:20:55 -0800
Content-Disposition: inline
In-Reply-To: <200503040350.51163.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:50:42AM +0800, Antonino A. Daplas wrote:
>...
> > Is there any reason for these being three modules?
> > It seems the best solution would be to make this one module composed of
> > up to three object files?
> 
> Yes.

Two possible solutions:
- rename savagefb.c and link the three files into savagefb.o
- merge the other two files into savagefb.c

I'd slightly prefer the first choice, but I can send patches for 
whichever you prefer.

As a note, in both cases the EXPORT_SYMBOL's can be removed.

> Tony

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
