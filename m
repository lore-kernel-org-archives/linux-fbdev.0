From: Matt Mackall <mpm@selenic.com>
Subject: Re: Radeon framebuffer weirdness in -mm2
Date: Thu, 20 Jan 2005 22:09:28 -0800
Message-ID: <20050121060928.GI12076@waste.org>
References: <20050120232122.GF3867@waste.org> <20050120153921.11d7c4fa.akpm@osdl.org> <20050120234844.GF12076@waste.org> <20050120160123.14f13ca6.akpm@osdl.org> <20050121035758.GH12076@waste.org> <20050120200530.4d5871f9.akpm@osdl.org> <20050120200711.4313dbcc.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262262AbVAUGJj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050120200711.4313dbcc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

On Thu, Jan 20, 2005 at 08:07:11PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Next suspects would be:
> > 
> >  +cleanup-vc-array-access.patch
> >  +remove-console_macrosh.patch
> >  +merge-vt_struct-into-vc_data.patch
> > 
> > 
> 
> Make that:
> 
> +cleanup-vc-array-access.patch
> +remove-console_macrosh.patch
> +merge-vt_struct-into-vc_data.patch
> +vgacon-fixes-to-help-font-restauration-in-x11.patch

It's something in this batch. Which is good, as I'd be a bit
disappointed if the "vt leakage" were somehow attributable to the fb
layer. More bisection after dinner.

-- 
Mathematics is the supreme nostalgia of our time.
