From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] make savagefb one module
Date: Sat, 5 Mar 2005 02:12:41 +0100
Message-ID: <20050305011241.GO3327@stusta.de>
References: <20050301024118.GF4021@stusta.de> <200503040350.51163.adaplas@hotpop.com> <20050303202039.GH4608@stusta.de> <200503040437.43495.adaplas@hotpop.com> <20050303230750.GT4608@stusta.de> <Pine.LNX.4.62.0503041017000.22831@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7NrN-0006TA-1R
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 17:13:37 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D7NrL-0005Lj-9f
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 17:13:36 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503041017000.22831@numbat.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, adaplas@pol.net, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, Mar 04, 2005 at 10:17:17AM +0100, Geert Uytterhoeven wrote:
> On Fri, 4 Mar 2005, Adrian Bunk wrote:
> > This patch links all selected files under drivers/video/savagefb/ into 
> > one module.
> > 
> > This required a renaming of savagefb.c to savagefb_driver.c .
> > 
> > As a side effect, the EXPORT_SYMBOL's in this directory are no longer 
> > required.
> > 
> > ---
> > 
> > Other names than savagefb_driver.c (e.g. savagefb_main.c) are easily 
> > possible - I do not claim being good at picking names...
> 
> savagefb_core.c?

Antonino, what's your opinion?

> Gr{oetje,eeting}s,
> 
> 						Geert

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
