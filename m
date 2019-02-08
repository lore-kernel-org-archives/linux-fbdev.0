From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Feb 2019 18:02:22 +0000
Subject: Re: [PATCH v5 0/2] Do not output logo on quiet boots
Message-Id: <af6b2ffb-28d1-0513-5f77-30e387bab80d@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190129134418epcas3p12a932e3d400600ac92ecf268f7bc4a38@epcas3p1.samsung.com>
 <20190129134350.24049-1-prarit@redhat.com>
In-Reply-To: <20190129134350.24049-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prarit Bhargava <prarit@redhat.com>, linux-fbdev@vger.kernel.org
Cc: Yisheng Xie <ysxie@foxmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Steven Rostedt <rostedt@goodmis.org>, Marko Myllynen <myllynen@redhat.com>, Hans de Goede <hdegoede@redhat.com>, dri-devel@lists.freedesktop.org, Thierry Reding <treding@nvidia.com>


On 01/29/2019 02:43 PM, Prarit Bhargava wrote:
> On text-based systems the 'quiet' boot option will show printk levels
> higher than CONSOLE_LOGLEVEL_QUIET.  The displaying of the Tux logo
> during boot can cause some consoles to lose display data and as a result
> confuse the end user.
> 
> Do not display the Tux logo on systems that are in 'quiet' boot.
> 
> v2: It helps to commit all my changes before sending them.  Remove extra
> bracket.
> v3: buildbot error fix: fbcon can be built as part of a module so export console_printk
> v4: move console_printk change to separate patch, and drop logo cleanup
> v5: Only set FBCON_LOGO_DONTSHOW for console loglevel
> 
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>

Patches #1-2 queued for v5.1, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
