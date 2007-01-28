From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
Date: Mon, 29 Jan 2007 08:37:00 +1100
Message-ID: <1170020220.26655.35.camel@localhost.localdomain>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<200701260513.24010.arnd@arndb.de>
	<Pine.LNX.4.62.0701261535180.30062@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBHkK-0004ts-0T for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 13:39:32 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX18JAnZTZrwcwIl+/n2F9Um1na5BUmhOEcg=])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBHkJ-0008P1-Hk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 13:39:31 -0800
In-Reply-To: <Pine.LNX.4.62.0701261535180.30062@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>

> Analog YUV (Component and composite/S-video) video timings are dictated by
> broadcast standards.
> 
> The last 3 resolutions are supported through the HDMI output only. Hence if
> your TV has HDMI or DVI-D (_with_ HDCP, else you get a black screen) inputs,
> you can use 1280x768.
> 
> If your TV doesn't have HDMI or DVI-D with HDCP, but it has component inputs,
> you can use analog 720p.

Please, still try to get the HV folks to add more VESA modes for use by
linux :-) 1600x1200 would be nice for example, as would 1440x900 (lots
of cheap flat panels do that nowadays.... they can demote to 720p which
is good enough for games, but for linux, we want native resolution).

> Reducing these values may cause video noise to be seen when changing video
> modes.

So the whole thing should be turned into a state machine on a timer or a
kthread no ? So at least, whatever issues the mode change can start
drawing while the kernel waits to actually enable the outputs...

Ben.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
