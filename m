From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 10999] New: intelfb +
 965GM still not working in 2.6.26-rc8
Date: Sat, 28 Jun 2008 11:36:42 -0700
Message-ID: <20080628113642.b34e4e51.akpm@linux-foundation.org>
References: <bug-10999-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KCfI4-0000Ts-54 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Jun 2008 11:36:52 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KCfI3-0003JW-Qm
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 28 Jun 2008 11:36:52 -0700
In-Reply-To: <bug-10999-10286@http.bugzilla.kernel.org/>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: peter.ganzhorn@googlemail.com, Maik@sc8-sf-spam2.sourceforge.net, bugme-daemon@bugzilla.kernel.org, Broemme <mbroemme@plusserver.de>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sat, 28 Jun 2008 06:26:31 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=10999
> 
>            Summary: intelfb + 965GM still not working in 2.6.26-rc8
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.26-rc8
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Console/Framebuffers
>         AssignedTo: jsimmons@infradead.org
>         ReportedBy: peter.ganzhorn@googlemail.com
> 
> 
> Distribution: Debian Lenny
> Hardware Environment: Toshiba Tecra A9 (Core2 Duo / 965GM)
> Software Environment: Debian Lenny
> Problem Description:
> With 2.6.26-rc8 intelfb is supposed to support Intels 965GM integrated graphics
> chips, but I am unable to get it working.
> I included the fbcon and intelfb drivers statically and removed all other
> framebuffer drivers such as vesafb. I selected the 8x16 font to be included.
> 
> I tried with the following config in grub:
> title           Linux
> root            (hd0,1)
> kernel          /vmlinuz root=/dev/sda3 video=intelfb:mode=1680x1050-32@60
> savedefault
> 
> video=intelfb:mode=1680x1050-32@60
> video=intelfb:mode=1280x1024
> video=intelfb:mode=1280x1024-32@60
> 
> won't work either, I'm always getting a blank black screen until X starts.
> My screen does support resolutions up to 1680x1050, X is working with that
> resolution. At least 1280x1024 should work as vesafb did with my last kernel
> (with vga=794).
> 965GM chipsets are listed in my kconfig as well as in
> Documentation/fb/intelfb.txt.
> 
> What might be wrong here?!
> 



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
