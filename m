From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 02 May 2010 01:18:53 +0000
Subject: Re: [PATCH 24/30] viafb: Add a driver for the video capture engine
Message-Id: <4BDCD2FD.8090104@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1272493051-25380-1-git-send-email-corbet@lwn.net> <1272493051-25380-25-git-send-email-corbet@lwn.net>
In-Reply-To: <1272493051-25380-25-git-send-email-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Harald Welte <laforge@gnumonks.org>, linux-fbdev@vger.kernel.org, JosephChan@via.com.tw, ScottFang@viatech.com.cn

Jonathan Corbet schrieb:
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 22c1662..a969f76 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -1516,12 +1516,21 @@ config FB_VIA
>  	  This is the frame buffer device driver for Graphics chips of VIA
>  	  UniChrome (Pro) Family (CLE266,PM800/CN400,P4M800CE/P4M800Pro/
>  	  CN700/VN800,CX700/VX700,P4M890) and Chrome9 Family (K8M890,CN896
> - 	  /P4M900,VX800)
> + 	  /P4M900,VX800,VX855)
>  	  Say Y if you have a VIA UniChrome graphics board.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called viafb.
>  
> +config FB_VIA_CAMERA
> +	tristate "VIAFB camera controller support"
> +	depends on FB_VIA
> +	select VIDEOBUF_DMA_SG
> +	help
> +	   Driver support for the integrated camera controller in VIA
> +	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems
> +	   with ov7670 sensors.
> +

Probably this is not the right place for this config option. Even if it 
currently depends on the framebuffer having it there is just confusing. 
Additionally you should depend/select some V4L stuff to make the 
following compile errors go away:

ERROR: "video_ioctl2" [drivers/video/via/via-camera.ko] undefined!
ERROR: "video_device_release_empty" [drivers/video/via/via-camera.ko] 
undefined!
ERROR: "video_register_device" [drivers/video/via/via-camera.ko] undefined!
ERROR: "v4l2_i2c_new_subdev_cfg" [drivers/video/via/via-camera.ko] 
undefined!
ERROR: "v4l2_device_register" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_read_stream" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_mmap_free" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_stop" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_streamoff" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_poll_stream" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_mmap_mapper" [drivers/video/via/via-camera.ko] undefined!
ERROR: "video_devdata" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_iolock" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_reqbufs" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_querybuf" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_qbuf" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_dqbuf" [drivers/video/via/via-camera.ko] undefined!
ERROR: "videobuf_streamon" [drivers/video/via/via-camera.ko] undefined!
ERROR: "v4l2_chip_match_host" [drivers/video/via/via-camera.ko] undefined!
ERROR: "v4l2_device_unregister" [drivers/video/via/via-camera.ko] undefined!
ERROR: "video_unregister_device" [drivers/video/via/via-camera.ko] 
undefined!
ERROR: "videobuf_alloc" [drivers/media/video/videobuf-dma-sg.ko] undefined!
ERROR: "videobuf_queue_core_init" 
[drivers/media/video/videobuf-dma-sg.ko] undefined!

Otherwise you can count this patch series as
Acked-by: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Although it is still far away from destination and has its issues but 
it's a step forward and delaying it would be probably just frustrating 
for both of us.


Thanks,

Florian Tobias Schandinat
