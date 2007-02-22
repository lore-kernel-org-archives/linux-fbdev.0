From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] fbdev driver for S3 Trio/Virge, updated
Date: Thu, 22 Feb 2007 00:53:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702220049320.17121@pentafluge.infradead.org>
References: <20070209193405.GB2637@localhost.localdomain> <1172102733.4217.38.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751376AbXBVAyK@vger.kernel.org>
In-Reply-To: <1172102733.4217.38.camel@daplas>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Jiri Slaby <jirislaby@gmail.com>


> > +/* image data is MSB-first, fb structure is MSB-first too */
> > +static inline u32 expand_color(u32 c)
> > +{
> > +	return ((c & 1) | ((c & 2) << 7) | ((c & 4) << 14) | ((c & 8) << 21)) * 0xFF;
> > +}
> > +
> > +/* s3fb_iplan_imageblit silently assumes that almost everything is 8-pixel aligned */
> 
> Hmn, same thing with vga16fb... Perhaps we should bring back the
> fontwidth flag of 2.2 and 2.4 kernels.

Ug no. It is possible to get 12,6 bit width fonts working with vga 
interleaved planes. I got it paritally working but never got back to it.
Its in my queue of this to do. Now that I finished the display class I 
need to get around to makeing drm/fbdev work together :-)
