From: James Simmons <jsimmons@infradead.org>
Subject: Re: request_mem_region problem ...
Date: Fri, 1 Nov 2002 09:35:06 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211010933210.6296-100000@maxwell.earthlink.net>
References: <1036062270.638.25.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187esG-0003e8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Nov 2002 08:42:20 -0800
In-Reply-To: <1036062270.638.25.camel@daplas>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> If you did not define fb_set_var at all, then info->disp.dispsw must
> point to valid console drawing hooks before you register the
> framebuffer.  (Actually, all fields in struct display must be valid
> before you register the framebuffer)

The next set of change should help reduce these problems of missing
pointers as we move to the new api.

> > So, does the cfb_xxx generic accel stuff get linked correctly when
> > building as modules or am i missing something ?
>
> You're correct, the neofb line in the Makefile is for static building
> only.  The cfb_xxx will not compile as modules, yet.  If your driver has
> its own Makefile, just add cfb_xxx.o objects to directly link to them.

In the next set of changes the cfb* files should be able to be built as
modules!!!!




-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
