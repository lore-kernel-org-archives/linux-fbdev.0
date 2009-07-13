From: Ali Gholami Rudi <ali@rudi.ir>
Subject: Re: [PATCH 0/2] fbdev: add fillrect and copyarea ioctls
Date: Tue, 14 Jul 2009 00:38:04 +0430
Message-ID: <20090713200804.GB1280@lilem.mirepesht>
References: <20090713151709.GA1297@lilem.mirepesht>
 <20090713163530.GA22251@suse.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756957AbZGMUGP@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090713163530.GA22251@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Philippe De Muyter <phdm@macqel.be>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
> On Mon, Jul 13, 2009 at 07:47:09PM +0430, Ali Gholami Rudi wrote:
> > Is there any reason for not adding these ioctls to fbdev?  I searched
> > the net and couldn't any.  Anyway, these patches simply implement those
> > ioctls.
> 
> Have you also added the needed 32 vs. 64 bit handlers for these ioctls?

I guess Arnd's patch will do.

By the way, it should check for overflows, too?  I mean should I change
this:

> +       if (copy->dx + copy->width > info->var.xres ||
> +           copy->sx + copy->width > info->var.xres ||
> +           copy->dy + copy->height > info->var.yres ||
> +           copy->sy + copy->height > info->var.yres) {

#define ISSUMLESSTHAN(a, b, s)	(((a) <= (s)) && ((b) <= (s)) && \
				 ((a) + (b) <= (s)))

if (!ISSUMLESSTHAN(copy->dx, copy->width, info->var.xres) || ...

	Ali
