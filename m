From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 02 Apr 2014 11:15:19 +0000
Subject: re: video: pxa3xx-gcu: switch to devres functions
Message-Id: <20140402111519.GC23000@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Daniel Mack,

The patch a9b47c7f2390: "video: pxa3xx-gcu: switch to devres
functions" from Mar 5, 2014, leads to the following static checker
warning:

	drivers/video/fbdev/pxa3xx-gcu.c:616 pxa3xx_gcu_probe()
	warn: 'priv->mmio_base' isn't an ERR_PTR

drivers/video/fbdev/pxa3xx-gcu.c
   612  
   613          /* handle IO resources */
   614          r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   615          priv->mmio_base = devm_request_and_ioremap(dev, r);
   616          if (IS_ERR(priv->mmio_base)) {

devm_request_and_ioremap() returns NULL on error.

   617                  dev_err(dev, "failed to map I/O memory\n");
   618                  return PTR_ERR(priv->mmio_base);
   619          }
   620  

regards,
dan carpenter
