From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Some questions
Date: Thu, 6 Mar 2003 12:40:09 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030306114009.GA1770@iliana>
References: <Pine.LNX.4.44.0303051939470.27760-100000@phoenix.infradead.org> <1046913411.1206.185.camel@localhost.localdomain> <3E670B82.30900@winischhofer.net> <1046942633.1330.54.camel@localhost.localdomain> <3E671848.5020506@winischhofer.net> <1046945135.1209.76.camel@localhost.localdomain> <20030306103156.GA864@iliana> <1046947667.1330.87.camel@localhost.localdomain> <1046947834.1209.89.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qtkb-00073F-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Mar 2003 03:41:25 -0800
Content-Disposition: inline
In-Reply-To: <1046947834.1209.89.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Thomas Winischhofer <thomas@winischhofer.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Mar 06, 2003 at 06:51:58PM +0800, Antonino Daplas wrote:
> On Thu, 2003-03-06 at 18:48, Antonino Daplas wrote:
> > On Thu, 2003-03-06 at 18:31, Sven Luther wrote:
> > > On Thu, Mar 06, 2003 at 06:05:37PM +0800, Antonino Daplas wrote:
> > > > Yes, there is.  Using the "stale" pixelclock, htotal and vtotal,
> > > > calculate hsync and vsync.  Compare this with your monitor's limit -- if
> > > > any fall outside, the entire mode, pixelclock and all is not valid.
> > > > 
> > > > (see fb_get_mode() and fb_validate_mode() in fbmon.c)
> > > > 
> > > > And if you use very narrow vsync and hsync ranges, then the "stale"
> > > > pixelclock will always most certainly be invalid.
> > > 
> > > BTW, do we have an easy way of knowing if it is an LCD or analog monitor
> > > which is attached to the card (or even a TV) ? I think the radeonfb
> > > knows how to do this, not sure though.
> > > 
> > 
> > There's an EDID parser in fbmon.c.  I think it will work only for the
> > PPC. This is currently used by rivafb and radeonfb. For the rest, either

Mmm, is it because the EDID parser uses the EDID information pased by
the OF ?

> > we implement DDC or just have something similar to XF86Config's
> > HorizSync and VertRefresh.  We can load this either as a kernel/module
> > option or passed via ioctl/sysfs.  

Most monitors today have DDC support, so i guess best would be to use
it, and fall back to a command line option if DDC is not supported.

> > I'm already doing this with the i810fb (as boot/module option), which
> > greatly simplified mode switching.
> 
> Oops, totally missed your question :-)  But yes, I think the EDID block
> contains information about the monitor type, not sure thogh.

X finds :

Digital Display Input

So, i guess this is it.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
