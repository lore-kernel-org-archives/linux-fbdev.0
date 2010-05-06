From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP: DSS2: Fix omap_dss_probe() error path
Date: Thu, 06 May 2010 11:54:40 -0700
Message-ID: <87wrvguahb.fsf@deeprootsystems.com>
References: <cover.1273146321.git.ext-jani.1.nikula@nokia.com>
	<bce34ed2a9f7206ddeedb2921807c7602cfcaaaa.1273146322.git.ext-jani.1.nikula@nokia.com>
	<cover.1273146321.git.ext-jani.1.nikula@nokia.com>
	<2af519336cb42682d13d46baf0b770edcada3dac.1273146322.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <2af519336cb42682d13d46baf0b770edcada3dac.1273146322.git.ext-jani.1.nikula@nokia.com> (Jani Nikula's message of "Thu\,  6 May 2010 14\:59\:03 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: Tomi.Valkeinen@nokia.com, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

Jani Nikula <ext-jani.1.nikula@nokia.com> writes:

> From: Jani Nikula <ext-jani.1.nikula@nokia.com>
>
> Perform graceful cleanup on errors instead of just bailing out.
>
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

Nice.  Much cleaner than my previous one.

Tested on my n900, and with failed init, clocks are turned off
and doesn't prevent suspend.

Thanks,

Kevin
