From: Petr Mladek <pmladek@suse.com>
Date: Fri, 20 Jul 2018 09:10:51 +0000
Subject: Re: [PATCH v3 2/2] fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set
Message-Id: <20180720091051.nvdmoci5owstxuzw@pathway.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180719101601.25076-1-tzimmermann@suse.de>
 <20180719101601.25076-3-tzimmermann@suse.de>
In-Reply-To: <20180719101601.25076-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-fbdev@vger.kernel.org, sergey.senozhatsky.work@gmail.com, hdegoede@redhat.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, sergey.senozhatsky@gmail.com, rostedt@goodmis.org, akpm@linux-foundation.org

On Thu 2018-07-19 12:16:01, Thomas Zimmermann wrote:
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

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have vacation the following two weeks. Note that I am fine with
v2 if anyone see the atomic as an overkill.

Best Regards,
Petr
