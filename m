From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 22 Mar 2012 00:01:05 +0000
Subject: Re: [PATCH] kyrofb: fix on x86_64
Message-Id: <20120322000104.GB26543@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203212336.55396.linux@rainbow-software.org>
In-Reply-To: <201203212336.55396.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Wed, Mar 21, 2012 at 11:36:50PM +0100, Ondrej Zary wrote:
> kyrofb is completely broken on x86_64 because the registers are defined as
> unsigned long. Change them to u32 to make the driver work.
> Tested with Hercules 3D Prophet 4000XT.
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> 
Looks fine to me.

Acked-by: Paul Mundt <lethal@linux-sh.org>
