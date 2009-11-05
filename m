From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] added brightness feature to lcd class.
Date: Thu, 5 Nov 2009 20:27:25 +0100
Message-ID: <20091105192725.GE1392@ucw.cz>
References: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758688AbZKET1a@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: InKi Dae <daeinki@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

On Mon 2009-11-02 17:50:02, InKi Dae wrote:
> This patch adds brightness feature to lcd class.
> (kernel/driver/video/backlight/lcd.c)
> 
> In the past, most of the lcd panels for embedded system was TFT-LCD
> Panel needing backlight device.
> But now AMOLED LCD Panel appeared so we should consider brightness
> control for AMOLED Panel.
> 
> For the time being, I used backlight fake driver for brightness
> control of AMOLED LCD Panel.
> But this way is not good, so I propose to add brightness feature to lcd class.
>

Why is it 'not good'? Using backlight driver seems like way to go to
me.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
