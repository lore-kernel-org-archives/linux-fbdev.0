From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] cg*: New framebuffer_alloc API and class_dev changes
Date: Wed, 17 Sep 2003 18:37:34 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030917163734.GA8032@dreamland.darkstar.lan>
References: <20030915194259.GG16370@dreamland.darkstar.lan> <20030915162705.24913719.davem@redhat.com> <20030916134603.GA1209@dreamland.darkstar.lan> <20030916182146.6c848c59.davem@redhat.com>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zfLn-0007gZ-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 17 Sep 2003 09:40:19 -0700
Received: from mail-3.tiscali.it ([195.130.225.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zfLn-0006tT-2J
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Sep 2003 09:40:19 -0700
Content-Disposition: inline
In-Reply-To: <20030916182146.6c848c59.davem@redhat.com>
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
To: "David S. Miller" <davem@redhat.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, jsimmons@infradead.org

Il Tue, Sep 16, 2003 at 06:21:46PM -0700, David S. Miller ha scritto: 
> On Tue, 16 Sep 2003 15:46:03 +0200
> Kronos <kronos@kronoz.cjb.net> wrote:
> 
> > Btw, how do the patches look?
> 
> They look fine, just push them into James tree.

As Russell King pointed out there was a flaw in that API. I reworked it
a bit. I've patched sparc drivers:

drivers/video/bw2.c
drivers/video/cg14.c
drivers/video/cg3.c
drivers/video/cg6.c
drivers/video/ffb.c
drivers/video/leo.c
drivers/video/p9100.c
drivers/video/tcx.c

Patches are almost  identical to the ones  I sent to you,  but I removed
the release_* callback. If you want to  take a look I've just pushed the
changeset:

bk://mesa3d@bkbits.net/fbdev-2.5

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Fare l'amore con dieci donne e` fantastico, soprattutto perche` ti
 presentano un sacco di amiche." -- Fabio Di Iorio


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
