From: David Eger <eger@havoc.gtf.org>
Subject: Re: [PATCH] radeonfb: mode switch work around
Date: Sun, 4 Jul 2004 05:35:42 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040704093542.GA13486@havoc.gtf.org>
References: <20040704025923.39501.qmail@web14930.mail.yahoo.com> <Pine.GSO.4.58.0407041034250.21842@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bh3Qj-0008Eo-9k
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 02:37:01 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bh3Qi-0001Pe-VZ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 02:37:01 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0407041034250.21842@waterleaf.sonytel.be>
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Antonino Daplas <adaplas@pol.net>, Javier Marcet <javier-ml-gmane@marcet.info>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, xorg@freedesktop.org

Nevermind the patch I sent.  I tracked down my X->VT issue to 
my xorg.conf file.  It was missing the line

    Option          "UseFBDev"

Tony, your patch (the one with the big HACK ALERT sticker on it) 
 seems to give radeon the mode switch call when it is needed.

-dte


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
