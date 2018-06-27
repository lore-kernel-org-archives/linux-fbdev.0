From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date: Wed, 27 Jun 2018 01:09:30 +0000
Subject: Re: [PATCH v3 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <20180627010930.GB10321@jagdpanzerIV>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626183612.321-1-hdegoede@redhat.com>
 <20180626183612.321-3-hdegoede@redhat.com>
In-Reply-To: <20180626183612.321-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org

On (06/26/18 20:36), Hans de Goede wrote:
> Replace comments about places where the console lock should be held with
> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
