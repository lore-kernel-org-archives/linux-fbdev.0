From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/6] PM/FB/gxfb: add config option
 that allows disabling of VT switch during suspend
Date: Mon, 10 Mar 2008 15:28:28 -0700
Message-ID: <20080310152828.8f102f52.akpm@linux-foundation.org>
References: <20080308204927.73afa56c@ephemeral>
	<20080310141939.ce1169c0.akpm@linux-foundation.org>
	<20080310174424.29621e62@ephemeral>
	<20080310145118.adb0cf1e.akpm@linux-foundation.org>
	<20080310181446.2fb85eea@ephemeral>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYqVP-0001B5-QU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 15:30:03 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JYqVO-0007T5-GU
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 15:30:03 -0700
In-Reply-To: <20080310181446.2fb85eea@ephemeral>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, rjw@sisk.pl, jordan.crouse@amd.com, samuel.thibault@ens-lyon.org

On Mon, 10 Mar 2008 18:14:46 -0400 Andres Salomon <dilinger@queued.net> wrote:

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
> drivers (lxfb and gxfb) seems like overkill?

It's just a few bytes of code?

>  I also don't really see
> anyone needing to switch back and forth between VT_SWITCH and
> NO_VT_SWITCH other than to work around possible bugs in the register
> save/restore code..

Making driver behaviour depend upon compile-time settings is really to be
avoided.  A distributor has to choose one setting or the other, and a) that
means that some people will get the wrong setting and b) there's a decent
chance that the distributor will get it wrong.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
