From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver V2
Date: Mon, 2 Jun 2008 10:43:57 +0900
Message-ID: <aec7e5c30806011843k32b692e3q3105b20d7611781a@mail.gmail.com>
References: <20080530110239.21680.46731.sendpatchset@rx1.opensource.se>
	<20080530120606.9ff1b384.akpm@linux-foundation.org>
	<20080530214418.f024ba0c.krzysztof.h1@poczta.fm>
	<200805311625.27018.fabio.giovagnini@aurion-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K2z5b-0006W2-Lo for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 18:43:59 -0700
Received: from yw-out-1718.google.com ([74.125.46.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K2z5b-0004mC-EP
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 01 Jun 2008 18:43:59 -0700
Received: by yw-out-1718.google.com with SMTP id 6so353909ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 01 Jun 2008 18:43:58 -0700 (PDT)
In-Reply-To: <200805311625.27018.fabio.giovagnini@aurion-tech.com>
Content-Disposition: inline
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
To: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, iwamatsu@nigauri.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, May 31, 2008 at 11:25 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Which differences are bteween SuperH Mobile LCDC frame buffer and SH2A 7203
> LCDC controller?

Judging from the data sheets the LCDC block in sh7203, sh7763 and
sh7720 are identical. Except different base address for registers and
palette. And maybe IRQ number and pin configuration. =) Anyway, the
sh7760 LCDC is very similar but seems to be missing a few registers.
I'm sure there are other parts that are using this LCDC block as well.
Having a shared driver for sh7203/sh7763/sh7720 and sh7760 makes
sense.

The SuperH Mobile LCDC block (sh7723/sh7722/sh7343) is very different:
Supported pixel formats, hardware interfaces, number of channels,
register layout and register width.

/ magnus

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
