From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 28 Oct 2010 23:19:38 +0000
Subject: Re: [PATCH 2/4] fbdev: export fb_edid_add_monspecs() for modules,
Message-Id: <20101028161938.dccf018b.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1010281431560.1257@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010281431560.1257@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 28 Oct 2010 14:34:48 +0200 (CEST)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:

> +EXPORT_SYMBOL(fb_edid_add_monspecs);

Fooled me again!

Please check the edid[2] thing..
