From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: framebuffer ioctl
Date: Tue, 7 Sep 2004 10:38:13 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e4733910409070738a46cafb@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413A3735.9E7D2F11@orpatec.ch> <413B4925.5000706@comcast.net>
	 <200409060926.07163.adaplas@hotpop.com> <413CC0EA.8070709@comcast.net>
	 <9e4733910409061402372095b1@mail.gmail.com>
	 <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
	 <9e47339104090707172cdc258d@mail.gmail.com>
	 <Pine.GSO.4.58.0409071623550.518@waterleaf.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4h6x-0004PL-HO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 07:38:19 -0700
Received: from rproxy.gmail.com ([64.233.170.207] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4h6u-0007yT-Q6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 07:38:19 -0700
Received: by mproxy.gmail.com with SMTP id 76so188610rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Sep 2004 07:38:13 -0700 (PDT)
In-Reply-To: <Pine.GSO.4.58.0409071623550.518@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

On Tue, 7 Sep 2004 16:26:47 +0200 (MEST), Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, 7 Sep 2004, Jon Smirl wrote:
> > The numbers compare two peices of software that exist.  Sure you could
> > probably write a super optimized library for CPU based drawing in 2D
> > mode that would be faster, but this library doesn't exist. No matter
> > what you do using the GPU to draw is always going to beat using the
> > CPU by a wide margin because of the memory bandwidth difference.
> >
> > Would Cairo on hardware OpenGL vs Cairo on software only OpenGL be a
> > better comparison? Those ratios are even worse.
> 
> I think (but I'm not sure) Michel wants you to compare Cairo on OpenGL vs.
> traditional 2D accelerated X.

That's what the numbers compare. I think he wants me to compare it to
his new render implementation that uses the 3D hardware.  But that's
what I'm against. I don't want to see even more drivers trying to take
control of the 3D hardware and causing even more conflicts.
Implementing X on GL completely removes the need for expanding XAA to
include using the 3D hardware. This pratice of ten different groups
programming the video hardware however they want has got to stop or
Linux is never going to be competitive with Mac/Longhorn.

> 
> I.e. while X on top of hardware accelerated OpenGL is _much_ faster than X on
> top of software OpenGL, what we really care about is whether it's much faster
> than traditional 2D accelerated X.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
