From: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: PM/FB/gxfb: add config option that allows
	disabling of VT	switch during suspend
Date: Mon, 10 Mar 2008 16:24:07 -0600
Message-ID: <20080310222407.GD589@cosmic.amd.com>
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
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JYqRa-0000ix-5U for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 15:26:06 -0700
Received: from outbound-sin.frontbridge.com ([207.46.51.80]
	helo=outbound2-sin-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JYqRX-0007PV-JB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 10 Mar 2008 15:26:06 -0700
Content-Disposition: inline
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
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, info-linux@geode.amd.com, rjw@sisk.pl, samuel.thibault@ens-lyon.org, Andrew Morton <akpm@linux-foundation.org>

On 10/03/08 18:14 -0400, Andres Salomon wrote:
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

I like Andrew's idea.  I wager This won't be Geode specific for long.
Either other drivers will get the hint and add real save/restore code
or the GPU subystem code being worked on by the X folks will come along
and make the VT switch obsolete for everybody.  Either way, I see hooks
in the PM core as generic love that everybody can benefit from.

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
