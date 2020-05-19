From: Greg KH <gregkh@linuxfoundation.org>
Date: Tue, 19 May 2020 17:27:09 +0000
Subject: Re: [RFC PATCH 1/4] gpu: dxgkrnl: core code
Message-Id: <20200519172709.GA1150171@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200519163234.226513-1-sashal@kernel.org>
 <20200519163234.226513-2-sashal@kernel.org>
In-Reply-To: <20200519163234.226513-2-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sasha Levin <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org, sthemmin@microsoft.com, tvrtko.ursulin@intel.com, haiyangz@microsoft.com, spronovo@microsoft.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, chris@chris-wilson.co.uk, wei.liu@kernel.org, linux-fbdev@vger.kernel.org, iourit@microsoft.com, alexander.deucher@amd.com, kys@microsoft.com, Hawking.Zhang@amd.com

On Tue, May 19, 2020 at 12:32:31PM -0400, Sasha Levin wrote:
> +static int dxgglobal_init_global_channel(struct hv_device *hdev)
> +{
> +	int ret = 0;
> +
> +	TRACE_DEBUG(1, "%s %x  %x", __func__, hdev->vendor_id, hdev->device_id);
> +	{
> +		TRACE_DEBUG(1, "device type   : %pUb\n", &hdev->dev_type);
> +		TRACE_DEBUG(1, "device channel: %pUb %p primary: %p\n",
> +			    &hdev->channel->offermsg.offer.if_type,
> +			    hdev->channel, hdev->channel->primary_channel);
> +	}
> +
> +	if (dxgglobal->hdev) {
> +		/* This device should appear only once */
> +		pr_err("dxgglobal already initialized\n");
> +		ret = -EBADE;
> +		goto error;
> +	}
> +
> +	dxgglobal->hdev = hdev;
> +
> +	ret = dxgvmbuschannel_init(&dxgglobal->channel, hdev);
> +	if (ret) {
> +		pr_err("dxgvmbuschannel_init failed: %d\n", ret);
> +		goto error;
> +	}
> +
> +	ret = dxgglobal_getiospace(dxgglobal);
> +	if (ret) {
> +		pr_err("getiospace failed: %d\n", ret);
> +		goto error;
> +	}
> +
> +	ret = dxgvmb_send_set_iospace_region(dxgglobal->mmiospace_base,
> +					     dxgglobal->mmiospace_size, 0);
> +	if (ret) {
> +		pr_err("send_set_iospace_region failed\n");
> +		goto error;
> +	}
> +
> +	hv_set_drvdata(hdev, dxgglobal);
> +
> +	if (alloc_chrdev_region(&dxgglobal->device_devt, 0, 1, "dxgkrnl") < 0) {
> +		pr_err("alloc_chrdev_region failed\n");
> +		ret = -ENODEV;
> +		goto error;
> +	}
> +	dxgglobal->devt_initialized = true;
> +	dxgglobal->device_class = class_create(THIS_MODULE, "dxgkdrv");
> +	if (dxgglobal->device_class = NULL) {
> +		pr_err("class_create failed\n");
> +		ret = -ENODEV;
> +		goto error;
> +	}
> +	dxgglobal->device_class->devnode = dxg_devnode;
> +	dxgglobal->device = device_create(dxgglobal->device_class, NULL,
> +					  dxgglobal->device_devt, NULL, "dxg");
> +	if (dxgglobal->device = NULL) {
> +		pr_err("device_create failed\n");
> +		ret = -ENODEV;
> +		goto error;
> +	}
> +	dxgglobaldev = dxgglobal->device;
> +	cdev_init(&dxgglobal->device_cdev, &dxgk_fops);
> +	ret = cdev_add(&dxgglobal->device_cdev, dxgglobal->device_devt, 1);
> +	if (ret < 0) {
> +		pr_err("cdev_add failed: %d\n", ret);
> +		goto error;
> +	}
> +	dxgglobal->cdev_initialized = true;
> +
> +error:
> +	return ret;
> +}

As you only are asking for a single char dev node, please just use the
misc device api instead of creating your own class and major number on
the fly.  It's much simpler and easier overall to make sure you got all
of the above logic correct.

thanks,

greg k-h
