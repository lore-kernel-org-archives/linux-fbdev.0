From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 10 May 2011 12:16:07 +0000
Subject: Re: [PATCH V2] omap2/omapfb: make DBG() more resistant in if-else
Message-Id: <1305029767.2045.42.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <BANLkTinEJZ=fvJmWRkQ7kKyxbFRaJnum7g@mail.gmail.com>
	 <1305025653-17138-1-git-send-email-ndevos@redhat.com>
In-Reply-To: <1305025653-17138-1-git-send-email-ndevos@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Niels de Vos <ndevos@redhat.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Sanjeev Premi <premi@ti.com>

On Tue, 2011-05-10 at 12:07 +0100, Niels de Vos wrote:
> When DBG() is used in a simple if-else, the resulting code path
> currently depends on the definition of DBG(). Inserting the statement in
> a "do { ... } while (0)" prevents this possible misuse.
> 
> Signed-off-by: Niels de Vos <ndevos@redhat.com>

Thanks, I'll add this to the dss2 tree.

 Tomi


