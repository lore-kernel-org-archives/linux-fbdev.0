From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: fbset : strange problem (fwd)
Date: Sun, 28 Aug 2005 21:56:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508282156190.27014@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9THE-0005Ci-DT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 Aug 2005 12:57:12 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E9THC-0002K6-3n
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 28 Aug 2005 12:57:12 -0700
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: p.pouget@nerim.net

---------- Forwarded message ----------
Date: Sun, 28 Aug 2005 21:27:58 +0200 (CEST)
From: p.pouget@nerim.net
To: geert.uytterhoeven@cs.kuleuven.ac.be, geert.uijtterhoeven@cs.kuleuven.ac.be
Cc: p.pouget@nerim.net
Subject: fbset : strange problem

Hello

I am trying to use the frame buffers under linux 2.6.12.xxx.

fbset should work via the drivers then as the same way regardless the
hardware it runs on?

On my dell inspiron using a radeon mobility, everything works well, fbset
sets, consfb works etc... vlc uses the frame buffer etc...

On my Tyan S2885, I have problems with 2 radeons:
On the 0x4966 ( R250 ) fbset looks like to change the resolution but I see
the bios startup screen splitted. The machine is running properly but
without screen
On the 0x554f ( R423 according FB R430 according xorg ) bfset makes an
ooops but the mode is unchnaged and the machine is running with screen.

Any ideas?

Regards

Patrick




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
