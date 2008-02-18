From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
 Metronomefb v3
Date: Mon, 18 Feb 2008 15:03:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802181502550.12244@anakin>
References: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JR6aW-0006zC-0A for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 06:03:20 -0800
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JR6aU-0004V7-Dm
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 06:03:19 -0800
In-Reply-To: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@pol.net, akpm@linux-foundation.org, Jaya Kumar <jayakumar.lkml@gmail.com>

On Mon, 18 Feb 2008, Jaya Kumar wrote:
> This patch implements support for the E-Ink Metronome controller. It
> provides an mmapable interface to the controller using defio support.
> 
> I welcome your feedback. Please let me know if it looks okay to apply.

To me it looks OK.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
