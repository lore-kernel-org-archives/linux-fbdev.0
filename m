From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 10 Jun 2015 15:51:32 +0000
Subject: re: video, sm501: add OF binding to support SM501
Message-Id: <20150610155132.GK10549@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello Heiko Schocher,

The patch 4295f9bf74a8: "video, sm501: add OF binding to support
SM501" from Jan 26, 2011, leads to the following static checker
warning:

	drivers/video/fbdev/sm501fb.c:1958 sm501fb_probe()
	warn: strcpy() 'cp' of unknown size might be too large for 'fb_mode'

drivers/video/fbdev/sm501fb.c
    46  static char *fb_mode = "640x480-16@60";

	[ snip ]

  1953                  info->pdata = &sm501fb_def_pdata;
  1954                  if (np) {
  1955                          /* Get EDID */
  1956                          cp = of_get_property(np, "mode", &len);
  1957                          if (cp)
  1958                                  strcpy(fb_mode, cp);

I don't know anything about this hardware but there might be a mode
longer than "640x480-16@60"?

  1959                          prop = of_get_property(np, "edid", &len);
  1960                          if (prop && len = EDID_LENGTH) {

regards,
dan carpenter
