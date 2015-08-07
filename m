From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 07 Aug 2015 05:34:21 +0000
Subject: Re: [PATCH] video: fbdev: atmel: fix warning for const return value
Message-Id: <20150807052221.GC3537@sudip-pc>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438011701-18423-1-git-send-email-robh@kernel.org>
In-Reply-To: <1438011701-18423-1-git-send-email-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

On Mon, Jul 27, 2015 at 10:41:41AM -0500, Rob Herring wrote:
> A const on a return value is meaningless and generates a warning on some
> versions of gcc:
> 
> drivers/video/fbdev/atmel_lcdfb.c:1003: warning: type qualifiers ignored on function return type
maybe this one should have been static instead of const.

regards
sudip
