From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 09 Nov 2017 11:56:55 +0000
Subject: Re: [RFC 00/14] Kernel based bootsplash
Message-Id: <20171109115655.GA18436@atrey.karlin.mff.cuni.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
In-Reply-To: <20171025124602.28292-1-mstaudt@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Staudt <mstaudt@suse.de>
Cc: b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org, tiwai@suse.com, oneukum@suse.com, msrb@suse.com, sndirsch@suse.com, michal@markovi.net, linux-kernel@vger.kernel.org

Hi!

> Dear fbdev and fbcon developers,
> 
> Could you please voice your opinion on the following patch series?
> 
> 
> This series adds simple bootsplash functionality on top of fbcon.
> 
> A (simple!) kernel based bootsplash allows system integrators to show an
> earlier and more reliable bootsplash, completely hiding the kernel's
> text output and VT (the 'quiet' option still displays warnings and a
> blinking cursor).

"More reliable bootsplash" seems like an anti-goal. More reliable boot
should be the goal...

You should be able to display nice splash screen from initrd...

We may want to fix the blinking cursor.

But if there are warnings, it is better to see the warnings then to
hide them. If root filesystem can't be mounted (for example) it is
good to know the reason, not to stare at the blank screen (or at boot splash).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
