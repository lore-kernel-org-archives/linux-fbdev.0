From: Boris Brezillon <boris.brezillon@free-electrons.com>
Date: Tue, 14 Jul 2015 11:03:53 +0000
Subject: Re: [RFC PATCH 15/15] regulator: pwm: properly initialize the ->state field
Message-Id: <20150714130353.5f5d9d69@bbrezillon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435738921-25027-1-git-send-email-boris.brezillon@free-electrons.com>
 <1435738921-25027-16-git-send-email-boris.brezillon@free-electrons.com>
 <20150714105155.GS11162@sirena.org.uk>
In-Reply-To: <20150714105155.GS11162@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 14 Jul 2015 11:51:55 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 01, 2015 at 10:22:01AM +0200, Boris Brezillon wrote:
> > The ->state field is currently initialized to 0, thus referencing the
> > voltage selector at index 0, which might not reflect the current voltage
> > value.
> 
> This looks like it'll need reworking on top of Lee's recent changes to
> implement continuous voltage support for PWM regulators - we may be
> calculating the values to set dynamically at runtime.

Yep, I was planning on doing that in the next iteration, but I'd like
to have Thierry's feedback before sending a new version.


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
