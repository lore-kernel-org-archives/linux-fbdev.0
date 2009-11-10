From: Richard Purdie <rpurdie@linux.intel.com>
Subject: Re: [patch] added brightness feature to lcd class.
Date: Tue, 10 Nov 2009 08:43:17 +0000
Message-ID: <1257842597.29038.162.camel@dax.rpnet.com>
References: <90b950fc0911020050q3bc3fae8j954ec6ed73d79b5@mail.gmail.com>
	 <1257809705.29038.82.camel@dax.rpnet.com>
	 <90b950fc0911091926v32dc1c44n1018322390282bc0@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752950AbZKJIqg@vger.kernel.org>
In-Reply-To: <90b950fc0911091926v32dc1c44n1018322390282bc0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: InKi Dae <daeinki@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

On Tue, 2009-11-10 at 12:26 +0900, InKi Dae wrote:
> Thank you for your comments.
> 
> it is a good idea that lcd driver registers interfaces to lcd class
> and backlight class.
> but I think for AMOLED LCD Panel, backlight couldn't be real device so
> power on/off
> for backlight device doesn't make sense.

The backlight power control can just turn the backlight level down to
its lowest setting (off)?

> I had tried lcd driver registers interfaces to lcd class and backlight
> class as you said.
> and also backlight fake driver as Pavel said.

So you've tried this, what was the problem? Perhaps post this driver
code to illustrate your problem?

> but I thought to use my patch is more simple and effective.
> of course, this patch has a problem that it has different path from
> backlight class
> for controlling brightness.
> 
> how about creating symbolic link file for competiability?

Creating two ways to do something (with or without symlinks) is not
simple and effective for anything other than your driver.

Cheers,

Richard
