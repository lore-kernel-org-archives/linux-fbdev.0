From: "Thomas S. Iversen" <zensonic@zensonic.dk>
Subject: Re: Need advice on blitting to dword alignment
Date: Sat, 13 Sep 2003 07:17:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030913051736.GA13008@zensonic.dk>
References: <20030912195842.GA25986@zensonic.dk> <Pine.LNX.4.44.0309122225100.5017-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19y2oC-00056c-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 22:18:56 -0700
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228] helo=www.zensonic.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19y2oB-0002XV-B2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 22:18:55 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309122225100.5017-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, Sep 12, 2003 at 10:26:33PM +0100, James Simmons wrote:

> No hardware support to draw color images :-(

No, not at the moment, will look into that later; my
time is, like everybody else, limited :-(

> Cursor broken in 2.5.73.

Ahh, I will try some of the later kernels. Or add support
for hardware cursor when time permits :-)

> You mean a cfb_copyarea call? 

No a cfb_imageblit(info,image) call. My code looked roughly like
during development:

void lynxfb_imageblit(info, image) {
	if(image->depth!=1)
	 	return cfb_imageblit(info,image);
	
	hardware accelerated font blit of
 	the requested image, but 
	_hardwired_ to start at 0,0

	cfb_imageblit(info,image); //At the right position
}

When I set alignment to 1 the code above does produce a normal
console except for the top line which are blitted wrong by
the hardware.

If I change alignment to 4, the hardware blits correctly, but
the rest of screen become garbage (sort of, one get a staircase effect,
probably because of the alignment)

It is not a problem anymore, now that the hardware blitting
works for me, but I will see if I get the same effect in 2.6.0pre 
kernels at the same time as I hope for the cursor to turn up all
normal again ;-)

Thanks for your help

Regards Thomas


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
