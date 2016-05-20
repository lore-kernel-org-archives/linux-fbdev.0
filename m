From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 20 May 2016 01:21:58 +0000
Subject: Re: [PATCH] fbcon: warn on invalid cursor blink intervals
Message-Id: <573E66B6.40109@ozlabs.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463510464-28124-1-git-send-email-ddaney.cavm@gmail.com>
 <20160517204912.GA29719@amd>
 <CACVXFVPdjfFkRFucTQsOHsVFtgm1W0JtOTqjyDzyNbzygghUyg@mail.gmail.com>
 <alpine.DEB.2.10.1605181519540.8967@laptop>
 <ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
 <alpine.DEB.2.10.1605182252230.12118@laptop>
 <573DE2D0.1050402@caviumnetworks.com>
 <alpine.DEB.2.10.1605191708400.15396@laptop>
 <alpine.DEB.2.10.1605191726030.15478@laptop>
In-Reply-To: <alpine.DEB.2.10.1605191726030.15478@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: David Daney <david.daney@cavium.com>, Ming Lei <ming.lei@canonical.com>, Dann Frazier <dann.frazier@canonical.com>, Peter Hurley <peter@hurleysoftware.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Chintakuntla, Radha" <Radha.Chintakuntla@caviumnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, ddaney.cavm@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hi Scot,

> Two systems are locking on boot [1] because ops->cur_blink_jiffies
> is set to zero from vc->vc_cur_blink_ms.
> 
> Ignore such invalid intervals and log a warning.

This prevents a lockup on AST BMC machines, but (as expected) generates
a warning against the fbcon driver, which is a significantly better
result.

Tested-by: Jeremy Kerr <jk@ozlabs.org>

[now to sort out the issue in the ast driver...]

Cheers,


Jeremy
