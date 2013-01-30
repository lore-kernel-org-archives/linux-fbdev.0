From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 30 Jan 2013 22:27:03 +0000
Subject: Re: BUG: circular locking dependency detected
Message-Id: <CAKMK7uGukLQ31vsg9g-cWuyOiddiEhF0T7j6VgC92i3qpsZ+gw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130130200648.GA13298@flint.arm.linux.org.uk>
	<20130130215211.GA28418@flint.arm.linux.org.uk>
	<CAKMK7uHEggaGfLTq4c3MfY7csQSFpb=kRwdbJUQMN9Cz9K=V4A@mail.gmail.com>
	<20130130221946.GA14801@flint.arm.linux.org.uk>
In-Reply-To: <20130130221946.GA14801@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>

On Wed, Jan 30, 2013 at 11:19 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> So... what you seem to be telling me is that 3.9 is going to be a
> release which issues lockdep complaints when the console blanks, and
> you think that's acceptable?
>
> Adding Linus and Andrew so they're aware of this issue...

Linus was the guy who shot down the patches for 3.9 since one of the
earlier iterations caused instant deadlocks - I've been pushing them
to merge them ;-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
