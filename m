From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2 1/4] video: sh7760fb:
	SH7760/SH7763 LCDC framebuffer driver part 1/3
Date: Sat, 28 Jun 2008 12:01:33 +0900
Message-ID: <20080628030133.GA25492@linux-sh.org>
References: <48632CAF.3090703@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KCQjZ-0000bb-Lq for Linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Jun 2008 20:04:19 -0700
Received: from mta23.gyao.ne.jp ([125.63.38.249] helo=mx.gate01.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KCQjY-0003Ad-QF
	for Linux-fbdev-devel@lists.sourceforge.net;
	Fri, 27 Jun 2008 20:04:17 -0700
Content-Disposition: inline
In-Reply-To: <48632CAF.3090703@renesas.com>
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
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: linux-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>

On Thu, Jun 26, 2008 at 02:44:15PM +0900, Nobuhiro Iwamatsu wrote:
> Main source code of Driver for the LCDC interface on the SH7760 and SH7763 SoCs.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Also note that the SH7203 LCDC is virtually identical, so that might be
worth a brief look also. Unfortunately porting this to the RSK+ 7203 is a
bit of a headache with regards to the panel control, which is closer to
MigoR with the external controller.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
