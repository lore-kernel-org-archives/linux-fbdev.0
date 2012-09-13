From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 13 Sep 2012 08:09:55 +0000
Subject: Re: [PATCH v6 1/4] Runtime Interpreted Power Sequences
Message-Id: <20120913080953.GC20959@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347443867-18868-1-git-send-email-acourbot@nvidia.com>
 <1347443867-18868-2-git-send-email-acourbot@nvidia.com>
In-Reply-To: <1347443867-18868-2-git-send-email-acourbot@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Leela Krishna Amudala <l.krishna@samsung.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org

On Wed, Sep 12, 2012 at 06:57:44PM +0900, Alexandre Courbot wrote:
> Some device drivers (panel backlights especially) need to follow precise
> sequences for powering on and off, involving gpios, regulators, PWMs
> with a precise powering order and delays to respect between each steps.
> These sequences are board-specific, and do not belong to a particular
> driver - therefore they have been performed by board-specific hook
> functions to far.

It does make me a little sad that the DT bindings need to specify the
number of steps but otherwise this looks good (modulo the minor comments
Stephen had as well):

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I think regardless of the current discussion about some of the
applications (like pwm-backlight) there are going to be cases where this
is useful even if it ends up being more as library code for drivers than 
as something that users work with directly.
