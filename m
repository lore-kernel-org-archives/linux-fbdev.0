From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: [PATCH] matroxfb: New framebuffer_alloc API and class_dev
Date: Mon, 15 Sep 2003 22:42:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030915204233.GZ16370@dreamland.darkstar.lan>
References: <4CCE1F5E79@vcnet.vc.cvut.cz>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19z0Br-0000aP-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Sep 2003 13:43:19 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19z0Br-0006Yy-2Q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 15 Sep 2003 13:43:19 -0700
Content-Disposition: inline
In-Reply-To: <4CCE1F5E79@vcnet.vc.cvut.cz>
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
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>

Il Mon, Sep 15, 2003 at 10:24:29PM +0200, Petr Vandrovec ha scritto: 
> Besides that, what's the point of this change? Making driver slower, 
> scattering its data over random memory places (so no cache locality...), 
> or is there some benefit it brings in and which I missed?

There is  a class_dev  embedded in struct  fb_info, framebuffer_register
registers  it with  the driver  model. In  this way  drivers can  export
whatever  they  want using  sysfs. A  dynamically  allocated fb_info  is
needed  because the  release function  calls kfree  on the  container of
class_dev  and  can't  tell  weather  a  struct  fb_info  is  statically
allocated or not.

I  see your  point  though. Note that  framebuffer_alloc  uses a  single
kmalloc call for  fb_info and fb_info->par and they are  both aligned to
sizeof(long)... I'm  not  really  scattering data  "over  random  memory
places".

Of course I didn't want to screw your driver :)

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
La somma dell'intelligenza sulla terra e` una costante.
La popolazione e` in aumento.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
