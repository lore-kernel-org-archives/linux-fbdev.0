From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev driver for S3 Trio/Virge, updated
Date: Thu, 01 Mar 2007 05:35:28 +0800
Message-ID: <1172698528.21204.6.camel@daplas>
References: <20070209193405.GB2637@localhost.localdomain>
	 <1172102733.4217.38.camel@daplas>
	 <Pine.LNX.4.64.0702220049320.17121@pentafluge.infradead.org>
	 <1172106505.4217.54.camel@daplas>
	 <Pine.LNX.4.64.0702281652290.14127@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932267AbXB1Vd1@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0702281652290.14127@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Jiri Slaby <jirislaby@gmail.com>

On Wed, 2007-02-28 at 16:53 +0000, James Simmons wrote:
> > On Thu, 2007-02-22 at 00:53 +0000, James Simmons wrote:
> > > > > +/* image data is MSB-first, fb structure is MSB-first too */
> > > > > +static inline u32 expand_color(u32 c)
> > > > > +{
> > > > > +	return ((c & 1) | ((c & 2) << 7) | ((c & 4) << 14) | ((c & 8) << 21)) * 0xFF;
> > > > > +}
> > > > > +
> > > > > +/* s3fb_iplan_imageblit silently assumes that almost everything is 8-pixel aligned */
> > > > 
> > > > Hmn, same thing with vga16fb... Perhaps we should bring back the
> > > > fontwidth flag of 2.2 and 2.4 kernels.
> > > 
> > > Ug no. It is possible to get 12,6 bit width fonts working with vga 
> > > interleaved planes. I got it paritally working but never got back to it.
> > > Its in my queue of this to do. Now that I finished the display class I 
> > > need to get around to makeing drm/fbdev work together :-)
> > > 
> > 
> > Of course, not fontwidth exactly, but to allow the driver to specify the
> > alignment of the blit engine, in this case 8 pixels. I do believe X also
> > has similar functionality to compensate for the limitation of the
> > hardware.
> 
> Isn't scan_align in pixmap for this? Or do we need more.

No, scan_align is how much to pad each line, and it's up to the engine
to discard the padding.  In this case, the hardware does not allow
padding and must be given data in exact multiples. For example, vesafb
can accept 4x4 fonts padded to 8x4, but vga16fb will not be able to draw
4x4 fonts properly.

Tony
