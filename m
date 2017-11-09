From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 09 Nov 2017 16:00:16 +0000
Subject: Re: [PATCH] video: fbdev: cirrusfb: mark expected switch fall-throughs
Message-Id: <2619770.VHeb1jtPGe@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171106224555epcas3p153ad90e2c81169658eded4e40655cb31@epcas3p1.samsung.com>
 <20171106224550.GA2583@embeddedor.com>
In-Reply-To: <20171106224550.GA2583@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Monday, November 06, 2017 04:45:50 PM Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I placed the "fall through" comment
> on its own line, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Patch queued for 4.15, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

