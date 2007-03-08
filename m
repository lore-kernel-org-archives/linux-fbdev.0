From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Gives Bus error in memcpy() in
	coping	/dev/fb0 to a file.
Date: Fri, 09 Mar 2007 05:49:39 +0800
Message-ID: <1173390579.6201.7.camel@daplas>
References: <426888a60703070350x48ee4d0eoa017bdb859e70f73@mail.gmail.com>
	<1173359145.11105.1.camel@daplas>
	<c4f20e170703080939m2398197dg9653dc22902f1481@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HPQT6-0007im-Py for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Mar 2007 13:48:12 -0800
Received: from wx-out-0506.google.com ([66.249.82.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HPQT5-0008A7-5u
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Mar 2007 13:48:11 -0800
Received: by wx-out-0506.google.com with SMTP id i30so965773wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 08 Mar 2007 13:48:09 -0800 (PST)
In-Reply-To: <c4f20e170703080939m2398197dg9653dc22902f1481@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

On Thu, 2007-03-08 at 17:39 +0000, Nuno Lucas wrote:
> On 3/8/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > On Wed, 2007-03-07 at 17:20 +0530, Vishal Soni wrote:
> > > hello,
> > >
> > > I am trying to get the snapshot of the screen through a c program by mmaping
> > > the framebuffer device /dev/fb0 .
> > > For this i compiled kernel with virtual framebuffer support and passing
> > > vga=791 as boot line argument.
> > >
> > > Though i am able to get snapshot by
> > > [root@tw pcapp]# cat /dev/fb0 > frame
> > >
> > > and see it on the screen by
> > > [root@tw pcapp]# cat frame > /dev/fb0
> > >
> > > But when i try to capture the frame buffer using the below c code, It gives
> > > bus error @ memcpy()
> > >
> > > Output :::::::::
> > >
> > > [root@tw pcapp]# ./pcapp
> > > 1024x768, 16bpp
> > > framebuffer device mapped to memory @ 0xb7db3000.
> > > FB_FRAME mapped to memory @ 0xb7c33000.
> > > Bus error
> >
> > I don't think vfb's framebuffer can be mmapped.  It's fixable, but
> > nobody seems to have a need for it,  yet.
> 
> Having read about the Hecuba driver, using the deferred IO patch,
> isn't that a better starting point for a virtual fb driver? One could
> just ignore the deferred IO and have an instant virtual frame buffer.
> With just a little bit of effort and one could even make a
> para-virtual driver for Xen and/or KVM.
> 
> I'm just a curious soul lying on this list but would appreciate
> someone to correct my thinking.
> 

Yes, something like that without the mkwrite method.

The classic method was to use get_free_pages to allocate the memory and
mark the range as reserved and io.

Tony


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
