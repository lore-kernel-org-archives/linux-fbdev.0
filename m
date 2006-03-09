From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: 2.6.16-rc5-mm3 -- Can't get fbset or 855resolution
 to change resolution
Date: Fri, 10 Mar 2006 07:39:24 +0800
Message-ID: <4410BCAC.5050106@gmail.com>
References: <a44ae5cd0603091205r3e095f0g623eb64649ffcd6c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHUjY-0004EW-G5
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Mar 2006 15:39:52 -0800
Received: from xproxy.gmail.com ([66.249.82.206])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHUjY-0005yp-4T
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Mar 2006 15:39:52 -0800
Received: by xproxy.gmail.com with SMTP id h29so405613wxd
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Mar 2006 15:39:47 -0800 (PST)
In-Reply-To: <a44ae5cd0603091205r3e095f0g623eb64649ffcd6c@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Antonino Daplas <adaplas@pol.net>, jsimmons@transvirtual.com, Miles Lane <miles.lane@gmail.com>

Miles Lane wrote:
> Hi,
> 
> I have a "Intel Corporation 82852/855GM Integrated Graphics Device
> (rev 02)" in my laptop.  I am currently running Fedora Core Test3 +
> Rawhide updates on it.  I would like to use 1280x768 in my VT
> framebuffer displays.  Unfortunately, neither fbset or 855resolution
> cause the video mode to change.  I boot with the kernel option
> vga=791.  This gives me 1024x768@76, according to fbset.
> 
> Specifically, I have tried "fbset -xres 1280 -yres 768 -a" and
> "855resolution mode 1280 768".
> 

If you are using a flatpanel display, then no, you cannot change the
resolution, or anything for that matter, with fbset.

If you are using an analog display, then perhaps you need to give
fbset the entire modeline.  You probably know how to do this, just enter
the modeline in /etc/fb.modes and label it 1280x768-60 for example.

> Currently, fbset says:
> mode "1024x768-76"
>     # D: 78.653 MHz, H: 59.949 kHz, V: 75.694 Hz
>     geometry 1024 768 1024 768 16
>     timings 12714 128 32 16 4 128 4
>     rgba 5/11,6/5,5/0,0/0
> endmode
> 
> 855resolution version 0.4 says:
> Chipset: 855GM (id=0x35808086)
> VBIOS type: 2
> VBIOS Version: 3360
> [...]
> Mode 7e : 1280x768, 32 bits/pixel

I don't know hot 855resolution works....

Tony


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
