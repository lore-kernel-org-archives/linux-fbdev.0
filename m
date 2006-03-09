From: "Miles Lane" <miles.lane@gmail.com>
Subject: 2.6.16-rc5-mm3 -- Can't get fbset or 855resolution to change resolution
Date: Thu, 9 Mar 2006 12:05:15 -0800
Message-ID: <a44ae5cd0603091205r3e095f0g623eb64649ffcd6c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHRNu-0006Jt-Ru
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Mar 2006 12:05:18 -0800
Received: from uproxy.gmail.com ([66.249.92.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHRNt-000716-Iv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Mar 2006 12:05:18 -0800
Received: by uproxy.gmail.com with SMTP id q2so271799uge
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Mar 2006 12:05:15 -0800 (PST)
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
To: Antonino Daplas <adaplas@pol.net>, jsimmons@transvirtual.com, linux-fbdev-devel@lists.sourceforge.net

Hi,

I have a "Intel Corporation 82852/855GM Integrated Graphics Device
(rev 02)" in my laptop.  I am currently running Fedora Core Test3 +
Rawhide updates on it.  I would like to use 1280x768 in my VT
framebuffer displays.  Unfortunately, neither fbset or 855resolution
cause the video mode to change.  I boot with the kernel option
vga=3D791.  This gives me 1024x768@76, according to fbset.

Specifically, I have tried "fbset -xres 1280 -yres 768 -a" and
"855resolution mode 1280 768".

Currently, fbset says:
mode "1024x768-76"
    # D: 78.653 MHz, H: 59.949 kHz, V: 75.694 Hz
    geometry 1024 768 1024 768 16
    timings 12714 128 32 16 4 128 4
    rgba 5/11,6/5,5/0,0/0
endmode

855resolution version 0.4 says:
Chipset: 855GM (id=3D0x35808086)
VBIOS type: 2
VBIOS Version: 3360
[...]
Mode 7e : 1280x768, 32 bits/pixel

Any suggestions?  Is this a bug in the mm tree?
       Miles


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
