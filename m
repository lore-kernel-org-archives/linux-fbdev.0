From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [REVIEW  PATCH 4/9] DSS: TV-out support for OMAP2/3 DSS
Date: Wed, 5 Nov 2008 12:27:20 +0200
Message-ID: <20081105122720.251d0bbc.jarkko.nikula@nokia.com>
References: <20081104160946.19071.44903.stgit@tubuntu>
	<20081104161012.19071.11889.stgit@tubuntu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20081104161012.19071.11889.stgit@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: ext Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

On Tue, 04 Nov 2008 18:10:12 +0200
"ext Tomi Valkeinen" <tomi.valkeinen@nokia.com> wrote:

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
> 
>  arch/arm/plat-omap/dss/venc.c |  499 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 499 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/dss/venc.c
> 
> +#include <mach/board.h>
> +#include <mach/gpio.h>

Are these two includes needed?


Jarkko
