From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Mon, 15 Mar 2010 09:32:26 +0000
Subject: Re: [RFC][PATCH 2/3] OMAP: DSS2: Prevent recursive Panel
Message-Id: <1268645546.2417.15.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com>
	 <1268407644-31230-3-git-send-email-roger.quadros@nokia.com>
In-Reply-To: <1268407644-31230-3-git-send-email-roger.quadros@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Quadros Roger (Nokia-D/Helsinki)" <roger.quadros@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2010-03-12 at 16:27 +0100, Quadros Roger (Nokia-D/Helsinki)
wrote:
> From: Roger Quadros <roger.quadros@nokia.com>
> 
> Panel enable/disable is now done inside display manager,
> so don't need to do it again.
> 

This looks correct, thanks.

 Tomi


