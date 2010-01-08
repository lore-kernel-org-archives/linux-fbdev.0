From: Pavel Machek <pavel@ucw.cz>
Date: Fri, 08 Jan 2010 17:04:50 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.3
Message-Id: <20100108170450.GB8328@elf.ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>
 <20100108083020.GB3696@core.coreip.homeip.net>
 <20100108163655.GA8328@elf.ucw.cz>
 <a3581fd32d39b5e86aba9ded88bd5f46.squirrel@intranet.cs.nmsu.edu>
In-Reply-To: <a3581fd32d39b5e86aba9ded88bd5f46.squirrel@intranet.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, jkosina@suse.cz

On Fri 2010-01-08 09:50:33, Rick L. Vinyard, Jr. wrote:
> Pavel Machek wrote:
> > Hi!
> >
> >> > +static DEVICE_ATTR(name, 0666, g13_name_show, g13_name_store);
> >>
> >> What this attribute is for?
> >
> > Actually, all the new files this added need to be documented.
> 
> Which is better? A hid-g13.txt file added to Documentation/ or comments in
> the driver itself?

Documentation. Coordinate with sysfs maintainer (gregkh).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
