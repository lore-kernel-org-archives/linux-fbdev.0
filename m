From: Olaf Hering <olaf@aepfle.de>
Date: Thu, 28 Feb 2013 15:16:41 +0000
Subject: Re: [PATCH RFC] video: Add Hyper-V Synthetic Video Frame Buffer Driver
Message-Id: <20130228151641.GA13552@aepfle.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1360955396-14183-1-git-send-email-haiyangz@microsoft.com>
In-Reply-To: <1360955396-14183-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: FlorianSchandinat@gmx.de, linux-fbdev@vger.kernel.org, kys@microsoft.com, jasowang@redhat.com, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org

On Fri, Feb 15, Haiyang Zhang wrote:

> +	if (fb_get_options("hyperv_fb", &opt) || !opt || !*opt)

> +	strcpy(info->fix.id, "hyperv");


Here is a mismatch between video=<optname> and /proc/fb output.
Both should have the same string IMO.

Olaf
