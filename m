From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 03 Mar 2010 00:19:19 +0000
Subject: Re: [PATCH] Add sysfs support for fbdefio delay
Message-Id: <20100302161919.19df3a18.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201003021847.o22IlYR8004349@mustang.cs.nmsu.edu>
In-Reply-To: <201003021847.o22IlYR8004349@mustang.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>
Cc: linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, pavel@ucw.cz, jayakumar.lkml@gmail.com, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, npavel@ituner.com, tomi.valkeinen@nokia.com, tony@atomide.com, FlorianSchandinat@gmx.de, krzysztof.h1@wp.pl, linux-fbdev@vger.kernel.org, jkosina@suse.cz, bonbons@linux-vserver.org

On Tue, 02 Mar 2010 11:47:34 -0700
"Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu> wrote:

> This patch adds support for examining and modifying the fbdefio delay
> parameter through sysfs. It also adds two driver definable minimum
> and maximum bounds.
> 
> The default behavior is to not permit modifications if delay_max is 0,
> thus preventing modification of the delay if the driver does not
> explicitly permit modification.

Why is this being added?  You have some device which doesn't function
properly without this change?

If so, that's pretty critical changelog info - we presently have no
reason to merge the patch!

Thanks.

