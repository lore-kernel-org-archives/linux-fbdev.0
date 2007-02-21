From: James Simmons <jsimmons@infradead.org>
Subject: Re: enquiry about 4 bpp frame buffer with
 nibbles swapped
Date: Wed, 21 Feb 2007 21:50:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702212148500.20620@pentafluge.infradead.org>
References: <20070220121156.41538.qmail@web51601.mail.yahoo.com>
	<Pine.LNX.4.62.0702210832300.7944@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJzM4-00005s-Sz for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 13:50:29 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HJzM2-00054z-S5
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 13:50:28 -0800
In-Reply-To: <Pine.LNX.4.62.0702210832300.7944@pademelon.sonytel.be>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Aitor Garcia <carrierphasejitter@yahoo.com>, Geert Uytterhoeven <geert@linux-m68k.org>


> > But I do not know where to do it. 
> > Frame Buffer has 3 functions cfb_fillrect,
> > cfb_copyarea and cfb_imageblit which I thought were
> > the key to solve my problems but Qtopia Core does not
> > make use
> > of them.  
> 
> Indeed, cfb_{fillrect,copyarea,imageblit}() are used by the kernel only.

Speaking of. Are you using fbcon? If that is the case then your console 
should look messed up.
 
> > imxfb_map_video_memory function or fb_mmap, seem to be
> > good candidates but I do not know how to progress
> > further.
> 
> If the order of the nibbles can be configured in hardware, you should do that.
> Else I'm afraid you will have to modify Qtopia Core.

Can fb_bitfield handle that case ?


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
