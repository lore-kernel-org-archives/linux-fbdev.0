From: Antonino Daplas <adaplas@pol.net>
Subject: [ANNOUNCE]: VM86 Daemon
Date: 31 Mar 2003 17:53:29 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1049104351.1037.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18zwVl-0000V1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 31 Mar 2003 02:27:30 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, DirectFB-devel <directfb-dev@directfb.org>

Hi,

A few weeks ago, a discussion on reviving the vesafbd project by Aki
Laukkanen, methods on initializing non-primary cards, and on how to
gather monitor information via DDC/EDID were ongoing at approximately
the same time.  It seems a nice idea to get this information from the
Video BIOS, and so I started on writing vm86d.

The vm86d is a user daemon that accepts requests from the kernel,
processes those requests, and gives the result back to the kernel.  The
communication is done via a miscellaneous character device /dev/vm86. 
The requests can be anything, but currently supports only BIOS services,
predominantly VBE (int 0x10 function 0x4f).  How the daemon processes
those requests is irrelevant, but is currently done via LRMI. 

The vesafb functionality is extended by using various Core and DDC VBE
services.  If the EDID data is available, a table of video modes are
constructed in struct fb_videomode format.  If the monitor is GTF
capable, then modes can actually be computed via the GT formula.  The
result is a vesafb driver that supports video mode changing, cmap
loading, and display panning.  Of course, the latter two functionality
can be done via the protected mode interface, but not all BIOS'es have a
working PMI.

In theory, other fbdev drivers can also use some of the vm86
functionality, notably DDC, EDID parsing, and even video mode changing.

The code is very preliminary, very incomplete, and no attempts were made
to beautify or optimize the code.  I have successfully tested vesafb
against DirectFB, mplayer -vo fbdev, and XFree86 fbdev, using various
modes and pixelformats.  Changing console window size using stty also
works.

There are still a lot of problems to iron out.  EDID parsing is probably
only 70-75% complete.  The EDID data I get from my displays are very
incomplete.  Hopefully, someone can send me their EDID data.  You can
get the read-edid utility, and do a 

'get_edid > edid.dmp', 

and send the dump either directly to me or to this mailing list.  I will
greatly appreciate it.

Other things to do:  Support and initialization of more than 1 card, a
modular vesafb, more robust error checking, extending vm86d to execute
non-BIOS code, to name a few.

It is very unlikely that this will get into the main kernel tree, but if
you are willing to try this out, the package is at:

http://i810fb.sourceforge.net/vm86d-0.1.tar.gz

It will require linux-2.5.66. The main reason for using an unstable
kernel is because it requires some of the features of the new
framebuffer framework to avoid scheduling problems. 

Please browse the README file for installation instructions.

Tony






-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
