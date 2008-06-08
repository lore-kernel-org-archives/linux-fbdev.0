From: Jean Delvare <khali@linux-fr.org>
Subject: Re: radeonfb monid i2c bus
Date: Sun, 8 Jun 2008 16:20:23 +0200
Message-ID: <20080608162023.431083c7@hyperion.delvare>
References: <20080606120151.7976df45@hyperion.delvare>
	<1212760218.12464.33.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K5Ll7-0000Hc-AD for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Jun 2008 07:20:37 -0700
Received: from zone0.gcu-squad.org ([212.85.147.21]
	helo=services.gcu-squad.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K5Ll5-0003C3-Qq
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Jun 2008 07:20:37 -0700
In-Reply-To: <1212760218.12464.33.camel@pasglop>
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
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 06 Jun 2008 23:50:18 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2008-06-06 at 12:01 +0200, Jean Delvare wrote:
> > Can you explain what is the "monid" i2c bus on Radeon adapters? I have
> > two Radeon chips here, an M6 in my old laptop and a 9200 in my desktop
> > system. On the M6 there is nothing on the monid bus. On the 9200, the
> > monid bus doesn't even work, every access results in timeout. The
> > radeonfb driver doesn't even look for EDID EEPROMs on that bus (except
> > in debug code.)
> > 
> > So I'm curious why you create this i2c bus if you don't need it.
> > Have you ever seen a Radeon adapter where there is something on that
> > bus?
> 
> The BIOS connector tables might make us use it.

Where is the code handling this? In radeon_monitor.c I can only see
radeon_probe_i2c_connector() being called on ddc_vga, ddc_dvi and
ddc_crt2. No reference to ddc_monid.

>                                                 Otherwise, it tends to
> have the external TMDS transmitter on it for which we'll one day get
> proper support for re-initializing on wakeup from sleep...

But apparently not all chips have the "monid" bus? Or is it a card
property, and other cards using the same Radeon 9200 might have it
while mine doesn't? I wouldn't care about an empty i2c bus, but a
broken bus as I get now affects the whole i2c subsystem and its users
in unpleasant ways. That's why I am wondering if there's a way to avoid
it.

Thanks,
-- 
Jean Delvare

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
