From: Jens Remus <jremus@linux.ibm.com>
Date: Thu, 18 Jul 2019 12:02:23 +0000
Subject: Re: [PATCH] vt: Grab console_lock around con_is_bound in show_bind
Message-Id: <d242e41d-04cf-ba0e-2d81-9ed1a9c52195@linux.ibm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190718080903.22622-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190718080903.22622-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Martin Hostettler <textshell@uchuujin.de>, Adam Borowski <kilobyte@angband.pl>, Mikulas Patocka <mpatocka@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Sam Ravnborg <sam@ravnborg.org>

Am 18.07.2019 um 10:09 schrieb Daniel Vetter:
> Not really harmful not to, but also not harm in grabbing the lock. And
> this shuts up a new WARNING I introduced in commit ddde3c18b700 ("vt:
> More locking checks").
> 
> Reported-by: Jens Remus <jremus@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linux-s390@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Martin Hostettler <textshell@uchuujin.de>
> Cc: Adam Borowski <kilobyte@angband.pl>
> Cc: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> ---
>   drivers/tty/vt/vt.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Thank you for the quick fix! Looks fine to me. Did test with cat as well 
as our dump2tar utility. The warning is gone.

Tested-by: Jens Remus <jremus@linux.ibm.com>

Regards,
Jens Remus
-- 
Linux on Z and z/VSE Development & Service (D3229)
IBM Systems & Technology Group, Pure Systems & Modular Software Development

IBM Data Privacy Statement: https://www.ibm.com/privacy/us/en/

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Matthias Hartmann
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
