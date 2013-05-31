From: Timur Tabi <timur@tabi.org>
Date: Fri, 31 May 2013 15:06:43 +0000
Subject: Re: [PATCH v3 7/8] video: xilinxfb: Fix sparse warnings
Message-Id: <51A8BC83.6050809@tabi.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1370004925.git.michal.simek@xilinx.com> <51A8A89C.8030404@tabi.org> <51A8B220.6070308@monstr.eu> <1466524.sgAzczhnBg@wuerfel>
In-Reply-To: <1466524.sgAzczhnBg@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: monstr@monstr.eu, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

On 05/31/2013 09:56 AM, Arnd Bergmann wrote:
> Yes, unfortunately, this is what all other frame buffer drivers do
> at the moment. It is technically not correct, but most architectures
> are able to call readl/writel on regular memory, or dereference
> __iomem tokens, so we often get away with it. It's probably not
> worth fixing it in the fbdev code base as that would be a huge
> change, and people are migrating to DRM/KMS.

But why bother fixing this bug if it just makes things worse?  Sparse is
supposed to warn us about bad code.  This patch doesn't fix the bug, it
just masks the warnings!

-- 
Timur Tabi
