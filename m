From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Wed, 31 Jan 2007 09:45:13 +0100
Message-ID: <20070131084513.GB5596@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<20070126031236.GG18537@lst.de>
	<Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
	<20070129161502.GA32313@lst.de>
	<E674F9E5-3FFC-4291-A03B-0C3BF0F833A6@kernel.crashing.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HCB61-00004z-G0 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 00:45:40 -0800
Received: from verein.lst.de ([213.95.11.210] helo=mail.lst.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HCB5z-0004GB-Q4
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 31 Jan 2007 00:45:37 -0800
Content-Disposition: inline
In-Reply-To: <E674F9E5-3FFC-4291-A03B-0C3BF0F833A6@kernel.crashing.org>
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
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, James Simmons <jsimmons@infradead.org>, Christoph Hellwig <hch@lst.de>

On Tue, Jan 30, 2007 at 07:39:40PM +0100, Segher Boessenkool wrote:
> >obj-$(CONFIG_FB_PS3)	+= ps3_av.o
> >obj-$(CONFIG_SND_PS3)	+= ps3_av.o
> 
> I don't think Kbuild will be too happy with that.  Or does
> it filter out duplicate files everywhere (dep, build, link)?

Yes, it's a feature stamming from the first predecessor of the current
kbuild system (drivers/sound/Makefile in late 2.2.x).

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
