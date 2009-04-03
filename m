From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] fbdev: move logo externs to header file
Date: Fri, 3 Apr 2009 15:45:40 +0200
Message-ID: <20090403134540.GA16066@uranus.ravnborg.org>
References: <alpine.LRH.2.00.0904031157550.32353@vixen.sonytel.be> <20090403123143.GA15598@uranus.ravnborg.org> <alpine.LRH.2.00.0904031537250.32353@vixen.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765516AbZDCNnz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.0904031537250.32353@vixen.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Krzysztof Helt <krzysztof.h1@wp.pl>, Andrew Morton <akpm@linux-foundation.org>, James Simmons <jsimmons@infradead.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, Apr 03, 2009 at 03:38:37PM +0200, Geert Uytterhoeven wrote:
> On Fri, 3 Apr 2009, Sam Ravnborg wrote:
> > On Fri, Apr 03, 2009 at 01:45:40PM +0200, Geert Uytterhoeven wrote:
> > > Now we have __initconst, we can finally move the external declarations for the
> > > various Linux logo structures to <linux/linux_logo.h>.
> > > 
> > > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > > Acked-By: James Simmons <jsimmons@infradead.org>
> > > ---
> > > James' ack dates back to the previous submission (way to long ago), when the
> > > logos were still __initdata, which caused failures on some platforms with some
> > > toolchain versions.
> > > 
> > > Note: you have to remove the generated logos, as they're not automatically
> > > regenerated if scripts/pnmtologo.c changes.
> > 
> > Something like this to fix that bug?
> 
> Yep, after s/pnmtlogo/pnmtologo/g
> (it cannot work as-is, as there's one place where you did spell `pnmtologo'
>  correctly ;-)
> 
> Acked-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

I assume you take the patch - no?

	Sam
