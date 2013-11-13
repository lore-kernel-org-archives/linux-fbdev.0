From: Peter Hurley <peter@hurleysoftware.com>
Date: Wed, 13 Nov 2013 14:24:21 +0000
Subject: Re: [GIT PULL] fbdev changes for 3.13
Message-Id: <52838B95.6060007@hurleysoftware.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <52836BBB.4010502@ti.com>
In-Reply-To: <52836BBB.4010502@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Tapsell <johnflux@gmail.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

On 11/13/2013 07:08 AM, Tomi Valkeinen wrote:
> Hi Linus,
>
> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>
>    Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>
> are available in the git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbdev-3.13
>
> for you to fetch changes up to 3a41c5dbe8bc396a7fb16ca8739e945bb003342e:
>
>    fb: reorder the lock sequence to fix potential dead lock (2013-11-11 15:52:59 +0200)
>
> ----------------------------------------------------------------
> fbdev changes for 3.13
>
> Nothing particularly stands out in this pull request. The biggest part of the
> changes are cleanups.
>
> Maybe one fix to mention is the "fb: reorder the lock sequence to fix potential
> dead lock" which hopefully fixes the fb locking issues reported by multiple
> persons.
>
...<snip>
>
> Gu Zheng (1):
>        fb: reorder the lock sequence to fix potential dead lock

John,

The above patch should fix the deadlock you found in fbcon_generic_blank().
Please re-test 3.13-rc1 when released [or Tomi's for-next branch now].

Regards,
Peter Hurley
