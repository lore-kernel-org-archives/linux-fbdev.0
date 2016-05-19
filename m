From: Jeremy Kerr <jk@ozlabs.org>
Date: Thu, 19 May 2016 07:25:49 +0000
Subject: Re: [PATCH] fbcon: use default if cursor blink interval is not valid
Message-Id: <573D6A7D.5050702@ozlabs.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463510464-28124-1-git-send-email-ddaney.cavm@gmail.com>
 <20160517204912.GA29719@amd>
 <CACVXFVPdjfFkRFucTQsOHsVFtgm1W0JtOTqjyDzyNbzygghUyg@mail.gmail.com>
 <alpine.DEB.2.10.1605181519540.8967@laptop>
 <ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
 <alpine.DEB.2.10.1605182252230.12118@laptop>
In-Reply-To: <alpine.DEB.2.10.1605182252230.12118@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Scot Doyle <lkml14@scotdoyle.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: David Daney <david.daney@cavium.com>, Ming Lei <ming.lei@canonical.com>, Dann Frazier <dann.frazier@canonical.com>, Peter Hurley <peter@hurleysoftware.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Chintakuntla, Radha" <Radha.Chintakuntla@caviumnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, ddaney.cavm@gmail.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hi Scot,

> Use the normal cursor blink default interval of 200 ms if
> ops->cur_blink_jiffies is not in the range specified in commit
> bd63364caa8d. Since invalid values are not used, specific system
> initialization timings should not cause lockups.

This fixes an issue we're seeing with the ast driver on OpenPOWER
machines, thanks!

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy
