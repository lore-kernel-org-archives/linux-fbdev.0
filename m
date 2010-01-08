From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 08 Jan 2010 17:20:51 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.3
Message-Id: <201001080920.51979.dmitry.torokhov@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu> <20100108170450.GB8328@elf.ucw.cz> <20100108171329.GA4711@kroah.com>
In-Reply-To: <20100108171329.GA4711@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, jkosina@suse.cz

On Friday 08 January 2010 09:13:29 am Greg KH wrote:
> On Fri, Jan 08, 2010 at 06:04:50PM +0100, Pavel Machek wrote:
> > On Fri 2010-01-08 09:50:33, Rick L. Vinyard, Jr. wrote:
> > > Pavel Machek wrote:
> > > > Hi!
> > > >
> > > >> > +static DEVICE_ATTR(name, 0666, g13_name_show, g13_name_store);
> > > >>
> > > >> What this attribute is for?
> > > >
> > > > Actually, all the new files this added need to be documented.
> > >
> > > Which is better? A hid-g13.txt file added to Documentation/ or comments
> > > in the driver itself?
> >
> > Documentation. Coordinate with sysfs maintainer (gregkh).
> 
> All sysfs files need to be documented in Documentation/ABI/  Please add
> the documentation there for your new sysfs files.

We need to have an agreement that all of them are needed first though.

-- 
Dmitry
