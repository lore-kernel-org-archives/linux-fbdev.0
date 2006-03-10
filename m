From: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.16-rc5-mm3 -- Can't get fbset or 855resolution to change resolution
Date: Thu, 9 Mar 2006 18:09:13 -0800
Message-ID: <a44ae5cd0603091809g12807830v925eee6b11110717@mail.gmail.com>
References: <a44ae5cd0603091205r3e095f0g623eb64649ffcd6c@mail.gmail.com>
	 <4410BCAC.5050106@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHX4D-00069v-MH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Mar 2006 18:09:21 -0800
Received: from uproxy.gmail.com ([66.249.92.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHX4D-0006tB-AH
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Mar 2006 18:09:21 -0800
Received: by uproxy.gmail.com with SMTP id h2so309822ugf
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Mar 2006 18:09:13 -0800 (PST)
In-Reply-To: <4410BCAC.5050106@gmail.com>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@pol.net>, jsimmons@transvirtual.com

On 3/9/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Miles Lane wrote:
> > Hi,
> >
> > I have a "Intel Corporation 82852/855GM Integrated Graphics Device
> > (rev 02)" in my laptop.  I am currently running Fedora Core Test3 +
> > Rawhide updates on it.  I would like to use 1280x768 in my VT
> > framebuffer displays.  Unfortunately, neither fbset or 855resolution
> > cause the video mode to change.  I boot with the kernel option
> > vga=3D791.  This gives me 1024x768@76, according to fbset.
> >
> > Specifically, I have tried "fbset -xres 1280 -yres 768 -a" and
> > "855resolution mode 1280 768".
> >
>
> If you are using a flatpanel display, then no, you cannot change the
> resolution, or anything for that matter, with fbset.

Xorg's DDC info shows this mode:
*Mode: 7e (1280x768)
        XResolution: 1280
        YResolution: 768
        BitsPerPixel: 32
Is there any way to tell vesafb to use this mode?  I have searched
using Google quite a bit, but come up empty-handed.

855resolution can be used to patch a video mode with different vres
and yres.  It works for me to get 1280x768, but fbcon doesn't increase
the number of columns (stty doesn't help)
so I end up having the characters in the left-hand part of the screen
get redisplayed along the right side of the display, like this:

Here I go to the store.................                         Here I go
This is approximately what I see........                   This is app

You get the idea?

Thanks,
      Miles


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
