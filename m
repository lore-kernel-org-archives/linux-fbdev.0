From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] vesafb memory size mismatch
Date: Mon, 4 Oct 2004 11:27:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20041004092730.GA4552@bytesex>
References: <20041001153624.267a808b@homer.gnuage.org> <87acv6l9ru.fsf@bytesex.org> <200410020422.15936.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267968AbUJDKlH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200410020422.15936.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>

> > +	/*   size_total -- all video memory we have. Used for mtrr
> > +	 *                 entries and bounds checking. */
> > +	size_total = screen_info.lfb_size * 65536;
> > +	if (size_total < size_vmode)
> > +		size_total = size_vmode;
> > +	if (vram)
> > +		size_total = vram * 1024 * 1024;

> Probably a typo, but shouldn't it be...
> 
> size_remap = size_vmode * 2;
> if (vram)
> 	size_remap = vram * 1024 * 1024;
> if (size_remap > size_total)
> 	size_remap = size_total

No, it's intentional.  Some bioses seem to report bogous values for the
total amount of memory, so you can use vram to fixup that.  The
"size_total < size_vmode" check which is kida silly is there for the
very same reason: on a bug-free bios it should never ever trigger, but
looks like it is needed neverless.

We might want to add another parameter to allow the user to adjust
size_remap through.  I'll prepare an updated patch one later today,
with other issue (line_length != width * depth) fixed as well.

  Gerd

-- 
return -ENOSIG;
