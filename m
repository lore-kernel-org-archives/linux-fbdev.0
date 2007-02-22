From: James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]
Date: Thu, 22 Feb 2007 01:35:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702220119060.17121@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0702212105280.20620@pentafluge.infradead.org>
 <1172106234.4217.50.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1945934AbXBVBfK@vger.kernel.org>
In-Reply-To: <1172106234.4217.50.camel@daplas>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> On Wed, 2007-02-21 at 21:23 +0000, James Simmons wrote:
> > This is the new display intreface. Its goal is to provide a standard 
> > interface to various types of displays. Currently we have auxdisplay, 
> > output acpi device and the now defunct lcd class in the backlight directory.
> > Please apply.
> 
> Is this an attempt to consolidate all display hardware and drivers?

All display types. Its LCD panels, LCD teletypes, TVs, CRTs etc. Right now 
we have several solutions to the same problem (acpi output.c driver, auxdisplay 
directory). A good idea what this aimed at take a look at 

http://lcd4linux.sf.net

The bonus is the acpi and fbdev layer coudl use this as well.

> > +		} else {
> > +			new_dev->dev = NULL;
> > +			kfree(new_dev);
> 
> Set new_dev to NULL on failure.

Hum let me look. Okay, from what I see kfree doesn't set the the pointer 
to null. Will fix.

> > +	mutex_lock(&ddev->lock);
> > +	device_del(ddev->dev);
> > +	ddev->driver = NULL;
> > +	index--;
> 
> display0
> display1
> index = 2
> unregister display0
> index = 1
> display_device_register() as device1
> device1 <-- BUG, already used.

Ug. Will fix. 

> If this is an attempt to consolidate, I don't see the 'brightness'
> hook of backlight and lcd.
> 
> If this is not a consolidation, why don't we just extend the lcd class?

Its is a replacement for lcd. Is brightness universal for all display 
types? 
