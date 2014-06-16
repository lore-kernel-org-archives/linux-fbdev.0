From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 16 Jun 2014 07:23:08 +0000
Subject: Re: [PATCH] offb: Fix little-endian support
Message-Id: <1402903388.7661.32.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400073709-15012-1-git-send-email-tiwai@suse.de>
	 <5373772D.9060807@fr.ibm.com> <s5hha4sh20d.wl%tiwai@suse.de>
	 <5373A200.6080301@fr.ibm.com> <s5h8uq4qm3h.wl%tiwai@suse.de>
In-Reply-To: <s5h8uq4qm3h.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Iwai <tiwai@suse.de>
Cc: Cedric Le Goater <clg@fr.ibm.com>, Dinar Valeev <dvaleev@suse.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


On Wed, 2014-05-14 at 19:57 +0200, Takashi Iwai wrote:
> 
> Hm, so it actually regressed on BE?
> 
> It's strange because fb_math_be() should be true and the patch won't
> change the values in that case...

Shouldn't the patch be based on foreign endian being set rather than
just "be" anyway ?

IE. If the fb is LE and the host is LE we *also* don't want to change
the ordering, which will be the case when we fix qemu...

Cheers,
Ben.



