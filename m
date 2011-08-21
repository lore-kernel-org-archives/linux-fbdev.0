From: Andi Kleen <andi@firstfloor.org>
Date: Sun, 21 Aug 2011 22:13:27 +0000
Subject: Re: [RFC PATCH v2] Resurrect Intel740 driver: i740fb
Message-Id: <m24o1ae7lk.fsf@firstfloor.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108212242.12717.linux@rainbow-software.org>
In-Reply-To: <201108212242.12717.linux@rainbow-software.org> (Ondrej Zary's
	message of "Sun, 21 Aug 2011 22:42:06 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

Ondrej Zary <linux@rainbow-software.org> writes:
>
> The i740_calc_fifo() function formatting is nice but does not pass
> checkpatch. Making it checkpatch-compliant makes the code look ugly. How to
> make it both nice and compatible with Linux coding style?

When checkpatch.pl and sanity conflict, sanity should generally win.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
