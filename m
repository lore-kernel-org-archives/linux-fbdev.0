From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: I2C standalone vs integrated?
Date: Thu, 16 Oct 2003 12:14:34 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066299274.644.130.camel@gaston>
References: <20031016004349.71177.qmail@web14908.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AA5AF-00029F-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Oct 2003 03:15:27 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AA5AD-0005sI-7g
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Oct 2003 03:15:25 -0700
In-Reply-To: <20031016004349.71177.qmail@web14908.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> Also, I2C drivers for Intel810, Savage, Voodoo, etc are implemented as
> standalone I2C drivers. Ben implemented his and Matrox as an integral part of
> the fb driver. Wouldn't it be better to implement these all standalone? It's
> probably the same amount of code, and I can use the standalone ones from Mesa
> without loading framebuffer support.

(Note: I didn't do the Matrox part)

Regarding the standalone, I'm not too sure about it. I even though about
not using the linux i2c layer at all, it's not very convenient, and we
need to wrap the i2c accesses in all sort of tweaks to make DDC work
properly in all cases (all the stuff in radeon_probe_i2c_connector()
typically).

I'd rather see things built on top of framebuffer drivers (fbcon staying
something separate).

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
