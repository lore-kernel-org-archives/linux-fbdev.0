From: Greg KH <greg@kroah.com>
Subject: Re: Display class
Date: Sat, 13 Jan 2007 23:55:14 -0800
Message-ID: <20070114075514.GE10585@kroah.com>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org> <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org> <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org> <200612292232.44122.dtor@insightbb.com> <Pine.LNX.4.64.0701132225530.18652@pentafluge.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751165AbXANIFj@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701132225530.18652@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Miguel Ojeda <maxextreme@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, oLinux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>, linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org, lcd4linux-devel@sf.net

On Sat, Jan 13, 2007 at 10:40:55PM +0000, James Simmons wrote:
> 
> > Hi,
> > 
> > On Tuesday 05 December 2006 13:03, James Simmons wrote:
> > > +int probe_edid(struct display_device *dev, void *data)
> > > +{
> > > +???????struct fb_monspecs spec;
> > > +???????ssize_t size = 45;
> 
> That code was only for testing. I do have new core code. Andrew could 
> you merge this patch as it is against the -mm tree.
> 
> This new class provides a way common interface for various types of 
> displays such as LCD, CRT, LVDS etc. It is a expansion of the lcd
> class to include other types of displays.

Have you worked with the DRM developers who also need to tie into this
CRT class somehow?

thanks,

greg k-h
