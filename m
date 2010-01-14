From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 14 Jan 2010 21:03:39 +0000
Subject: Re: Best way to post Logitech G13 driver 0.0.4?
Message-Id: <20100114210339.GA16205@elf.ucw.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001071623.o07GNOB4022157@mustang.cs.nmsu.edu>
 <45a44e481001071832q40d6f913w2ccf89c4c45a692a@mail.gmail.com>
 <5370b38ca0c149470c0e364627c56ee4.squirrel@intranet.cs.nmsu.edu>
 <alpine.LNX.2.00.1001091441180.7275@pobox.suse.cz>
 <cf0603d7c734f836f0b4a64815d649ae.squirrel@intranet.cs.nmsu.edu>
 <fbd89f64a86fc72184658fe9b27509f3.squirrel@intranet.cs.nmsu.edu>
In-Reply-To: <fbd89f64a86fc72184658fe9b27509f3.squirrel@intranet.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, Andrew Morton <akpm@linux-foundation.org>, linux-usb@vger.kernel.org, Oliver Neukum <oliver@neukum.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu 2010-01-14 13:50:49, Rick L. Vinyard, Jr. wrote:
> What would be the best way to post 0.0.4 of the driver; as a diff against
> the previous 0.0.3 patch to emphasize the changes or as a diff against the
> torvalds tree to show the patch in its entirety?

Diff against linus tree. If you want to be fancy, make it series with
first patch adding input functionality, second fbcon output on top of
that, third led interface, etc.
									Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
