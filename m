From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Date: Thu, 01 Jul 2010 14:57:18 +0000
Subject: Re: [PATCH] OMAP:DSS2:OMAPFB: Fix probe error path
Message-Id: <1277996239.2474.354.camel@tubuntu.research.nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277991601-16528-1-git-send-email-lazfamam@gmail.com>
	 <1277991601-16528-2-git-send-email-lazfamam@gmail.com>
In-Reply-To: <1277991601-16528-2-git-send-email-lazfamam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ext Afzal Mohammed <lazfamam@gmail.com>
Cc: "Syrjala Ville (Nokia-MS/Helsinki)" <ville.syrjala@nokia.com>, "tj@kernel.org" <tj@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2010-07-01 at 15:40 +0200, ext Afzal Mohammed wrote:
> Move sysfs entry creation to omapfb_probe() from omapfb_create_framebuffers().
> This will make sure that sysfs entry is not left behind in case of unsuccessful
> probe due to failure in enabling fb0 of omapfb_create_framebuffers().

Yes, I think this version is ok. Thanks!

 Tomi


