From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Gives Bus error in memcpy()
	in	coping	/dev/fb0 to a file.
Date: Fri, 09 Mar 2007 16:54:11 +0800
Message-ID: <1173430451.4305.2.camel@daplas>
References: <426888a60703070350x48ee4d0eoa017bdb859e70f73@mail.gmail.com>
	<1173359145.11105.1.camel@daplas>
	<200703091021.46041.vishal.soni@samsung.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HPaqF-0004Io-9P for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Mar 2007 00:52:47 -0800
Received: from nz-out-0506.google.com ([64.233.162.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HPaqD-0003XV-Q8
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Mar 2007 00:52:47 -0800
Received: by nz-out-0506.google.com with SMTP id i11so811021nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 Mar 2007 00:52:45 -0800 (PST)
In-Reply-To: <200703091021.46041.vishal.soni@samsung.com>
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

On Fri, 2007-03-09 at 10:21 +0530, Vishal Soni wrote:
> On Thursday 08 March 2007 18:35, Antonino A. Daplas wrote:
> > On Wed, 2007-03-07 at 17:20 +0530, Vishal Soni wrote:
> > > [root@tw pcapp]# ./pcapp
> > > 1024x768, 16bpp
> > > framebuffer device mapped to memory @ 0xb7db3000.
> > > FB_FRAME mapped to memory @ 0xb7c33000.
> > > Bus error
> >
> > I don't think vfb's framebuffer can be mmapped.  It's fixable, but
> > nobody seems to have a need for it,  yet.
> >
> > Tony
> fb is getting successfully mapped.. its just that memcpy gives bus error when 
> i try to copy the mapped memory of framebuffer device to a "mapped file,"
> 
> Well, I am able to get the ball rolling by writing the mapped framebuffer onto 
> the file by using write system call

Unless you modified vfb yourself, it's not possible because
fix->smem_start is not set all (it's pointing to NULL). What's actually
being mmapped is physical addres 0UL.

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
