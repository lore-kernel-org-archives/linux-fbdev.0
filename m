From: James Simmons <jsimmons@infradead.org>
Subject: Re: 3DFX framebuffer driver v0.2.2
Date: Fri, 20 Dec 2002 18:34:43 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212201834130.6471-100000@phoenix.infradead.org>
References: <20021219050604.GA26640@ahrairah.internal.aom.geek>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from carisma.slowglass.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18PRzT-0004OU-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 20 Dec 2002 10:35:19 -0800
In-Reply-To: <20021219050604.GA26640@ahrairah.internal.aom.geek>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: idalton@mail.ferret.dyndns.org
Cc: linux-fbdev-devel@lists.sourceforge.net


> > The current kernel still contains version 0.1.3 which is rather old. Much
> > work has been done until version 0.2.2, mainly support for:
> > 
> > * non-8 dot wide fonts
> > * multihead
> > * full 8/16/24/32 bit color (fixes the ugly bootup penguin)
> > * MIPS
> > * module options
> > 
> > I think it's worth to give it a chance and to continue development on the
> > base of that code. So I "ported" it to kernel 2.4.2x. Get this new patch
> > here:
> > 
> > http://tu-ilmenau.de/~johe-ii/3dfx-0.2.2-2.4.21-pre1.diff.gz
> > 
> > I just merged the improvements that happened to v0.1.3 while it was in the
> > kernel and did some source formating.

Thanks. I'm looking over the patch now and will intergrate it into 2.5.X.



-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
