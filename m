From: Roger Quadros <roger.quadros@nokia.com>
Date: Mon, 15 Mar 2010 09:57:55 +0000
Subject: Re: [RFC][PATCH 1/3] OMAP: DSS2: Do regulator stuff in dpi_init_display()
Message-Id: <4B9E04A3.5050305@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1268407644-31230-1-git-send-email-roger.quadros@nokia.com>	 <1268407644-31230-2-git-send-email-roger.quadros@nokia.com> <1268645429.2417.14.camel@tubuntu.research.nokia.com>
In-Reply-To: <1268645429.2417.14.camel@tubuntu.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

Valkeinen Tomi (Nokia-D/Helsinki) wrote:

> I don't think this is quite correct. dpi_init_display() will be called
> for all DPI displays, which means that it may be called more than once.
> dpi_init() is meant for global initializations.
> 
> Perhaps it would be best to have DPI compiled conditionally like
> SDI/DSI/RFBI.
> 
OK, will do it this way. Compiled conditionally makes sense.

-roger
