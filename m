From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: pm3fb driver is ok in 2.5.24
Date: Thu, 4 Jul 2002 19:38:27 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207041936220.1718-100000@www.transvirtual.com>
References: <20020702063549.GB30388@lambda.u-strasbg.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QIzW-0005O6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 04 Jul 2002 19:38:38 -0700
In-Reply-To: <20020702063549.GB30388@lambda.u-strasbg.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <luther@lambda.u-strasbg.fr>
Cc: Romain Dolbeau <dolbeau@irisa.fr>, linux-fbdev-devel@lists.sourceforge.net


> > api. I'm going to removal the old fbgen code soon.
>
> how soon, and is there documentation or sample code for the changed api
> ?

In the next few days. Take a look at several drivers that have been ported
over. Plus take a look at skeletonfb.c. It details alot. If you have
furthur questions feel free to ask.

> BTW, i suppose now it will be easier to implement dual head with a dual
> output board ?

Yes :-) ON struct fb_info for each framebuffer and a struct xxx_par for
the hardware. In this case your xxx_par struct would be shared betweem
each struct fb_info.


>
> Friendly,
>
> Sven Luther
> >
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
