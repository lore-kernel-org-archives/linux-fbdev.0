From: Aleksandr Koltsoff <czr@iki.fi>
Subject: anyone working on radeonfb?
Date: Thu, 12 Dec 2002 14:23:08 +0200 (EET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0212121419410.31977-100000@iohazard.tts.fi>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from iohazard.tts.fi ([193.94.244.252])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18MSNX-0001fw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Dec 2002 04:23:48 -0800
Received: from czr (helo=localhost)
	by iohazard.tts.fi with local-esmtp (Exim 3.35 #1 (Debian))
	id 18MSMu-0008K4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 12 Dec 2002 14:23:08 +0200
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

hello

is anyone actively maintaining the radeon fb driver in the 2.4 series?

I've started reviving and older hacked version (based on mplayer radeonfb)
of the driver. The version I have has proper panning and accel console
(almost, 32bit mode is causing some minor head-aches still).

I'd like to eventually sync my version with the kernel one (and yes, I
know that the mplayer version is way off Linus coding style, and yes, it's
based somewhat on xfree86, but I'm willing to work that out eventually).

currently I have only some radeon boards left, but no DVI anymore, so I'll
need someone with DVI displays as well. Also I have no access to PPCs, so
would need someone to test the newer driver there as well if possible.

thanks :-)

ak.



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
