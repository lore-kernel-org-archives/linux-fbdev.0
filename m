From: "Buttchereit, Axel (XLsigned)" <XL@XLsigned.net>
Subject: Re: Re: Added 915G to intelfb of 2.6.10-kernel-sources
Date: Fri, 28 Jan 2005 23:41:45 +0100
Message-ID: <41FABFA9.7050709@XLsigned.net>
References: <41F9BEA6.2030300@XLsigned.net> <41FA6B64.6090506@worldonline.fr> <200501290554.24649.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CueoS-0002ag-MG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 14:42:00 -0800
Received: from mail.goracer.de ([62.75.192.134])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CueoQ-0003qT-Sd
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 14:42:00 -0800
In-Reply-To: <200501290554.24649.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Sylvain Meyer <sylvain.meyer@worldonline.fr>

Antonino A. Daplas wrote:
> Can you resend the patch that touches only intelfb?  Also, there are a lot
> of XLSigned with the printk's, what is that?
Yes, I will do so.
I've marked all the places where I added/changed something with a
comment that contains my domainname (for finding them easier
during editing). I'll remove this before resending.

> Because the modedb array is marked __init.  You can however pass
> the vesa_modes array instead to fb_find_mode().
Ah, yes!
At the moment "intelfb" does not pass any "modedb" in its call(s) to
"fb_find_mode()" which results in using the "__init modedb" in case
of "static link" and using no modedb (actually using a not-initialized one)
at all, otherwise.
Passing "vesa_modes" would make things better when loading
"intelfb" as a module, but would change "well known behaviour",
when linked statically, though I could perfectly live with an "initfb"
that is always using "vesa_modedb".

Any suggestions?

Bumping into driver development for the first time it's quite
clear that I do not know many important things that I should know.
So please be "forgiving", if I ask stupid questions like this one:

How do I detect, if something (intelfb) is loaded as a module or
statically linked into the kernel?

>>>ByTheWay: Why isn't the framebuffer module (intelfb) automatically
>>>loaded, if
>>>"video=intelfb:..." is specified as kernel-parameter?
> 
> 
> If you want it loaded automatically, compile the driver statically. If you don't
> want to load a compiled-in driver, use:
> 
> video=intelfb:off
This is not exactly what I was asking for. :-)
It would be nice, if the module would automatically be loaded in
"early boot stage", when specified as a kernel-parameter. But this is
not really important (for me), because using "udev" and "hotplug/coldplug"
(on gentoo) finally loads it anyway.

Thanks
--Axel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
