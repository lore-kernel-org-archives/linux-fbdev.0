From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: cfb* routines and high mem
Date: Mon, 22 Sep 2003 12:48:40 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922194840.59600.qmail@web14902.mail.yahoo.com>
References: <Pine.LNX.4.44.0309221953110.6431-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1Wfq-0001T3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 12:48:42 -0700
Received: from web14902.mail.yahoo.com ([216.136.225.54])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1Wfp-0001Bj-Pq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 12:48:41 -0700
In-Reply-To: <Pine.LNX.4.44.0309221953110.6431-100000@phoenix.infradead.org>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

--- James Simmons <jsimmons@infradead.org> wrote:
> No. The penguin code works for fbdev without console support. The logo can 
> be displayed for embedded fbdev devices so the developer knows it is 
> loaded.

Could the penguin code do the ioremap in its code? That way if it fails it
isn't fatal. Right now if the fb driver fails to load the penguin code is kind
of pointless. 

The client of the framebuffer needs to be responsible for the ioremap(), not
the driver. Since if the buffer is mapped to high mem the client code needs to
match. The current scheme prevents a high mem mapping since the client code
isn't high mem aware.

I also think that it is wrong that the fb drivers should fail to load just
because it can't ioremap() to draw the penguin. It would be much better to have
the fb driver load and the penguin disappear.

> 
> > Are there non-cfb drivers? How hard would it be to convert them?
> > Is there another solution to the problem?
> 
> There are several non-cfb drivers. Breaking the code up and pushing it 
> into the fbconsole layer is a bad idea. 
> 
> Accelerated driver (non-cfb) don't need to ioremap the framebuffer memory
> except for the case of fb_read/fb_write. That can be handled. What should 
> be done is a surface api that allocates the amount of memory we really 
> need at any time. 
> 
I'm still having trouble with the fb drivers doing the ioremap() when
fbconsole/penguin is the only client. 1600x1200x4 dual head still takes up 16MB
of address space. 16MB will fail ioremap() on my system. Aren't we just
delaying an inevitable problem with increasing resolutions?


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
