From: Ondrej Zary <linux@rainbow-software.org>
Date: Tue, 23 Aug 2011 09:03:30 +0000
Subject: Re: [RFC PATCH v2] Resurrect Intel740 driver: i740fb
Message-Id: <201108231103.30591.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201108212242.12717.linux@rainbow-software.org> <20110821233648.6d120143@lxorguk.ukuu.org.uk>
In-Reply-To: <20110821233648.6d120143@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>

On Monday 22 August 2011, Alan Cox wrote:
> > - 24bpp modes still don't work in fbtest but it looks like fbtest bug!
> >
> > Is there any better way to test fb drivers than fbtest?
>
> X11 fbdev driver ?

Thanks, completely forgot about that. It works fine even in 24bpp.

> Alan


-- 
Ondrej Zary
