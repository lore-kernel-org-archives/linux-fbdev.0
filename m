From: Oliver Neukum <oliver@neukum.org>
Date: Thu, 25 Feb 2010 04:11:52 +0000
Subject: Re: [PATCH 1/3] picolcd: driver for PicoLCD HID device
Message-Id: <201002250511.52284.oliver@neukum.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002001.0a7e05a7@neptune.home> <201002241927.53532.oliver@neukum.org> <ffb352764fc5a0da5cca6f3da7fc2603.squirrel@intranet.cs.nmsu.edu>
In-Reply-To: <ffb352764fc5a0da5cca6f3da7fc2603.squirrel@intranet.cs.nmsu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
Cc: Bruno =?iso-8859-1?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Nicu Pavel <npavel@ituner.com>

Am Mittwoch, 24. Februar 2010 22:44:53 schrieb Rick L. Vinyard, Jr.:
> The issue, as I understand it is that non-interrupt code may obtain the
> lock and then the interrupt code is executed... hence the deadlock and the
> need to use spin_lock_irqsave() and spin_unlock_irqrestore().

Yes.

> If that is correct, is there any problem with the following approach?

Why not always a workqueue or alternatively spin_lock_irq() when
you are not in interrupt? This approach seems needlessly complicated.

Secondly, when you hold a spinlock, you must use GFP_ATOMIC.
GFP_NOIO is insufficient.

	Regards
		Oliver
