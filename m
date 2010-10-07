From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Thu, 07 Oct 2010 13:53:59 +0000
Subject: Re: [PATCH] arm/omap: simplify conditional
Message-Id: <1286459639.28499.1064.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20101005203154.0ba412d2@absol.kitzblitz>
In-Reply-To: <20101005203154.0ba412d2@absol.kitzblitz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Nicolas Kaiser <nikai@nikai.net>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2010-10-05 at 20:31 +0200, ext Nicolas Kaiser wrote:
> Simplify conditional: (a || (!a && !b)) => (a || !b)
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> ---

Thanks, applied.

 Tomi


