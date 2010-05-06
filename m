From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] OMAP: DSS2: omap_dss_probe() conditional compilation cleanup
Date: Thu, 06 May 2010 11:52:51 -0700
Message-ID: <874oikvp4s.fsf@deeprootsystems.com>
References: <cover.1273146321.git.ext-jani.1.nikula@nokia.com>
	<cover.1273146321.git.ext-jani.1.nikula@nokia.com>
	<bce34ed2a9f7206ddeedb2921807c7602cfcaaaa.1273146322.git.ext-jani.1.nikula@nokia.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <bce34ed2a9f7206ddeedb2921807c7602cfcaaaa.1273146322.git.ext-jani.1.nikula@nokia.com> (Jani Nikula's message of "Thu\,  6 May 2010 14\:59\:02 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: Tomi.Valkeinen@nokia.com, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

Jani Nikula <ext-jani.1.nikula@nokia.com> writes:

> From: Jani Nikula <ext-jani.1.nikula@nokia.com>
>
> Move a number of #ifdefs from code into dss.h and elsewhere, and
> conditionally define no-op static inline functions, cleaning up the
> code. This style is according to Documentation/SubmittingPatches.
>
> Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>

Indeed, this helps readability greatly.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
