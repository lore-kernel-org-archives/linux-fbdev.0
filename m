From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2013 15:29:50 +0000
Subject: Re: [PATCH v3 7/8] video: xilinxfb: Fix sparse warnings
Message-Id: <4930944.aMQtpv2nTI@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <1466524.sgAzczhnBg@wuerfel> <51A8BC83.6050809@tabi.org>
In-Reply-To: <51A8BC83.6050809@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Timur Tabi <timur@tabi.org>
Cc: monstr@monstr.eu, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On Friday 31 May 2013 10:06:43 Timur Tabi wrote:
> On 05/31/2013 09:56 AM, Arnd Bergmann wrote:
> > Yes, unfortunately, this is what all other frame buffer drivers do
> > at the moment. It is technically not correct, but most architectures
> > are able to call readl/writel on regular memory, or dereference
> > __iomem tokens, so we often get away with it. It's probably not
> > worth fixing it in the fbdev code base as that would be a huge
> > change, and people are migrating to DRM/KMS.
> 
> But why bother fixing this bug if it just makes things worse?  Sparse is
> supposed to warn us about bad code.  This patch doesn't fix the bug, it
> just masks the warnings!

Yes, good point. It's probably best cast the ioremap() output to
a regular pointer here, as that is actually just uncached RAM,
not an MMIO register.

	Arnd
