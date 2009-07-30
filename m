From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 13869] New: Radeon
 framebuffer (w/o KMS) corruption at boot.
Date: Wed, 29 Jul 2009 17:19:40 -0700
Message-ID: <20090729171940.016575a5.akpm@linux-foundation.org>
References: <bug-13869-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
In-Reply-To: <bug-13869-10286@http.bugzilla.kernel.org/>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, bugzilla-daemon@bugzilla.kernel.org, 1i5t5.duncan@cox.net, bugme-daemon@bugzilla.kernel.org



(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

(lots of cc's added)

On Wed, 29 Jul 2009 16:45:00 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=13869
> 
>            Summary: Radeon framebuffer (w/o KMS) corruption at boot.
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 2.6.31-rc4-198-g7d3e91b
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Bluetooth
>         AssignedTo: drivers_bluetooth@kernel-bugs.osdl.org
>         ReportedBy: 1i5t5.duncan@cox.net
>         Regression: No
> 
> 
> I have an older rv280 Radeon 9200 SE AGP, dual CRTC, DVI + VGA (plus
> unconnected TV-Out).  To it I have connected dual 1920x1200 monitors, one each
> to the DVI and VGA out ports.
> 
> I run the radeon framebuffer in native 1920x1200 mode at the text console, and
> haven't yet enabled KMS.
> 
> I've noted that for most of the 2.6.31 cycle, thru rc4-198-g7d3e91b pulled just
> this morning, at boot, sometimes both monitors come up fine, sometimes the VGA
> connected monitor comes up fine in framebuffer, while the DVI connected monitor
> has the characteristic larger print stair-step scramble of unmatched hardware
> and software resolution.  Normally, they come up as clones of each other.
> 
> I strongly suspect that the changes introducing Radeon KMS (even tho I don't
> have it enabled) disrupted the hardware mode reset of the DVI CRTC, such that
> it stays in whatever mode grub or early-boot uses, before the framebuffer mode
> switch.  The VGA CRTC switches just fine, thus allowing me to actually see what
> I'm doing on it, login, do whatever, startx, etc.  I'm guessing the code now
> only checks for and resets one of the CRTCs instead of both of them, as it did
> before.   It's only when I startx and its mode switches kick in that the DVI
> connected monitor gets reset to normal, after which I can VT-switch back to a
> text VT, and they both come up fine.  However, before starting X, simply
> switching between text/framebuffer mode VTs doesn't unscramble the DVI
> connected one.
> 
> However, sometimes it works just fine.  I /think/ it has something to do with
> whether it's a cold startup, or a warm C-A-D based reboot, possibly with whever
> mode it was in before the reboot as a triggering factor.  Whatever.  I've not
> been able to pin that angle down specifically.  But that, combined with other
> factors including the post-hibernate load bug (bug 13750, see there for much
> more detail on my system, hardware, kernel config, compiler, etc) that was just
> fixed prior to rc4, meant that every time I was about ready to file a bug, it
> seemed to go away, only to return a bit later.
> 
> I can git bisect this if necessary, but hopefully the above is sufficient to
> nail it, as I have my hands full with a problematic kde4 upgrade ATM.
> 

I don't actually see any post-2.6.31 commit to drivers/video/aty/ which
could be attributed to KMS-related things.  Perhaps the change lay
elsewhere in the tree?

Yes, I suspect that a bisect would be useful, thanks.

I'll tentatively reassign this bugzilla report to DRI (how'd it get
assigned to bluetooth??).  I shall mark it as a regression and shall ask
Rafael to add it to his (large) list.  I assume that it's a post-2.6.30
regression.



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
