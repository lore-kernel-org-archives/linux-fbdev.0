From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Mobility M1 refresh code problem 2.4.26?
Date: Thu, 6 May 2004 22:42:41 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405062241550.20729@waterleaf.sonytel.be>
References: <20040430150627.GB1543@sci.fi> <Pine.LNX.4.44.0404301707110.12865-100000@phoenix.infradead.org>
 <20040501004059.GD30285@guug.org> <409A91D6.4000508@bitworks.com>
 <409A98A5.2040809@telia.com> <409AA194.8090609@bitworks.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLphe-0002OT-M1
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 13:42:46 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BLphe-00066z-5d
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 May 2004 13:42:46 -0700
In-Reply-To: <409AA194.8090609@bitworks.com>
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
To: Richard Smith <rsmith@bitworks.com>
Cc: miffe-miffe@telia.com, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 6 May 2004, Richard Smith wrote:
> Hmmm... I had GX set.  Unsetting and rebuilding did change things.  the

Strange, {en,dis}abling GX should matter for Mach64 GX chips only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
