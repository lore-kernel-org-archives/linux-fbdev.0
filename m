From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Fri, 23 Apr 2004 20:54:49 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404232054290.5826-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0404231935340.5307-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH6lB-0007WD-D3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 12:54:53 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH6lA-0000eZ-Q4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 12:54:53 -0700
In-Reply-To: <Pine.LNX.4.44.0404231935340.5307-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Alex Stewart <alex@foogod.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>


It fixed a color map problem I had :-)


On Fri, 23 Apr 2004, James Simmons wrote:

> 
> In that case the pacth will be applied.
> 
> 
> On 22 Apr 2004, Antonino A. Daplas wrote:
> 
> > On Thu, 2004-04-22 at 01:47, James Simmons wrote:
> > 
> > > > neofb.3.16bit.patch     - Misc fixes for 16-bit mode
> > > >
> > > >   Changed the visual reported for 16-bit mode from DirectColor to TrueColor,
> > > >   since we don't support changing the colormap, which means we don't really
> > > >   support DirectColor.  Also changed the palette entries for to be 32 bits 
> > > >   wide even for 16-bit mode because this is what the logo code expects, 
> > > >   and appears to be the correct way of doing things.
> > > 
> > > I haven't tried this one yet. Geert is this right?
> > 
> > Yes, _all_ of the generic drawing functions expect the pseudopalette to
> > be always u32.
> > 
> > Tony
> > 
> > 
> > 
> > 
> > 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
> For a limited time only, get FREE Ground shipping on all orders of $35
> or more. Hurry up and shop folks, this offer expires April 30th!
> http://www.thinkgeek.com/freeshipping/?cpg=12297
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
