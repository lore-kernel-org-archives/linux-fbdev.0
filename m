From: Jon Smirl <jonsmirl@gmail.com>
Subject: Mapping the framebuffer into kernel space
Date: Thu, 28 Apr 2005 23:55:28 -0400
Message-ID: <9e473391050428205517f3c8c0@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRMbH-0003Zh-DU
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Apr 2005 20:55:35 -0700
Received: from wproxy.gmail.com ([64.233.184.198])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DRMbH-00013A-1c
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Apr 2005 20:55:35 -0700
Received: by wproxy.gmail.com with SMTP id 69so814826wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Apr 2005 20:55:28 -0700 (PDT)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

I looked at a few fbdev drivers and they are mapping the framebuffer
into kernel space.

Example from radeonfb:
  rinfo->mapped_vram =3D min_t(unsigned long, MAX_MAPPED_VRAM, rinfo->video=
_ram);
 do {
     rinfo->fb_base =3D ioremap (rinfo->fb_base_phys,
                                       rinfo->mapped_vram);

Isn't the only consumer of this kernel mapping fbconsole? If so
shouldn't fbconsole be doing the mapping instead of doing it in the
drivers? Doing it in fbconsole would let us map exactly the amount of
VRAM needed for the console. Right now the driver has to guess the
maximum consumption.  This would minimize the amount of kernel address
space consumed by fbdev. It could also remove a bunch of redundant
code.

Then in my case where I'm running radeonfb but not fbconsole there
would be no kernel address space consumed at all.

Minimizing kernel address space consumption is important for x86
systems with more than 1GB of memory. Address space going to fbdev
pushes system pages from low into high memory and slows them down.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
