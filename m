From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] added brightness feature to lcd class.
Date: Mon, 9 Nov 2009 15:18:36 -0800
Message-ID: <20091109151836.4a6b294d.akpm@linux-foundation.org>
References: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755159AbZKIXTq@vger.kernel.org>
In-Reply-To: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: InKi Dae <daeinki@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, Richard Purdie <rpurdie@rpsys.net>

On Mon, 2 Nov 2009 17:50:02 +0900
InKi Dae <daeinki@gmail.com> wrote:

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
> For this, I attached patch file and if my proposal is approved
> Then I will send s6e63m0 and tl2796 AMOLED lcd panel driver based on
> lcd class modified soon.

Please send the s6e63m0 and tl2796 patches anyway.  That way we have
some examples of how this new capability is used by drivers.
