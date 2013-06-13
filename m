From: Inki Dae <inki.dae@samsung.com>
Date: Thu, 13 Jun 2013 11:25:08 +0000
Subject: RE: [RFC PATCH] dmabuf-sync: Introduce buffer synchronization framework
Message-Id: <02c201ce6828$a97bda90$fc738fb0$%dae@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1371112088-15310-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1371112088-15310-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org


> +static void dmabuf_sync_timeout_worker(struct work_struct *work)
> +{
> +	struct dmabuf_sync *sync = container_of(work, struct dmabuf_sync,
> work);
> +	struct dmabuf_sync_object *sobj;
> +
> +	mutex_lock(&sync->lock);
> +
> +	list_for_each_entry(sobj, &sync->syncs, head) {
> +		if (WARN_ON(!sobj->robj))
> +			continue;
> +
> +		printk(KERN_WARNING "%s: timeout = 0x%x [type = %d, " \
> +					"refcnt = %d, locked = %d]\n",
> +					sync->name, (u32)sobj->dmabuf,
> +					sobj->access_type,
> +
atomic_read(&sobj->robj->shared_cnt),
> +					sobj->robj->locked);
> +
> +		/* unlock only valid sync object. */
> +		if (!sobj->robj->locked)
> +			continue;
> +
> +		if (sobj->robj->shared &&
> +				atomic_read(&sobj->robj->shared_cnt) > 1) {
> +			atomic_dec(&sobj->robj->shared_cnt);
> +			continue;
> +		}
> +
> +		ww_mutex_unlock(&sobj->robj->lock);
> +
> +		if (sobj->access_type & DMA_BUF_ACCESS_READ)
> +			printk(KERN_WARNING "%s: r-unlocked = 0x%x\n",
> +					sync->name, (u32)sobj->dmabuf);
> +		else
> +			printk(KERN_WARNING "%s: w-unlocked = 0x%x\n",
> +					sync->name, (u32)sobj->dmabuf);
> +
> +#if defined(CONFIG_DEBUG_FS)
> +		sync_debugfs_timeout_cnt++;
> +#endif

Oops, unnecessary codes. will remove them.

