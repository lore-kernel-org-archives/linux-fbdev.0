From: Clint Adams <schizo@debian.org>
Subject: Re: Re: Bug#226973: xserver-xfree86: [glint] second card at wrong resolution
Date: Wed, 31 Mar 2004 11:10:02 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040331161002.GB16669@scowler.net>
References: <20040113074158.GF4863@iliana> <20040113154025.GA12817@scowler.net> <20040113160221.GA12752@iliana> <20040114211246.GA31567@scowler.net> <20040114211643.GA6793@iliana> <20040330153247.GB11287@scowler.net> <20040330165738.GC31639@lambda> <20040330230203.GA2568@scowler.net> <20040330230829.GA5257@lambda> <Pine.GSO.4.58.0403311011400.22944@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8iI1-00081j-GD
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Mar 2004 08:10:05 -0800
Received: from acolyte.scowler.net ([216.254.112.45])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1B8iI1-000380-4M
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 31 Mar 2004 08:10:05 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0403311011400.22944@waterleaf.sonytel.be>
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
Cc: Sven Luther <sven.luther@wanadoo.fr>, 226973@bugs.debian.org, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

> If your graphics controller is limited by memory bandwidth, the maximum pixel
> clock depends on the number of bits per pixels, since larger pixels mean more
> memory bandwidth.

I'm unclear on the differences between 24 bpp and 32 bpp and how this
relates to internal pixmap format.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
