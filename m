From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Re: Fw: [Bugme-new] [Bug 4218] New: Radeon
 fb doesn't have correct resolution for lcd screen
Date: Wed, 16 Feb 2005 19:55:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502161955370.23410@pentafluge.infradead.org>
References: <20050215133933.61769fd0.akpm@osdl.org> <1108504048.13376.11.camel@gaston>
 <200502160948.51781.bart@verwilst.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1VHI-0003ch-AB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 11:56:04 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1VHD-0002N8-Jq
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 11:56:04 -0800
Received: from jsimmons (helo=localhost)
	by pentafluge.infradead.org with local-esmtp (Exim 4.43 #1 (Red Hat Linux))
	id 1D1VH7-000668-22
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 19:55:55 +0000
In-Reply-To: <200502160948.51781.bart@verwilst.be>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Be careful. Don't run radeonfb and vesa fb at the same time!!!

On Wed, 16 Feb 2005, Bart Verwilst wrote:

> Hi!
> 
> Hm, i'm not sure wether it's radeonfb or not 
> 
> ----
> 
> vesafb: framebuffer at 0xe0000000, mapped to 0xdc880000, using 1875k, total 
> 65472k
> vesafb: mode is 800x600x16, linelength=1600, pages=67
> vesafb: protected mode interface info at c000:51a9
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
> bootsplash 3.1.4-2004/02/19: looking for picture.... silentjpeg size 14554 
> bytes, found (800x600, 14506 bytes, v3).
> Console: switching to colour frame buffer device 92x32
> fb0: VESA VGA frame buffer device
> 
> ---
> 
> Is radeonfb a driver for vesafb? Or are they unrelated?
> 
> Could you give me some more pointers for me what i could do to test more? Or 
> will enabling radeonfb debug support still be helpful?
> 
> Thanks in advance!
> 
> Op dinsdag 15 februari 2005 22:47, schreef Benjamin Herrenschmidt:
> ||  On Tue, 2005-02-15 at 13:39 -0800, Andrew Morton wrote:
> ||  > Begin forwarded message:
> ||  >
> ||  > Date: Tue, 15 Feb 2005 13:28:36 -0800
> ||  > From: bugme-daemon@osdl.org
> ||  > To: bugme-new@lists.osdl.org
> ||  > Subject: [Bugme-new] [Bug 4218] New: Radeon fb doesn't have correct
> ||  > resolution for lcd screen
> ||
> ||  Please, enable radeonfb verbose debug in the .config and send me the
> ||  log.
> ||
> ||  Ben.
> 
> -- 
> Bart Verwilst
> Jabber ID & Email: bart@verwilst.be
> Website: http://www.verwilst.be
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
