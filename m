From: Henk Vergonet <rememberme@god.dyndns.org>
Subject: RFC: Modeline configuration strategies.
Date: Mon, 7 Mar 2005 18:37:53 +0100
Message-ID: <20050307173753.GA7774@god.dyndns.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8MB8-0005XX-4q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 09:38:02 -0800
Received: from god.demon.nl ([83.160.164.11] helo=god.dyndns.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8MB6-0005aP-In
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 09:38:02 -0800
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Greetings,

I currently have a savage that's directly connected via the VGA interface to the SCART plug of the TV. This gives magnitudes better picture quality and I don't have to hassle with TVout suppor;)

One of the things I always do is to adjust the static variable savagefb_var800x600x8 with the settings suitable for the TV (PAL mode) in order to boot linux (console) with the TV attached.


This made me wonder, can we make this configurable at kernel config time?

The idea would be that you could do the video mode initialization at kernel configuration time.

For example something like this:
    Videomode intialization strategy:
    [ ] Use EDID Monitor probing
    [ ] Use Laptop mode probing ? (Im not an expert on DVI)
    [ ] Select a videomode:
	[ ] Pre-defined (Vesa modes, PAL, PAL interlaced, NTSC, NTCS interlaced ...)
	[ ] User defined video mode
		parameter1 ... parameterN


As an added bonus this could further modularize the framebuffer code and further enhance modedb...


What do you think?




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
