From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
	seconds to initialize
Date: Tue, 21 Nov 2006 15:07:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611211506480.32103@pentafluge.infradead.org>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
	<Pine.LNX.4.64.0611201633240.17639@pentafluge.infradead.org>
	<808c8e9d0611201447y6e053e89m9a5333af91a235aa@mail.gmail.com>
	<20061121003447.GD5160@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmXDZ-000405-Jt for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 07:07:25 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmXDZ-00073O-1F
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Nov 2006 07:07:25 -0800
In-Reply-To: <20061121003447.GD5160@cosmic.amd.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


Thank you :-) If this works it will save me alot of trouble.

On Mon, 20 Nov 2006, Jordan Crouse wrote:

> On 20/11/06 16:47 -0600, Ben Gardner wrote:
> > I tracked it down to the memset_io() call in gxfb_core.c that clears
> > all the video memory.
> > 
> > It take 12.5 seconds to memset() a mere 16,384 Kibyte of memory.
> > That seems a bit strange to me.
> > 
> > What's stranger is the time it takes to clear the fb memory:
> > The first 4 MB clear in 0.01 s each.
> > The last 12MB are SLOW.
>  
> Hmmm - thats interesting.  One thing about the current gxfb driver is that
> it assumes a 16Mb framebuffer, which may or may not be what you have, since 
> the amount of memory that is assigned to the graphics engine is configurable.
> 
> Its possible that you only have 4Mb of memory assigned to the graphics
> engine, and that memsetting further is out being subtractively decoded on
> the PCI bus and going nowhere slowly.
> 
> The attached patch queries the BIOS for the true amount of memory that
> is configured.  The patch has been kicking around in the Geode git tree and 
> -mm for a while so it should be sane.  Give it a try and see if it helps.
> 
> Jordan
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
