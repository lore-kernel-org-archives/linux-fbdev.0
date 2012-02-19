From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 19 Feb 2012 22:40:05 +0000
Subject: Re: [PATCH 00/13] sa1100fb cleanups
Message-Id: <4F417A45.8040106@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Russell,

On 02/04/2012 09:37 AM, Russell King - ARM Linux wrote:
> Here's another bunch of SA11x0 stuff - its framebuffer driver.  This
> set of patches fixes some section mismatch warnings, moves the board
> configuration out to the board files, converts the Shannon stuff to
> use gpiolib rather than poking at GPDR/GPSR/GPCR directly.
> 
> The function hooks for LCD and backlight power control are moved into
> the platform data passed from the board, eliminating the global function
> pointers.

This series looks good to me.
Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

> This series will conflict with the previous series (in the case of
> Assabet, the conflict is quite large) so I'd prefer to keep this in my
> tree for the next merge window.

Sure, feel free to proceed with this series as you like.


Best regards,

Florian Tobias Schandinat
