From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: New API and X option UseFBDev
Date: Tue, 9 Sep 2003 18:40:26 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909164026.GC4428@iliana>
References: <20030909100849.GA17091@iliana> <XFMail.20030909145758.jim.hague@acm.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wlYD-0001Ba-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 09:41:09 -0700
Received: from smtp6.wanadoo.fr ([193.252.22.28] helo=mwinf0303.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wlYD-0001wg-17
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 09:41:09 -0700
Content-Disposition: inline
In-Reply-To: <XFMail.20030909145758.jim.hague@acm.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jim Hague <jim.hague@acm.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, linux-fbdev-devel@lists.sourceforge.net

On Tue, Sep 09, 2003 at 02:57:58PM +0100, Jim Hague wrote:
> On 09-Sep-2003 Sven Luther wrote:
> > On Tue, Sep 09, 2003 at 07:49:55AM +0100, Jim Hague wrote:
> >> I have a problem when I try and run X (Debian 4.2.1-11 20030829103906). My
> >> config uses the Glint driver with UseFBDev true, and works fine on 2.4.22.
> >> [....]
> >> It's occurred to me that maybe this just doesn't work and I need an updated
> >> fbdevhw. Do I? Or should it really Just Work?
> > 
> > I think the glint driver is hardcoded to expect amiga hardware when
> > using pm2 with fbdev. Just don't use the usefbdev option, and everything
> > should be fine.
> > 
> > the glint driver does not really support usefbdev anyway, only as a
> > hacky workaround for amigas with cybervision/bvision graphic board.
> 
> Unfortunately, I do rather think I need to use UseFBDev. Hardware is

Ok, i was wrong, it has been some time since i looked at the glint
driver for fbdev stuff, altough i am kind of the default maintainer of
the glint driver now, or at least part-wise with Alan Hourihane. After
looking at it, i saw that the fbdev code is hardcoded to use a ti_pm2,
and will not work with other graphic chips. But the pm3 X driver i wrote
worked perfectly well without it.

> Graphics Exxtreme, x86, BTW. Without, things just don't work properly -
> something isn't quite right with the mode set by X, and you can't switch back
> to the console. Well, you can try, but it seems to hang the kernel.
> 
> I'm currently using UseFBDev on 2.4, for the same reasons. I will keep on
> digging.

Mmm, notice that the :

(--) GLINT(0): Linear framebuffer at 0xCE800000
(--) GLINT(0): MMIO registers at 0xCFFE0000
(EE) GLINT(0): mmap mmio: Invalid argument
(EE) GLINT(0): mmap mmio: Invalid argument

means that the linear framebuffer and mmio registers, values given to
you by pm2fb, are correct (but check this fact with lspci). GLINTMapMem
should call fbdevHWMapVidmem, so i suppose the message you see are from
fbdevhw. Try enabling the DEBUG #define in glint_driver.c to get a bit
more context. 

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
