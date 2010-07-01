From: Afzal Mohammed <lazfamam@gmail.com>
Date: Thu, 01 Jul 2010 13:52:00 +0000
Subject: [PATCH] OMAP:DSS2:OMAPFB: Fix probe error path
Message-Id: <1277991601-16528-1-git-send-email-lazfamam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277907327-3443-1-git-send-email-lazfamam@gmail.com>
In-Reply-To: <1277907327-3443-1-git-send-email-lazfamam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@nokia.com
Cc: ville.syrjala@nokia.com, tj@kernel.org, lazfamam@gmail.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tomi,

Is this change ok instead of having sysfs entry removal in omapfb_free_resources() ?
Hope this change makes probe look more of a remove mirror.

Regards
Afzal
