From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Rage128 as secondary adapter
Date: Thu, 9 Jan 2003 09:47:06 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030109174706.1471.qmail@web14907.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14907.mail.yahoo.com ([216.136.225.59])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Wgls-0005kW-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 09 Jan 2003 09:47:12 -0800
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
Content-Transfer-Encoding: 7bit
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

I'm working on aty128fb to make it support a Rage128
as a secondary adapter. It needs a few new minor
changes to do this.

My main problem is that secondary adapters are not
initialized at boot.  I have a program (vbios.vm86)
that will initialize the R128, but instead I would
like to do it when the driver loads. vbios.vm86 goes
through a complicated process in real mode of
emulating the system boot ROM (same thing X does).

Can someone with access to the Rage128 documentation
tell me how to do this from protected mode? I have the
ROM mapped so the code can get to constants stored in
the ROM. What I need is a piece of C code equal to
what the ROM initialization does minus the part about
Int10 vector setup.

The programmers at ATI probably have a piece of code
available to do this since ATI's Windows driver can do
it.  I've tried emailing and signing up as a developer
without response.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
