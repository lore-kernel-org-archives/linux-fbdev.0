From: Jorge Luis Zapata Muga <jorgeluis.zapata@gmail.com>
Subject: geodefb issues, possible patch
Date: Fri, 11 Nov 2005 13:05:24 +0100
Message-ID: <eb77d7060511110405i13b8bc8aw335147185398cd22@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EaXep-0006lx-D9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Nov 2005 04:05:27 -0800
Received: from nproxy.gmail.com ([64.233.182.202])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EaXeo-00011j-3S
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Nov 2005 04:05:27 -0800
Received: by nproxy.gmail.com with SMTP id o60so147089nfa
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 11 Nov 2005 04:05:24 -0800 (PST)
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
To: linux-fbdev-devel@lists.sourceforge.net

hi all,

i am having problems with the geode fb driver in 2.6 kernels. it seems
that it cant ioremap the video registers. ive debug a little bit of
code and compared it to the
previous kernel tree (2.4) geode fb driver amd (i think) provided. the
old driver works perfectly on my SBP.

ok here are the things i found:
* when requesting the pci regions all the pci_resource_start,
pci_resource_len return 0's
* the hardcoded offsets for mapping are different from what i found in
the other driver, ive changed them to the older values. (to map the
video reg, display controller reg, and the fb memory)
* the display controller functions to blank the screen, configure
display, set clock freq, etc used the vid_regs  for writel readl
instead (as seen in the other driver) of the dc_vid (display
controller registers).

after changed all this i can get the frame buffer mapped, but then
suddenly the screen goes blank, and the monitor off. like it has power
down the screen,  suspend, disable the crt, or something.

i have a patch if someone is interested. the problem is that i dont
know what else to do, as i cant debug (with printf's) the driver as i
dont have a screen, how does a fb driver gets debugged? does this
driver actually works? what are the pci bar ranges? maybe i have an
issue with the pci detection?

any help will be appreciated.
thanks


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
