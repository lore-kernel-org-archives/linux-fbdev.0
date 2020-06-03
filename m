From: Markus Elfring <Markus.Elfring@web.de>
Date: Wed, 03 Jun 2020 16:48:31 +0000
Subject: Re: [PATCH] fbdev: geocode: Add the missed pci_disable_device() in gx1fb_map_video_memory()
Message-Id: <4bec4498-05a2-9ec5-8b91-7934d05ded68@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200603092547.1424428-1-hslester96@gmail.com>
In-Reply-To: <20200603092547.1424428-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Chuhong Yuan <hslester96@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-geode@lists.infradead.org
Cc: Andrew Morton <akpm@osdl.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Andres Salomon <dilinger@queued.net>, David Vrabel <dvrabel@arcom.com>

> Add the missed function call to fix the bug.

…
> +++ b/drivers/video/fbdev/geode/gx1fb_core.c
> @@ -208,29 +208,44 @@  static int gx1fb_map_video_memory(struct fb_info *info, struct pci_dev *dev)
…
>  	return 0;
> +
> +err:
> +	pci_disable_device(dev);
> +	return ret;
>  }
…

I suggest to use more descriptive labels so that the exception handling
can be improved accordingly.

 	return 0;
+
+e_nomem:
+	ret = -ENOMEM;
+disable_device:
+	pci_disable_device(dev);
+	return ret;
 }


Regards,
Markus
