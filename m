From: Oliver Neukum <oneukum@suse.com>
Date: Thu, 09 Nov 2017 12:36:16 +0000
Subject: Re: [RFC 00/14] Kernel based bootsplash
Message-Id: <1510230976.2975.10.camel@suse.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171025124602.28292-1-mstaudt@suse.de>
         <20171109115655.GA18436@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20171109115655.GA18436@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>, Max Staudt <mstaudt@suse.de>
Cc: michal@markovi.net, b.zolnierkie@samsung.com, Michal Srb <MSrb@suse.com>, Stefan Dirsch <sndirsch@suse.com>, Takashi Iwai <tiwai@suse.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Am Donnerstag, den 09.11.2017, 12:56 +0100 schrieb Pavel Machek:
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

Hi,

well you are not required to use a boot splash. Though I note that
many people want a boot splash. However, if you use a boot splash
at all, you will not see the messages, so how does it matter to you
if it comes out of the initrd?

And of course we want a reliable boot, but that is an orthogonal issue.
And this solution is more reliable than plymouth.

	Regards
		Oliver

