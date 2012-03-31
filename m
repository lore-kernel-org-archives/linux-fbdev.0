From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 31 Mar 2012 23:38:58 +0000
Subject: Re: [PATCH 1/4] fb_defio: add first_io callback
Message-Id: <4F779592.2040305@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203281933.57109.heiko@sntech.de>
In-Reply-To: <201203281933.57109.heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Heiko,

On 03/28/2012 05:33 PM, Heiko St=FCbner wrote:
> With this optional callback the driver is notified when the first page
> is entered into the pagelist and a new deferred_io call is scheduled.
>=20
> A possible use-case for this is runtime-pm. In the first_io call
> 	pm_runtime_get()
> could be called, which starts an asynchronous runtime_resume of the
> device. In the deferred_io callback a call to
> 	pm_runtime_barrier()
> makes the sure, the device is resumed by then and a
> 	pm_runtime_put()
> may put the device back to sleep.
>=20
> Also, some SoCs may use the runtime-pm system to determine if they
> are able to enter deeper idle states. Therefore it is necessary to
> keep the use-count from the first written page until the conclusion
> of the screen update, to prevent the system from going to sleep before
> completing the pending update.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Special characters are allowed in sign-offs. And your other patches are
encoded as quoted-printable anyway (although I'd prefer an encoding my
git takes directly like UTF-8).

> ---
>  drivers/video/fb_defio.c |    4 ++++
>  include/linux/fb.h       |    1 +
>  2 files changed, 5 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
> index c27e153..070f26f 100644
> --- a/drivers/video/fb_defio.c
> +++ b/drivers/video/fb_defio.c
> @@ -107,6 +107,10 @@ static int fb_deferred_io_mkwrite(struct vm_area_str=
uct *vma,
>  	/* protect against the workqueue changing the page list */
>  	mutex_lock(&fbdefio->lock);
> =20
> +	/* first write in this cycle, notify the driver */
> +	if (fbdefio->first_io && list_empty(&fbdefio->pagelist))
> +		fbdefio->first_io(info);
> +
>  	/*
>  	 * We want the page to remain locked from ->page_mkwrite until
>  	 * the PTE is marked dirty to avoid page_mkclean() being called
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index d31cb68..c10e71e 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -607,6 +607,7 @@ struct fb_deferred_io {

There are some drivers (smscufx & udlfb) that kmalloc this struct. I
think you have to fix (kzalloc) them to avoid breaking them?

>  	struct mutex lock; /* mutex that protects the page list */
>  	struct list_head pagelist; /* list of touched pages */
>  	/* callback */
> +	void (*first_io)(struct fb_info *info);
>  	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
>  };
>  #endif

Thanks,

Florian Tobias Schandinat
