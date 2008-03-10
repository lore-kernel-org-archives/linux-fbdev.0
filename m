From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/6] PM/FB/gxfb: add config option
	that allows disabling of VT switch during suspend
Date: Mon, 10 Mar 2008 23:28:18 +0100
Message-ID: <200803102328.19985.rjw@sisk.pl>
References: <20080308204927.73afa56c@ephemeral>
	<20080310145118.adb0cf1e.akpm@linux-foundation.org>
	<20080310181446.2fb85eea@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYqUf-00016M-Ec for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 15:29:17 -0700
Received: from ogre.sisk.pl ([217.79.144.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JYqUd-00009s-P2
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 15:29:17 -0700
In-Reply-To: <20080310181446.2fb85eea@ephemeral>
Content-Disposition: inline
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
To: Andres Salomon <dilinger@queued.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, jordan.crouse@amd.com, Pavel Machek <pavel@ucw.cz>, samuel.thibault@ens-lyon.org, Andrew Morton <akpm@linux-foundation.org>

On Monday, 10 of March 2008, Andres Salomon wrote:
> On Mon, 10 Mar 2008 14:51:18 -0700
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > On Mon, 10 Mar 2008 17:44:24 -0400
> > Andres Salomon <dilinger@queued.net> wrote:
> > 
> > > On Mon, 10 Mar 2008 14:19:39 -0700
> > > Andrew Morton <akpm@linux-foundation.org> wrote:
> > > 
> > > > 
> > > > It would be far preferable to do this via a kernel boot parameter rather
> > > > than via a kernel rebuild.
> > > > 
> > > 
> > > Well, it shouldn't be supported at _all_ unless the framebuffer driver
> > > supports it; you're asking for it to be converted to something like the
> > > following?
> > > 
> > > 
> > > 
> > > #ifdef CONFIG_FBDEV_SUPPORTS_NOSWITCH
> > > static int no_vt_switch;
> > > #endif
> > > 
> > > int pm_prepare_console(void)
> > > {
> > > #ifdef CONFIG_FBDEV_SUPPORTS_NOSWITCH
> > > 	if (no_vt_switch)
> > > 		return 0;
> > > #endif
> > > 	...
> > > }
> > > 
> > > #ifdef CONFIG_FBDEV_SUPPORTS_NOSWITCH
> > > module_param(no_vt_switch, int, 0);
> > > MODULE_PARM_DESC(no_vt_switch, "...");
> > > #endif
> > > 
> > > 
> > > If so, that means extra #ifdef's sprinkled throughout the code.  Note
> > > that most framebuffer drivers won't be supporting this, and those that
> > > do will almost certainly always want vt switching turned off..
> > > 
> > 
> > I don't think you need any ifdefs or config options at all, do you?  Just
> > add a new module parameter to this driver and some little interface into
> > the PM core which allows the driver to set no_vt_switch?
> > 
> 
> That's a possibility, but doesn't adding hooks into PM core for two
> drivers (lxfb and gxfb) seems like overkill?  I also don't really see
> anyone needing to switch back and forth between VT_SWITCH and
> NO_VT_SWITCH other than to work around possible bugs in the register
> save/restore code..

FWIW, I prefer the original .config option idea.

Thanks,
Rafael

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
