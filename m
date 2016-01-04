From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 04 Jan 2016 13:27:54 +0000
Subject: re: omapfb: copy omapdss & displays for omapfb
Message-Id: <20160104132754.GA26552@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160104132534.GA24840@mwanda>
In-Reply-To: <20160104132534.GA24840@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Tomi Valkeinen,

The patch f76ee892a99e: "omapfb: copy omapdss & displays for omapfb"
from Dec 9, 2015, leads to the following static checker warning:

	drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c:213 sharp_ls_get_gpio()
	warn: 'gd' isn't an ERR_PTR

drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
   200  static int sharp_ls_get_gpio(struct device *dev, int gpio, unsigned long flags,
   201                    char *desc, struct gpio_desc **gpiod)
   202  {
   203          struct gpio_desc *gd;
   204          int r;
   205  
   206          *gpiod = NULL;
   207  
   208          r = devm_gpio_request_one(dev, gpio, flags, desc);
   209          if (r)
   210                  return r = -ENOENT ? 0 : r;
   211  
   212          gd = gpio_to_desc(gpio);
   213          if (IS_ERR(gd))
   214                  return PTR_ERR(gd) = -ENOENT ? 0 : PTR_ERR(gd);

This doesn't work.  It's either compiled out (ENOENT) or NULL.

   215  
   216          *gpiod = gd;
   217          return 0;
   218  }

regards,
dan carpenter
