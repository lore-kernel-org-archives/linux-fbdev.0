From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Framebuffer overflow halts network (fwd)
Date: Tue, 28 Jan 2003 10:33:52 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0301281033390.9269-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18dS8Y-00052U-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 28 Jan 2003 01:34:34 -0800
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Leif Neland <leif@neland.dk>

---------- Forwarded message ----------
Date: Mon, 27 Jan 2003 21:44:13 +0100
From: Leif Neland <leif@neland.dk>
To: geert@linux-m68k.org
Subject: Framebuffer overflow halts network

Sorry to bother you "privately", but I can't find much info of the use of
framebuffer after it is installed.

I have set up my primary work machine (i.e. it is mostly used as a terminal
to connect to other servers) with framebuffer and have 64 lines*160 chars in
a pretty font.

I ssh to other servers from this machine.

If I do something which create a lot of output, eg. ls -lR /, the remote
machine sends more data than the framebuffer-terminal can handle. This
blocks the network on the terminal machine, which also is nameserver,
internal webserver and upsd server.

Is it possible to set up some sort of flow control, so the remote machine
stops when the terminal is overloaded?

Both servers are 100Mb, on different switches, which are connected at 100Mb
The terminal is on a Cisco, the other on a cheaper 24ports switch.

If you can't help me, can you direct me in the proper direction?

Leif



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
