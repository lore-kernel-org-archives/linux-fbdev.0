From: Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.12-rc2
Date: Wed, 25 May 2005 21:56:37 -0700
Message-ID: <20050525215637.252cbaba.akpm@osdl.org>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org>
	<Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
	<E1DJE6t-0001T5-UD@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DbARA-00052q-4K
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 21:57:40 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DbAR7-00039m-So
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 25 May 2005 21:57:39 -0700
In-Reply-To: <E1DJE6t-0001T5-UD@localhost.localdomain>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Moritz Muehlenhoff <jmm@inutil.org>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

Moritz Muehlenhoff <jmm@inutil.org> wrote:
>
> Linus Torvalds wrote:
> > Benjamin Herrenschmidt:
> >   o radeonfb: Implement proper workarounds for PLL accesses
> >   o radeonfb: DDC i2c fix
> >   o radeonfb: Fix mode setting on CRT monitors
> >   o radeonfb: Preserve TMDS setting
> 
> One of these patches introduced two regressions on my Thinkpad X31 with
> "ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])":
> 
> 1. When resuming from S3 suspend and having switched off the backlight
> with radeontool the backlight isn't switched back on any more.
> 
> 2. I'm using fbcon as my primary work environment, but tty switching has
> become _very_ sloppy, it's at least a second now, while with 2.6.11 it
> was as fast as a few ms. Is this caused by the "proper PLL accesses"?
> 

Moritz, can you tell us whether either of these problems remain in 2.6.12-rc5?

Thanks.


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
