From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Radeon framebuffer weirdness in -mm2
Date: Sat, 22 Jan 2005 00:36:43 +0800
Message-ID: <200501220036.43358.adaplas@hotpop.com>
References: <20050120232122.GF3867@waste.org> <20050121060928.GI12076@waste.org> <Pine.LNX.4.61.0501211315010.6118@scrub.home>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cs1mW-0005vO-T3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 08:37:08 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cs1mW-0006Li-3O
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Jan 2005 08:37:08 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id B68FFD04F52
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Jan 2005 16:36:57 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.61.0501211315010.6118@scrub.home>
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
To: Roman Zippel <zippel@linux-m68k.org>, Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

On Friday 21 January 2005 20:33, Roman Zippel wrote:
> Hi,
>
> On Thu, 20 Jan 2005, Matt Mackall wrote:
> > On Thu, Jan 20, 2005 at 08:07:11PM -0800, Andrew Morton wrote:
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > > Next suspects would be:
> > > >
> > > >  +cleanup-vc-array-access.patch
> > > >  +remove-console_macrosh.patch
> > > >  +merge-vt_struct-into-vc_data.patch
> > >
> > > Make that:
> > >
> > > +cleanup-vc-array-access.patch
> > > +remove-console_macrosh.patch
> > > +merge-vt_struct-into-vc_data.patch
> > > +vgacon-fixes-to-help-font-restauration-in-x11.patch
> >
> > It's something in this batch. Which is good, as I'd be a bit
> > disappointed if the "vt leakage" were somehow attributable to the fb
> > layer. More bisection after dinner.
>
> Could you try the patch below. I cleaned up the logic a little in
> redraw_screen() and the code below really wants to do a update_screen().
> The old switch_screen(fg_console) behaved like update_screen(fg_console).
>

Probably does not matter as this particular code is never invoked during
framebuffer initialization (unless one uses fbcon=map:n option). 

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
