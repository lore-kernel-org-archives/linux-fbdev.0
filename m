From: Sean D'Epagnier <sean@depagnier.com>
Subject: Multihead support
Date: Sun, 6 Aug 2006 03:35:04 -0600
Message-ID: <20060806093504.GA30519@inferno.domain.actdsltmp>
References: <170385E48B041543AC99CCD09E325AD1952C32@mail.elevenonline.com.au>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G9f1U-0007lH-9n for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 02:34:16 -0700
Received: from mercury.lunarpages.com ([216.227.217.101])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G9f1S-0004mE-2D
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 02:34:16 -0700
Received: from 71-208-204-50.hlrn.qwest.net ([71.208.204.50] helo=localhost)
	by mercury.lunarpages.com with esmtp (Exim 4.52) id 1G9f2w-0002SQ-KZ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 06 Aug 2006 02:35:46 -0700
Content-Disposition: inline
In-Reply-To: <170385E48B041543AC99CCD09E325AD1952C32@mail.elevenonline.com.au>
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

I think multihead support is slightly broken with fbdev.

I have multihead working with nvidiafb and matroxfb. I had to patch the
kernel to get console text to update on the non-active vt.

In userspace programs, I know how to  register signal handlers to notify
a program when it gains or loses the active vt, but I don't think there is
a way to correctly detect when a framebuffer device becomes visible or
hidden.   The FBIOGET_CON2FBMAP ioctl provides a means to find which 
fbdev devices is mapped to a given console, but as far as I know to do
the reverse lookup (find the vt attached to a given fbdev) can't be done.
There are really 3 states a vt can be in:
1. active/visible
2. inactive/visible   (only applies to multihead)
3. inactive/invisible

If it were possible to register a signal handler for visible changes the
same way as active changes, this would fix the problem.

Xorg for example won't run on /dev/fb0 and allow me to run something else
on /dev/fb1  I have in my own programs written hacks to poll con2fb, at
a timed interval.  This is a terrible solution, and it has a high probability
of corrupting the screen output (until refresh)

I think in the future this will be come a bigger concern as x11 is slowly
being separated from the hardware, and it will become useful to run
multiple sessions of x11.  I would like to discuss all possible solutions,
and hopefully implement a simple working solution.


Thanks,
Sean D'Epagnier

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
