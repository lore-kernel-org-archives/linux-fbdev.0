From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 02 Feb 2017 20:07:01 +0000
Subject: Re: [PATCH v9 4/4] console: Make persistent scrollback a boot parameter
Message-Id: <CAP=VYLpBfFdixRm5=gQOqjxc+Qpy-Kk1oa1uMQjUnXTJO3fqrg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4640722.jsFVORW8WM@amdc3058> <20170110212838.16175-1-manuel.schoelling@gmx.de>
 <20170110212838.16175-5-manuel.schoelling@gmx.de>
In-Reply-To: <20170110212838.16175-5-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?Q?Manuel_Sch=C3=B6lling?= <manuel.schoelling@gmx.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, jslaby@suse.com, kilobyte@angband.pl, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, Andrew Morton <akpm@linux-foundation.org>, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, LKML <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Tue, Jan 10, 2017 at 4:28 PM, Manuel Schölling
<manuel.schoelling@gmx.de> wrote:
> The impact of the persistent scrollback feature on the code size is
> rather small, so the config option is removed. The feature stays
> disabled by default and can be enabled by using the boot command line
> parameter 'vgacon.scrollback_persistent=1' or by setting
> VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y.
>
> Signed-off-by: Manuel Schölling <manuel.schoelling@gmx.de>
> Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---

[...]

> +module_param_named(scrollback_persistent, scrollback_persistent, bool, 0000);
> +MODULE_PARM_DESC(scrollback_persistent, "Enable persistent scrollback for all vga consoles");

Since this hasn't got widespread deployment yet and  only exists
in Greg's tree, can we please fix the above to use setup_param or
similar, since there is nothing modular about this code at all.

Thanks.
Paul.
