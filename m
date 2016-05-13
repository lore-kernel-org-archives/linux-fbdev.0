From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Fri, 13 May 2016 22:05:24 +0000
Subject: Re: [PATCH v3 update 4/4] Thermal: add INT3406 thermal driver
Message-Id: <5104945.McBGKbKeb7@vostro.rjw.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com> <20160509075458.GA8945@aaronlu.sh.intel.com> <1462867730.25391.2.camel@rzhang1-mobl4>
In-Reply-To: <1462867730.25391.2.camel@rzhang1-mobl4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>, "Lu, Aaron" <aaron.lu@intel.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, May 10, 2016 08:08:52 AM Zhang, Rui wrote:
> On Mon, 2016-05-09 at 15:54 +0800, Aaron Lu wrote:
> > INT3406 ACPI device object resembles an ACPI video output device, but its
> > _BCM is said to be deprecated and should not be used. So we will make
> > use of the raw interface to do the actual cooling.
> > 
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied, thanks!

