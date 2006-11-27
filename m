From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbmem: is bootup logo broken for monochrome
 LCD ?
Date: Mon, 27 Nov 2006 16:01:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0611271558550.11317@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
	<Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org> 
	<cda58cb80611140144q79718798p40f2762955c1d91@mail.gmail.com> 
	<Pine.LNX.4.64.0611171825520.32200@pentafluge.infradead.org> 
	<cda58cb80611171242sb40a53bvd02145364551b5a2@mail.gmail.com> 
	<Pine.LNX.4.64.0611201636500.17639@pentafluge.infradead.org> 
	<cda58cb80611210145ic52001cr38aed6e38797e3a@mail.gmail.com> 
	<Pine.LNX.4.64.0611211507290.32103@pentafluge.infradead.org> 
	<cda58cb80611220048p73bb54e3w414f1c0a5ce178d3@mail.gmail.com> 
	<Pine.LNX.4.64.0611222101220.14604@pentafluge.infradead.org>
	<cda58cb80611230653x2951d9d8x41b193f0101f9fdf@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Goiw2-0003Gh-SG for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 08:02:22 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Goivv-00051J-6w
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 08:02:21 -0800
In-Reply-To: <cda58cb80611230653x2951d9d8x41b193f0101f9fdf@mail.gmail.com>
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
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > Replace the below line in my patch I sent
> > 
> > > >                     val |= color << shift;
> > 
> > with
> >                         val <<= shift;
> >                         val |= color;
> 
> I think it can't work since shift is 0 to 31, you'll end up with 'val
> <<= 31' which I don't think is what you want.
 
> doing
>                         val <<= 1;
> 
> make it works but it's still very fragile. Code which deals with
> trailing bit seems bogus since new value of 'val' is simply discarded
> here.

I'm going to test the code in depth over the next few days. I managed to 
fix most of the problems with fast_imageblit. Now to fix the slow image 
blit code.

> I'm wondering if working with 32 bits words really worth... I mean the
> code is quite hard to follow because it needs to deal with endianess,
> heading bits, trailings bits whereas working with 8 bits would be so
> much easier, wouldn't it ? Are writings in video RAM very long ?

Yes. We need to minimize the writes over the PCI bus. Its really really 
slow.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
