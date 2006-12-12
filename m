From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbdev driver for S3 Trio/Virge
Date: Tue, 12 Dec 2006 09:42:58 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0612120938550.18306@pademelon.sonytel.be>
References: <20061206100601.GA1408@localhost.localdomain>
	<20061211143041.d42aff3b.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gu3ER-0000GY-Uh for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 00:43:24 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gu3EN-0004pu-H9
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Dec 2006 00:43:23 -0800
In-Reply-To: <20061211143041.d42aff3b.akpm@osdl.org>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, James Simmons <jsimmons@infradead.org>

On Mon, 11 Dec 2006, Andrew Morton wrote:
> On Wed, 6 Dec 2006 11:06:01 +0100
> Ondrej Zajicek <santiago@crfreenet.org> wrote:
> 
> > This patch adds driver for S3 Trio / S3 Virge.
> 
> Confused.  Don't S3triofb.c and virgefb.c already do that?

S3triofb is a dumb frame buffer device for an S3 Trio card initialized by Open
Firmware (i.e. no mode setting). It's practical use is very limited these days
(how many of the handful CHRP LongTrail boards are still alive and have an S3
Trio card?).

Cyberfb and Virgefb are frame buffer devices for S3 Trio and ViRGE chips tied
to Zorro-to-PCI bridges on Zorro graphics cards for Amiga. But they were never
converted to the 2.6 fbdev kernel API and Adrian wants to remove them.

So yes, it would be nice to finally have a full-featured driver for S3 Trio and
ViRGE in the kernel ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
