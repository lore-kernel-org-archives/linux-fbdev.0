From: Sven Luther <luther@lambda.u-strasbg.fr>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Fri, 5 Jul 2002 08:00:53 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020705060053.GA12472@lambda.u-strasbg.fr>
References: <20020702063549.GB30388@lambda.u-strasbg.fr> <Pine.LNX.4.44.0207041936220.1718-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dpt-info.u-strasbg.fr ([130.79.44.193])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QM00-00039C-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 Jul 2002 22:51:21 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207041936220.1718-100000@www.transvirtual.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@transvirtual.com>
Cc: Romain Dolbeau <dolbeau@irisa.fr>, linux-fbdev-devel@lists.sourceforge.net

On Thu, Jul 04, 2002 at 07:38:27PM -0700, James Simmons wrote:
> 
> > > api. I'm going to removal the old fbgen code soon.
> >
> > how soon, and is there documentation or sample code for the changed api
> > ?
> 
> In the next few days. Take a look at several drivers that have been ported
> over. Plus take a look at skeletonfb.c. It details alot. If you have
> furthur questions feel free to ask.

Well, the only problem is that i don't have much time :(((

But i will have a look at it.

do i need to get the bk tree, or can i start working with the 2.5.24
linus tree i now have ?

Maybe there is a patch available somewhere ?

> > BTW, i suppose now it will be easier to implement dual head with a dual
> > output board ?
> 
> Yes :-) ON struct fb_info for each framebuffer and a struct xxx_par for
> the hardware. In this case your xxx_par struct would be shared betweem
> each struct fb_info.

:)))

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
