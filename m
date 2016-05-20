From: Scot Doyle <lkml14@scotdoyle.com>
Date: Fri, 20 May 2016 16:27:17 +0000
Subject: Re: [PATCH] fbcon: warn on invalid cursor blink intervals
Message-Id: <alpine.DEB.2.10.1605200937330.18587@laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463510464-28124-1-git-send-email-ddaney.cavm@gmail.com> <20160517204912.GA29719@amd> <CACVXFVPdjfFkRFucTQsOHsVFtgm1W0JtOTqjyDzyNbzygghUyg@mail.gmail.com> <alpine.DEB.2.10.1605181519540.8967@laptop> <ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
 <alpine.DEB.2.10.1605182252230.12118@laptop> <573DE2D0.1050402@caviumnetworks.com> <alpine.DEB.2.10.1605191708400.15396@laptop> <alpine.DEB.2.10.1605191726030.15478@laptop> <CACVXFVM77CaHGE9kwhaxoa-fuNxZrDDzpCdHfnRno857pQANZQ@mail.gmail.com>
 <573E75CD.6050202@ozlabs.org> <CACVXFVPRiOShXHNCQsDe_0AoC++wQAfix3OTjyKC4spu1r9LvQ@mail.gmail.com> <573E9AE5.1020206@ozlabs.org>
In-Reply-To: <573E9AE5.1020206@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, Ming Lei <ming.lei@canonical.com>, David Daney <david.daney@cavium.com>, Dann Frazier <dann.frazier@canonical.com>, Peter Hurley <peter@hurleysoftware.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Chintakuntla, Radha" <Radha.Chintakuntla@caviumnetworks.com>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, David Daney <ddaney.cavm@gmail.com>, Scot Doyle <lkml14@scotdoyle.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>

On Fri, 20 May 2016, Jeremy Kerr wrote:
> Hi Ming,
> 
> >Then looks there are two fix patches acked & tested:
> >
> > - the patch in this thread
> > - another one "[PATCH] tty: vt: Fix soft lockup in fbcon cursor
> >blink timer."
> > https://lkml.org/lkml/2016/5/17/455
> >
> >So which one will be pushed to linus?
> 
> Not that it's my call, but we may want both; the first as a safety
> measure to prevent an invalid cur_blink_jiffies ever being set, and the
> second one to actually fix the initialisation of vc_cur_blink_ms (and
> address the warning introduced by the first).

Tomi / Greg,

I'd suggest
- applying "tty: vt: Fix soft lockup in fbcon cursor blink timer." to 4.7 and stable[4.2]
- applying "fbcon: warn on invalid cursor blink intervals" to 4.7
- ignoring "fbcon: use default if cursor blink interval is not valid"

Note: the patches don't depend on each other


> I guess we could just go with the latter for stable...
>
> Cheers,
> 
> Jeremy
