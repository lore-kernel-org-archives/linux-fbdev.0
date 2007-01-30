From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Tue, 30 Jan 2007 20:39:30 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701302039090.7678@pademelon.sonytel.be>
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
	id 1HBypX-0008Me-3W for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 11:39:47 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBypR-00007u-22
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 11:39:47 -0800
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
Cc: James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Christoph Hellwig <hch@lst.de>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

On Tue, 30 Jan 2007, Segher Boessenkool wrote:
> >> We can make FB_PS3 (and SND_PS3 later) select PS3_PS3AV. Is that  
> >> better?
> >> I prefer not to make it unconditional, as people who want to run  
> >> their PS3s
> >> headless don't need it.
> >
> > Ok.  Even better would be handling it on the makefile level, by doing
> >
> > obj-$(CONFIG_FB_PS3)	+= ps3_av.o
> > obj-$(CONFIG_SND_PS3)	+= ps3_av.o
> 
> I don't think Kbuild will be too happy with that.  Or does
> it filter out duplicate files everywhere (dep, build, link)?

Yes, it filters out duplicates. But I went for `select' instead.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
