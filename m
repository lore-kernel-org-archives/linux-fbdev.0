From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb monid i2c bus
Date: Fri, 06 Jun 2008 23:50:18 +1000
Message-ID: <1212760218.12464.33.camel@pasglop>
References: <20080606120151.7976df45@hyperion.delvare>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4cKs-0005R6-9F for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 06:50:30 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18ryXxRaqoVAajNfTSdKk+AGcq2EkcL/EQ=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4cKq-0007j2-Rp
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 06:50:30 -0700
In-Reply-To: <20080606120151.7976df45@hyperion.delvare>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 2008-06-06 at 12:01 +0200, Jean Delvare wrote:
> Hi Ben,
> 
> Can you explain what is the "monid" i2c bus on Radeon adapters? I have
> two Radeon chips here, an M6 in my old laptop and a 9200 in my desktop
> system. On the M6 there is nothing on the monid bus. On the 9200, the
> monid bus doesn't even work, every access results in timeout. The
> radeonfb driver doesn't even look for EDID EEPROMs on that bus (except
> in debug code.)
> 
> So I'm curious why you create this i2c bus if you don't need it.
> Have you ever seen a Radeon adapter where there is something on that
> bus?

The BIOS connector tables might make us use it. Otherwise, it tends to
have the external TMDS transmitter on it for which we'll one day get
proper support for re-initializing on wakeup from sleep...

Ben.



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
