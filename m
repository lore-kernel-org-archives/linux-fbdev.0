From: Duncan <1i5t5.duncan@cox.net>
Subject: Re: [Bugme-new] [Bug 13869] New: Radeon framebuffer (w/o KMS)
	corruption at boot.
Date: Thu, 30 Jul 2009 05:05:55 -0700
Message-ID: <200907300505.56492.1i5t5.duncan@cox.net>
References: <bug-13869-10286@http.bugzilla.kernel.org/>
	<20090729171940.016575a5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20090729171940.016575a5.akpm@linux-foundation.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=dri-devel>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: dri-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, dri-devel@lists.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org

On Wednesday 29 July 2009 17:19:40 Andrew Morton wrote:
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).
>
> (lots of cc's added)
>
> On Wed, 29 Jul 2009 16:45:00 GMT
>
> bugzilla-daemon@bugzilla.kernel.org wrote:
> > http://bugzilla.kernel.org/show_bug.cgi?id=13869
> >
> >            Summary: Radeon framebuffer (w/o KMS) corruption at boot.
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 2.6.31-rc4-198-g7d3e91b
> >         ReportedBy: 1i5t5.duncan@cox.net
> >
> >
> > I have an older rv280 Radeon 9200 SE AGP, dual CRTC, DVI + VGA (plus
> > unconnected TV-Out).  To it I have connected dual 1920x1200 monitors, one
> > each to the DVI and VGA out ports.
> >
> > I run the radeon framebuffer in native 1920x1200 mode at the text
> > console, and haven't yet enabled KMS.
> >
> > I've noted that for most of the 2.6.31 cycle, thru rc4-198-g7d3e91b
> > pulled just this morning, at boot, sometimes both monitors come up fine,
> > sometimes the VGA connected monitor comes up fine in framebuffer, while
> > the DVI connected monitor has the characteristic larger print stair-step
> > scramble of unmatched hardware and software resolution.  Normally, they
> > come up as clones of each other.
> >
> > I strongly suspect that the changes introducing Radeon KMS (even tho I
> > don't have it enabled) disrupted the hardware mode reset of the DVI CRTC,
> > such that it stays in whatever mode grub or early-boot uses, before the
> > framebuffer mode switch. 
> >
> > I can git bisect this if necessary, but hopefully the above is sufficient
> > to nail it, as I have my hands full with a problematic kde4 upgrade ATM.
>
> I don't actually see any post-2.6.31 commit to drivers/video/aty/ which
> could be attributed to KMS-related things.  Perhaps the change lay
> elsewhere in the tree?
>
> Yes, I suspect that a bisect would be useful, thanks.
>
> I'll tentatively reassign this bugzilla report to DRI (how'd it get
> assigned to bluetooth??).  I shall mark it as a regression and shall ask
> Rafael to add it to his (large) list.  I assume that it's a post-2.6.30
> regression.

Bluetooth?  <setting="Family Matters" voice=Urkel>Did I do that?</voice> =:^P

I thought I chose console/framebuffers, but evidently the mouse slipped.

I don't quite understand your version references here.  2.6.31 isn't out yet, 
so no, it's not a post 2.6.31 commit.  Unless that was supposed to be 
post-2.6.30, which it is, in the 2.6.31 cycle, as I stated.  The  
2.6.31-rc4-198-g7d3e91b I listed as kernel version is what I'm currently 
running, where it isn't yet fixed.  But yes, I believe it started post-2.6.30.

Bisecting... I can do if I can get it sufficiently reproducible.  At this 
point, it happens regularly, but I don't have a solid trigger, which makes 
bisecting difficult.  (I stated that in the original bug filing but then 
edited it out, I guess, before hitting submit.)


... And adding a reply to this, which was on the bug, so it gets CCed to the 
same people:

--- Comment #2 from Dave Airlie <airlied@linux.ie>  2009-07-30 00:48:38 ---

> If you don't have KMS enabled the code never ever gets called.

Perhaps it isn't KMS, but whatever code, "never gets called" for the DVI port 
and presumably CRTC, appears to be the problem, as it doesn't get reset from 
whatever other mode to framebuffer mode, with the typical stair-step display 
that results when the horizontal scans are longer than the hardware mode.

> so please bisect to find it, radeonfb has never really been useful for
> multi-head so I suspect it worked by luck, so it could be a timing change
> somewhere else that affected it.

As I indicated above, "I can bisect" refers to the fact that I'm setup to do 
so.  However, unless I can make it more reliably reproducible, it'll take 
quite some time and I'm not sure it's practical.  False positives aren't an 
issue but false negatives would be as it's happening regularly but not 
reliably.  But since the largest domain area elimination steps are first, just 
reducing the commit domain some will hopefully help, and I can probably do 
that even if it takes me a couple days a step in the process, to verify a 
negative is really a negative and didn't just happen to work that time.

As you said, the framebuffer isn't really useful for multi-head as it's 
cloned, but since the scrambled one is my "working" monitor, it gets annoying 
really fast, because I have to crane my neck to use the other one, until I do 
the first startx and trigger the first post-framebuffer-init mode-switch, 
after which everything (including the framebuffers once again) work correctly.

And since the DVI output is sharper, I want to keep it as my working display.  
If it was reversed and the VGA display scrambled until X started, it'd be 
fine, as it's clone mode until X anyway, so I could ignore the less convenient 
to look at for primary usage VGA output until I started X and the issue 
disappeared even back at the non-X text framebuffer.

> it could also be a userspace issue, since X + radeonfb on x86 hw has always
> been a works by luck solution.

The thing is, it's happening at boot, at the initial switch from whatever grub 
uses or pre-frame-buffer, to framebuffer mode, with the mode set for the VGA 
output but not the (normally cloned except in X) DVI output.  Once I login and 
start KDE, that forces the mode-switch on the DVI, and after that initial mode 
switch, everything works fine, including VT-switch from X/VT-7 to 
framebuffer/console and back, mode switches in X, etc.  It's just the initial 
switch to text mode framebuffer that screws up.  So X should have nothing to 
do with the problem since it hasn't even run at that point.  The only 
possibility is that it only triggers when the reboot was from a particular X 
mode, which does seem like it might be happening, but since it's a reboot, the 
hardware mode should be reset when entering radeon framebuffer in any case, 
and that's not happening.

-- 
Duncan - List replies preferred.   No HTML msgs.
"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--
