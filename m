From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Added 915G to intelfb of 2.6.10-kernel-sources
Date: Sat, 29 Jan 2005 08:19:07 +0800
Message-ID: <200501290819.08329.adaplas@hotpop.com>
References: <41F9BEA6.2030300@XLsigned.net> <200501290554.24649.adaplas@hotpop.com> <41FABFA9.7050709@XLsigned.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CugMA-0001An-57
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 16:20:54 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CugM8-0007NP-Q6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 28 Jan 2005 16:20:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1317BD50197
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 29 Jan 2005 00:20:45 +0000 (UTC)
In-Reply-To: <41FABFA9.7050709@XLsigned.net>
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
To: "Buttchereit, Axel (XLsigned)" <XL@XLsigned.net>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Sylvain Meyer <sylvain.meyer@worldonline.fr>

On Saturday 29 January 2005 06:41, Buttchereit, Axel (XLsigned) wrote:
> Antonino A. Daplas wrote:
> > Because the modedb array is marked __init.  You can however pass
> > the vesa_modes array instead to fb_find_mode().
>
> Ah, yes!
> At the moment "intelfb" does not pass any "modedb" in its call(s) to
> "fb_find_mode()" which results in using the "__init modedb" in case
> of "static link" and using no modedb (actually using a not-initialized one)
> at all, otherwise.
> Passing "vesa_modes" would make things better when loading
> "intelfb" as a module, but would change "well known behaviour",
> when linked statically, though I could perfectly live with an "initfb"
> that is always using "vesa_modedb".
>
> Any suggestions?

If you really must, you can pass modedb if compiled statically, and
vesa_modedb if compiled as a module.

>
> Bumping into driver development for the first time it's quite
> clear that I do not know many important things that I should know.
> So please be "forgiving", if I ask stupid questions like this one:
>
> How do I detect, if something (intelfb) is loaded as a module or
> statically linked into the kernel?

What do you mean, detect by whom? Detect by another module
in the kernel or by userspace?

You can do several things:

1. Use #ifdef MODULE/#endif
2. Check if CONFIG_FB_INTELFB_MODULE is defined
3. Check struct fb_info.flags if FBINFO_MODULE is set
4. Use symbol_get()/symbol_put() and check the return value before calling
any of the functions of the driver.

> >>>loaded, if
> >>>"video=intelfb:..." is specified as kernel-parameter?
> >
> > If you want it loaded automatically, compile the driver statically. If
> > you don't want to load a compiled-in driver, use:
> >
> > video=intelfb:off
>
> This is not exactly what I was asking for. :-)
> It would be nice, if the module would automatically be loaded in
> "early boot stage", when specified as a kernel-parameter. But this is

Because at this stage, userspace hasn't been initialized yet, so you cannot
automatically load modules (which are stored in the filesystem) without help
from userspace.

> not really important (for me), because using "udev" and "hotplug/coldplug"
> (on gentoo) finally loads it anyway.
>

Yes, that is a better solution.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
