From: Matt Mackall <mpm@selenic.com>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Fri, 21 Jan 2005 16:52:09 -0800
Message-ID: <20050122005209.GN12076@waste.org>
References: <20050120232122.GF3867@waste.org> <20050120153921.11d7c4fa.akpm@osdl.org> <20050120234844.GF12076@waste.org> <20050120160123.14f13ca6.akpm@osdl.org> <20050121035758.GH12076@waste.org> <20050120200530.4d5871f9.akpm@osdl.org> <20050120200711.4313dbcc.akpm@osdl.org> <20050121060928.GI12076@waste.org> <Pine.LNX.4.61.0501211315010.6118@scrub.home>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262584AbVAVAzD@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501211315010.6118@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Fri, Jan 21, 2005 at 01:33:39PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 20 Jan 2005, Matt Mackall wrote:
> 
> > On Thu, Jan 20, 2005 at 08:07:11PM -0800, Andrew Morton wrote:
> > > Andrew Morton <akpm@osdl.org> wrote:
> > > >
> > > > Next suspects would be:
> > > > 
> > > >  +cleanup-vc-array-access.patch
> > > >  +remove-console_macrosh.patch
> > > >  +merge-vt_struct-into-vc_data.patch
> > > > 
> > > > 
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

Same behaviour.

-- 
Mathematics is the supreme nostalgia of our time.
