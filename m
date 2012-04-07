From: Ondrej Zary <linux@rainbow-software.org>
Date: Sat, 07 Apr 2012 11:38:27 +0000
Subject: Re: [PATCH] kyrofb: fix on x86_64
Message-Id: <201204071338.30521.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203212336.55396.linux@rainbow-software.org> <20120322000104.GB26543@linux-sh.org>
In-Reply-To: <20120322000104.GB26543@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Thursday 22 March 2012 01:01:05 Paul Mundt wrote:
> On Wed, Mar 21, 2012 at 11:36:50PM +0100, Ondrej Zary wrote:
> > kyrofb is completely broken on x86_64 because the registers are defined
> > as unsigned long. Change them to u32 to make the driver work.
> > Tested with Hercules 3D Prophet 4000XT.
> >
> > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
>
> Looks fine to me.
>
> Acked-by: Paul Mundt <lethal@linux-sh.org>

When will this go in?

-- 
Ondrej Zary
