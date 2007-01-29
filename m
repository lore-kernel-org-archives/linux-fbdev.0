From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Mon, 29 Jan 2007 15:10:16 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701291442530.19906@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<20070126031236.GG18537@lst.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBXDI-0006qM-6j for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 06:10:28 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBXDH-0000Mh-Nf
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Jan 2007 06:10:28 -0800
In-Reply-To: <20070126031236.GG18537@lst.de>
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
To: Christoph Hellwig <hch@lst.de>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

On Fri, 26 Jan 2007, Christoph Hellwig wrote:
> Btw, the Kconfig and/or top of file comment really needs a better
> explanation what this "driver" is for.  I also wonder why it's

What about `PS3 AV settings driver library' instead of `PS3 AV controller
support'?

> selectable in Kconfig at all given it has no visible user interface.
> Shouldn't the users of the exported symbols simply pull it in or the
> code made part of the unconditional build bits in the ps3 platform
> directory?

We can make FB_PS3 (and SND_PS3 later) select PS3_PS3AV. Is that better?
I prefer not to make it unconditional, as people who want to run their PS3s
headless don't need it.

I guess you want us to do the same for the virtual uart, i.e. let PS3_PS3AV and
PS3_SYS_MANAGER select PS3_VUART?

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
