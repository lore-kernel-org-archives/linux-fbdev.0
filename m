From: "Thomas S. Iversen" <zensonic@zensonic.dk>
Subject: Re: Need advice on blitting to dword alignment
Date: Fri, 12 Sep 2003 21:13:41 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030912191341.GA23768@zensonic.dk>
References: <20030912135229.GA12523@zensonic.dk> <Pine.LNX.4.44.0309121742420.5017-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xtNl-0002iY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 12:15:02 -0700
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228] helo=www.zensonic.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xtNl-0002FN-2M
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Sep 2003 12:15:01 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309121742420.5017-100000@phoenix.infradead.org>
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

On Fri, Sep 12, 2003 at 06:09:56PM +0100, James Simmons wrote:

Hi Again

> The NVIDIA fbdev driver had the same problems. That is what struct 
> fb_pixmap is for. Since you need 32 bit padded images you would need to 
> fill in your own pixmap when you initalize the driver. Something like 
> this.
> 
> 	info->pixmap.addr = kmalloc(64*1024, GFP_KERNEL);
> 	info->pixmap.size = 64 * 1024;
>         info->pixmap.buf_align = 4;
>         info->pixmap.scan_align = 4;
>         info->pixmap.flags = FB_PIXMAP_SYSTEM;

[snip]

Thanks a million --- you guys truely rocks! The good part is, that
now my mono/font expansion blit actually works and I can actually feel
the improvement when scrolling around in emacs ;-) .... but it came at a cost it
seems:

* My software cursor became messed up/flashing. I suspect that the software cursor
  does not work with alignment>1, but is that right??
* Tux, which was nicely drawn using the software fallback before I changed the pixmap 
  alignment, became messed up.

It made me suspect that the software imageblit does not work when alignment>1,
and further tests seemed to support this. Can I fix it somehow? Or
is it fixed in later kernel versions? (I use 2.5.73 for development at the moment)

Regards Thomas


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
