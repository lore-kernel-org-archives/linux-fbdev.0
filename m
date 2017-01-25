From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 25 Jan 2017 10:55:30 +0000
Subject: Re: [PATCH v10 0/4] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20170125105530.GA2451@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201701112105.R6Zog6jw%fengguang.wu@intel.com>
 <20170113200758.9880-1-manuel.schoelling@gmx.de>
In-Reply-To: <20170113200758.9880-1-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: jslaby@suse.com, kilobyte@angband.pl, lkml14@scotdoyle.com, rdunlap@infradead.org, shorne@gmail.com, andrey_utkin@fastmail.com, akpm@linux-foundation.org, paul.burton@imgtec.com, daniel.vetter@ffwll.ch, tj@kernel.org, hdegoede@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Jan 13, 2017 at 09:07:54PM +0100, Manuel Sch=F6lling wrote:
> Changes in v10:
>   - Fix compilation error if CONFIG_VGACON_SOFT_SCROLLBACK=3Dn

All now applied to my tty-testing branch, let's see what the 0-day bot
has to say about this :)

thanks for the persistence.

greg k-h
