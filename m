From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 26 Jan 2015 20:54:28 +0000
Subject: Re: [PATCH v3 2/2] fbcon: expose cursor blink interval via sysfs
Message-Id: <CAFLxGvzhaK-m4+QuBwGkdm4mQptSg7+e9DZtkhZEKpBn5gNJjw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.11.1501262034380.1945@localhost.localdomain>
	<alpine.DEB.2.11.1501262040380.2052@localhost.localdomain>
In-Reply-To: <alpine.DEB.2.11.1501262040380.2052@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Jan 26, 2015 at 9:41 PM, Scot Doyle <lkml14@scotdoyle.com> wrote:
> The fbcon cursor, when set to blink, is hardcoded to toggle display state
> five times per second. Expose this setting via
> /sys/class/graphics/fbcon/cursor_blink_ms
>
> Values written to the interface set the approximate time interval in
> milliseconds between cursor toggles, from 1 to 32767. Since the interval
> is stored internally as a number of jiffies, the millisecond value read
> from the interface may not exactly match the entered value.
>
> An outstanding blink timer is reset after a new value is entered.
>
> If the cursor blink is disabled, either via the 'cursor_blink' boolean
> setting or some other mechanism, the 'cursor_blink_ms' setting may still
> be modified. The new value will be used if the blink is reactivated.

Out of curiosity, why do you need this new setting?
Your patch describes what it does but does not describe the "why".

-- 
Thanks,
//richard
