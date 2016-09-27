From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 27 Sep 2016 10:58:42 +0000
Subject: Re: [PATCH v3] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <20160927105842.GA3922@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1474236417-27150-1-git-send-email-manuel.schoelling@gmx.de>
In-Reply-To: <1474236417-27150-1-git-send-email-manuel.schoelling@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Manuel =?iso-8859-1?Q?Sch=F6lling?= <manuel.schoelling@gmx.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, jslaby@suse.cz, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Sep 19, 2016 at 12:06:57AM +0200, Manuel Sch=F6lling wrote:
> Add a scrollback buffers for each VGA console. The benefit is that
> the scrollback history is not flushed when switching between consoles
> but is persistent.
> The buffers are allocated on demand when a new console is opened.
>=20
> It always annoys me when I switch back to a console and I can just
> read half of an error backtrace. This should fix issues like these.
>=20
> This breaks tools like clear_console that rely on flushing the
> scrollback history by switching back and forth between consoles
> which is why this feature is disabled by default.
> Use the escape sequence \e[3J instead for flushing the buffer.
>=20
> Signed-off-by: Manuel Sch=F6lling <manuel.schoelling@gmx.de>
> ---
> Changes in v3:
>   - Add config option for this feature
>   - Fallback to old scrollback buffer if kcalloc() fails
>   - Remove ioctl() call again and add documentation about existing
>     escape sequence to flush the scrollback buffer
> Changes in v2:
>   - Add ioctl() call to flush scrollback buffer
>   - (Patch v2 was not labeled as such, sorry)
> ---
>  drivers/video/console/Kconfig  |  23 +++++-
>  drivers/video/console/vgacon.c | 160 +++++++++++++++++++++++++++--------=
------
>  2 files changed, 128 insertions(+), 55 deletions(-)

I need someone else to at least test this, and give an acked-by for
it...

thanks,

greg k-h
