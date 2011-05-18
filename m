From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 18 May 2011 11:26:47 +0000
Subject: Re: [PATCH 2/2] trivial: Changed the printk loglevel when not able
Message-Id: <20110518112647.GA15386@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1305653342.2182.15.camel@anish-desktop> <BANLkTi=AGbuU-jyhqaSF+yXA3qQuKVLWfA@mail.gmail.com> <BANLkTi=ngJiMyVt4AMqcWUSUM2EVXtjRQQ@mail.gmail.com> <1305713710.11468.39.camel@e102109-lin.cambridge.arm.com> <BANLkTinZ6d1=58Y0SCL72Jh3F6R8yfqE-Q@mail.gmail.com> <20110518112436.GH5913@n2100.arm.linux.org.uk>
In-Reply-To: <20110518112436.GH5913@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: anish singh <anish198519851985@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, lethal@linux-sh.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, May 18, 2011 at 12:24:36PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 18, 2011 at 04:27:47PM +0530, anish singh wrote:
> > Got it.So should i change both as KERN_WARN and resend?
> 
> Much better would be to change it to pr_warn() or even
> dev_warn(&dev->dev, ...).

Actually, make that pr_err() or dev_err().  Both printks in clcdfb_probe()
are errors and so should be reported at error severity - they cause things
to stop working and so they're not just a warning.
