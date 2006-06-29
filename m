From: Pavel Machek <pavel@ucw.cz>
Subject: Re: radeonfb: corrupted screen on bootup
Date: Thu, 29 Jun 2006 19:19:03 +0200
Message-ID: <20060629171852.GA3340@elf.ucw.cz>
References: <200606282118.27750.mb@bu3sch.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751072AbWF2RTR@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200606282118.27750.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Buesch <mb@bu3sch.de>
Cc: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi!

> I have a weird error with my PowerBook G4, which
> has a radeon card. I am using radeonfb.
> After bootup, the screen sometimes looks like it is melting.
> I made a video to show you what is going on:
> http://bu3sch.de/misc/after_boot.avi  (6.1 MB)

I did not see the video (slow link here)... but if you turn off LCD
while keeping backlight on, you get very interesting "burning screen"
effect. I suspect that might be it. It will not damage anything.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
