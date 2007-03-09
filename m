From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Gives Bus error in memcpy() in coping
	/dev/fb0 to a file.
Date: Sat, 10 Mar 2007 01:55:10 +0800
Message-ID: <1173462910.4719.3.camel@daplas>
References: <426888a60703070350x48ee4d0eoa017bdb859e70f73@mail.gmail.com>
	<426888a60703082059ifc118bfwe48c26d68114d79e@mail.gmail.com>
	<426888a60703090109i669536b4t455a8ef984dfd278@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HPjHr-00040P-JF for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Mar 2007 09:53:51 -0800
Received: from nz-out-0506.google.com ([64.233.162.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HPjHm-0000Xh-Gh
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Mar 2007 09:53:51 -0800
Received: by nz-out-0506.google.com with SMTP id i11so918005nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 Mar 2007 09:53:45 -0800 (PST)
In-Reply-To: <426888a60703090109i669536b4t455a8ef984dfd278@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Vishal Soni <vishal.soni@samsung.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 2007-03-09 at 14:39 +0530, Vishal Soni wrote:
> > > > I don't think vfb's framebuffer can be mmapped.  It's fixable, but
> > > > nobody seems to have a need for it,  yet.
> > > >
> > > > Tony
> > >
> > > fb is getting successfully mapped.. its just that memcpy gives bus error
> > > when i try to copy the mapped memory of framebuffer device to a "mapped
> > > file,"
> > >
> > > Well, I am able to get the ball rolling by writing the mapped framebuffer
> > > onto the file by using write system call
> >
> > Unless you modified vfb yourself, it's not possible because
> > fix->smem_start is not set all (it's pointing to NULL). What's actually
> > being mmapped is physical addres 0UL.
> what i wanted to do......as i wrote in my very first mail........ i
> have got that, now i am able to capture the snapshot using c program
> and the results are output on my screen....
>       printf("frame bufffer mapped  @ %p\n", src);
>       for(i = 0; i < vinfo.xres*vinfo.yres*vinfo.bits_per_pixel/8; i++)
>                 *src++ = 0xBB;
> 
> Framebuffer is getting mapped... by mmap system call
>   // Map the device to memory
>         src = (char *)mmap(0, screensize, PROT_READ|PROT_WRITE,
> MAP_SHARED, fdin, 0);
>         if ((int)src == -1) {
>                 printf("Error: failed to map framebuffer device to memory.\n");
>                 return -1;
>         }
> 
> and therefore  physical addres 0UL is not what is mapped.....its the
> framebuffer.
> doubt in my last mail was w.r.t memcpy().

Well you had me confused, you mentioned virtual framebuffer, but I think
you are actually using the VESA framebuffer.

Anyway, the bus error is because the source file is truncated to zero
size. Try instead to open a file whose size is >= screensize.

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
