From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH RESEND] vgacon: remember scrollback buffer on console
	switch
Date: Wed, 29 Oct 2008 15:00:56 +0100
Message-ID: <20081029140056.GA1469@ucw.cz>
References: <20081025195814.GD10932@joi> <20081025134615.36f7285f.akpm@linux-foundation.org> <20081025224247.GA25497@joi>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756102AbYJ3OwH@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081025224247.GA25497@joi>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Antonino Daplas <adaplas@gmail.com>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-fbdev-devel@lists.sourceforge.net

Hi!

> > If so, it would be much much better to make this feature switchable at
> > runtime (module parameter/boot option or a /proc or /sys knob).
> 
> /sys knob seems to be the most flexible option.
> 
> /sys/class/vtconsole/vtconX/persistent_history? 0/1

0/number-of-lines-to-remember?
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
