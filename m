From: "Vishal Soni" <vishal.soni@samsung.com>
Subject: Re: Gives Bus error in memcpy() in coping
	/dev/fb0 to a file.
Date: Fri, 9 Mar 2007 10:29:13 +0530
Message-ID: <426888a60703082059ifc118bfwe48c26d68114d79e@mail.gmail.com>
References: <426888a60703070350x48ee4d0eoa017bdb859e70f73@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HPXCE-00074b-KO for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Mar 2007 20:59:14 -0800
Received: from wr-out-0506.google.com ([64.233.184.224])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HPXCE-0007uo-AU
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Mar 2007 20:59:14 -0800
Received: by wr-out-0506.google.com with SMTP id 68so1803502wri
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 08 Mar 2007 20:59:13 -0800 (PST)
In-Reply-To: <426888a60703070350x48ee4d0eoa017bdb859e70f73@mail.gmail.com>
Content-Disposition: inline
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
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On Thursday 08 March 2007 18:35, Antonino A. Daplas wrote:
> On Wed, 2007-03-07 at 17:20 +0530, Vishal Soni wrote:
> > [root@tw pcapp]# ./pcapp
> > 1024x768, 16bpp
> > framebuffer device mapped to memory @ 0xb7db3000.
> > FB_FRAME mapped to memory @ 0xb7c33000.
> > Bus error
>
> I don't think vfb's framebuffer can be mmapped.  It's fixable, but
> nobody seems to have a need for it,  yet.
>
> Tony
fb is getting successfully mapped.. its just that memcpy gives bus error when
i try to copy the mapped memory of ""framebuffer device"" to a
"""mapped file""""

Well, I am able to get the ball rolling by writing the mapped framebuffer onto
the file by using the below write system call

write(fdout, src, screensize);
/* where fdout = open("./fb_frame", O_RDWR);
and src = (char *)mmap(0, screensize, PROT_READ|PROT_WRITE, MAP_SHARED, fdin,
0); // fdin=open("/dev/fb0", O_RDONLY)
*/

Interesting is that.... why the below code gives problem in memcpy 'ng
with bus error

memcpy(dst, src, screensize);
/*
where src = mmap (0, screensize, PROT_READ, MAP_PRIVATE, fdin, 0));
and
fdin is descriptor of "/dev/fb0"
and
dst = mmap (0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fdout,
0);
and
fdout is descriptor of "./fb_frame" file
*/

Had this fdin not been descriptor of device file "/dev/fb0" but an ordinary
file this method of copying the two files works.

Any clues !!!!!!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
