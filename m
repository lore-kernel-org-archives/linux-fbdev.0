From: Yauhen Kharuzhy <jekhor@gmail.com>
Subject: Metronome specifications
Date: Wed, 24 Dec 2008 23:57:36 +0200
Message-ID: <20081224215736.GA1788@jeknote.loshitsa1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jekhor@gmail.com>) id 1LFbjs-0005sz-O5
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 21:58:00 +0000
Received: from qw-out-1920.google.com ([74.125.92.147])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LFbjn-0006Kq-UB for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Dec 2008 21:58:00 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1620904qwc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 24 Dec 2008 13:57:54 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi!

I write board driver for Sony PRS-505 book reader display controller and
need some help. Controller seems to be respond for first command only (RDY is
0 before powerup and 1 after and it won't change on any other steps).
I cannot localize cause of problem because controller behaviour is
undocumented and non-trivial. I compare Sony's driver and metronomefb,
and don't understand differences due lack of documentation.

Can you help to find any documentation for Metronome or, if it
is distrubuted under NDA, explain some moments for me?

How dimensions of image and size of buffer are set in controller? What
does define positions of command buffer, waveforms, image data etc. in
controller memory? What are arguments of config (0xCC10) command mean?

I feel that I will find answers for most of this questions after some
time, but with documentation it will happen soon...

-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek@jabber.ru

A: No
Q: Should I quote below my post?

------------------------------------------------------------------------------
