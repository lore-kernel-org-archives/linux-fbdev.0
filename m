From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] imsttfb 2.5.x
Date: Tue, 15 Apr 2003 20:33:35 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0304152030500.8236-100000@phoenix.infradead.org>
References: <1050390341.5574.105.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 195WC3-0004Qy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 15 Apr 2003 12:34:12 -0700
In-Reply-To: <1050390341.5574.105.camel@zion.wanadoo.fr>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boris Bezlaj <boris@gajba.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Sat, 2003-04-12 at 13:19, Boris Bezlaj wrote:
> > In 2.5.67 imsttfb locks the system when it's time to scrool the text.
> > Patch below fixes that. Otherwise everything seems to work as in 2.4
> > 
> > --- linux/drivers/video/ORIG_imsttfb.c  2003-04-09 15:11:46.000000000 +0200
> > +++ linux/drivers/video/imsttfb.c       2003-04-11 16:44:07.000000000 +0200
> > @@ -409,7 +409,7 @@
> >  static inline u32 read_reg_le32(volatile u32 *base, int regindex)
> >  {
> >  #ifdef __powerpc__
> > -       in_le32((volatile u32 *) (base + regindex));
> > +       return in_le32((volatile u32 *) (base + regindex));
> >  #else
> >         return readl(base + regindex);
> >  #endif
> 
> There is actually no reason not to use readl() on ppc as well

Does readl handle byte swapping on the PPC. The registers expect the data 
feed to them to be little endian. Actually this driver will only work on 
the PPC and ix86 platform. Other big endian platforms are out of luck. 

P.S
   This whole issue really sucks. I really wish there was a clean standard 
api to this. 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
