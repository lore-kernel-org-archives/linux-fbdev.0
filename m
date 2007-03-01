From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: matroxfb returning incorrect fix.smem_len?
Date: Thu, 1 Mar 2007 14:21:32 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0703011420461.766@pademelon.sonytel.be>
References: <45E5D610.5060807@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMlE7-0003xU-GQ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 05:21:43 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMlE6-0004k9-1O
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 05:21:43 -0800
In-Reply-To: <45E5D610.5060807@us.ibm.com>
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
To: Ian Romanick <idr@us.ibm.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 28 Feb 2007, Ian Romanick wrote:
> While doing some work on the pci-rework branch of X.org, I noticed
> something strange.  matroxfb correctly detects that my card has 16MiB,
> but fix.smem_len is only 8MiB.
> 
> I looked around the matroxfb code and some of the other driver's code,
> and I believe that matroxfb is incorrectly setting fix.smem_len.
> Matroxfb sets fix.smem_len to (total_memory_size -
> memory_used_by_current_mode).  Other drivers, such as nvidiafb do not do
> this.

Did matroxfb detect a dual-head capable card?

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
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
