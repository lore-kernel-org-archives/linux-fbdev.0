From: James Simmons <jsimmons@infradead.org>
Subject: Re: Some small problems...
Date: Fri, 24 Jan 2003 22:58:25 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0301242254230.2597-100000@phoenix.infradead.org>
References: <1043270608.1879.53.camel@laptop-STIAN>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18cCmp-00048t-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Jan 2003 14:59:00 -0800
In-Reply-To: <1043270608.1879.53.camel@laptop-STIAN>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stian Hartviksen <stian.hartviksen@kitrus.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> 1. When compiling, the following framebuffer devices does not compile :
> 	- Cirrus Logic
> 	- Matrox
> 	- Riva (had some warnings)
> 	- Ati (Had to do some small hack in aty_base.c to get this compiling)

Ati didn't compile? Do you have a patch I could apply.

Riva is starting to shape up. The Cirrus Logic and Matrox driver haven't 
been ported yet. The good news is I'm working on the matrox driver. I have 
alot to go tho for it.
 
> 2. When I'm doing make modules_install everything stops. This I got

Yeah the module stuff changed.

> 3. When the compiling sequence is finished, and it is time for reboot,
> there is no output on the screen after the grub startup manager.

DId you framebuffer console?

> 4. Are there a list of framebuffer drivers that are verified on the
> 2.5.59 kernel ?

No but most do work.

SHould work. been ported.
> - ATI Rage Pro 3D (AGP)
> - Nvidia Geforce 2 (PCI)
> - Nvidia TNT 2 (PCI)

WOrking on port.
> - Matrox Millenium II (PCI)

Driver way out of date and only works on m68k.
> - Herkules S3virge (PCI)

Needs to be ported.
> - Cirrus Logic GD5434-8 (PCI)

Driver is starting to work.
> - Nvidia Geforce 4 MX420 (AGP)
> - Nvidia Geforce 2 (PCI)
> - Nvidia TNT 2 (PCI)

Same as above.
> - Matrox Millenium II (PCI)
> - Herkules S3virge (PCI)
> - Cirrus Logic GD5434-8 (PCI)

Works.
> Machine #3:
> - Pentium 4, 2,4GHz, 256Mb
> - ATI Radeon Mobility M6



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
