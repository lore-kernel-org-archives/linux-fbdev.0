From: Parag Warudkar <warudkar@vsnl.net>
Subject: Re: 2.5.70 - Blank Screen with VESA VGA Framebuffer
Date: Sat, 14 Jun 2003 09:20:16 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <002201c33228$12566b80$016f41db@Lappy>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp2.vsnl.net ([203.200.235.232])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19R2Eg-0007Gg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 21:01:50 -0700
Received: from Lappy ([127.0.0.1])
 by smtp2.vsnl.net (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14
 2003)) with SMTP id <0HGG008WGDBM25@smtp2.vsnl.net> for
 linux-fbdev-devel@lists.sourceforge.net; Sat, 14 Jun 2003 09:20:16 +0530 (IST)
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
To: nsouch@free.fr
Cc: geert@linux-m68k.org, jsimmons@infradead.org, linux-fbdev-devel@lists.sourceforge.net, jochen@panix.com

  Sorry - Last time I sent the message encoded/html which appeared garbled
on the list.. Thanx to Jochen Roth for pointing it out.
  Original Message...>

  Yeah, exact same card. I will try the LCD patch, does X work with it?
  For me the reason for using FB is X, it wont work otherwise. Why? I don't
know..
  Will take this up with X-Pert..!

  P
  -----Original Message----- 
  From: Nicolas Souchu [mailto:nsouch@free.fr]
  Sent: Sat 6/14/2003 04:55
  To: Parag Warudkar
  Cc: Geert Uytterhoeven; James Simmons; Linux Frame Buffer Device
Development
  Subject: Re: [Linux-fbdev-devel] 2.5.70 - Blank Screen with VESA VGA
Framebuffer


  On Fri, Jun 13, 2003 at 02:06:56PM +0530, Parag Warudkar wrote:
  > No. Atyfb hasn't worked for me in 2.4.20. If I use video=atyfb, I get a
  > corrupted white screen which is beyond my capabilities to describe!! :)

  My experience is almost the same with the following board:

  01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M
AGP 2x
  +(rev 64) (prog-if 00 [VGA])
          Subsystem: ATI Technologies Inc Rage Mobility P/M AGP 2x
          Flags: bus master, stepping, medium devsel, latency 64, IRQ 9
          Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
          I/O ports at c000 [size=256]
          Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
          Expansion ROM at <unassigned> [disabled] [size=128K]
          Capabilities: [50] AGP version 1.0
          Capabilities: [5c] Power Management version 1

  The PCI id is Ox4d4c, and you?

  e.g. I got the famous encrypted white screen with at least 2.4.9 but
  now with 2.5.69 + LCD patch posted recently, it's much better. I get
  half the screen duplicated verticaly but with correct resolution.

  I guess this is a modesetting problem?

  > The graphics chip is ATI RAGE Mobility M1(LT) AGP2X - a MACH64 Derivate
  > with 8Mb RAM..  For X, 3D acceleration (DRI, direct rendering) works
  > with a Mach64 branch of XFree86.
  > (http://dri.sourceforge.net/snapshots/bleeding-edge/mach64*-*)

  You should try the 2.5.69+patch...

  Note that I had to disable everything else but the ATY driver (VESA,
VGA16,
  framebuffer virtual).

  Nicholas

  --
  Nicholas Souchu - nsouch@free.fr - nsouch@FreeBSD.org





-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
