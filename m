From: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Subject: Re: new api example or docs ?
Date: Fri, 2 Aug 2002 18:54:35 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020802165435.GA7822@iliana>
References: <20020801151812.GA392@iliana> <Pine.LNX.4.44.0208020845050.10247-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23] helo=mel-rto4.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17bLpI-0002OD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 04 Aug 2002 06:53:45 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208020845050.10247-100000@www.transvirtual.com>
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
Cc: Sven LUTHER <luther@dpt-info.u-strasbg.fr>, linux-fbdev-devel@lists.sourceforge.net

On Fri, Aug 02, 2002 at 08:46:39AM -0700, James Simmons wrote:
> 
> > Hello James.
> >
> > I did give a quick try at adapting pm3fb to the new api, but without
> > much success.
> >
> > I did look at skeletonfb.c as you suggested (the one in the 2.5.29
> > kernel) and after some work to make it build, it only gave me a segfault
> > when inserting the module.
> 
> skeletonfb is meant for only a example. I never expected to work.

Not as a skeleton from which you can build up a new driver ?

> > Looking a bit more to into this, and comparing skeletonfb to both neofb
> > and matroxfb, it seems to me that the skeletonfb that ships with the
> > 2.5.29 kernel is severly outdated.
> 
> No skeletonfb is pretty much up to data. The driver to look at is the 3Dfx
> driver. Its is the best new api driver.

Ok i will look at the 3Dfx driver.

BTW, the main difference i see between skeletonfb and the other driver
is about the _init function. if contains lot of stuff to initialize the
fb_info structure and such.

But when i look at the neofb for example, but it is the same in
matroxfb, i see that pci_register_driver is called with a structure
containing the neofb_probe function, which is something absolutely not
present in the skeletonfb.

> > In this case, which driver would you suggest i look at ? And is there
> > other documentation about the new api around.
> 
> Not yet.

Too bad, ...

I would have been nice to have such a thing before you remove the
backward compatibility from the new kernels.

Anyway, thanks for your help, i will look at the existing drivers then.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
