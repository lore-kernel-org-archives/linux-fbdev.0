From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 01 Feb 2012 09:42:54 +0000
Subject: re: backlight: Add pcf50633 backlight driver
Message-Id: <20120201094254.GA24044@elgon.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Lars-Peter Clausen,

This is a semi-automatic email about new static checker warnings.

The patch 2ddfd12f3584: "backlight: Add pcf50633 backlight driver" 
from May 12, 2010, leads to the following Smatch complaint:

drivers/video/backlight/pcf50633-backlight.c +136 pcf50633_bl_probe()
	 error: we previously assumed 'pdata' could be null (see line 118)

drivers/video/backlight/pcf50633-backlight.c
   117	
   118		if (pdata) {
                    ^^^^^
check.

   119			bl_props.brightness = pdata->default_brightness;
   120			pcf_bl->brightness_limit = pdata->default_brightness_limit;
   121		} else {
   122			bl_props.brightness = 0x3f;
   123			pcf_bl->brightness_limit = 0x3f;
   124		}
   125	
   126		pcf_bl->pcf = dev_to_pcf50633(pdev->dev.parent);
   127	
   128		pcf_bl->bl = backlight_device_register(pdev->name, &pdev->dev, pcf_bl,
   129							&pcf50633_bl_ops, &bl_props);
   130	
   131		if (IS_ERR(pcf_bl->bl))
   132			return PTR_ERR(pcf_bl->bl);
   133	
   134		platform_set_drvdata(pdev, pcf_bl);
   135	
   136		pcf50633_reg_write(pcf_bl->pcf, PCF50633_REG_LEDDIM, pdata->ramp_time);
                                                                     ^^^^^^^^^^^^^^^^
dereference with checking.

   137	
   138		/* Should be different from bl_props.brightness, so we do not exit

regards,
dan carpenter

