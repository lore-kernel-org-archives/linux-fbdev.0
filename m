From: Matt Mackall <mpm@selenic.com>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Thu, 20 Jan 2005 19:57:58 -0800
Message-ID: <20050121035758.GH12076@waste.org>
References: <20050120232122.GF3867@waste.org> <20050120153921.11d7c4fa.akpm@osdl.org> <20050120234844.GF12076@waste.org> <20050120160123.14f13ca6.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262261AbVAUD6N@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050120160123.14f13ca6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

On Thu, Jan 20, 2005 at 04:01:23PM -0800, Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> >
> > > Which radeon driver? CONFIG_FB_RADEON_OLD or CONFIG_FB_RADEON?
> > 
> > FB_RADEON.
> 
> Ah, OK.  Likely culprits are
> 
> radeonfb-massive-update-of-pm-code.patch
> radeonfb-build-fix.patch

Ok, learned a few things.

Here are the symptoms:

mm2: corruption of Tux logo at boot, corruption of display at
powerdown, lockup and LCD blooming on next warm boot when radeonfb
starts. Ben suggested I try some radeonfb options, but none seemed to
have any effect.

mm1: no observed problems

mm2 - above patches: corruption still occurs but no lockup on next
warm boot.

I think I have a lead on the logo and shutdown corruption:

If I do a reboot(8) from inside X, I get switched to vt 0, but the
shutdown messages come out on vt 7, where X was running. As I'm
sitting on vt 0 during shutdown, I see character cells changed to
something like "_" (last two scanlines filled) slowly marching down
the screen corresponding to the shutdown messages.

So the logo corruption is probably getty popping up on the
other vts at the end of init. The timing and the screen placement seem
to agree.

Photos for the curious (be sure to see "executioner Tux" glitch):
http://selenic.com/radeon

-- 
Mathematics is the supreme nostalgia of our time.
