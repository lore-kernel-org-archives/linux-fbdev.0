From: David Eger <eger@havoc.gtf.org>
Subject: Re: Fw: [Bugme-new] [Bug 2916] New: Console font became black on black after upgrade from 2.6.6 to 2.6.7
Date: Fri, 18 Jun 2004 21:20:57 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040619012057.GA14319@havoc.gtf.org>
References: <20040618152036.3f5cd6b3.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbUXm-0006X0-4Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 18:21:18 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbUXl-000326-Jo
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Jun 2004 18:21:17 -0700
Content-Disposition: inline
In-Reply-To: <20040618152036.3f5cd6b3.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, spamhole@gmx.at, Johannes Bauer <dfnsonfsduifb@gmx.de>

> # Graphics support
> #
> CONFIG_FB=y
> CONFIG_FB_VESA=y
> CONFIG_FB_RADEON=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_DUMMY_CONSOLE=y
> # CONFIG_FRAMEBUFFER_CONSOLE is not set

For a typical setup, framebuffer drivers (CONFIG_FB_VESA, CONFIG_FB_RADEON) 
are only really useful if you want the console to live on top of them... 
so use either:

(1) CONFIG_FB + (CONFIG_FB_VESA | CONFIG_FB_RADEON) + CONFIG_FRAMEBUFFER_CONSOLE

or

(2) CONFIG_VGA_CONSOLE

Please let me know if any of these three setups work.  I wouldn't select
both VESA and a specific driver.... eww... I'd guess they would get
confused and try to access the same hardware...

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
