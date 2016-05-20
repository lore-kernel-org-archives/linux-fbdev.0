From: Ming Lei <ming.lei@canonical.com>
Date: Fri, 20 May 2016 02:48:14 +0000
Subject: Re: [PATCH] fbcon: warn on invalid cursor blink intervals
Message-Id: <CACVXFVPRiOShXHNCQsDe_0AoC++wQAfix3OTjyKC4spu1r9LvQ@mail.gmail.com>
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
	<CACVXFVM77CaHGE9kwhaxoa-fuNxZrDDzpCdHfnRno857pQANZQ@mail.gmail.com>
	<573E75CD.6050202@ozlabs.org>
In-Reply-To: <573E75CD.6050202@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Scot Doyle <lkml14@scotdoyle.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, David Daney <david.daney@cavium.com>, Dann Frazier <dann.frazier@canonical.com>, Peter Hurley <peter@hurleysoftware.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Chintakuntla, Radha" <Radha.Chintakuntla@caviumnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, David Daney <ddaney.cavm@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>

On Fri, May 20, 2016 at 10:26 AM, Jeremy Kerr <jk@ozlabs.org> wrote:
> Hi Ming,
>
>> Not sure this one is needed for stable because it justs dumps
>> a warning, and not set a valid period to ops->cur_blink_jiffies.
>>
>> So I guess other fix patch is still required for the soft lockup
>> issue, right?
>
> The main thing is that we don't set cur_blink_jiffies to the < 50ms
> value. As far as I can tell, it means we'll still get the original
> default, set in fbcon_startup():
>
>         ops->cur_blink_jiffies = HZ / 5;
>
> And so don't end up spinning on the timer expiry.

Jeremy, your theory is correct, thanks for your clarification! And my test
just shows that this patch does fix the soft lockup too, so

      Tested-by: Ming Lei <ming.lei@canonical.com>

Then looks there are two fix patches acked & tested:

     - the patch in this thread
     - another one "[PATCH] tty: vt: Fix soft lockup in fbcon cursor
blink timer."
     https://lkml.org/lkml/2016/5/17/455

So which one will be pushed to linus?

Thanks,
Ming

>
> Cheers,
>
>
> Jeremy
