From: Scot Doyle <lkml14@scotdoyle.com>
Date: Thu, 19 May 2016 22:25:36 +0000
Subject: Re: [PATCH] fbcon: use default if cursor blink interval is not valid
Message-Id: <alpine.DEB.2.10.1605191708400.15396@laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1463510464-28124-1-git-send-email-ddaney.cavm@gmail.com> <20160517204912.GA29719@amd> <CACVXFVPdjfFkRFucTQsOHsVFtgm1W0JtOTqjyDzyNbzygghUyg@mail.gmail.com> <alpine.DEB.2.10.1605181519540.8967@laptop> <ed8fa4ca-49e0-3ff4-5499-fc5250dd8ae2@caviumnetworks.com>
 <alpine.DEB.2.10.1605182252230.12118@laptop> <573DE2D0.1050402@caviumnetworks.com>
In-Reply-To: <573DE2D0.1050402@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Daney <ddaney@caviumnetworks.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, David Daney <david.daney@cavium.com>, Ming Lei <ming.lei@canonical.com>, Dann Frazier <dann.frazier@canonical.com>, Jeremy Kerr <jk@ozlabs.org>, Peter Hurley <peter@hurleysoftware.com>, Pavel Machek <pavel@ucw.cz>, Jonathan Liu <net147@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Chintakuntla, Radha" <Radha.Chintakuntla@caviumnetworks.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, David Airlie <airlied@linux.ie>, ddaney.cavm@gmail.com, Scot Doyle <lkml14@scotdoyle.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Thu, 19 May 2016, David Daney wrote:
> On 05/18/2016 09:21 PM, Scot Doyle wrote:
> > Two current [1] and three previous [2] systems locked during boot
> > because the cursor flash timer was set using an ops->cur_blink_jiffies
> > value of 0. Previous patches attempted to solve the problem by moving
> > variable initialization earlier in the setup sequence [2].
> > 
> > Use the normal cursor blink default interval of 200 ms if
> > ops->cur_blink_jiffies is not in the range specified in commit
> > bd63364caa8d. Since invalid values are not used, specific system
> > initialization timings should not cause lockups.
> > 
> 
> This patch just papers over the problem that you yourself introduced in commit
> bd63364caa8d ("vt: add cursor blink interval escape sequence").
> 
> As you know, I have a patch that fixes the problem at the source:
> https://lkml.org/lkml/2016/5/17/455
> 
> I don't like the idea of silently ignoring bad values passed in from other
> code (drivers/tty/vt/vt.c), and much less doing the check for bad values each
> time the timer expires rather than just once, where the bad value is first
> introduced.
> 
> I think it would be preferable to WARN() at the site the bad value is
> introduced, so that we can easily find the real source of the problem.
> Initialize cur_blink_jiffies to a sane default value, then if something
> attempts to set it to a value that would cause soft lockup, WARN and refuse to
> change it.

I agree this approach would be cleaner and am willing to give it a try
by submitting an alternative patch and ack'ing yours. Thanks for taking 
the time to critique my proposal.

