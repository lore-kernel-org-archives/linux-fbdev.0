From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] fbcon: replace mono_col macro
	with	static inline
Date: Tue, 26 Feb 2008 13:50:02 -0800
Message-ID: <1204062602.5582.38.camel@brick>
References: <1203963237.5582.4.camel@brick>
	<Pine.LNX.4.64.0802260917410.5158@anakin>
	<1204059074.5582.35.camel@brick>
	<Pine.LNX.4.64.0802262235150.22486@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JU7gv-0001aI-2j for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 13:50:25 -0800
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JU7gt-0005LN-R6
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 13:50:25 -0800
Received: by wa-out-1112.google.com with SMTP id k22so2891715waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Feb 2008 13:50:23 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0802262235150.22486@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>

On Tue, 2008-02-26 at 22:36 +0100, Geert Uytterhoeven wrote:
> On Tue, 26 Feb 2008, Harvey Harrison wrote:
> > On Tue, 2008-02-26 at 09:18 +0100, Geert Uytterhoeven wrote:
> > > On Mon, 25 Feb 2008, Harvey Harrison wrote:
> > > > +static inline int mono_col(struct fb_info *info)
> > >                               ^^^^^^^^^^^^^^^^^^^^
> > > const struct fb_info *info?
> > 
> > I suppose, but seeing as it's an inline, does it really matter?
> 
> Sure, if one day a new routine calls mono_col() passing a const struct fb_info
> pointer, it won't compile.

Fair enough, want an updated patch, or will Andrew just make the small
addition?

Harvey


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
