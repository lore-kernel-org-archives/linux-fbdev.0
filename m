From: Takashi Iwai <tiwai@suse.de>
Date: Thu, 09 Nov 2017 12:42:51 +0000
Subject: Re: [RFC 00/14] Kernel based bootsplash
Message-Id: <s5hr2t7ei7o.wl-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
        <20171109115655.GA18436@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20171109115655.GA18436@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Max Staudt <mstaudt@suse.de>, michal@markovi.net, b.zolnierkie@samsung.com, Michal Srb <MSrb@suse.com>, Oliver Neukum <ONeukum@suse.com>, Stefan Dirsch <sndirsch@suse.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 09 Nov 2017 12:56:55 +0100,
Pavel Machek wrote:
> 
> Hi!
> 
> > Dear fbdev and fbcon developers,
> > 
> > Could you please voice your opinion on the following patch series?
> > 
> > 
> > This series adds simple bootsplash functionality on top of fbcon.
> > 
> > A (simple!) kernel based bootsplash allows system integrators to show an
> > earlier and more reliable bootsplash, completely hiding the kernel's
> > text output and VT (the 'quiet' option still displays warnings and a
> > blinking cursor).
> 
> "More reliable bootsplash" seems like an anti-goal. More reliable boot
> should be the goal...
> 
> You should be able to display nice splash screen from initrd...
> 
> We may want to fix the blinking cursor.
> 
> But if there are warnings, it is better to see the warnings then to
> hide them. If root filesystem can't be mounted (for example) it is
> good to know the reason, not to stare at the blank screen (or at boot splash).

In theory, we can put a bootsplash_disable() call automatically when
the certain level of kernel message appears, too.  It's a question
whether such behavior should be dynamically configurable or not,
though.

BTW, one thing that is bad with quiet boot option is that it hides
always messages and shows only errors.  With this bootsplash scenario,
you can boot without quiet option.  Once when the splash turned off
(either by user action like key input or by some kernel trigger),
you'll see the whole messages, thus have far more information there.


thanks,

Takashi
