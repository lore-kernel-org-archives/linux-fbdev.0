From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] intelfb fixes
Date: Mon, 24 Mar 2003 20:15:47 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030324201546.A11416@lst.de>
References: <20030321193703.A12179@lst.de> <1048537227.25652.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from verein.lst.de ([212.34.181.86])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xXQc-0005ca-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Mar 2003 11:16:15 -0800
Content-Disposition: inline
In-Reply-To: <1048537227.25652.33.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Mar 24, 2003 at 08:20:27PM +0000
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
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Mon, Mar 24, 2003 at 08:20:27PM +0000, Alan Cox wrote:
> On Fri, 2003-03-21 at 18:37, Christoph Hellwig wrote:
> > It looks like someone is trying to make the kernel looling as messy
> > as XFree..
> > 
> > Remove the silly symlinking rules from the intelfb makefile and remove
> > one of the copies of the private copy of modedb in intelfb.  Maybe
> > someone who actually has the hardware could fix it to properly use
> > modedb directly.
> 
> No longer compiles with that change

It _does_ compile (after actually adding intelfb to Config.in) in
Marcelo's tree.  You're probably hit by the symlink braindamage in
the original driver tarball..



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
