From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 31 Jul 2018 10:45:37 +0000
Subject: Re: [PATCH v3 2/2] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <2462673.Azj3QxDNnS@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180719101601.25076-1-tzimmermann@suse.de>
 <CGME20180719101612epcas1p1768bec3c591129fbec77867631eb18a3@epcas1p1.samsung.com>
 <20180719101601.25076-3-tzimmermann@suse.de>
In-Reply-To: <20180719101601.25076-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: pmladek@suse.com, linux-fbdev@vger.kernel.org, sergey.senozhatsky.work@gmail.com, sergey.senozhatsky@gmail.com, dri-devel@lists.freedesktop.org, hdegoede@redhat.com, rostedt@goodmis.org, akpm@linux-foundation.org

On Thursday, July 19, 2018 12:16:01 PM Thomas Zimmermann wrote:
> If the console is unlocked during registration, the console subsystem
> generates significant amounts of warnings, which obfuscate actual
> debugging messages. Setting ignore_console_lock_warning while debugging
> console registration avoid the noise.
> 
> v3:
> 	- manipulate ignore_console_lock_warning with atomic_{inc,dec}
> v2:
> 	- restore ignore_console_lock_warning if lock_fb_info() fails
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

