From: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: Bug#226973: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Thu, 1 Apr 2004 08:51:02 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040401065102.GB637@lambda>
References: <20040113160221.GA12752@iliana> <20040114211246.GA31567@scowler.net> <20040114211643.GA6793@iliana> <20040330153247.GB11287@scowler.net> <20040330165738.GC31639@lambda> <20040330230203.GA2568@scowler.net> <20040330230829.GA5257@lambda> <Pine.GSO.4.58.0403311011400.22944@waterleaf.sonytel.be> <20040331161002.GB16669@scowler.net> <20040401064122.GH16695@deadbeast.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8w2g-0004Ry-PQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Mar 2004 22:51:10 -0800
Received: from smtp1.wanadoo.fr ([193.252.22.30] helo=mwinf0102.wanadoo.fr)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8w2g-0000X2-JZ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Mar 2004 22:51:10 -0800
Content-Disposition: inline
In-Reply-To: <20040401064122.GH16695@deadbeast.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Branden Robinson <branden@debian.org>
Cc: Clint Adams <schizo@debian.org>, 226973@bugs.debian.org, Geert Uytterhoeven <geert@linux-m68k.org>, Sven Luther <sven.luther@wanadoo.fr>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Apr 01, 2004 at 01:41:22AM -0500, Branden Robinson wrote:
> On Wed, Mar 31, 2004 at 11:10:02AM -0500, Clint Adams wrote:
> > > If your graphics controller is limited by memory bandwidth, the maximum pixel
> > > clock depends on the number of bits per pixels, since larger pixels mean more
> > > memory bandwidth.
> > 
> > I'm unclear on the differences between 24 bpp and 32 bpp and how this
> > relates to internal pixmap format.
> 
> Some hardware uses a "packed-pixel format"; that is, 4 24-bit pixels are
> encoded in 3 32-bit words (what Intel calls "DWORDS", I think).

Yeah, DWORDS, because they are stil living in the era of 16bit hardware :)

> Other hardware tosses in a zero byte with every 32-bit "DWORD" transfer.

Well, the permedia2 should support both formats, depending on chosen
mode.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
