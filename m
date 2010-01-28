From: Oliver Neukum <oliver@neukum.org>
Date: Thu, 28 Jan 2010 07:47:50 +0000
Subject: Re: [PATCH] hid: Logitech G13 driver 0.0.4
Message-Id: <201001280847.50445.oliver@neukum.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201001202047.o0KKlMTr014003@mustang.cs.nmsu.edu> <8512e098224714ed7d54c62b46346796.squirrel@intranet.cs.nmsu.edu> <20100128072425.GA25633@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20100128072425.GA25633@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, jayakumar.lkml@gmail.com, linux-fbdev@vger.kernel.org, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

 Am Donnerstag, 28. Januar 2010 08:24:26 schrieben Sie:
> > Again, like I said, I don't have a problem changing it. If it's wrong,
> > it's wrong no matter how many other drivers may take the same
> > approach.
> 
> I believe it is wrong.

So do I. You need not fail if copy_to_user() fails, but if you go
that route you need to evaluate the return value of copy_to_user()
and return:

not_written = copy_to_user(...);
return to_be_written - not_written ? to_be_written - not_written : -EFAULT;

	Regards
		Oliver
