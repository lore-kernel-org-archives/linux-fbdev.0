From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/6] PM/FB/gxfb: add config option that allows disabling
 of VT switch during suspend
Date: Mon, 10 Mar 2008 16:37:44 -0700
Message-ID: <20080310163744.5f6a04b8.akpm@linux-foundation.org>
References: <20080308204927.73afa56c@ephemeral>
	<20080310145118.adb0cf1e.akpm@linux-foundation.org>
	<20080310181446.2fb85eea@ephemeral>
	<200803102328.19985.rjw@sisk.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757336AbYCJXim@vger.kernel.org>
In-Reply-To: <200803102328.19985.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andres Salomon <dilinger@queued.net>, adaplas@gmail.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, info-linux@geode.amd.com, jordan.crouse@amd.com, samuel.thibault@ens-lyon.org, Pavel Machek <pavel@ucw.cz>

On Mon, 10 Mar 2008 23:28:18 +0100 "Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > > If so, that means extra #ifdef's sprinkled throughout the code.  Note
> > > > that most framebuffer drivers won't be supporting this, and those that
> > > > do will almost certainly always want vt switching turned off..
> > > > 
> > > 
> > > I don't think you need any ifdefs or config options at all, do you?  Just
> > > add a new module parameter to this driver and some little interface into
> > > the PM core which allows the driver to set no_vt_switch?
> > > 
> > 
> > That's a possibility, but doesn't adding hooks into PM core for two
> > drivers (lxfb and gxfb) seems like overkill?  I also don't really see
> > anyone needing to switch back and forth between VT_SWITCH and
> > NO_VT_SWITCH other than to work around possible bugs in the register
> > save/restore code..
> 
> FWIW, I prefer the original .config option idea.

Please explain your reasoning?
