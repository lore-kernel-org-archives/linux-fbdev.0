From: Xanthakis Stelios <sxanth@ceid.upatras.gr>
Subject: waitretrace available?
Date: Sat, 11 Jan 2003 13:21:55 +0200 (EET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301111316070.12383-100000@zenon.ceid.upatras.gr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from diogenis.ceid.upatras.gr ([150.140.141.181])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18XJk1-0000KD-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 11 Jan 2003 03:23:53 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net


Is there WAITRETRACE available in fb?

It seems that there used to be because svgalib sais:

	static void fbdev_waitretrace(void)
	{
		/* This is from SDL */
	#ifdef FBIOWAITRETRACE
		ioctl(console_fd, FBIOWAITRETRACE, 0);
	#endif
	}

But I can't find such a value in the headers.
Seems like WAITRETRACE call is implemented in svga by:

	while (!(inb(0x3da) & 8));
	while (inb(0x3da) & 8);


*I know very little on how video hardware works*

The goal is to attempt some smooth scrolling. 
Back in the MS-DOS days there used to be a program
called smooth editor which was amazing (so amazing that
I used to do Page up/Down all the time w/o doing
any work). I was thinking if I could have some similar
smooth scrolling in my linux fb console.

I recall that smooth editor explained that smooth scrolling
was achieved by "synchronizing with the video refresh"
(horizontal?, vertical? I don't remember). That's retrace yes?

So, can we by some way do waitretrace at each \n?
Should this be userland or kernelland?


stelios




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
