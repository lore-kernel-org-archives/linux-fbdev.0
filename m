From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: request_mem_region problem ...
Date: Fri, 1 Nov 2002 19:43:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021101184307.GA356@iliana>
References: <1036062270.638.25.camel@daplas> <Pine.LNX.4.33.0211010933210.6296-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25] helo=mel-rto6.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187glu-0000sK-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Nov 2002 10:43:54 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211010933210.6296-100000@maxwell.earthlink.net>
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
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Antonino Daplas <adaplas@pol.net>, Sven Luther <luther@dpt-info.u-strasbg.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Nov 01, 2002 at 09:35:06AM -0800, James Simmons wrote:
> 
> > If you did not define fb_set_var at all, then info->disp.dispsw must
> > point to valid console drawing hooks before you register the
> > framebuffer.  (Actually, all fields in struct display must be valid
> > before you register the framebuffer)
> 
> The next set of change should help reduce these problems of missing
> pointers as we move to the new api.
> 
> > > So, does the cfb_xxx generic accel stuff get linked correctly when
> > > building as modules or am i missing something ?
> >
> > You're correct, the neofb line in the Makefile is for static building
> > only.  The cfb_xxx will not compile as modules, yet.  If your driver has
> > its own Makefile, just add cfb_xxx.o objects to directly link to them.
> 
> In the next set of changes the cfb* files should be able to be built as
> modules!!!!

The ones in the patches you failed to send or the one thereafter ?

BTW, do you think the latest set of changes will be in 2.4.46 or
something such ?

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
