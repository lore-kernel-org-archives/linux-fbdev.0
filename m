From: "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: Re: [PATCH 1/4][RESEND][FBDEV]: Core fbcon fixes
Date: Thu, 24 Jun 2004 09:11:05 +0800 (PHT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <61276.10.250.10.1.1088039465.squirrel@sq03.pol.net>
References: <200406220638.34214.adaplas@hotpop.com>
        <Pine.LNX.4.56.0406240112270.609@pentafluge.infradead.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdIlm-0000vB-8H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 18:11:14 -0700
Received: from mxresolver.pol.net ([63.240.86.230] helo=sq03.pol.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdIll-0000c6-Oz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 18:11:13 -0700
In-Reply-To: <Pine.LNX.4.56.0406240112270.609@pentafluge.infradead.org>
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
To: jsimmons@pentafluge.infradead.org
Cc: adaplas@pol.net, akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net

>
> Wow. That is a big patch. I will loook it over. I had some ideas I like

It is a big patch.

Needed because fb_console_init and set_con2fbmap are just plain broken. 
Really, you need to adjust module reference counts, re/deinitialize the
cursor timer, initialize/reinitialize the global arrays, preserve user
fonts, consider that you can have multiple fbdevs mapped to different
consoles, consider that you can load/unload fbdev modules at will, etc.
All the above complexities were introduced because fbdev was separated
from fbcon.  Not doing/taking note of any of the above is just asking for
trouble. (The 2.4 framework is simpler because fbcon is automatically
initialized with fbdev).

Plus, the patch also combined the changes needed to prevent screen
corruption at boot time.  Note that the logo code is actually simplified
by the changes.

> to  try myslef. I like to have you be able to map the fbdevs to teh
> correct  VCs at boot time. If one is modular as soon as you load that
> module it  maps to fbcon automatically :-) Like in 2.4.X.
>

Setcon2fbmap is already fixed so you can use it to choose which
framebuffers to load.

Choosing which fbdev to map to a console at boot time is as simple as
adding a boot parameter and use that in fb_console_init.

As for the 2.4 behavior of automatically initializing fbcon when an fb
module is loaded, that is also simple.  Add another notifier event which
is called during register_framebuffer that will subsequently call
fb_console_init().

However you implement it, with this patch, the framework is already in place.

Tony





-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
