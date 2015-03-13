From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Mar 2015 10:07:37 +0000
Subject: re: fbdev: sh_mobile_lcdc: Implement overlays support
Message-Id: <20150313100737.GA1984@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Laurent Pinchart,

The patch c5deac3c9b22: "fbdev: sh_mobile_lcdc: Implement overlays
support" from Dec 12, 2011, leads to the following static checker
warning:

	drivers/video/fbdev/sh_mobile_lcdcfb.c:1471 overlay_rop3_store()
	warn: bool comparison is always 'false'

drivers/video/fbdev/sh_mobile_lcdcfb.c
  1455  static ssize_t
  1456  overlay_rop3_store(struct device *dev, struct device_attribute *attr,
  1457                      const char *buf, size_t count)
  1458  {
  1459          struct fb_info *info = dev_get_drvdata(dev);
  1460          struct sh_mobile_lcdc_overlay *ovl = info->par;
  1461          unsigned int rop3;
  1462          char *endp;
  1463  
  1464          rop3 = !!simple_strtoul(buf, &endp, 10);
                       ^^
rop3 is true/false.

  1465          if (isspace(*endp))
  1466                  endp++;
  1467  
  1468          if (endp - buf != count)
  1469                  return -EINVAL;
  1470  
  1471          if (rop3 > 255)
                    ^^^^^^^^^^
This condition is never true.  Should we just delete it?

  1472                  return -EINVAL;
  1473  
  1474          if (ovl->rop3 != rop3) {
  1475                  ovl->rop3 = rop3;
  1476  
  1477                  if (ovl->mode = LCDC_OVERLAY_ROP3 && ovl->enabled)
  1478                          sh_mobile_lcdc_overlay_setup(ovl);
  1479          }
  1480  
  1481          return count;
  1482  }

regards,
dan carpenter
